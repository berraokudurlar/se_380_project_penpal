import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/features/auth/login_screen.dart';
import 'package:se_380_project_penpal/features/home/letterbox_screen.dart';
import 'package:se_380_project_penpal/features/home/friends_screen.dart';
import 'package:se_380_project_penpal/features/home/write_letter_screen.dart';
import 'package:se_380_project_penpal/features/home/profile_screen.dart';
import 'package:se_380_project_penpal/features/home/settings_screen.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    LetterboxScreen(),
    FriendsScreen(),
    WriteLetterScreen(),
    ProfileScreen(),
  ];

  final List<String> _pageTitles = [
    'Letterbox',
    'Pen Pals',
    'Write a Letter',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: Text(
          _pageTitles[_selectedIndex],
          style: const TextStyle(
            fontFamily: 'Georgia',
            color: AppColors.textDark,
          ),
        ),
      ),

      drawer: Drawer(
        elevation: 0,
        child: CustomPaint(
          painter: EnvelopeDrawerPainter(),
          child: Container(
            decoration: const BoxDecoration(
              // OPTIONAL vintage texture:
              // image: DecorationImage(
              //   image: AssetImage("assets/textures/paper_bg.png"),
              //   fit: BoxFit.cover,
              // ),
              color: AppColors.background,
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Transform.translate(
                    offset: const Offset(10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'PenPal',
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                            fontSize: 48,
                            color: AppColors.textDark,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Write. Connect. Cherish.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textMedium,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                _drawerItem(icon: Icons.mail_outline, label: 'Letterbox', index: 0),
                _drawerItem(icon: Icons.people_outline, label: 'Pen Pals', index: 1),
                _drawerItem(icon: Icons.edit_note, label: 'Write a Letter', index: 2),
                _drawerItem(icon: Icons.person_outline, label: 'Profile', index: 3),

                const SizedBox(height: 250),
                const Divider(height: 50, color: Colors.transparent),

                // Settings button
                _drawerButton(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                    );
                  },
                ),

                // Logout button
                _drawerButton(
                  icon: Icons.logout,
                  label: 'Log Out',
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _pages[_selectedIndex],
      ),
    );
  }

  // ------------------------- MAIN DRAWER ITEM -------------------------
  Widget _drawerItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool selected = _selectedIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: selected ? AppColors.textDark : AppColors.textMedium,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: selected ? AppColors.textDark : AppColors.textMedium,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: selected,
      selectedTileColor: AppColors.accentLight.withOpacity(0.5),
      onTap: () {
        Navigator.pop(context); // close drawer
        setState(() => _selectedIndex = index);
      },
    );
  }

  // ------------------------- SETTINGS / LOGOUT BUTTON -------------------------
  Widget _drawerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      splashColor: AppColors.accentLight.withOpacity(0.4),
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, color: AppColors.textMedium),
        title: Text(
          label,
          style: const TextStyle(color: AppColors.textMedium),
        ),
      ),
    );
  }
}

class EnvelopeDrawerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = Colors.brown.shade300
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    final dividerX = size.width * 0.35;

    // Divider line between drawer and main content
    canvas.drawLine(
      Offset(dividerX, 0),
      Offset(dividerX, size.height),
      linePaint,
    );

    // Envelope diagonal lines
    canvas.drawLine(
      const Offset(0, 0),
      Offset(dividerX, size.height * 0.45),
      linePaint,
    );

    canvas.drawLine(
      Offset(dividerX, size.height * 0.45),
      Offset(0, size.height),
      linePaint,
    );

    // Wax seal circle
    final sealPaint = Paint()
      ..color = Colors.brown.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(
      Offset(dividerX, size.height * 0.45),
      18,
      sealPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

