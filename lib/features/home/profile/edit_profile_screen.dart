import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/features/home/home_screen.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:se_380_project_penpal/models/user_model.dart';




class EditProfileScreen extends StatefulWidget {
  final String displayName;
  final String username;
  final String bio;
  final String country;
  final String age;
  final List<String> interests;
  final List<Map<String, String>> languages;

  final bool isFirstSetup;

  const EditProfileScreen({
    super.key,
    required this.displayName,
    required this.username,
    required this.bio,
    required this.country,
    required this.age,
    required this.interests,
    required this.languages,
    this.isFirstSetup = false,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _displayNameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _countryController;
  late TextEditingController _ageController;

  late List<String> _interests;
  late List<Map<String, String>> _languages;

  String _newInterest = "";
  bool isSaving = false;

  bool _isCountryPrivate = false;

  @override
  void initState() {
    super.initState();


    // Initialize with passed data
    _displayNameController = TextEditingController(text: widget.displayName);
    _usernameController = TextEditingController(text: widget.username);
    _bioController = TextEditingController(text: widget.bio);
    _countryController = TextEditingController(text: widget.country);
    _ageController = TextEditingController(text: widget.age);
    _interests = List<String>.from(widget.interests);
    _languages = List<Map<String, String>>.from(
      widget.languages.map((lang) => Map<String, String>.from(lang)),
    );

    if (widget.isFirstSetup) {
      _loadUserFromFirestore();
    }
  }

  Future<void> _loadUserFromFirestore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (!doc.exists) return;

    final model = UserModel.fromJson(doc.data()!);

    if (!mounted) return;

    setState(() {
      _displayNameController.text = model.displayName;
      _usernameController.text = model.username;
    });
  }


  @override
  void dispose() {
    _displayNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _countryController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown.shade800),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isFirstSetup ? 'Complete Profile' : 'Edit Profile',
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 24,
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: isSaving ? null : _saveProfile,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.brown.shade600,
                        Colors.brown.shade800,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: isSaving
                      ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                      : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check,
                          color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Save',
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture Section
            _buildProfilePictureCard(),
            const SizedBox(height: 16),

            // Basic Info Card
            _buildBasicInfoCard(),
            const SizedBox(height: 16),

            // Bio Card
            _buildBioCard(),
            const SizedBox(height: 16),

            // Interests Card
            _buildInterestsCard(),
            const SizedBox(height: 16),

            // Details Card
            _buildDetailsCard(),
            const SizedBox(height: 16),

            // Languages Card
            _buildLanguagesCard(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePictureCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.brown.shade400,
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.brown.shade200,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.brown.shade600,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Implement image picker
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Image picker coming soon!")),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.brown.shade700,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Tap to change photo",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: Colors.brown.shade600,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person_outline, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "Basic Information",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _displayNameController,
            style: const TextStyle(fontFamily: 'Georgia'),
            decoration: InputDecoration(
              labelText: "Display Name",
              labelStyle: TextStyle(fontFamily: 'Georgia', color: Colors.brown.shade600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade600, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _usernameController,
            style: const TextStyle(fontFamily: 'Georgia'),
            decoration: InputDecoration(
              labelText: "Username",
              prefixText: "@",
              labelStyle: TextStyle(fontFamily: 'Georgia', color: Colors.brown.shade600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade600, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildBioCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_stories, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "About Me",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _bioController,
            maxLines: 5,
            style: const TextStyle(fontFamily: 'Georgia'),
            decoration: InputDecoration(
              hintText: "Tell others about yourself...",
              hintStyle: TextStyle(fontFamily: 'Georgia', color: Colors.brown.shade300),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade600, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.favorite_outline, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "Interests",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ..._interests.map((interest) => _buildEditableInterestTag(interest)),
              _buildAddInterestButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditableInterestTag(String interest) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.brown.shade100, Colors.brown.shade50],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.brown.shade300, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            interest,
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.brown.shade800,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () {
              setState(() {
                _interests.remove(interest);
              });
            },
            child: Icon(
              Icons.close,
              size: 16,
              color: Colors.brown.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddInterestButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Add Interest", style: TextStyle(fontFamily: 'Georgia')),
            content: TextField(
              autofocus: true,
              style: const TextStyle(fontFamily: 'Georgia'),
              decoration: InputDecoration(
                hintText: "Enter interest",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (val) => _newInterest = val,
              onSubmitted: (val) {
                if (val.isNotEmpty) {
                  setState(() {
                    _interests.add(val);
                  });
                  Navigator.pop(context);
                }
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel", style: TextStyle(color: Colors.brown.shade600)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_newInterest.isNotEmpty) {
                    setState(() {
                      _interests.add(_newInterest);
                      _newInterest = "";
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade700,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: const Text("Add"),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.brown.shade100,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.brown.shade400, width: 1.5, style: BorderStyle.solid),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, size: 16, color: Colors.brown.shade700),
            const SizedBox(width: 4),
            Text(
              "Add",
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.brown.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "Details",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _countryController,
            style: const TextStyle(fontFamily: 'Georgia'),
            decoration: InputDecoration(
              labelText: "Country",
              prefixIcon: Icon(Icons.public, color: Colors.brown.shade600),
              suffixIcon: IconButton( tooltip: _isCountryPrivate
                  ? "Only visible to you"
                  : "Visible to everyone",
                icon: Icon(
                  _isCountryPrivate ? Icons.lock : Icons.visibility,
                  color: Colors.brown.shade600,
                ),
                onPressed: () {
                  setState(() {
                    _isCountryPrivate = !_isCountryPrivate;
                  });
                },),
              labelStyle: TextStyle(fontFamily: 'Georgia', color: Colors.brown.shade600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade600, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ageController,
            style: const TextStyle(fontFamily: 'Georgia'),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Age",
              prefixIcon: Icon(Icons.cake_outlined, color: Colors.brown.shade600),
              labelStyle: TextStyle(fontFamily: 'Georgia', color: Colors.brown.shade600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.brown.shade600, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguagesCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.language, color: Colors.brown.shade700, size: 20),
              const SizedBox(width: 8),
              Text(
                "Languages",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._languages.asMap().entries.map((entry) {
            int index = entry.key;
            Map<String, String> lang = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildLanguageItem(index, lang),
            );
          }),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: _addLanguage,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.brown.shade300, style: BorderStyle.solid),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.brown.shade700),
                  const SizedBox(width: 8),
                  Text(
                    "Add Language",
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(int index, Map<String, String> lang) {
    final colors = [
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.blue.shade100,
    ];

    final Color chipColor = colors[index % colors.length];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              lang["language"]!,
              style: const TextStyle(
                fontFamily: 'Georgia',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              lang["level"]!,
              style: TextStyle(
                fontFamily: 'Georgia',
                fontSize: 12,
                color: Colors.brown.shade800,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _languages.removeAt(index);
              });
            },
            child: Icon(Icons.close, size: 20, color: Colors.brown.shade600),
          ),
        ],
      ),
    );
  }

  void _addLanguage() {
    String newLanguage = "";
    String newLevel = "Beginner";

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Add Language", style: TextStyle(fontFamily: 'Georgia')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                style: const TextStyle(fontFamily: 'Georgia'),
                decoration: InputDecoration(
                  labelText: "Language",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (val) => newLanguage = val,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: newLevel,
                items: const [
                  DropdownMenuItem(value: "Beginner", child: Text("Beginner")),
                  DropdownMenuItem(value: "Intermediate", child: Text("Intermediate")),
                  DropdownMenuItem(value: "Fluent", child: Text("Fluent")),
                  DropdownMenuItem(value: "Native", child: Text("Native")),
                ],
                decoration: InputDecoration(
                  labelText: "Proficiency",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onChanged: (val) {
                  if (val != null) {
                    setDialogState(() => newLevel = val);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: Colors.brown.shade600)),
            ),
            ElevatedButton(
              onPressed: () {
                if (newLanguage.isNotEmpty) {
                  setState(() {
                    _languages.add({"language": newLanguage, "level": newLevel});
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown.shade700,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
              )),
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => isSaving = true);

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!doc.exists) {
        throw Exception("User document not found");
      }

      final currentUser = UserModel.fromJson(doc.data()!);

      final updatedUser = currentUser.copyWith(
        displayName: _displayNameController.text.trim(),
        username: _usernameController.text.trim(),
        bio: _bioController.text.trim(),
        country: _countryController.text.trim(),
        age: int.tryParse(_ageController.text),
        interests: _interests,
        languages: _languages,
        lastActive: DateTime.now(),
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(updatedUser.toJson());

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Profile saved successfully ✨"),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );

      if (widget.isFirstSetup) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        Navigator.pop(context, {
          'displayName': updatedUser.displayName,
          'username': updatedUser.username,
          'bio': updatedUser.bio,
          'country': updatedUser.country,
          'age': updatedUser.age?.toString() ?? "Hidden",
          'interests': updatedUser.interests,
          'languages': _languages,
        });

      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to save profile: $e"),
          backgroundColor: Colors.red.shade700,
        ),
      );
    } finally {
      if (mounted) setState(() => isSaving = false);
    }
  }
}