import 'package:flutter/material.dart';
import 'package:flutter_sqflite_homework/addform.dart';
import 'package:flutter_sqflite_homework/database.dart';
import 'package:flutter_sqflite_homework/model.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int screenIndex = 0;

  //------ หน้าจอแต่ละหน้า ------
  final mobileScreens = [
    home(),
    search(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(39, 45, 47, 1),
        title: Center(
          child: Text(
            'iNotes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      //------ เรียกหน้าจอแต่ละหน้าตาม Index ------
      body: mobileScreens[screenIndex],
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              screenIndex = 1;
            });
            Navigator.push(
                context, MaterialPageRoute(builder: ((context) => addForm())))
                .then((_) {
                  setState(() {
                    screenIndex = 0;
                  });
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.lightBlue.shade300,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      //------ bottomNavigationBar ------
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(39, 45, 47, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    //------ กำหนดค่า Index เมื่อมีการคลิก ------
                    screenIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  //------ ถ้า Index = 0 ให้ไอคอนสีเหลือง ถ้าไม่ใช้ไอคอนสีขาว ------
                  color: screenIndex == 0
                      ? Color.fromRGBO(238, 224, 201, 1)
                      : Colors.white,
                  // color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    screenIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: screenIndex == 1
                      ? Color.fromRGBO(238, 224, 201, 1)
                      : Colors.white,
                  // color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.widgets,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}

var db = AppDatabase();

//------------- Home page -------------
class home extends StatelessWidget {
  const home({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<NoteModel>>(
          future: db.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  NoteModel topic = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {},
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: Icon(Icons.list_alt_sharp, color: Colors.white),
                      ),
                      title: Text('${topic.title}'),
                      subtitle: Container(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text('${topic.description}'),
                            ],
                          )),
                      trailing: Container(
                        width: 70,
                        child: Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: Color.fromARGB(39, 45, 47, 1),
                                  )),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    )))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            } else {
              return Text('No data');
            }
          }),
    );
  }
}

//------------- Search page -------------
class search extends StatelessWidget {
  const search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text('Search')],
        ),
      ),
    );
  }
}
