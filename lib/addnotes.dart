import 'package:flutter/material.dart';
import 'package:gjntjkbfgjknc/sqflite.dart';

import 'main.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  sqflite sqfdb =sqflite();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController notes = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:

        AppBar(title :Text("add notes"

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
               int tttt = await sqfdb.insertData('''
                   INSERT INTO RAWAN (notes , title, color)
                    VALUES ("${notes.text}","${title.text}","${color.text}")
           '''    );

             if(tttt>0){Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> Home() ), (route) => false);}
            },child: Text("add notes"),)
          ],))],),));
  }
}
