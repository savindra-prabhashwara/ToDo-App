// ignore: unused_import
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/db_services/database.dart';
import 'package:random_string/random_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State <HomeScreen> createState() =>  _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool Personal = true, College = false, Office = false;
  bool suggest = false;
  TextEditingController todoController = TextEditingController();
  Stream?todoStream;

  getonTheLoad() async{
    todoStream = await DatabaseService().
    getTask(Personal? "Personal": College? "College": "Office");
    setState(() {
      
    });
  }

void initState(){
  //ToDo: implement initState
  super.initState();
}

Widget getWork(){
  return StreamBuilder(
    stream: todoStream,
    builder: (context, AsyncSnapshot snapshot){
      return snapshot.hasData?
      Expanded(
        child: ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot docSnap = snapshot.data.docs[index];
            return  CheckboxListTile(
              activeColor: Colors.greenAccent.shade400,
              title: Text(docSnap["work"]

              ),
              value: docSnap["Yes"], onChanged: (newValue)async{
              
                await DatabaseService().tickMethod(docSnap["Id"],
                Personal ? "Personal" : College ? "College" : "Office");
                setState((){

                  Future.delayed(Duration(seconds: 2), (){
                                     DatabaseService().removeMethod(docSnap["Id"], 
                  Personal ? "Personal" : College ? "College" : "Office");
                });
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
            );
          }),
      ):Center(child: CircularProgressIndicator());
      
     }
     );
    }

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){
          openbox();
        },
        child: Icon(Icons.add,
        color: Colors.white,
        size: 35,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.white,
             Colors.white38,
             Colors.white10,
           ],
           ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Container(
              child: Text("Hello, Savi!",
              style: TextStyle(
                fontSize: 54,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                textBaseline: TextBaseline.alphabetic,
              ),
              ),
            ),

            SizedBox(height: 10,),
            
            Container(
              child: Text("This Is Your Workspace",
              style: TextStyle(
                fontSize: 32,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              ),
            ),

            SizedBox(height: 10,),

            Container(
              
                height: 3,
                width: 350,
                decoration: BoxDecoration(
                color: Colors.black,
                 borderRadius: BorderRadius.circular(10),
              ),
              ),
            

            SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Personal ? Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade200,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text("Personal",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ):GestureDetector(
                    onTap: ()async{
                      
                        Personal = true;
                        College = false;
                        Office = false;
                        await getonTheLoad();
                        setState(() {
                      });
                    },
                    child: Text("Personal",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),

                College ? Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade200,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text("College",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ):GestureDetector(
                    onTap: ()async{
                      
                        Personal = false;
                        College = true;
                        Office = false;
                        await getonTheLoad();
                          setState(() {
                      });
                    },
                    child: Text("College",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),

                Office ? Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.shade200,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text("Office",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ):GestureDetector(
                    onTap: ()async{
                      
                        Personal = false;
                        College = false;
                        Office = true;
                        await getonTheLoad();
                          setState(() {
                      });
                    },
                    child: Text("Office",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                ),

             

              

                
              ],
            ),

            SizedBox(height: 20,),
       

            getWork(),


          ],
        ),
      ),
    );
  }
  Future openbox(){
    return showDialog(
      context: context,
      builder: (context)=>AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },child: Icon(Icons.close),
                  ),
        
                SizedBox(width: 60.0,),
                Text("Add Task",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                ),
              ],
              ),
        
              SizedBox(height: 20.0,),
              Text("Add a Text"),
              SizedBox(height: 20.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  )
                ), 
              
                child: TextField(
                  controller: todoController,
                  decoration: InputDecoration(
                   border: InputBorder.none,
                    hintText: "Enter the Task",
                  ),
                ),
              ),
              SizedBox(height: 20.0,),
              Center(
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      String id= randomAlphaNumeric(10); 
                      Map<String,dynamic> userTodo={
                        "work": todoController.text,
                        "Id":id,
                        "Yes": false,
                      };
                      Personal? DatabaseService()
                      .addPerosnalTask(userTodo, id)
                      :College? DatabaseService()
                      .addCollegeTask(userTodo, id)
                      : DatabaseService()
                      .addOfficeTask(userTodo, id);
                      Navigator.pop(context);
                      // Handle add task logic here
                    },
                    child: Center(
                      child: Text("Add",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
  ),
    );
  }
}
