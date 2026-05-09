import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../services/localization_service.dart';
import 'saved_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _openUrl(String url) async {
    if (await canLaunch(url)) await launch(url);
  }

  @override
  Widget build(BuildContext context) {
    final langService = Provider.of<LocalizationService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: Colors.blue),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            trailing: Text(langService.locale.languageCode == 'en' ? 'English' : 'العربية'),
            onTap: () => _showLanguageDialog(context, langService),
          ),
          ListTile(
            leading: const Icon(Icons.delete_sweep),
            title: const Text('Clear Cache'),
            onTap: () async {
              await ApiService().clearCache();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cache cleared')));
            },
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved Profiles'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SavedScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            onTap: () {
              // share_plus implementation can be added
            },
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title: const Text('Rate App'),
            onTap: () {
              // Open store link
            },
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Email: info@zodmanpower.info'),
            onTap: () => _openUrl('mailto:info@zodmanpower.info'),
          ),
          ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Phone: +974 5535 5206'),
            onTap: () => _openUrl('tel:+97455355206'),
          ),
          ListTile(
            leading: const Icon(Icons.web),
            title: const Text('Website'),
            onTap: () => _openUrl('https://zodmanpower.info'),
          ),
          ListTile(
            leading: const Icon(Icons.facebook),
            title: const Text('Facebook'),
            onTap: () => _openUrl('https://www.facebook.com/profile.php?id=61573964615952'),
          ),
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('TikTok'),
            onTap: () => _openUrl('https://www.tiktok.com/@zodmanpower'),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Twitter'),
            onTap: () => _openUrl('https://twitter.com/zodmanpower'),
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LocalizationService langService) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: const Text('English'), onTap: () async { await langService.setLanguage('en'); if(context.mounted) Navigator.pop(context); }),
            ListTile(title: const Text('العربية'), onTap: () async { await langService.setLanguage('ar'); if(context.mounted) Navigator.pop(context); }),
          ],
        ),
      ),
    );
  }
}