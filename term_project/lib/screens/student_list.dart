import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:term_project/screens/studentsignup.dart';
import '../data/dbhelper.dart';
import '../models/Student.dart';

//THIS PAGE IS A DEVELOPMENT TESTING PAGE

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  var dbHelper = DbHelper();
  List<Student>? students;
  int studentsCount = 0;

  @override
  void initState() {
    getStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Öğrenci Listesi")),
      body: buildStudentList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToStudentAdd();
        },
        child: Icon(Icons.add),
        tooltip: "kayıt ol",
      ),
    );
  }

  ListView buildStudentList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          color: Colors.cyan,
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black12,
              child: Text("s"),
            ),
            title: Text(this.students![index].username!),
            subtitle: Text("more student information"),
            onTap: () {},
          ),
        );
      },
      itemCount: studentsCount,
    );
  }

  void goToStudentAdd() async {
    try {
      bool result = await Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) {
          return StudentSignUpPage();
        },
      ));
      if (result) {
        getStudents();
      }
    } catch (e) { 
        
    }
  }

  void getStudents() {
    var studentsFuture = dbHelper.getStudents();
    studentsFuture.then((value) {
      this.students = value;
      this.studentsCount = value.length;
    });
  }
}
