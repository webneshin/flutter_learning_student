import 'package:flutter/material.dart';
import 'package:flutter_learning_student/data.dart';

void main() {
  getStudents();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
          inputDecorationTheme:
              InputDecorationTheme(border: OutlineInputBorder()),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
          ).copyWith(secondary: Colors.orange)),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Experts'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            final resualt = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return _AddStudentForm();
              },
            ));
            setState(() {});
          },
          label: Text("Add Student"),
          icon: Icon(Icons.add),
        ),
        body: FutureBuilder<List<StudentData>>(
          future: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                padding: EdgeInsets.only(bottom: 85),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _Student(student: snapshot.data![index]);
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Container();
          },
        ));
  }
}

class _AddStudentForm extends StatelessWidget {
  // const _AddStudentForm({super.key});
  final TextEditingController _firstNameControler = TextEditingController();
  final TextEditingController _lastNameControler = TextEditingController();
  final TextEditingController _courseControler = TextEditingController();
  final TextEditingController _scoreControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        // Raveshe 1
        // onPressed: () {
        //   try {
        //     saveStudent(_firstNameControler.text, _lastNameControler.text,
        //             _courseControler.text, int.parse(_scoreControler.text))
        //         .then((value) => Navigator.pop(context));
        //   } catch (e) {
        //     debugPrint(e.toString());
        //   }
        // },

        // Ravesh 2
        onPressed: () async {
          try {
            final newStudent = await saveStudent(
                _firstNameControler.text,
                _lastNameControler.text,
                _courseControler.text,
                int.parse(_scoreControler.text));
            Navigator.pop(context, newStudent);
          } catch (e) {
            debugPrint(e.toString());
          }
        },
        label: Text("Save"),
        icon: Icon(Icons.save),
      ),
      appBar: AppBar(
        title: Text("Add New Student"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameControler,
              decoration: InputDecoration(
                label: Text("First Name"),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _lastNameControler,
              decoration: InputDecoration(
                label: Text("Last Name"),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _courseControler,
              decoration: InputDecoration(
                label: Text("Course"),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            TextField(
              controller: _scoreControler,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text("Score"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Student extends StatelessWidget {
  final StudentData student;

  const _Student({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
      padding: EdgeInsets.all(8),
      height: 84,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05))
          ]),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            child: Center(
                child: Text(
              student.firstName.characters.first.toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w900,
                fontSize: 24,
              ),
            )),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1)),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${student.firstName} ${student.lastName}'),
                  Chip(
                    label: Text(
                      student.course,
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.normal),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.bar_chart_rounded,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
              ),
              Text(student.score.toString())
            ],
          ),
        ],
      ),
    );
  }
}
