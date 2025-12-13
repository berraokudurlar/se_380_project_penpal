import 'package:flutter/material.dart';
import 'package:se_380_project_penpal/theme/app_theme.dart';

class WriteLetterScreen extends StatefulWidget {
  const WriteLetterScreen({super.key});

  @override
  State<WriteLetterScreen> createState() => _WriteLetterScreenState();
}

class _WriteLetterScreenState extends State<WriteLetterScreen> {
  final TextEditingController toController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final FocusNode bodyFocusNode = FocusNode();

  // TODO: Replace with actual logged in user name from Firebase
  final String senderName = "YourName";

  String _greeting = "";
  String _closing = "";

  // Rich text formatting state
  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderline = false;

  @override
  void initState() {
    super.initState();
    toController.addListener(_updateLetterFormat);
  }

  @override
  void dispose() {
    toController.dispose();
    bodyController.dispose();
    bodyFocusNode.dispose();
    super.dispose();
  }

  void _updateLetterFormat() {
    final recipient = toController.text.trim();
    if (recipient.isEmpty) {
      setState(() {
        _greeting = "";
        _closing = "";
      });
      return;
    }

    setState(() {
      _greeting = "Dear $recipient,";
      _closing = "Best regards,\n$senderName";
    });

    // Auto-focus body when recipient is entered
    if (bodyController.text.isEmpty) {
      bodyFocusNode.requestFocus();
    }
  }

  void _insertFormatting(String prefix, String suffix) {
    final text = bodyController.text;
    final selection = bodyController.selection;

    if (selection.start == -1) return;

    final before = text.substring(0, selection.start);
    final selected = text.substring(selection.start, selection.end);
    final after = text.substring(selection.end);

    final newText = '$before$prefix$selected$suffix$after';
    bodyController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: selection.start + prefix.length + selected.length + suffix.length,
      ),
    );
  }

  void _toggleBold() {
    setState(() => _isBold = !_isBold);
    _insertFormatting('**', '**');
  }

  void _toggleItalic() {
    setState(() => _isItalic = !_isItalic);
    _insertFormatting('*', '*');
  }

  void _toggleUnderline() {
    setState(() => _isUnderline = !_isUnderline);
    _insertFormatting('__', '__');
  }

  void _insertBulletList() {
    final text = bodyController.text;
    final selection = bodyController.selection;

    if (selection.start == -1) return;

    final before = text.substring(0, selection.start);
    final after = text.substring(selection.start);

    final newText = '$before\n• ';
    bodyController.value = TextEditingValue(
      text: newText + after,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  bool _validateLetter() {
    final recipient = toController.text.trim();
    final body = bodyController.text.trim();

    if (recipient.isEmpty) {
      _showError("Please enter a recipient");
      return false;
    }

    // Check minimum length (at least 50 characters of actual content)
    if (body.length < 50) {
      _showError("Your letter is too short. Please write at least a few sentences.");
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _sendLetter() {
    if (!_validateLetter()) return;

    // TODO: Send to Firebase/backend
    final recipient = toController.text.trim();
    final body = bodyController.text.trim();
    final fullLetter = "$_greeting\n\n$body\n\n$_closing";

    print("Sending letter to: $recipient");
    print("Full letter:\n$fullLetter");

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Letter sent! 📬"),
        backgroundColor: Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Letter paper with all elements
              _buildLetterPaper(),
              const SizedBox(height: 16),

              // Formatting toolbar
              _buildFormattingToolbar(),
              const SizedBox(height: 16),

              // Guidelines
              _buildGuidelines(),
              const SizedBox(height: 16),

              // Send button
              _buildSendButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLetterPaper() {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 600,
        maxHeight: 700,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.shade200.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipient field
              Row(
                children: [
                  Icon(Icons.person_outline, color: Colors.brown.shade600, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: toController,
                      style: const TextStyle(
                        fontFamily: "Georgia",
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: "To: recipient's username",
                        hintStyle: TextStyle(
                          fontFamily: "Georgia",
                          color: Colors.brown.shade400,
                          fontStyle: FontStyle.italic,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isCollapsed: true,
                        filled: false,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              Divider(color: Colors.brown.shade200, thickness: 1),
              const SizedBox(height: 24),

              // Greeting (Dear...)
              if (_greeting.isNotEmpty) ...[
                Text(
                  _greeting,
                  style: const TextStyle(
                    fontFamily: "Georgia",
                    fontSize: 17,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Body text field
              TextField(
                controller: bodyController,
                focusNode: bodyFocusNode,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: const TextStyle(
                  fontFamily: "Georgia",
                  fontSize: 17,
                  height: 1.6,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  hintText: _greeting.isEmpty
                      ? "Enter a recipient above to begin..."
                      : "Start writing your letter...",
                  hintStyle: TextStyle(
                    fontFamily: "Georgia",
                    color: Colors.brown.shade400,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isCollapsed: true,
                  filled: false,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),

              // Closing (Best regards...)
              if (_closing.isNotEmpty) ...[
                const SizedBox(height: 40),
                Text(
                  _closing,
                  style: const TextStyle(
                    fontFamily: "Georgia",
                    fontSize: 17,
                    color: Colors.black87,
                    height: 1.6,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormattingToolbar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade300, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.shade200.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.format_size, color: Colors.brown.shade600, size: 18),
          const SizedBox(width: 8),
          Text(
            "Format:",
            style: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 13,
              color: Colors.brown.shade700,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                _buildFormatButton(
                  icon: Icons.format_bold,
                  isActive: _isBold,
                  onPressed: _toggleBold,
                  tooltip: "Bold (**text**)",
                ),
                const SizedBox(width: 4),
                _buildFormatButton(
                  icon: Icons.format_italic,
                  isActive: _isItalic,
                  onPressed: _toggleItalic,
                  tooltip: "Italic (*text*)",
                ),
                const SizedBox(width: 4),
                _buildFormatButton(
                  icon: Icons.format_underline,
                  isActive: _isUnderline,
                  onPressed: _toggleUnderline,
                  tooltip: "Underline (__text__)",
                ),
                const SizedBox(width: 4),
                _buildFormatButton(
                  icon: Icons.format_list_bulleted,
                  isActive: false,
                  onPressed: _insertBulletList,
                  tooltip: "Bullet List",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatButton({
    required IconData icon,
    required bool isActive,
    required VoidCallback onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isActive ? Colors.brown.shade200 : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? Colors.brown.shade400 : Colors.transparent,
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            size: 20,
            color: isActive ? Colors.brown.shade800 : Colors.brown.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildGuidelines() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Colors.brown.shade700, size: 18),
              const SizedBox(width: 8),
              Text(
                "Letter Guidelines",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _buildTipItem("Start with 'Dear [name],'"),
          _buildTipItem("Write at least a few meaningful sentences"),
          _buildTipItem("Use formatting: **bold**, *italic*, __underline__"),
          _buildTipItem("End with a closing like 'Best regards,' or 'Sincerely,'"),
          _buildTipItem("Be thoughtful - this is old-fashioned letter writing!"),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "• ",
            style: TextStyle(
              fontFamily: 'Georgia',
              color: Colors.brown.shade600,
              fontSize: 12,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Georgia',
                color: Colors.brown.shade700,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      shadowColor: Colors.brown.withOpacity(0.4),
      child: InkWell(
        onTap: _sendLetter,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown.shade600, Colors.brown.shade800],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.send, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                "Send Letter",
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 16,
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
}