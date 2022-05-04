import 'package:flutter/material.dart';

class UpdateDeleteUI extends StatefulWidget {
  const UpdateDeleteUI({Key? key}) : super(key: key);

  @override
  State<UpdateDeleteUI> createState() => _UpnDeUIState();
}

class _UpnDeUIState extends State<UpdateDeleteUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'รายละเอียดข้อมูล (แก้ไข/ลบ)',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Text(
          'UpdateDeleteUI',
        ),
      ),
    );
  }
}
