import 'dart:convert';
import 'package:http/http.dart'  as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:practical_task/Task1/sqlite_Database.dart';
import 'package:practical_task/Task1/user_data.dart';

class Task1HomeScreen extends StatefulWidget {

  @override
  _Task1HomeScreenState createState() => _Task1HomeScreenState();
}

class _Task1HomeScreenState extends State<Task1HomeScreen> {

  final dbHelper = SQLiteDatabase.instance;

  bool loadingData=true;
  bool hide=false;

  String searchValue="";

  List<UserData> userData=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: hide ? false : true,
        actions: [

          Visibility(
            visible: !hide,
            child: Container(
              margin:EdgeInsets.only(left:5),
              child: InkWell(
                onTap: (){  setState(() { hide=true;  });  },
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child:Icon(Icons.search, size: 30, color: Colors.white),
                ),
              ),
            ),
          ),

        ],
        title: Container(
          child: Row(
            children: [

              Visibility(
                visible: hide,
                child:InkWell(
                    onTap: (){
                      setState(() {
                        searchValue="";
                       // clearSearch=true;
                        hide=false;
                      });
                    },
                     child: Icon(Icons.close,color:Colors.white,)
                ),
              ),

              Visibility(
                visible: !hide,
                child: Flexible(
                  child: Container(
                    child: AutoSizeText('Task 1',style: TextStyle(fontFamily: "FuturaHeavy")),
                  ),
                ),
              ),

              Visibility(
                visible: hide,
                child: Flexible(
                  child: Container(
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0,)),
                    ),
                    //width: 500,
                    margin: EdgeInsets.only(left:10,right:10,top: 5,bottom: 5),
                    child:TextField(
                      autofocus: true,
                      keyboardType: TextInputType.text,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      onChanged: (String value){
                        setState(() {
                          searchValue=value;
                        });
                      },
                      style: TextStyle(fontFamily: "FuturaMedium",fontSize:15,),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 11.3, horizontal: 10.0),
                        prefixIcon: Container(margin: EdgeInsets.all(3.0), child:Icon(Icons.search,color: Colors.blue,size:30,)),
                        hintText:"Search",
                        hintStyle: new TextStyle(fontFamily: "FuturaMedium",color: Colors.grey[300],),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      body: Container(
        child:loadingData
         ?Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                CircularProgressIndicator(backgroundColor: Colors.blue,),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child:AutoSizeText('Loading...',maxFontSize: 17,
                    style: TextStyle(fontFamily: "FuturaMedium",color: Colors.black87),),
                ),

              ],
            ),
          ),
        )
        :Container(
          margin: EdgeInsets.all(10),
          child:ListView.builder(
              shrinkWrap: true,
              itemCount: userData!=null ? userData.length : 0,
              itemBuilder: (context,index){

                if(userData[index].name.toLowerCase().contains(searchValue.toLowerCase()) ||
                    userData[index].username.toLowerCase().contains(searchValue.toLowerCase()) ) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [

                            Container(
                              child: Row(
                                children: [

                                  Container(child: Icon(Icons.person,size: 20,color: Colors.blue[900],)),

                                  Flexible(
                                      child: Container(
                                          padding:EdgeInsets.only(left: 5),
                                          child: AutoSizeText("${userData[index].name}( ${userData[index].username} )",
                                            style: TextStyle(color: Colors.blue[900],fontFamily: "FuturaHeavy"),
                                            minFontSize: 15,
                                            maxLines: 1,overflow: TextOverflow.clip,)
                                      )
                                  )

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top:5,bottom: 5),
                              child: Row(
                                children: [

                                  Container(child: Icon(Icons.call,size: 20,color: Colors.blue[900],)),

                                  Flexible(
                                      child: Container(
                                          padding:EdgeInsets.only(left: 5),
                                          child: AutoSizeText("${userData[index].phone}",
                                            style: TextStyle(fontFamily: "FuturaMedium"),
                                            minFontSize: 12,maxLines: 1,overflow: TextOverflow.clip,)
                                      )
                                  )

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [

                                  Container(child: Icon(Icons.location_on_outlined,size: 20,color: Colors.blue[900],)),

                                  Flexible(
                                      child: Container(
                                          padding:EdgeInsets.only(left: 5),
                                          child: AutoSizeText("${userData[index].address.street}, ${userData[index].address.suite}, ${userData[index].address.city} - ${userData[index].address.zipcode}",
                                            style: TextStyle(fontFamily: "FuturaMedium"),
                                            minFontSize: 12,overflow: TextOverflow.clip,)
                                      )
                                  )

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [

                                  Container(child: Icon(Icons.email,size: 20,color: Colors.blue[900],)),

                                  Flexible(
                                      child: Container(
                                          padding:EdgeInsets.only(left: 5),
                                          child: AutoSizeText("${userData[index].email}",
                                            style: TextStyle(fontFamily: "FuturaMedium"),
                                            minFontSize: 12,overflow: TextOverflow.clip,)
                                      )
                                  )

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [

                                  Container(child: Icon(Icons.web,size: 20,color: Colors.blue[900],)),

                                  Flexible(
                                      child: Container(
                                          padding:EdgeInsets.only(left: 5),
                                          child: AutoSizeText("${userData[index].website}",
                                            style: TextStyle(fontFamily: "FuturaMedium"),
                                            minFontSize: 12,overflow: TextOverflow.clip,)
                                      )
                                  )

                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [

                                  Container(child: Icon(Icons.location_city_sharp,size: 20,color: Colors.blue[900],)),

                                  Flexible(
                                      child: Container(
                                          padding:EdgeInsets.only(left: 5),
                                          child: AutoSizeText("${userData[index].company.name}, ${userData[index].company.catchPhrase}, ${userData[index].company.bs}",
                                            style: TextStyle(fontFamily: "FuturaMedium"),
                                            minFontSize: 12,overflow: TextOverflow.clip,)
                                      )
                                  )

                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }
                else return Container();

              }
          )
        )

      ),
    );
  }


  fetchUserData()async{

    try{

      userData.clear();

      String url="https://jsonplaceholder.typicode.com/users";

      final response = await http.Client().get(url);

      print("User data response...${response.body}");

      var data = json.decode(response.body);

      if (data!= null && data.length>0) {
        //deleting data due to duplication of value because it will save again again when api give response.
        dbHelper.deleteUserData();
        dbHelper.deleteCompanyData();
        dbHelper.deleteAddressData();

        for(int i=0;i<data.length;i++){
          //inserting data in database

          Map<String, dynamic> row = {
            SQLiteDatabase.Name: '${data[i]["name"]}',
            SQLiteDatabase.UserName: '${data[i]["username"]}',
            SQLiteDatabase.Email: '${data[i]["email"]}',
            SQLiteDatabase.Phone:'${data[i]["phone"]}',
            SQLiteDatabase.Website:'${data[i]["website"]}',
            SQLiteDatabase.IdCompany:i+1,
            SQLiteDatabase.IdAddress:i+1,
          };
          dbHelper.insertData(row);

          Map<String, dynamic> companyData = {
            SQLiteDatabase.CompanyName: '${data[i]["company"]["name"]}',
            SQLiteDatabase.CatchPhrase: '${data[i]["company"]["catchPhrase"]}',
            SQLiteDatabase.BS: '${data[i]["company"]["bs"]}',
          };
          dbHelper.insertCompanyData(companyData);

          Map<String, dynamic> addressData = {
            SQLiteDatabase.Street: '${data[i]["address"]["street"]}',
            SQLiteDatabase.Suite: '${data[i]["address"]["suite"]}',
            SQLiteDatabase.City: '${data[i]["address"]["city"]}',
            SQLiteDatabase.Zipcode: '${data[i]["address"]["zipcode"]}',
          };
          dbHelper.insertAddressData(addressData);
        }//for

        //fetching data
        final allUserData = await dbHelper.fetchAllData();

        setState(() {
          userData = allUserData.map<UserData>((json) => UserData.fromJson(json)).toList();
        });
        await Future.delayed(Duration(seconds:2));
        setState(() {   loadingData = false; });
      }
      else {
        setState(() {
          loadingData = false;
          userData = [];
        });

        Navigator.of(context,rootNavigator: true).pop();
        Flushbar(
          message: 'Something went wrong, please retry after some time.',
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
          flushbarPosition: FlushbarPosition.BOTTOM,
          icon: Icon(Icons.close,color: Colors.white,),
        )..show(context);

      }//else

    }catch(e){
      print("Try Catch error...$e");
      setState(() { loadingData = false;  userData = [];});
      Navigator.of(context,rootNavigator: true).pop();
      Flushbar(
        message: 'Something went wrong, please retry after some time',
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.BOTTOM,
        icon: Icon(Icons.close,color: Colors.white,),
      )..show(context);
    }
  }//func

}
