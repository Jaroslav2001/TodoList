import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visualdart/language.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Language language = Language.english();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: language.title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        language: language,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    this.language,
  }) : super(key: key);

  final Language? language;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool text = false;
  String? rename;
  int? index;
  List<String> project = [];

  void _openText(){
    setState(() {
      text = true;
    });
  }

  void _openTextRename(String name, int i){
    setState(() {
      rename = name;
      index = i;
    });
  }

  void _addProject(String text) {
    setState(() {
      project.add(text);
    });
  }

  void removeProject(int index){
    setState(() {
      project.removeAt(index);
    });
  }

  Widget router(){
    if (rename != null){
      return TextField(
        autofocus: true,
        onSubmitted: (text){
          setState(() {
            project[index!] = text;
            index = null;
            rename = null;
          });
        },
      );
    }
    if(this.text){
      return TextField(
        autofocus: true,
        onSubmitted: (text){
          _addProject(text);
          this.text = false;
        },
      );
    }
    return ListView.builder(
      itemCount: project.length,
      itemBuilder: (BuildContext context, int index) {
        return MyBlock(
          title: project[index].toString(),
          index: index,
          removeProject: removeProject,
          renameProject: _openTextRename,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.language!.title)),
      ),
      body: router(),
      floatingActionButton: FloatingActionButton(
        onPressed: _openText,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyBlock extends StatelessWidget {
  const MyBlock({
    Key? key,
    this.title,
    this.index,
    this.removeProject,
    this.renameProject
  }) : super(key: key);

  final String? title;
  final int? index;
  final RemoveProject? removeProject;
  final RenameProject? renameProject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
                title!
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 60,
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: ElevatedButton(
                    onPressed: () {
                      renameProject!(title!,index!);
                    },
                    child: Icon(Icons.title)
                ),
              ),
              Container(
                width: 60,
                child: ElevatedButton(
                    onPressed: (){
                      removeProject!(index!);
                    },
                    child: Icon(Icons.remove)
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

typedef RemoveProject = void Function(int index);
typedef RenameProject = void Function(String name, int i);