import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';
import 'detailed_letter_screen.dart';


class LetterboxScreen extends StatefulWidget {
  const LetterboxScreen({super.key});

  @override
  State<LetterboxScreen> createState() => _LetterboxScreenState();
}

class _LetterboxScreenState extends State<LetterboxScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // UPDATED: Changed type to Map<String, dynamic> to allow integers
    final letters = <Map<String, dynamic>>[
      {
        'from': 'Sarah',
        'date': 'November 15, 2024',
        'origin': 'Paris, France', // Added for Detail View
        'deliveryDays': 5,         // Added for Detail View
        'content':
        "Dear friend,\n\nI hope you're doing well! Today I walked by the old bookshop and thought of your last letter...\n\nThe autumn leaves were falling, reminding me of the stories you used to tell about your grandmother's garden. I picked up a beautiful leather-bound journal that I think you would absolutely love.\n\nHow have you been? I'd love to hear about your recent adventures.\n\nWith warm regards,\nSarah"
      },
      {
        'from': 'Alex',
        'date': 'November 20, 2024',
        'origin': 'London, UK',    // Added for Detail View
        'deliveryDays': 3,         // Added for Detail View
        'content':
        "Hello friend,\n\nI finally finished the novel you recommended. It was brilliant!\n\nThe way the author wove the narrative through different timelines was masterful. I found myself staying up until 3 AM just to finish the last few chapters. You were absolutely right about the plot twist in chapter 12 - I never saw it coming!\n\nThank you for always having such wonderful book recommendations. What should I read next?\n\nCheers,\nAlex"
      },
      {
        'from': 'Jamie',
        'date': 'November 25, 2024',
        'origin': 'Kyoto, Japan',  // Added for Detail View
        'deliveryDays': 7,         // Added for Detail View
        'content':
        "My dearest pen pal,\n\nToday was a rainy day, so I stayed inside and wrote this for you...\n\nThere's something magical about rainy afternoons, don't you think? The sound of raindrops on the windowpane, a warm cup of tea, and good thoughts of friends far away.\n\nI've been thinking about our conversation last month about traveling. Perhaps we could finally plan that trip we've been discussing?\n\nStay dry and cozy,\nJamie"
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: letters.isEmpty
          ? _buildEmptyState()
          : Column(
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
                // Pass the whole map, not just individual strings
                return _buildLetterCard(letters[index], context);
              },
            ),
          ),
          _buildPageIndicator(letters.length),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ensure this asset path exists in your pubspec.yaml
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

  Widget _buildLetterCard(Map<String, dynamic> letter, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // UPDATED: Navigation logic fixes
        Navigator.push(
          context,
          MaterialPageRoute(
            // Changed from LetterDetailScreen to DetailedLetterScreen
            builder: (context) => DetailedLetterScreen(letter: letter),
          ),
        );
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
                    // Ensure this asset exists
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
                                      'From: ${letter['from']}',
                                      style: TextStyle(
                                        fontFamily: 'Georgia',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.brown.shade800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      letter['date'],
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
                          Text(
                            letter['content'],
                            style: const TextStyle(
                              fontFamily: "Georgia",
                              fontSize: 17,
                              height: 1.6,
                              color: Colors.black87,
                              letterSpacing: 0.3,
                            ),
                            maxLines: 15,
                            overflow: TextOverflow.ellipsis,
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