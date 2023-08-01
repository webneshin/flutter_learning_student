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
    return const MaterialApp(home: HomeScreen());
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Experts'),
        ),
        body: FutureBuilder<List<StudentData>>(
          future: getStudents(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
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
