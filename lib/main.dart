import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:practical_task/Task1/task1_home_screen.dart';
import 'package:practical_task/Task2/task2_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Practical Task'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            InkWell(
              onTap: (){
                Navigator.of(context).push(PageTransition(curve:Curves.decelerate,type: PageTransitionType.rightToLeft,
                    child: Task1HomeScreen() ) );
              },
              child:Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin:FractionalOffset.centerLeft,
                      end:FractionalOffset.centerRight,
                      colors:[Colors.blue[600],Colors.blue[300],Colors.blue[600]],
                    )
                ),
                padding: EdgeInsets.only(left:30,right: 30,top: 15,bottom: 15),
                child:AutoSizeText('Task 1',minFontSize: 20,maxFontSize: 30,
                  style: TextStyle(fontFamily: "FuturaHeavy",color: Colors.white),),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.of(context).push(PageTransition(curve:Curves.decelerate,type: PageTransitionType.rightToLeft,
                    child: Task2HomeScreen() ) );
              },
              child:Container(
                margin: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin:FractionalOffset.centerLeft,
                      end:FractionalOffset.centerRight,
                      colors:[Colors.blue[600],Colors.blue[300],Colors.blue[600]],
                    )
                ),
                padding: EdgeInsets.only(left:30,right: 30,top: 15,bottom: 15),
                child:AutoSizeText('Task 2',minFontSize: 20,maxFontSize: 30,
                  style: TextStyle(fontFamily: "FuturaHeavy",color: Colors.white),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
