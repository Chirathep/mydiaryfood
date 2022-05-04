import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class InsertUI extends StatefulWidget {
  const InsertUI({Key? key}) : super(key: key);

  @override
  State<InsertUI> createState() => _InsertUIState();
}

class _InsertUIState extends State<InsertUI> {
  //-------------------CAMERA-------------------//
  //start code: open camara
  XFile? imageFile;
  pickImage(sourceImage) async {
    //code open camera
    final photo = await ImagePicker().pickImage(
      source: sourceImage,
      imageQuality: 75,
      preferredCameraDevice: CameraDevice.rear,
    );
    //เอารูปที่ได้จาก camera/gallery ไปใช้งาน
    setState(() {
      imageFile = photo;
    });
  }
  //-------------------CAMERA-------------------//

  //-------------------MAP-------------------//
  //start code: open map
  GoogleMapController? _controller;

  //-------------------MAP-------------------//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('เพิ่มข้อมูลการกิน'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.height * 0.45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 10,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageFile == null
                                ? AssetImage(
                                    'assets/images/banner.jpg',
                                  )
                                : FileImage(
                                    File(imageFile!.path),
                                  ) as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 180, left: 200),
                        child: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'เลือกรูปจาก\nกล้องหรืออัลบั้ม',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Divider(),
                                    //code: open camera
                                    ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        //open camera
                                        pickImage(ImageSource.camera);
                                      },
                                      leading: Icon(
                                        Icons.camera_alt,
                                        color: Colors.blue,
                                      ),
                                      title: Text('Camera/กล้องถ่ายรูป'),
                                    ),
                                    Divider(),
                                    //code: open gallery
                                    ListTile(
                                      onTap: () {
                                        //ปิด modal
                                        Navigator.pop(context);
                                        //เปิด gallery
                                        pickImage(ImageSource.gallery);
                                      },
                                      leading: Icon(
                                        Icons.photo_album,
                                        color: Colors.orange,
                                      ),
                                      title: Text('อัลบั้มรูปภาพ'),
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.green,
                            size: 30.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 300.0,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(13.7073451, 100.3539168),
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('myMarker'),
                      position: LatLng(13.7073451, 100.3539168),
                      infoWindow: InfoWindow(
                        title: 'ม.เอเชีย',
                        snippet: 'ม.เอเชีย',
                        //modal
                      ),
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
