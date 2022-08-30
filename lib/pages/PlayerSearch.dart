import 'package:flutter/material.dart';
import 'package:json_parsing_demo/model/userDetails.dart';
class PlayerSearch extends SearchDelegate{
//  List<String> soccerPlayers;
 String selectedResult;
 List<userDetails> userList;

  PlayerSearch(this.userList);
  var test = "Priyanka2";
 
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
        query = "";
      })
    ];
  }
 
  @override
  Widget buildLeading(BuildContext context) {
      return IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          });
  }
 
  @override
  Widget buildResults(BuildContext context) {
      return Container(
        child: Center(
          child: Text(selectedResult),
        ),
      );
  }
 
  @override
  Widget buildSuggestions(BuildContext context) {
      List<userDetails> suggestedSoccerPlayers = [];
      query.isEmpty ? suggestedSoccerPlayers = userList
          : suggestedSoccerPlayers.addAll(userList.where(
            (element) => element.name.toLowerCase().contains(query.toLowerCase()),
      ));
 
      return ListView.builder(
          itemCount: suggestedSoccerPlayers.length,
          itemBuilder: (context, position) => ListTile(
            title: Text(suggestedSoccerPlayers[position].name),
          ));
  }
}