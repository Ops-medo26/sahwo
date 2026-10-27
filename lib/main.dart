import 'package:flutter/material.dart';

void main() {
  runApp(const SahwoApp());
}

const Color sahwoTeal = Color(0xFF176B63);
const Color sahwoCream = Color(0xFFF7F4EA);
const Color sahwoInk = Color(0xFF172A2A);

class SahwoApp extends StatelessWidget {
  const SahwoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sahwo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: sahwoCream,
        colorScheme: ColorScheme.fromSeed(seedColor: sahwoTeal),
        fontFamily: 'Roboto',
      ),
      home: const SahwoHome(),
    );
  }
}

class SahwoHome extends StatefulWidget {
  const SahwoHome({super.key});

  @override
  State<SahwoHome> createState() => _SahwoHomeState();
}

class _SahwoHomeState extends State<SahwoHome> {
  int _selectedIndex = 0;
  int _points = 0;
  bool _checkedIn = false;
  final List<String> _checkIns = [];

  void _checkIn() {
    if (_checkedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('سجّلت استيقاظك اليوم بالفعل 🌅')),
      );
      return;
    }
    setState(() {
      _checkedIn = true;
      _points += 10;
      _checkIns.insert(0, 'تم تسجيل الاستيقاظ اليوم — +10 نقاط');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('أحسنت! أضفنا 10 نقاط تجريبية إلى رصيدك ✨')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomePage(),
      _buildCommunityPage(),
      _buildChallengesPage(),
      _buildProfilePage(),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: sahwoCream,
          title: const Row(
            children: [
              Icon(Icons.wb_sunny_rounded, color: sahwoTeal, size: 28),
              SizedBox(width: 8),
              Text('سَهْوَة', style: TextStyle(
                color: sahwoInk, fontWeight: FontWeight.w800, fontSize: 23)),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('التنبيهات ستُضاف في مرحلة لاحقة.')),
              ),
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
        ),
        body: SafeArea(child: pages[_selectedIndex]),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          backgroundColor: Colors.white,
          indicatorColor: sahwoTeal.withValues(alpha: 0.13),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups), label: 'المجتمع'),
            NavigationDestination(icon: Icon(Icons.flag_outlined), selectedIcon: Icon(Icons.flag), label: 'التحديات'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'حسابي'),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [sahwoTeal, Color(0xFF2D9284)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(26),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.wb_twilight_rounded, color: Colors.white, size: 38),
              SizedBox(height: 14),
              Text('صباح الخير 🌅', style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('ابدأ يومك بنية طيبة وخطوة صغيرة نحو الأفضل.',
                style: TextStyle(color: Colors.white, fontSize: 15, height: 1.5)),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(child: _statCard('رصيد النقاط', '$_points', Icons.stars_rounded)),
            const SizedBox(width: 12),
            Expanded(child: _statCard('استيقاظ اليوم', _checkedIn ? 'تم ✓' : 'لم يُسجّل', Icons.alarm_rounded)),
          ],
        ),
        const SizedBox(height: 22),
        const Text('خطوتك لهذا الصباح', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: sahwoInk)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('هل استيقظت وبدأت يومك؟', style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              const Text('سجّل حضورك الصباحي. في هذه النسخة، النقاط تجريبية ومحفوظة أثناء استخدام التطبيق فقط.',
                style: TextStyle(color: Colors.black54, height: 1.45)),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _checkIn,
                  icon: Icon(_checkedIn ? Icons.check_circle : Icons.wb_sunny_outlined),
                  label: Text(_checkedIn ? 'تم تسجيل استيقاظ اليوم' : 'سجّل استيقاظي  +10 نقاط'),
                  style: FilledButton.styleFrom(
                    backgroundColor: sahwoTeal,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text('سجلّك الأخير', style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: sahwoInk)),
        const SizedBox(height: 10),
        if (_checkIns.isEmpty)
          _emptyCard(Icons.history_rounded, 'لسه ما عندك تسجيلات', 'أول ما تسجّل استيقاظك حتظهر إنجازاتك هنا.')
        else
          ..._checkIns.map((entry) => Card(
            color: Colors.white,
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Color(0xFFE0F1EB),
                child: Icon(Icons.check, color: sahwoTeal)),
              title: Text(entry),
            ),
          )),
        const SizedBox(height: 18),
        const Text('تذكير', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('النوم الكافي مهم. اجعل الاستيقاظ المبكر عادة صحية، وخطّط لنوم مناسب قبل موعد الفجر.'),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: sahwoTeal, size: 26),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: sahwoInk)),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(color: Colors.black54, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _emptyCard(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, color: sahwoTeal, size: 30),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(description, style: const TextStyle(color: Colors.black54)),
          ])),
        ],
      ),
    );
  }

  Widget _buildCommunityPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('مجتمع الصباح', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: sahwoInk)),
        const SizedBox(height: 8),
        const Text('مكان يشجّعنا نبدأ يومنا بطاقة طيبة. المنشورات هنا أمثلة تجريبية وليست من مستخدمين حقيقيين.'),
        const SizedBox(height: 18),
        _postCard('🌄', 'بداية جديدة', 'كل صباح فرصة نبدأ من جديد، حتى لو أمس ما مشى زي ما تمنّينا.'),
        _postCard('☕', 'خطوة صغيرة', 'جهّز حاجاتك من الليل، وخلي بداية يومك أهدأ وأسهل.'),
        _postCard('🤲', 'نية طيبة', 'ربنا يجعل يومكم مليان خير وبركة.'),
      ],
    );
  }

  Widget _postCard(String emoji, String title, String message) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$emoji  $title', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(message, style: const TextStyle(height: 1.5)),
          const SizedBox(height: 10),
          const Row(children: [
            Icon(Icons.favorite_border, size: 18, color: sahwoTeal),
            SizedBox(width: 6),
            Text('تفاعل تجريبي', style: TextStyle(color: Colors.black54, fontSize: 12)),
          ]),
        ]),
      ),
    );
  }

  Widget _buildChallengesPage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('تحدياتك', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: sahwoInk)),
        const SizedBox(height: 8),
        const Text('ابدأ بتحديات بسيطة، وبعدها نضيف التتبع الحقيقي والتنافس مع الأصدقاء.'),
        const SizedBox(height: 18),
        _challenge('تحدي 3 أيام', 'استيقظ في موعد ثابت لثلاثة أيام متتالية.', '0 / 3 أيام', Icons.calendar_month),
        _challenge('جهّز من الليل', 'جهّز ملابسك وأغراضك قبل النوم.', 'خطوة يومية', Icons.nightlight_round),
        _challenge('صباح بلا استعجال', 'امنح نفسك بضع دقائق هادئة بعد الاستيقاظ.', 'عادة صحية', Icons.spa_outlined),
      ],
    );
  }

  Widget _challenge(String title, String description, String status, IconData icon) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(backgroundColor: const Color(0xFFE0F1EB),
          child: Icon(icon, color: sahwoTeal)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Padding(padding: const EdgeInsets.only(top: 6), child: Text(description)),
        trailing: Text(status, style: const TextStyle(color: sahwoTeal, fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildProfilePage() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(
          child: CircleAvatar(
            radius: 42,
            backgroundColor: Color(0xFFDDEFE9),
            child: Icon(Icons.person, size: 48, color: sahwoTeal),
          ),
        ),
        const SizedBox(height: 14),
        const Center(child: Text('ضيف Sahwo', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold))),
        const Center(child: Text('حساب تجريبي — لم يتم تسجيل الدخول', style: TextStyle(color: Colors.black54))),
        const SizedBox(height: 24),
        Card(
          color: Colors.white,
          child: Column(children: const [
            ListTile(leading: Icon(Icons.stars_outlined, color: sahwoTeal), title: Text('النقاط'), trailing: Text('تجريبية')),
            Divider(height: 1),
            ListTile(leading: Icon(Icons.lock_outline, color: sahwoTeal), title: Text('الخصوصية'), subtitle: Text('سنضيف إعدادات الخصوصية مع نظام الحسابات.')),
            Divider(height: 1),
            ListTile(leading: Icon(Icons.info_outline, color: sahwoTeal), title: Text('عن Sahwo'), subtitle: Text('استيقظ وابدأ يومك بالطريقة الصحيحة.')),
          ]),
        ),
      ],
    );
  }
}
