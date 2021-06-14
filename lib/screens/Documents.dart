import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:leo_v1/widgets/footer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';



class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  final Dio dio = Dio();
  bool loading = false;
  bool loading2 = false;
  double progress = 0;

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/LEOApp";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
              setState(() {
                progress = value1 / value2;
              });
            });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 30),
            height: MediaQuery.of(context).size.height * 0.30,
            width: MediaQuery.of(context).size.width,
            color: mainColor,
            child: Image.asset(
              'images/logo.png',
              width: 200,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'File 1',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: loading
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LinearProgressIndicator(
                            minHeight: 10,
                            value: progress,
                          ),
                        )
                            : IconButton(
                          icon: Icon(
                            Icons.download_rounded,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                              progress = 0;
                            });
                            bool downloaded = await saveFile(
                                "https://www.leotunisia.tn/media/Lordre-du-jour-de-la-reunion-de-cloture-Convention2k21.pdf",
                                "Lordre-du-jour-de-la-reunion-de-cloture-Convention2k21.pdf");
                            if (downloaded) {
                              Fluttertoast.showToast(
                                  msg: "File Downloaded", toastLength: Toast.LENGTH_SHORT);
                              print("File Downloaded");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Problem Downloading File", toastLength: Toast.LENGTH_SHORT);
                              print("Problem Downloading File");
                            }
                            setState(() {
                              loading = false;
                            });
                          },
                          padding: const EdgeInsets.all(10),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'File 2',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: loading2
                            ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LinearProgressIndicator(
                            minHeight: 10,
                            value: progress,
                          ),
                        )
                            : IconButton(
                          icon: Icon(
                            Icons.download_rounded,
                            color: Colors.green,
                          ),
                          onPressed: () async {
                            setState(() {
                              loading2 = true;
                              progress = 0;
                            });
                            bool downloaded = await saveFile(
                                "https://www.leotunisia.tn/media/Lordre-du-jour-de-la-reunion-douverture-Convention-2k21.pdf",
                                "Lordre-du-jour-de-la-reunion-douverture-Convention-2k21.pdf");
                            if (downloaded) {
                              Fluttertoast.showToast(
                                  msg: "File Downloaded", toastLength: Toast.LENGTH_SHORT);
                              print("File Downloaded");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Problem Downloading File", toastLength: Toast.LENGTH_SHORT);
                              print("Problem Downloading File");
                            }
                            setState(() {
                              loading2 = false;
                            });
                          },
                          padding: const EdgeInsets.all(10),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: footer(),
    );
  }
}
