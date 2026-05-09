import 'package:flutter/material.dart';
import '../models/candidate.dart';
import '../services/api_service.dart';
import '../widgets/candidate_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Candidate> _allCandidates = [];
  List<Candidate> _filtered = [];
  bool _loading = true;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedCountry = 'All';
  bool _returnedOnly = false;

  final List<String> _categories = ['All', 'House Maids', 'Cooks', 'Drivers', 'Nurses', 'Teachers', 'Returned', 'Recruitment'];
  final List<String> _countries = ['All', 'INDONESIA', 'SRI LANKA', 'PHILIPPINES', 'BANGLADESH', 'INDIA', 'ETHIOPIA', 'KENYA', 'UGANDA'];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    try {
      final api = ApiService();
      final data = await api.fetchTalents();
      setState(() {
        _allCandidates = data;
        _filtered = List.from(data);
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  void _applyFilters() {
    List<Candidate> filtered = List.from(_allCandidates);
    if (_returnedOnly) {
      filtered = filtered.where((c) => c.workerType == 'Returned Housemaids').toList();
    }
    if (_selectedCategory != 'All') {
      filtered = filtered.where((c) => c.category == _selectedCategory).toList();
    }
    if (_selectedCountry != 'All') {
      filtered = filtered.where((c) => c.nationality == _selectedCountry).toList();
    }
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((c) => c.name.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }
    setState(() => _filtered = filtered);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ZOD MANPOWER'), backgroundColor: Colors.blue),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Search by name...', prefixIcon: Icon(Icons.search)),
              onChanged: (val) {
                _searchQuery = val;
                _applyFilters();
              },
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                DropdownButton<String>(
                  value: _selectedCategory,
                  items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) { setState(() { _selectedCategory = val!; _applyFilters(); }); },
                ),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: _selectedCountry,
                  items: _countries.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (val) { setState(() { _selectedCountry = val!; _applyFilters(); }); },
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    const Text('Returned only'),
                    Switch(value: _returnedOnly, onChanged: (val) { setState(() { _returnedOnly = val; _applyFilters(); }); }),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(alignment: Alignment.centerLeft, child: Text('${_filtered.length} candidates found')),
          ),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _filtered.length,
                    itemBuilder: (ctx, i) => CandidateCard(candidate: _filtered[i]),
                  ),
          ),
        ],
      ),
    );
  }
}