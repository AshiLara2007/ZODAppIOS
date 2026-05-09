import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/candidate.dart';
import '../utils/whatsapp_share.dart';
import '../screens/profile_screen.dart';

class CandidateCard extends StatelessWidget {
  final Candidate candidate;
  const CandidateCard({super.key, required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: ClipOval(
          child: CachedNetworkImage(
            imageUrl: candidate.imageUrl.isNotEmpty ? candidate.imageUrl : 'https://via.placeholder.com/80',
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            placeholder: (_, __) => const CircleAvatar(child: Icon(Icons.person)),
            errorWidget: (_, __, ___) => const CircleAvatar(child: Icon(Icons.error)),
          ),
        ),
        title: Text('${candidate.name} (${candidate.age})'),
        subtitle: Text('${candidate.subCategory} · ${candidate.nationality} · ${candidate.salary} QAR'),
        trailing: IconButton(
          icon: const Icon(Icons.whatsapp, color: Colors.green),
          onPressed: () => shareCandidateOnWhatsApp(context, candidate),
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen(candidate: candidate))),
      ),
    );
  }
}