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
    'Your Key Pals',
    'Write a Letter',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: AppColors.textDark,
              size: 28,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          _pageTitles[_selectedIndex],
          style: const TextStyle(
            fontFamily: 'Georgia',
            color: AppColors.textDark,
            fontSize: 22,
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 0,
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
                decoration: BoxDecoration(
                  color: AppColors.accentLight.withOpacity(0.15),
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.textMedium.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'KeyPal',
                      style: TextStyle(
                        fontFamily: 'DancingScript',
                        fontSize: 44,
                        color: AppColors.textDark,
                        height: 1.0,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'New connections. Old-fashioned.',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 13,
                        color: AppColors.textMedium,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // Main menu items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: [
                    _drawerItem(
                      icon: Icons.mail_outline,
                      label: 'Letterbox',
                      index: 0,
                    ),
                    _drawerItem(
                      icon: Icons.people_outline,
                      label: 'Key Pals',
                      index: 1,
                    ),
                    _drawerItem(
                      icon: Icons.edit_note,
                      label: 'Write a Letter',
                      index: 2,
                    ),
                    _drawerItem(
                      icon: Icons.person_outline,
                      label: 'Profile',
                      index: 3,
                    ),
                  ],
                ),
              ),

              // Bottom section with divider
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.textMedium.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    _drawerButton(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    _drawerButton(
                      icon: Icons.logout,
                      label: 'Log Out',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                              (route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          image: DecorationImage(
            image: AssetImage('assets/textures/textured_paper.png'),
            repeat: ImageRepeat.repeat,
            opacity: 0.25,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: _pages[_selectedIndex],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool selected = _selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
            setState(() => _selectedIndex = index);
          },
          child: Container(
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.accentLight.withOpacity(0.3)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                icon,
                color: selected ? AppColors.textDark : AppColors.textMedium,
                size: 24,
              ),
              title: Text(
                label,
                style: TextStyle(
                  fontFamily: 'Georgia',
                  color: selected ? AppColors.textDark : AppColors.textMedium,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: ListTile(
            leading: Icon(
              icon,
              color: AppColors.textMedium,
              size: 24,
            ),
            title: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Georgia',
                color: AppColors.textMedium,
                fontSize: 15,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
          ),
        ),
      ),
    );
  }
}