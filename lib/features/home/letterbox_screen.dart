import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart'; // adjust import

class LetterboxScreen extends StatelessWidget {
  const LetterboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final letters = <String>[]; // placeholder list

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: letters.isEmpty
          ? _buildEmptyState()
          : _buildLetterList(letters),
    );
  }

  /// ----------------------------
  /// EMPTY STATE (No Mail Yet)
  /// ----------------------------
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "📭",
            style: TextStyle(fontSize: 70),
          ),
          SizedBox(height: 12),
          Text(
            "No letters yet.\nWrite to your penpal!",
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

  /// ----------------------------
  /// LETTER LIST (Theme-Styled)
  /// ----------------------------
  Widget _buildLetterList(List<String> letters) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: letters.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),

      itemBuilder: (context, index) {
        final letter = letters[index];

        return Container(
          decoration: BoxDecoration(
            color: AppColors.accentLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.border.withOpacity(0.6),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.brown.withOpacity(0.15),
                blurRadius: 5,
                offset: const Offset(3, 4),
              ),
            ],
          ),

          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),

            leading: const Icon(
              Icons.mail_outline,
              color: AppColors.textDark,
            ),

            title: Text(
              letter,
              style: const TextStyle(
                fontFamily: 'Georgia',
                fontSize: 18,
                color: AppColors.textDark,
              ),
            ),

            onTap: () {
              // TODO: open letter detail
            },
          ),
        );
      },
    );
  }
}
