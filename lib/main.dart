
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gjntjkbfgjknc/addnotes.dart';
import 'package:gjntjkbfgjknc/edit.dart';
import 'package:gjntjkbfgjknc/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          surface: Colors.blueAccent,
          onSurface: Colors.black,
          // Colors that are not relevant to AppBar in DARK mode:
          primary: Colors.grey,
          onPrimary: Colors.grey,
          primaryVariant: Colors.grey,
          secondary: Colors.grey,
          secondaryVariant: Colors.grey,
          onSecondary: Colors.grey,
          background: Colors.grey,
          onBackground: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
        ),
      ),
      home: Home(),
      routes: {"addnotes": (context) => AddNotes()},
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  sqflite sqfdb =sqflite();
  bool isLoading = true;
List notes =[];
  Future ReadData() async{
    List<Map> response = await sqfdb.ReadData("SELECT * FROM 'RAWAN'");
    notes.addAll(response);
    isLoading = false;
  if(this.mounted){
    setState(() {
  });}
}
@override
  void initState() {
  ReadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Center(child: const Text ("Notes Page")),),
      floatingActionButton:
      FloatingActionButton(onPressed: (){
        Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add,
          color: Colors.black,),) ,
        body:

        isLoading == true ?
            Center(child: Text("is loading ...."))
         :Container(child:
        ListView(children: [
      MaterialButton(
        onPressed: ()async{
          await sqfdb.mydeletedatabase();
          },
        child: Text("delete database"),),

          ListView.builder(
            itemCount: notes.length,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemBuilder: (context,i){
    return Card(child: ListTile(title: Text("${notes[i]['title']}"),

      subtitle: Text("${notes[i]['notes']}"),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [         IconButton(
          onPressed: ()async{

            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>editNotes(
                  color:notes[i]['color'] ,
                  notes: notes[i]['notes'],
                  title:  notes[i]['title'],
                  id:  notes[i]['id'],
                )
                ));
          },
          icon:Icon(Icons.edit),color: Colors.blueAccent,),
          IconButton(onPressed: ()async{
            int respons = await sqfdb.DeleteData(" DELETE FROM RAWAN WHERE id= ${notes[i]['id']}" );
            if(respons>0){
              notes.removeWhere((element) => element['id'] == notes[i]['id']); setState(() {

              });

            }
          },
            icon:Icon(Icons.delete),color: Colors.blueAccent,),



        ],
      ),


    ),

    );
    },

    )


      ],)



      )
    );
  }
}

