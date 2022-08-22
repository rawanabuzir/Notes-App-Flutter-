import 'package:flutter/material.dart';
import 'package:gjntjkbfgjknc/sqflite.dart';
import 'main.dart';

class editNotes extends StatefulWidget {
  final notes;
  final title;
  final color;
  final id;

   editNotes({Key? key, this.notes, this.title, this.color, this.id}) : super(key: key);

  @override
  State<editNotes> createState() => _editNotes();
}

class _editNotes extends State<editNotes> {

  sqflite sqfdb =sqflite();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController notes = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  @override
  void initState() {
notes.text=widget.notes;
title.text=widget.title;
color.text=widget.color;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:

        AppBar(title :Text("edit notes"

        ),)

        , body: Container( padding: EdgeInsets.all(30)
      ,child: ListView(children: [Form(
          key:formstate ,
          child: Column(
            children: [
              TextFormField(
                controller: title,
                decoration:InputDecoration(hintText: "title") ,),
              TextFormField(
                controller: notes,
                decoration:InputDecoration(hintText: "note") ,

              ),TextFormField(
                controller: color,
                decoration:InputDecoration(hintText: "more details........") ,
              ),
              Container(height: 40,
              ),
              MaterialButton(
                textColor: Colors.black,
                color: Colors.blueAccent
                ,onPressed: ()async{
                int tttt = await sqfdb.UpdateData('''
          UPDATE RAWAN SET 
          notes = "${notes.text}" ,
           title = "${title.text}", 
           color ="${color.text}" 
           WHERE id = ${widget.id}
           ''');

                if(tttt>0){Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home() ), (route) => false);}
              },child: Text("save notes"),)
            ],))],),));
  }
}
