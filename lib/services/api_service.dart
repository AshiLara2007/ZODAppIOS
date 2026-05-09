import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/candidate.dart';

class ApiService {
  static const String apiUrl = 'https://zodmanpower.info/api/talents';
  static const String cacheKey = 'zod_candidates_cache';

  Future<List<Candidate>> fetchTalents({bool useOffline = true}) async {
    // 1. Try cache first
    List<Candidate>? cached = await _getCachedCandidates();
    if (cached != null && cached.isNotEmpty) {
      _fetchAndUpdateCache(); // background update
      return cached;
    }
    return await _fetchFromNetwork();
  }

  Future<List<Candidate>> _fetchFromNetwork() async {
    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Candidate> candidates = jsonList.map((json) => Candidate.fromJson(json)).toList();
        await _saveToCache(candidates);
        return candidates;
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<void> _fetchAndUpdateCache() async {
    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<Candidate> candidates = jsonList.map((json) => Candidate.fromJson(json)).toList();
        await _saveToCache(candidates);
      }
    } catch (e) {
      // ignore: silent fail
    }
  }

  Future<void> _saveToCache(List<Candidate> candidates) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = candidates.map((c) => json.encode(c.toJson())).toList();
    await prefs.setStringList(cacheKey, jsonList);
  }

  Future<List<Candidate>?> _getCachedCandidates() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(cacheKey);
    if (jsonList == null || jsonList.isEmpty) return null;
    return jsonList.map((jsonStr) => Candidate.fromJson(json.decode(jsonStr))).toList();
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cacheKey);
  }
}