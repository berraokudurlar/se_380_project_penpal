import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se_380_project_penpal/features/services/letter_service.dart';

class WriteLetterScreen extends StatefulWidget {
  final String? prefilledRecipient; // Optional: for replying

  const WriteLetterScreen({
    super.key,
    this.prefilledRecipient,
  });

  @override
  State<WriteLetterScreen> createState() => _WriteLetterScreenState();
}

class _WriteLetterScreenState extends State<WriteLetterScreen> {
  final TextEditingController toController = TextEditingController();
  final HtmlEditorController _htmlController = HtmlEditorController();
  final FocusNode bodyFocusNode = FocusNode();
  final LetterService _letterService = LetterService();

  String senderName = "You";
  String _greeting = "";
  String _closing = "";
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    toController.addListener(_updateLetterFormat);

    // Prefill recipient if replying
    if (widget.prefilledRecipient != null) {
      toController.text = widget.prefilledRecipient!;
    }

    _loadSenderName();
  }

  Future<void> _loadSenderName() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && mounted) {
        setState(() {
          senderName = doc.data()?['displayName'] ?? "You";
        });
      }
    }
  }

  @override
  void dispose() {
    toController.dispose();
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
  }

  Future<bool> _validateLetter() async {
    final recipient = toController.text.trim();
    final bodyText = await _htmlController.getText();

    if (recipient.isEmpty) {
      _showError("Please enter a recipient's username");
      return false;
    }

    // Check minimum length (at least 50 characters of actual content)
    if (bodyText.trim().length < 50) {
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

  Future<void> _sendLetter() async {
    if (!await _validateLetter()) return;

    setState(() {
      isSending = true;
    });

    try {
      final recipient = toController.text.trim();
      final bodyText = await _htmlController.getText();

      // Full letter with greeting and closing
      final fullLetter = "$_greeting\n\n$bodyText\n\n$_closing";

      // Send letter via service
      final letterId = await _letterService.sendLetter(
        receiverUsername: recipient,
        contentText: fullLetter,
        contentHtml: bodyText, // Store HTML version if needed
      );

      if (!mounted) return;

      if (letterId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Letter sent to $recipient! 📬"),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Clear the form
        toController.clear();
        _htmlController.clear();

        Navigator.pop(context);
      }
    } catch (e) {
      if (!mounted) return;

      String errorMessage = "Failed to send letter";
      if (e.toString().contains("not found")) {
        errorMessage = "User not found. Please check the username.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSending = false;
        });
      }
    }
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
              _buildLetterPaper(),
              const SizedBox(height: 16),
              _buildGuidelines(),
              const SizedBox(height: 16),
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
              Row(
                children: [
                  Icon(Icons.person_outline, color: Colors.brown.shade600, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: toController,
                      enabled: !isSending,
                      style: const TextStyle(
                        fontFamily: "Georgia",
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      decoration: InputDecoration(
                        hintText: "To: recipient's username (without @)",
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

              Container(
                constraints: const BoxConstraints(minHeight: 300),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.brown.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IgnorePointer(
                  ignoring: isSending,
                  child: HtmlEditor(
                    controller: _htmlController,
                    htmlEditorOptions: HtmlEditorOptions(
                      hint: _greeting.isEmpty
                          ? "Enter a recipient above to begin..."
                          : "Start writing your letter...",
                      initialText: "",
                      shouldEnsureVisible: true,
                      autoAdjustHeight: true,
                    ),
                    htmlToolbarOptions: HtmlToolbarOptions(
                      toolbarPosition: ToolbarPosition.aboveEditor,
                      toolbarType: ToolbarType.nativeScrollable,
                      defaultToolbarButtons: [
                        StyleButtons(style: false),
                        FontSettingButtons(
                          fontName: false,
                          fontSize: false,
                        ),
                        FontButtons(
                          bold: true,
                          italic: true,
                          underline: true,
                          clearAll: false,
                          strikethrough: true,
                          superscript: false,
                          subscript: false,
                        ),
                        ColorButtons(
                          foregroundColor: false,
                          highlightColor: false,
                        ),
                        ListButtons(
                          ul: true,
                          ol: true,
                          listStyles: false,
                        ),
                        ParagraphButtons(
                          textDirection: false,
                          lineHeight: false,
                          caseConverter: false,
                          alignLeft: false,
                          alignCenter: false,
                          alignRight: false,
                          alignJustify: false,
                          increaseIndent: false,
                          decreaseIndent: false,
                        ),
                        InsertButtons(
                          link: false,
                          picture: false,
                          audio: false,
                          video: false,
                          otherFile: false,
                          table: false,
                          hr: false,
                        ),
                        OtherButtons(
                          fullscreen: false,
                          codeview: false,
                          undo: true,
                          redo: true,
                          help: false,
                          copy: false,
                          paste: false,
                        ),
                      ],
                      toolbarItemHeight: 40,
                    ),
                    otherOptions: OtherOptions(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    callbacks: Callbacks(
                      onInit: () {
                        _htmlController.execCommand('fontName', argument: 'Georgia');
                      },
                    ),
                  ),
                ),
              ),

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
          _buildTipItem("Enter the recipient's username (without @)"),
          _buildTipItem("Write at least a few meaningful sentences"),
          _buildTipItem("Use the toolbar for bold, italic, underline, and lists"),
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
        onTap: isSending ? null : _sendLetter,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSending
                  ? [Colors.grey.shade400, Colors.grey.shade500]
                  : [Colors.brown.shade600, Colors.brown.shade800],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSending)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              else
                const Icon(Icons.send, color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(
                isSending ? "Sending..." : "Send Letter",
                style: const TextStyle(
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