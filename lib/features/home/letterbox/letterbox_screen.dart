import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lottie/lottie.dart';
import 'package:se_380_project_penpal/features/services/letter_service.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'package:se_380_project_penpal/models/letter_model.dart';
import 'detailed_letter_screen.dart';
import 'package:intl/intl.dart';

class LetterboxScreen extends StatefulWidget {
  const LetterboxScreen({super.key});

  @override
  State<LetterboxScreen> createState() => _LetterboxScreenState();
}

class _LetterboxScreenState extends State<LetterboxScreen> {
  final PageController _pageController = PageController();
  final LetterService _letterService = LetterService();
  late Stream<List<LetterModel>> _lettersStream;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _letterService.checkAndUpdateDeliveredLetters();
    _lettersStream = _letterService.getReceivedLetters();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: StreamBuilder<List<LetterModel>>(
        stream: _lettersStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.textMedium,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red.shade300,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Error loading letters",
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 16,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            );
          }

          final letters = snapshot.data ?? [];

          if (letters.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: letters.length,
                  itemBuilder: (context, index) {
                    return _buildLetterCard(letters[index], context);
                  },
                ),
              ),
              _buildPageIndicator(letters.length),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/images_animations/Message received.json',
            width: 300,
            height: 300,
            repeat: true,
          ),
          const SizedBox(height: 24),
          const Text(
            "No letters yet.\nWrite to your key pal!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMedium,
              fontSize: 18,
              fontFamily: 'Georgia',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLetterCard(LetterModel letter, BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _letterService.getUserBasicInfo(letter.senderId),
      builder: (context, senderSnapshot) {
        final senderName = senderSnapshot.data?['displayName'] ?? 'Unknown';
        final senderUsername = senderSnapshot.data?['username'] ?? 'unknown';
        final dateStr = DateFormat('MMMM dd, yyyy').format(letter.sentDate);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailedLetterScreen(
                  letter: {
                    'letterId': letter.letterId,
                    'from': senderName,
                    'username': senderUsername,
                    'date': dateStr,
                    'content': letter.contentText,
                    'origin': letter.locationSentFrom,
                  },
                ),
              ),
            ).then((_) {
              // Refresh if letter was deleted
              setState(() {});
            });
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(20),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: Container(
                    width: constraints.maxWidth * 0.95,
                    height: constraints.maxHeight * 0.9,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images_animations/background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'From: $senderName',
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown.shade800,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          dateStr,
                                          style: TextStyle(
                                            fontFamily: 'Georgia',
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.brown.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Image.asset(
                                    'assets/images_animations/delphinum backeri stamp.png',
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.mail,
                                        color: Colors.brown.shade600,
                                        size: 30,
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                height: 1,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.brown.shade300,
                                      Colors.brown.shade100,
                                      Colors.brown.shade300,
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Html(
                                data: letter.contentText,
                                style: {
                                  "body": Style(
                                    fontFamily: "Georgia",
                                    fontSize: FontSize(17),
                                    lineHeight: LineHeight(1.6),
                                    color: Colors.black87,
                                    letterSpacing: 0.3,
                                    padding: HtmlPaddings.zero,
                                    maxLines: 15,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                  "p": Style(
                                    margin: Margins.only(bottom: 8),
                                    ),
                                },
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.brown.shade700,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.touch_app,
                                      color: Colors.white, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Tap to read full letter',
                                    style: TextStyle(
                                      fontFamily: 'Georgia',
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildPageIndicator(int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
            (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Colors.brown.shade600
                : Colors.brown.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}