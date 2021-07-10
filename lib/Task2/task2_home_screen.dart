import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Task2HomeScreen extends StatefulWidget {

  @override
  _Task2HomeScreenState createState() => _Task2HomeScreenState();
}

class _Task2HomeScreenState extends State<Task2HomeScreen> {

  GlobalKey<FormState> _formKey=new GlobalKey();

  final _titleController=new TextEditingController();
  final _messageController=new TextEditingController();

  FocusNode _titleNode=new FocusNode();
  FocusNode _messageNode=new FocusNode();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  bool hideButton=false;

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _messageController.dispose();
    _messageNode.dispose();
    _titleNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid = new AndroidInitializationSettings('icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText('Task 2',style: TextStyle(fontFamily: "FuturaHeavy")),
      ),
      body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Visibility(
                    visible: !hideButton,
                    child: InkWell(
                      onTap: (){    setState(() {  hideButton=true; _titleController.text="" ; _messageController.text=""; });  },
                      child:Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              begin:FractionalOffset.centerLeft,
                              end:FractionalOffset.centerRight,
                              colors:[Colors.blue[600],Colors.blue[300],Colors.blue[600]],
                            )
                        ),
                        padding: EdgeInsets.all(20),
                        child:AutoSizeText('Send Notification',minFontSize: 20,maxFontSize: 30,
                          style: TextStyle(fontFamily: "FuturaHeavy",color: Colors.white),),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: hideButton,
                    child:Container(
                      child: formUI(),
                    )
                  ),

                ],
              ),
            ),
      ),
    );
  }

  Widget formUI(){

    return Container(
      decoration: BoxDecoration(
          color:Colors.grey[200] ,
          borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        autovalidate: false,
        child: Column(
          children: [

            Container(
                child: Row(
                  children: <Widget>[
                    AutoSizeText("Title ",minFontSize:20,style:TextStyle(fontFamily: "FuturaMedium",color: Colors.black87)),
                    AutoSizeText("\u002a ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ],
                )
            ),

            Container(
              height: 50,
              child:TextFormField(
                keyboardType:TextInputType.text,
                style:TextStyle(fontFamily: "FuturaMedium"),
                decoration: InputDecoration(
                  enabledBorder:UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  errorBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]),
                  ),
                ),
                validator:validateTitleField,
                controller: _titleController,
                focusNode: _titleNode,
              ),
            ),


            Container(
              margin: EdgeInsets.only(top:20),
                child: Row(
                  children: <Widget>[
                    AutoSizeText("Message ",minFontSize:18,style:TextStyle(fontFamily: "FuturaMedium",color: Colors.black87)),
                    AutoSizeText("\u002a ",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ],
                )
            ),

            Container(
              child:TextFormField(
                keyboardType:TextInputType.text,
                maxLines: 2,
                style:TextStyle(fontFamily: "FuturaMedium"),
                decoration: InputDecoration(
                  enabledBorder:UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                  ),
                  errorBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue[900]),
                  ),
                ),
                validator:validateMessageField,
                controller: _messageController,
                focusNode: _messageNode,
              ),
            ),

            Container(
                margin: EdgeInsets.only(top:30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    InkWell(
                      onTap: (){  setState(() {  hideButton=false;  });   },
                      child:Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              begin:FractionalOffset.centerLeft,
                              end:FractionalOffset.centerRight,
                              colors:[Colors.blue[600],Colors.blue[300],Colors.blue[600]],
                            )
                        ),
                        padding: EdgeInsets.all(15),
                        child:AutoSizeText('CANCEL',minFontSize: 20,maxFontSize: 30,
                          style: TextStyle(fontFamily: "FuturaHeavy",color: Colors.white),),
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        if(_formKey.currentState.validate()){
                          setState(() {  hideButton=false;  });
                          _showNotification(1234, "${_titleController.text}", "${_messageController.text}", "");
                        }
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
                        padding: EdgeInsets.all(15),
                        child:AutoSizeText('SEND',minFontSize: 20,maxFontSize: 30,
                          style: TextStyle(fontFamily: "FuturaHeavy",color: Colors.white),),
                      ),
                    ),

                  ],

                )
            ),

          ],
        ),
      ),
    );

  }

  Future<void> _showNotification(
      int notificationId,
      String notificationTitle,
      String notificationContent,
      String payload ,
      {
        String channelId = '1234',
        String channelTitle = 'Android Channel',
        String channelDescription = 'Default Android Channel for notifications',
        Priority notificationPriority = Priority.High,
        Importance notificationImportance = Importance.Max,
      })async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      channelId,
      channelTitle,
      channelDescription,
      playSound: true,
      sound:RawResourceAndroidNotificationSound('local_notification'),
      importance: notificationImportance,
      priority: notificationPriority,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails(presentAlert: true, presentSound: true,presentBadge: true,sound: "local_notification",);
    var platformChannelSpecifics = new NotificationDetails( androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      notificationTitle,
      notificationContent,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  Future onSelectNotification(String data) async { }

  String validateTitleField(String value) {
    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_titleNode);
      return "Field is required.";
    }
    return null;
  }

  String validateMessageField(String value) {
    if (value.length == 0) {
      FocusScope.of(context).requestFocus(_messageNode);
      return "Field is required.";
    }
    return null;
  }

}
