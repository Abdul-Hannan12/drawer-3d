import 'package:flutter/material.dart';
import 'my_drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '3D Drawer',
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
      drawer: Material(
        child: Container(
          color: const Color(0xFF24283b),
          child: ListView.builder(
            padding: const EdgeInsets.only(left: 100, top: 100),
            itemCount: 20,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("3D Drawer App"),
          centerTitle: true,
        ),
        body: Container(
          color: const Color(0xff414868),
        ),
      ),
    );
  }
}
