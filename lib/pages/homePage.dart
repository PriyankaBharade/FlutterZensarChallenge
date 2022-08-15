import 'package:flutter/material.dart';
import 'package:json_parsing_demo/provider/myHomePageProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'PlayerSearch.dart';
import 'package:json_parsing_demo/model/userInfo.dart';
class MyHomePage extends StatelessWidget {
SearchBar searchBar;
userInfo  userinfo;
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
      body: ChangeNotifierProvider<MyHomePageProvider>(
        create: (context) => MyHomePageProvider(),
        child: Consumer<MyHomePageProvider>(
          builder: (context, provider, child) {
            if (provider.userinfo == null) {
              provider.getData(context);
              return Center(child: CircularProgressIndicator());
            }
             this.userinfo = provider.userinfo;
            // when we have the json loaded... let's put the data into a data table widget
            return SingleChildScrollView(
             // scrollDirection: Axis.horizontal,
              // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
              child: SingleChildScrollView(
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text('id'),
                        tooltip: 'represents phone number of the user'),
                    DataColumn(
                        label: Text('Name'),
                        tooltip: 'represents first name of the user'),
                    DataColumn(
                        label: Text('Email'),
                        tooltip: 'represents last name of the user'),
                    DataColumn(
                        label: Text('Role'),
                        tooltip: 'represents email address of the user'),
                    DataColumn(
                        label: Text('Delete'),
                        tooltip: 'represents if user is verified.'),
                    DataColumn(
                        label: Text('Edit'),
                        tooltip: 'represents if user is verified.'),
                  ],
                  rows: provider.userinfo.userlist
                      .map((userinfo) =>
                          // we return a DataRow every time
                           //this.userinfo = provider.userinfo;
                          DataRow(
                              // List<DataCell> cells is required in every row
                              cells: [
                                DataCell(Text(userinfo.id)),
                                DataCell(Text(userinfo.name)),
                                DataCell(Text(userinfo.email)),
                                DataCell(Text(userinfo.role)),
                                DataCell(Icon(Icons.delete,color:Colors.black),
                                onTap: () {
                                 provider.deleteItem(userinfo.id);
                                }),
                                DataCell(Icon(Icons.edit,color:Colors.black)),
                              ]))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
