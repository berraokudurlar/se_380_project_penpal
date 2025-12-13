import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';

class LetterboxScreen extends StatefulWidget {
  const LetterboxScreen({super.key});

  @override
  State<LetterboxScreen> createState() => _LetterboxScreenState();
}

class _LetterboxScreenState extends State<LetterboxScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache images to avoid loading delays
    // Use didChangeDependencies instead of initState because we need context
    precacheImage(
      const AssetImage('assets/images_animations/background.png'),
      context,
    );
    precacheImage(
      const AssetImage('assets/images_animations/delphinum backeri stamp.png'),
      context,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Replace with real letter content
    final letters = <Map<String, String>>[
      {
        'from': 'Sarah',
        'date': 'November 15, 2024',
        'content':
        "Dear friend,\n\nI hope you're doing well! Today I walked by the old bookshop and thought of your last letter...\n\nThe autumn leaves were falling, reminding me of the stories you used to tell about your grandmother's garden. I picked up a beautiful leather-bound journal that I think you would absolutely love.\n\nHow have you been? I'd love to hear about your recent adventures.\n\nWith warm regards,\nSarah"
      },
      {
        'from': 'Alex',
        'date': 'November 20, 2024',
        'content':
        "Hello friend,\n\nI finally finished the novel you recommended. It was brilliant!\n\nThe way the author wove the narrative through different timelines was masterful. I found myself staying up until 3 AM just to finish the last few chapters. You were absolutely right about the plot twist in chapter 12 - I never saw it coming!\n\nThank you for always having such wonderful book recommendations. What should I read next?\n\nCheers,\nAlex"
      },
      {
        'from': 'Jamie',
        'date': 'November 25, 2024',
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
                return _buildLetterCard(
                  letters[index]['from']!,
                  letters[index]['date']!,
                  letters[index]['content']!,
                );
              },
            ),
          ),
          _buildPageIndicator(letters.length),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  /// ---------------------------------------------------------
  /// EMPTY STATE (no letters yet)
  /// ---------------------------------------------------------
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

  /// ---------------------------------------------------------
  /// LETTER CARD (postcard style with paper background)
  /// ---------------------------------------------------------
  Widget _buildLetterCard(String from, String date, String content) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Container(
              width: constraints.maxWidth * 0.95,
              height: constraints.maxHeight * 0.9,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images_animations/background.png'),
                  fit: BoxFit.cover,
                  // Add cache settings for better performance
                  filterQuality: FilterQuality.medium,
                ),
                // Add a background color as fallback while image loads
                color: Colors.grey.shade50,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Letter header with stamp
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'From: $from',
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown.shade800,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                date,
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
                        // Decorative stamp with frameBuilder to handle loading
                        Image.asset(
                          'assets/images_animations/delphinum backeri stamp.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          cacheWidth: 200, // Cache at 2x resolution for performance
                          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                            if (wasSynchronouslyLoaded) {
                              return child;
                            }
                            // Show a fade-in animation as the image loads
                            return AnimatedOpacity(
                              opacity: frame == null ? 0 : 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              child: child,
                            );
                          },
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
                    // Decorative line
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
                    // Letter body
                    Text(
                      content,
                      style: const TextStyle(
                        fontFamily: "Georgia",
                        fontSize: 17,
                        height: 1.6,
                        color: Colors.black87,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ---------------------------------------------------------
  /// PAGE INDICATOR (dots)
  /// ---------------------------------------------------------
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