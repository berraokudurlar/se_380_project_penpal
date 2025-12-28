import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';

class DetailedLetterScreen extends StatelessWidget {
  final Map<String, dynamic> letter;

  const DetailedLetterScreen({
    super.key,
    required this.letter,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'From ${letter['from']}',
          style: const TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            color: AppColors.textDark,
          ),
        ),
        actions: [
          // Reply button
          IconButton(
            icon: Icon(Icons.reply, color: Colors.brown.shade700),
            onPressed: () {
              // TODO: Navigate to WriteLetterScreen with recipient pre-filled
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Opening reply screen...')),
              );
            },
            tooltip: 'Reply',
          ),
          // More options
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.brown.shade700),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete_outline, size: 20),
                    SizedBox(width: 8),
                    Text('Delete', style: TextStyle(fontFamily: 'Georgia')),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'archive',
                child: Row(
                  children: [
                    Icon(Icons.archive_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('Archive', style: TextStyle(fontFamily: 'Georgia')),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteConfirmation(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Letter metadata card
            _buildMetadataCard(),
            const SizedBox(height: 16),

            // Letter content
            _buildLetterContent(),
            const SizedBox(height: 24),

            // Reply button
            _buildReplyButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMetadataCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(Icons.person_outline, 'From', letter['from']),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.calendar_today, 'Sent', letter['date']),
          const SizedBox(height: 8),
          _buildInfoRow(Icons.public, 'Origin', letter['origin'] ?? 'Unknown'),
          if (letter['deliveryDays'] != null) ...[
            const SizedBox(height: 8),
            _buildInfoRow(
              Icons.local_shipping_outlined,
              'Journey',
              '${letter['deliveryDays']} days',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.brown.shade600),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 14,
            color: Colors.brown.shade600,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontFamily: 'Georgia',
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLetterContent() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images_animations/background.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Html(
        data: letter['content'],
        style: {
          "body": Style(
            fontFamily: 'Georgia',
            fontSize: FontSize(17),
            lineHeight: LineHeight(1.6),
            color: Colors.black87,
            letterSpacing: 0.3,
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
          "p": Style(
            margin: Margins.only(bottom: 12),
          ),
          "strong": Style(
            fontWeight: FontWeight.bold,
          ),
          "em": Style(
            fontStyle: FontStyle.italic,
          ),
          "ul": Style(
            margin: Margins.only(left: 20, top: 8, bottom: 8),
          ),
          "ol": Style(
            margin: Margins.only(left: 20, top: 8, bottom: 8),
          ),
          "li": Style(
            margin: Margins.only(bottom: 4),
          ),
        },
      ),
    );
  }

  Widget _buildReplyButton(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.brown.withOpacity(0.4),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to WriteLetterScreen with recipient pre-filled
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('We will implement this!!!!!!'),
              backgroundColor: Colors.green.shade700,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown.shade600, Colors.brown.shade800],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.reply, color: Colors.white, size: 22),
              SizedBox(width: 12),
              Text(
                'Reply to this Letter',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete Letter?',
          style: TextStyle(color: Colors.brown, fontFamily: 'Georgia'),
        ),
        content: const Text(
          'This letter will be permanently deleted.',
          style: TextStyle(color: Colors.brown, fontFamily: 'Georgia'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.brown.shade600, fontFamily: 'Georgia'),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Delete from Firestore
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close letter detail
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Letter deleted')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent
            ),
            child: Text('Delete',
            style: TextStyle(color: Colors.brown.shade600, fontFamily: 'Georgia'),
            )
          ),
        ],
      ),
    );
  }
}