import 'dart:convert';
import 'dart:typed_data';
import 'package:counter/src/global.dart';
import 'package:counter/src/model/student_model.dart';
import 'package:counter/src/pages/attendence/attendence.dart';
import 'package:counter/src/pages/splash.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Student student;
  Uint8List? list;
  bool isLoading = true;
  late String name;
  late String regdNo;

  @override
  void initState() {
    fetchStudentInfo();
    requestImg();
    super.initState();
  }

  void requestImg() async {
    //login this  user and get Cookie and then call image section.
    try {
      final https.Response response = await https.get(
        Uri.parse(
            'http://115.240.101.71:8282/CampusPortalSOA/image/studentPhoto'),
        headers: {
          'Cookie': 'JSESSIONID=${sharedPreferences.getString('cookie')}',
        },
      );
      // print(profileImage);
      setState(() {
        list = response.bodyBytes;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  fetchStudentInfo() async {
    try {
      var response = await https.post(
          Uri.parse('http://115.240.101.71:8282//CampusPortalSOA/studentinfo'),
          headers: {
            "Cookie": "JSESSIONID=${sharedPreferences.getString('cookie')}"
          });

      var decoded = jsonDecode(response.body);
      if (decoded["detail"].isEmpty) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SplashScreen()));
      } else {
        student = Student(
          branch: decoded["detail"][0]["branchdesc"],
          dob: decoded["detail"][0]["dateofbirth"],
          email: decoded["detail"][0]["semailid"],
          name: decoded["detail"][0]["name"],
          regdNo: decoded["detail"][0]["enrollmentno"],
          sec: decoded["detail"][0]["sectioncode"],
          mname: decoded["detail"][0]["mothersname"],
          phone: decoded["detail"][0]["scellno"],
          bloodgroup: decoded["detail"][0]["bloodgroup"] ?? "Not Given!",
          cstatename: decoded["detail"][0]["cstatename"],
        );
      }

      setState(() {
        // name = decoded["detail"][0]["name"];
        // regdNo = decoded["detail"][0]["enrollmentno"];
        isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      list == null
                          ? const CircularProgressIndicator()
                          : Align(
                              child: CircleAvatar(
                                radius: 60,
                                child: CircleAvatar(
                                  backgroundImage: MemoryImage(list!),
                                  radius: 55,
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Center(
                          child: Text(
                            student.name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 235, 104, 48),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Center(
                          child: Text(
                            student.regdNo,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 60, 194, 239),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Center(
                          child: Text(
                            student.email,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 22, 97, 216),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Center(
                          child: Text(
                            student.sec,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 225, 64, 190),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Center(
                          child: Text(
                            "DOB: ${student.dob}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 224, 255, 112),
                            borderRadius:
                                BorderRadius.all(Radius.circular(35))),
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Center(
                          child: Text(
                            student.mname,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14)))),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const Attendance()));
                            },
                            child: const Text("Attendance")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
