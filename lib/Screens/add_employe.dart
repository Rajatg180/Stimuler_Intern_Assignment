import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  @override
  String date_='YYYY-MM-DD';
  final  textController=TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Employee Data Input'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height*0.5,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
              padding: EdgeInsets.all(5),
              child: TextField(
                controller: textController,
               keyboardType: TextInputType.text,
               cursorColor: Colors.orange,
               decoration: InputDecoration(
                hintText: 'Enter Name',
                border: InputBorder.none
               ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.05,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey)
              ),
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date_,
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_month_outlined,color: Colors.orange,),
                    onPressed: () {
                      DatePicker.showDatePicker(
                              theme: DatePickerTheme(
                                cancelStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                                doneStyle: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 15,
                                )
                              ),
                              context,
                              showTitleActions: true,
                              minTime: DateTime(2015, 1, 1),
                              maxTime: DateTime(2025, 12, 31), 
                              onConfirm: (date) {
                                setState(() {
                                  date_=date.toString();
                                });
                              }, 
                              // locale: LocaleType.en
                              );
                    },
                  )
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
              onPressed: addData,
              child: Text('Submit',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addData()async{
    final FirebaseFirestore _firebase=FirebaseFirestore.instance;
    DateTime id=DateTime.now();
    _firebase.collection('Users').doc(id.toString()).set({'name':textController.text,'time':date_});
    Navigator.pop(context);
  }
}