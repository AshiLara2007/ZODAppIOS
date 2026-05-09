import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/candidate.dart';

void shareCandidateOnWhatsApp(BuildContext context, Candidate candidate) {
  final String message = '''
╔══════════════════════════════════════════════════════════╗
║           🤝 ZOD MANPOWER RECRUITMENT - DOHA, QATAR 🤝          ║
╚══════════════════════════════════════════════════════════╝

┌─────────────────────────────────────────────────────────┐
│                    📋 CANDIDATE DETAILS                  │
└─────────────────────────────────────────────────────────┘

🔹 *Name:* ${candidate.name}
🔹 *Age:* ${candidate.age} years
🔹 *Gender:* ${candidate.gender}
🔹 *Marital Status:* ${candidate.maritalStatus}
🔹 *Religion:* ${candidate.religion}

┌─────────────────────────────────────────────────────────┐
│                    💼 JOB INFORMATION                    │
└─────────────────────────────────────────────────────────┘

🔹 *Position:* ${candidate.subCategory}
🔹 *Country:* ${candidate.nationality}
🔹 *Experience:* ${candidate.experience}
🔹 *Salary:* ${candidate.salary} QAR
🔹 *Worker Type:* ${candidate.workerType}

┌─────────────────────────────────────────────────────────┐
│                    📎 DOCUMENTS                         │
└─────────────────────────────────────────────────────────┘

🔹 *CV Link:* ${candidate.cvUrl.isNotEmpty ? candidate.cvUrl : "Not Available"}

┌─────────────────────────────────────────────────────────┐
│                    🌐 WEBSITE                           │
└─────────────────────────────────────────────────────────┘

🔹 https://zodmanpower.info

──────────────────────────────────────────────────────────

📞 *Contact us:*
   • WhatsApp: +974 5535 5206
   • Email: info@zodmanpower.info

──────────────────────────────────────────────────────────

✅ *Reply "HIRE ${candidate.name.toUpperCase()}" to proceed*
  ''';
  final whatsappUrl = "https://wa.me/97455355206?text=${Uri.encodeComponent(message)}";
  launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
}