import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/features/auth/login_screen.dart';
import 'package:se_380_project_penpal/features/home/letterbox/letterbox_screen.dart';
import 'package:se_380_project_penpal/features/home/friends/keypals_screen.dart';
import 'package:se_380_project_penpal/features/home/letters/write_letter_screen.dart';
import 'package:se_380_project_penpal/features/home/profile/profile_screen.dart';
import 'package:se_380_project_penpal/features/home/settings_screen.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'package:se_380_project_penpal/features/home/profile/edit_profile_screen.dart';
import '../../models/user_model.dart';
import '../services/user_service.dart';
import 'letterbox/sent_letters_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final UserService _userService = UserService();
  UserModel? _currentUser;

  final ValueNotifier<int> _profileRefreshNotifier = ValueNotifier<int>(0);

  List<Widget> get _pages => [
    LetterboxScreen(),
    FriendsScreen(),
    WriteLetterScreen(),
    SentLettersScreen(),
    ProfileScreen(refreshNotifier: _profileRefreshNotifier,),
  ];


  final List<String> _pageTitles = [
    'Letterbox',
    'Your Key Pals',
    'Write a Letter',
    'Sent Letters',
    'Profile',
  ];

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await _userService.getCurrentUser();
    if (mounted) {
      setState(() {
        _currentUser = user;
      });
    }
  }


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

        actions: _selectedIndex == 4 && _currentUser != null
            ? [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () async {
                final result=await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => EditProfileScreen(
                      displayName: _currentUser!.displayName,
                      username: _currentUser!.username,
                      bio: _currentUser!.bio ?? "",
                      country: _currentUser!.country ?? "",
                      age: _currentUser!.age?.toString() ?? "",
                      interests: _currentUser!.interests ?? [],
                      languages: _currentUser!.languages ?? [],
                    ),
                  ),
                );

                // Edit sonrası
                if (result != null) {
                  await _loadUser();
                  _profileRefreshNotifier.value++;
                }

              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.brown.shade600,
                      Colors.brown.shade800,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.edit, color: Colors.white, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontFamily: 'Georgia',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]
            : null,
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
                      icon: Icons.mail_outlined,
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
                        icon: Icons.outgoing_mail,
                        label: 'Sent Letters',
                        index: 3),
                    _drawerItem(
                      icon: Icons.person_outline,
                      label: 'Profile',
                      index: 4,
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