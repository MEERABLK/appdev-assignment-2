import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RegisterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RegisterPage extends StatefulWidget {
  final User? editingUser;

  const RegisterPage({super.key, this.editingUser});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Database? database;

  final _idController = TextEditingController();
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _marksController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeDatabase();

    if (widget.editingUser != null) {
      _idController.text = widget.editingUser!.id.toString();
      _fnameController.text = widget.editingUser!.fname;
      _lnameController.text = widget.editingUser!.lname;
      _marksController.text = widget.editingUser!.marks.toString();
    }
  }

  Future<void> initializeDatabase() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'usersdatabase.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, fname TEXT, lname TEXT, marks INTEGER)');
      },
    );
  }

  Future<void> insertUser(User user) async {
    await database!.insert('users', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(User user) async {
    await database!.update('users', user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  void clearForm() {
    _idController.clear();
    _fnameController.clear();
    _lnameController.clear();
    _marksController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.editingUser != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit User' : 'Register'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(80),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(labelText: 'ID'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _fnameController,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _lnameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
                const SizedBox(height: 30),
                TextField(
                  controller: _marksController,
                  decoration: const InputDecoration(labelText: 'Marks'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                    backgroundColor: Colors.deepPurpleAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                  ),
                  onPressed: () async {
                    final fname = _fnameController.text.trim();
                    final lname = _lnameController.text.trim();
                    final marks = int.tryParse(_marksController.text) ?? 0;
                    final id = int.tryParse(_idController.text);

                    if (fname.isEmpty || lname.isEmpty) return;

                    if (isEditing) {
                      await updateUser(User(
                        id: widget.editingUser!.id,
                        fname: fname,
                        lname: lname,
                        marks: marks,
                      ));
                    } else {
                      await insertUser(
                        User(
                            id: id ?? 0,
                            fname: fname,
                            lname: lname,
                            marks: marks),
                      );
                    }

                    clearForm();

                    // Move to details page after registering or updating
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailsPage()),
                    );
                  },
                  child: Text(isEditing ? 'UPDATE' : 'REGISTER'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Database? database;
  List<User> userList = [];

  @override
  void initState() {
    super.initState();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, 'usersdatabase.db');
    database = await openDatabase(path, version: 1);
    await refreshUsers();
  }

  Future<void> refreshUsers() async {
    final List<Map<String, dynamic>> maps =
    await database!.query('users', orderBy: 'id DESC');
    setState(() {
      userList = List.generate(maps.length, (i) {
        return User(
          id: maps[i]['id'],
          fname: maps[i]['fname'],
          lname: maps[i]['lname'],
          marks: maps[i]['marks'],
        );
      });
    });
  }

  Future<void> deleteUser(int id) async {
    await database!.delete('users', where: 'id = ?', whereArgs: [id]);
    await refreshUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
      ),
      body: userList.isEmpty
          ? const Center(child: Text('No Users Registered'))
          : ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user.id.toString()),
              ),
              title: Text('${user.fname} ${user.lname}'),
              subtitle: Text('Marks: ${user.marks}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit,
                        color: Colors.deepPurpleAccent),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RegisterPage(editingUser: user),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await deleteUser(user.id!);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
          );
        },
        label: const Text('RETURN'),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}

class User {
  final int? id;
  final String fname;
  final String lname;
  final int marks;

  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.marks,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'marks': marks,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, fname: $fname, lname: $lname, marks: $marks}';
  }
}
