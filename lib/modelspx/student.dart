
import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
   Student({required this.email, required this.id});

   final String id;
   final String email;
}
class StudentData {

   final String id;
   final String name;
   final String email;

   final String phone;
   final String hostelname;
   final bool disable;
   final String blocknumber;
   final int engagements;

   final String roomnumber;
   final Timestamp timestamp;
   final Timestamp disablestamp;




   StudentData({required this.roomnumber,required this.phone,required this.engagements,required this.hostelname,required this.blocknumber,required this.disablestamp,required this.disable,required this.id,required this.name,required this.timestamp,required this.email});
}


String x_State="";
bool x_Snulle=true;

