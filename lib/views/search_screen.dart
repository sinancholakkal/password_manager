import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:password_manager/models/password_model.dart';
import 'package:password_manager/utils/app_color.dart';
import 'package:password_manager/utils/app_sizes.dart';
import 'package:password_manager/views/home_screen.dart';
import 'package:password_manager/views/widgets/search_filed_widget.dart';
import 'package:password_manager/views/widgets/text_feild.dart';

class SearchScreen extends StatefulWidget {
  final List<PasswordModel>models;
  const SearchScreen({super.key, required this.models});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}


class _SearchScreenState extends State<SearchScreen> {

  late List<PasswordModel>filtered;
  @override
  void initState() {
   filtered = [...widget.models];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SafeArea(child: Padding(
        padding: screenPadding,
        
        child: Column(
          spacing: 20,
          children: [
            SearchFiledWidget(readOnly: false,labelText: "Search",onChanged: (val) {
              log(val);
              filtered.clear();
              for(var model in widget.models){
                if(model.name.contains(val)){
                 if(!filtered.contains(model)){
                  filtered.add(model);
                 }
                }
              }
              setState(() {});
            },),
            if(filtered.isEmpty)Flexible(child: TextWidget(text: "No search result")),
            if(filtered.isNotEmpty)Expanded(
              child: ListView.builder(itemBuilder: (context, index) {
                return ItemCardWidget(model: filtered[index]);
              },itemCount: filtered.length,),
            )
          ],
        ),
      )),
    );
  }
}