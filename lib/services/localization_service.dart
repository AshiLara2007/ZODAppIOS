import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends ChangeNotifier {
  static const String langKey = 'app_language';
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  LocalizationService() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString(langKey);
    if (langCode != null) {
      _locale = Locale(langCode);
      notifyListeners();
    }
  }

  Future<void> setLanguage(String langCode) async {
    if (_locale.languageCode == langCode) return;
    _locale = Locale(langCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(langKey, langCode);
    notifyListeners();
  }

  static String translate(String key, BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    if (locale == 'ar') {
      const Map<String, String> ar = {
        'app_name': 'زود مان باور',
        'search_hint': 'ابحث بالاسم...',
        'returned_only': 'الخادمات العائدات فقط',
        'all': 'الكل',
        'house_maids': 'خادمات',
        'cooks': 'طهاة',
        'drivers': 'سائقون',
        'nurses': 'ممرضات',
        'teachers': 'مدرسون',
        'returned': 'عائدات',
        'recruitment': 'توظيف',
        'hire_now': 'استأجر الآن',
        'download_cv': 'تحميل السيرة',
        'candidates_found': 'مرشح',
        'error': 'خطأ',
        'chat_default': 'محادثة واتساب',
        'profile_title': 'الملف الشخصي',
        'saved_profiles': 'الملفات المحفوظة',
        'no_saved_profiles': 'لا توجد ملفات محفوظة',
        'delete_profile': 'حذف الملف',
        'delete_confirmation': 'هل أنت متأكد من حذف',
        'delete': 'حذف',
        'cancel': 'إلغاء',
        'saved_on': 'حفظ في',
        'saved_recently': 'حفظ مؤخرًا',
        'view': 'عرض',
        'cache_cleared': 'تم مسح ذاكرة التخزين المؤقت',
        'coming_soon': 'قريباً',
        'share_app': 'مشاركة التطبيق',
        'share_app_text': 'تحميل تطبيق زود مان باور',
        'english': 'الإنجليزية',
        'arabic': 'العربية',
        'select_language': 'اختر اللغة',
        'english_selected': 'تم اختيار الإنجليزية',
        'arabic_selected': 'تم اختيار العربية',
      };
      return ar[key] ?? key;
    } else {
      const Map<String, String> en = {
        'app_name': 'ZOD MANPOWER',
        'search_hint': 'Search by name...',
        'returned_only': 'Returned Housemaids only',
        'all': 'All',
        'house_maids': 'House Maids',
        'cooks': 'Cooks',
        'drivers': 'Drivers',
        'nurses': 'Nurses',
        'teachers': 'Teachers',
        'returned': 'Returned',
        'recruitment': 'Recruitment',
        'hire_now': 'Hire Now',
        'download_cv': 'Download CV',
        'candidates_found': 'candidates found',
        'error': 'Error',
        'chat_default': 'WhatsApp Chat',
        'profile_title': 'Profile',
        'saved_profiles': 'Saved Profiles',
        'no_saved_profiles': 'No saved profiles',
        'delete_profile': 'Delete Profile',
        'delete_confirmation': 'Are you sure you want to delete',
        'delete': 'Delete',
        'cancel': 'Cancel',
        'saved_on': 'Saved on',
        'saved_recently': 'Saved recently',
        'view': 'View',
        'cache_cleared': 'Cache cleared',
        'coming_soon': 'Coming soon',
        'share_app': 'Share App',
        'share_app_text': 'Download ZOD MANPOWER App',
        'english': 'English',
        'arabic': 'Arabic',
        'select_language': 'Select Language',
        'english_selected': 'English selected',
        'arabic_selected': 'Arabic selected',
      };
      return en[key] ?? key;
    }
  }
}