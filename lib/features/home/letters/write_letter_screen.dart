import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se_380_project_penpal/features/services/letter_service.dart';
// Added the requested import below:
import 'package:se_380_project_penpal/features/home/fillers/letter_sent_screen.dart';

class WriteLetterScreen extends StatefulWidget {
  final String? prefilledRecipient;

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
  final LetterService _letterService = LetterService();

  String senderName = "You";
  String recipientDisplayName = "";
  bool isSending = false;
  bool isLoadingRecipient = false;

  @override
  void initState() {
    super.initState();
    toController.addListener(_onRecipientChanged);

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

  void _onRecipientChanged() {
    final recipient = toController.text.trim();
    if (recipient.isEmpty) {
      setState(() {
        recipientDisplayName = "";
      });
    } else {
      _loadRecipientDisplayName(recipient);
    }
  }

  Future<void> _loadRecipientDisplayName(String username) async {
    setState(() {
      isLoadingRecipient = true;
    });

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty && mounted) {
        final userData = querySnapshot.docs.first.data();
        setState(() {
          recipientDisplayName = userData['displayName'] ?? username;
          isLoadingRecipient = false;
        });
      } else {
        setState(() {
          recipientDisplayName = username;
          isLoadingRecipient = false;
        });
      }
    } catch (e) {
      setState(() {
        recipientDisplayName = username;
        isLoadingRecipient = false;
      });
    }
  }

  @override
  void dispose() {
    toController.dispose();
    super.dispose();
  }

  Future<bool> _validateLetter() async {
    final recipient = toController.text.trim();
    final bodyText = await _htmlController.getText();

    if (recipient.isEmpty) {
      _showError("Please enter a recipient's username");
      return false;
    }

    // Remove HTML tags for length check
    final plainText = bodyText.replaceAll(RegExp(r'<[^>]*>'), '').trim();

    if (plainText.length < 50) {
      _showError("Your letter is too short. Please write at least 50 characters.");
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
      final bodyHtml = await _htmlController.getText();

      // Build complete letter with greeting and closing
      final greeting = "Dear $recipientDisplayName,";
      final closing = "Best regards,\n$senderName";

      // Convert HTML to plain text for body
      final bodyPlainText = bodyHtml
          .replaceAll(RegExp(r'<br\s*/?>'), '\n')
          .replaceAll(RegExp(r'<p[^>]*>'), '')
          .replaceAll(RegExp(r'</p>'), '\n')
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .trim();

      // Complete letter
      final fullLetter = "$greeting\n\n$bodyPlainText\n\n$closing";

      final letterId = await _letterService.sendLetter(
        receiverUsername: recipient,
        contentText: fullLetter,
        contentHtml: bodyHtml,
      );

      if (!mounted) return;

      if (letterId != null) {
        // Navigate to success screen
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LetterSentScreen(
              recipientName: recipientDisplayName,
            ),
          ),
        );
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
        child: Column(
          children: [
            // Letter paper - takes most of the screen
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.6,
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
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Recipient field - MODIFIED AS REQUESTED
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.person_outline, color: Colors.brown.shade600, size: 20),
                                const SizedBox(width: 8),
                                const Text(
                                  "To:",
                                  style: TextStyle(
                                    fontFamily: "Georgia",
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
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
                                      hintText: "Choose a username", // Changed this text
                                      hintStyle: TextStyle(
                                        fontFamily: "Georgia",
                                        color: Colors.brown.shade400,
                                        fontStyle: FontStyle.italic,
                                      ),
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.zero,
                                      isCollapsed: true,
                                      filled: false,
                                    ),
                                  ),
                                ),
                                if (isLoadingRecipient)
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.brown.shade600,
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 24),
                            Divider(color: Colors.brown.shade200, thickness: 1),
                            const SizedBox(height: 24),

                            // Greeting
                            if (recipientDisplayName.isNotEmpty) ...[
                              Text(
                                "Dear $recipientDisplayName,",
                                style: const TextStyle(
                                  fontFamily: "Georgia",
                                  fontSize: 17,
                                  color: Colors.black87,
                                  height: 1.6,
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],

                            // HTML Editor
                            IgnorePointer(
                              ignoring: isSending,
                              child: HtmlEditor(
                                controller: _htmlController,
                                htmlEditorOptions: HtmlEditorOptions(
                                  hint: recipientDisplayName.isEmpty
                                      ? "Enter a recipient above to begin..."
                                      : "Start writing your letter...",
                                  initialText: "",
                                  shouldEnsureVisible: true,
                                  autoAdjustHeight: true,
                                ),
                                htmlToolbarOptions: HtmlToolbarOptions(
                                  toolbarPosition: ToolbarPosition.belowEditor,
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
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                ),
                                callbacks: Callbacks(
                                  onInit: () {
                                    _htmlController.editorController?.evaluateJavascript(
                                        source: "document.execCommand('fontName', false, 'Georgia');"
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Closing
                            const SizedBox(height: 40),
                            Text(
                              "Best regards,\n$senderName",
                              style: const TextStyle(
                                fontFamily: "Georgia",
                                fontSize: 17,
                                color: Colors.black87,
                                height: 1.6,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Guidelines
                    _buildGuidelines(),
                  ],
                ),
              ),
            ),

            // Bottom section with send button
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.all(16),
              child: Material(
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                shadowColor: Colors.brown.withOpacity(0.4),
                child: InkWell(
                  onTap: isSending ? null : _sendLetter,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: double.infinity,
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
              ),
            ),
          ],
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
          _buildTipItem("Write at least 50 characters of meaningful content"),
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
}