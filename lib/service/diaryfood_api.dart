//ไฟล์หรือคลาสนี้จะทำการเรียกใช้ api ต่างๆที่ server เพื่อทำงานกับตาราง diaryfood_tb
//ซึ่งจะเขียนในรูปแบบของ method
import 'dart:convert';
import 'package:flutter_app_mydiaryfood/models/diaryfood.dart';
import 'package:flutter_app_mydiaryfood/service/env.dart';
import 'package:http/http.dart' as http;

class DiaryfoodAPI {
  //เมธอดเรียกใช้ API getall (api_getall_diaryfood.php)

  //เพื่อดึงข้อมูลทั้งหมดมาแสดง
  static Future<List<Diaryfood>> getAllDiaryfood() async {
    final res = await http.get(
      Uri.parse('${Env.SERVER_URL}/getall'),
      headers: {"Content-Type": "application/json"},
    );
    if (res.statusCode == 200) {
      //ถอดข้อมูลที่เป็น json ที่ส่งกลับมาเก็บในตัวแปร

      final resData = jsonDecode(res.body);

      //แปลงข้อมูลให้อยู่ในรูปของ List

      final diaryfoodData = await resData.map<Diaryfood>((json) {
        return Diaryfood.fromJson(json);
      }).toList();

      //ส่งค่าข้อมูลในรูปแบบของ List ไปใช้งาน

      return diaryfoodData;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}
