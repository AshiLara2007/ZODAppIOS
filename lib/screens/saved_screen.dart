import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/candidate.dart';
import '../screens/profile_screen.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  List<Candidate> _saved = [];

  @override
  void initState() {
    super.initState();
    _loadSaved();
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? savedJson = prefs.getStringList('saved_profiles');
    if (savedJson != null) {
      setState(() {
        _saved = savedJson.map((jsonStr) => Candidate.fromJson(json.decode(jsonStr))).toList();
      });
    }
  }

  Future<void> _removeCandidate(Candidate c) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedJson = prefs.getStringList('saved_profiles');
    if (savedJson != null) {
      savedJson.removeWhere((jsonStr) => Candidate.fromJson(json.decode(jsonStr)).id == c.id);
      await prefs.setStringList('saved_profiles', savedJson);
      _loadSaved();
    }
  }

  Future<void> _saveCandidate(Candidate c) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedJson = prefs.getStringList('saved_profiles') ?? [];
    // check if already saved
    if (savedJson.any((jsonStr) => Candidate.fromJson(json.decode(jsonStr)).id == c.id)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Already saved')));
      return;
    }
    savedJson.add(json.encode(c.toJson()));
    await prefs.setStringList('saved_profiles', savedJson);
    _loadSaved();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile saved')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Profiles'), backgroundColor: Colors.blue),
      body: _saved.isEmpty
          ? const Center(child: Text('No saved profiles'))
          : ListView.builder(
              itemCount: _saved.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: const Icon(Icons.person),
                title: Text(_saved[i].name),
                subtitle: Text(_saved[i].subCategory),
                trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () => _removeCandidate(_saved[i])),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(candidate: _saved[i]))),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // For simplicity, you could add current candidate from home. 
          // This is just a demo. In real app, you'd pass candidate.
        },
      ),
    );
  }
}