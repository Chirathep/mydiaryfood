import 'package:flutter/material.dart';
import 'package:flutter_app_mydiaryfood/models/diaryfood.dart';
import 'package:flutter_app_mydiaryfood/service/diaryfood_api.dart';
import 'package:flutter_app_mydiaryfood/service/env.dart';
import 'package:flutter_app_mydiaryfood/views/insert_diaryfood_ui.dart';
import 'package:flutter_app_mydiaryfood/views/update_delete_diaryfood_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //สร้างตัวแปรเก็บข้อมูลที่ได้จากการเรยกใช้เมธอด getAllDiaryfood จาก diaryfood_api.dart
  Future<List<Diaryfood>>? diaryfoodData;

  //สร้างเมธอดเพื่อเรียกใช้ เมธอด getAllDiaryfood ที่ diaryfood_api.dart
  //เพื่อมากำหนดให้กับตัวแปร diaryfoodData เพื่อนำไปใช้กับ ListView ที่จะแสดงผลที่หน้าจอ
  getAllDiaryData() {
    setState(() {
      diaryfoodData = DiaryfoodAPI.getAllDiaryfood();
    });
  }

  @override
  void initState() {
    //ใช้เมธอด getAllDiaryfood ซึ่งจะไปเรียก เมธอด getAll Diaryfood
    getAllDiaryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('บันทึกการกิน V.1.0'),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/add');
        //     },
        //   ),
        // ],
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/banner.jpg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: FutureBuilder(
                future: diaryfoodData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //เช็คว่าข้อมูลมาหรือยัง
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        print(
                            '${Env.SERVER_URL}/picture_diaryfood/food3b02cf0875c1fae9e971eed4ab045491.jpg');
                        //แต่ละรายการของ listview
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 10.0,
                          ),
                          child: ListTile(
                            onTap: () {
                              //เปิดหน้า update
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateDeleteUI(),
                                  ));
                            },
                            tileColor: index % 2 == 0
                                ? Colors.green[200]
                                : Colors.grey[300],
                            leading: CircleAvatar(
                              backgroundImage: Image.network(
                                '${Env.SERVER_URL}/picture_diaryfood/${snapshot.data[index].foodImage}',
                                // '${Env.SERVER_URL}/picture_diaryfood/food3b02cf0875c1fae9e971eed4ab045491.jpg',
                                // '',
                              ).image,
                            ),
                            title: Text(
                              snapshot.data[index].foodShopname,
                            ),
                            subtitle: Text(
                                'บันทึกวันที่ : ${snapshot.data[index].foodDate}'),
                            trailing: Text(
                              'ดูข้อมูล',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          //เปิดหน้า AddDiaryfoodUI
          //เพิ่มได้
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => InsertUI()));
        },
      ),
    );
  }
}
