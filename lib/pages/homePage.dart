import 'package:flutter/material.dart';
import 'package:json_parsing_demo/provider/myHomePageProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'PlayerSearch.dart';
import 'package:json_parsing_demo/model/userInfo.dart';

class MyHomePage extends StatefulWidget {
  var test = "Priyanka";
 @override 
 _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage>{
SearchBar searchBar;
userInfo  userinfo;
int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;
AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('User Details'),
      actions: [searchBar.getSearchAction(context)]
    );
  }  
MyHomePage(){
   searchBar = new SearchBar(
      inBar: false,
      onSubmitted: print,
      buildDefaultAppBar: buildAppBar
    );
}
  @override
  Widget build(BuildContext context) {
     var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
               showSearch(
                   context: context, delegate: PlayerSearch(userinfo.userlist));
                   
            },
            icon: Icon(Icons.search),
          )
        ],
        centerTitle: true,
        title: Text('User info'),
      ),
      body: Container(
        width: screenSize.width,
        child : ChangeNotifierProvider<MyHomePageProvider>(
        create: (context) => MyHomePageProvider(),
        child: Consumer<MyHomePageProvider>(
          builder: (context, provider, child) {
            if (provider.userinfo == null) {
              provider.getData(context);
              return Center(child: CircularProgressIndicator());
            }
            this.userinfo = provider.userinfo;
            var dts = DTS(userinfo,provider,context);
            // when we have the json loaded... let's put the data into a data table widget
            return SingleChildScrollView(
              // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..      
              child: SingleChildScrollView(
                 child : PaginatedDataTable(
                     columns: [
                    DataColumn(
                        label: Text('id'),
                        tooltip: 'represents phone number of the user'),
                    DataColumn(
                        label: Text('Name'),
                        tooltip: 'represents first name of the user'),
                    DataColumn(
                        label: Text('Edit Name'),
                        tooltip: 'represents if user is verified.'),
                    DataColumn(
                        label: Text('Email'),
                        tooltip: 'represents last name of the user'),
                     DataColumn(
                        label: Text('Edit Email'),
                        tooltip: 'represents if user is verified.'),
                    DataColumn(
                        label: Text('Role'),
                        tooltip: 'represents email address of the user'),
                    DataColumn(
                        label: Text('Delete'),
                        tooltip: 'represents if user is verified.'),
                   
                  ],
                  source: dts,
                 onRowsPerPageChanged: (r){
                  print("Page Changes ${r}");
                        setState((){
                            _rowPerPage = r;
                        });
                    },
                    rowsPerPage:_rowPerPage,
              ),
             ),
            );
          },
        ),
       ),
      ),
    );
  }

}


class DTS extends DataTableSource {
  userInfo  userinfo;
  MyHomePageProvider provider;
  BuildContext context;
  DTS(this.userinfo, this.provider,this.context);
  @override
  DataRow getRow(int index){
      print("index $index check");
    return DataRow.byIndex(index: index,  cells: [
                                DataCell(Text(userinfo.userlist[index].id)),
                                DataCell(Text(userinfo.userlist[index].name)),
                                DataCell(Icon(Icons.edit,color:Colors.black),
                                onTap:(){
                                  provider.editName(userinfo.userlist[index],context);
                                 }),
                                DataCell(Text(userinfo.userlist[index].email)),
                                DataCell(Icon(Icons.edit,color:Colors.black),
                                onTap:(){
                                  provider.editEmail(userinfo.userlist[index],context);
                                 }),
                                DataCell(Text(userinfo.userlist[index].role)),
                                DataCell(Icon(Icons.delete,color:Colors.black),
                                onTap: () {
                                 provider.deleteItem(userinfo.userlist[index].id);
                                }),
                              ]);
  }
  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => userinfo.userlist.length;
  @override
  int get selectedRowCount => 0;
}
