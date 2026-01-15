import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se_380_project_penpal/features/services/letter_service.dart';
import 'package:se_380_project_penpal/features/home/fillers/letter_sent_screen.dart';
import 'package:super_editor/super_editor.dart';

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
  final LetterService _letterService = LetterService();

  late final MutableDocument _doc;
  late final MutableDocumentComposer _composer;
  late final Editor _editor;

  // Added a GlobalKey to help SuperEditor maintain focus/state correctly
  final GlobalKey _docLayoutKey = GlobalKey();

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

    // Initialize super_editor
    _doc = MutableDocument(
      nodes: [
        ParagraphNode(
          id: Editor.createNodeId(),
          text: AttributedText(),
        ),
      ],
    );
    _composer = MutableDocumentComposer();
    _editor = createDefaultDocumentEditor(document: _doc, composer: _composer);

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

  String _getPlainTextFromDocument() {
    final buffer = StringBuffer();
    for (int i = 0; i < _doc.nodeCount; i++) {
      final node = _doc.getNodeAt(i);
      if (node is TextNode) {
        buffer.write(node.text.text);
        buffer.write('\n');
      }
    }
    return buffer.toString().trim();
  }

  @override
  void dispose() {
    toController.dispose();
    super.dispose();
  }

  Future<bool> _validateLetter() async {
    final recipient = toController.text.trim();
    final bodyText = _getPlainTextFromDocument();

    if (recipient.isEmpty) {
      _showError("Please enter a recipient's username");
      return false;
    }

    if (bodyText.length < 50) {
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
      final bodyText = _getPlainTextFromDocument();

      // Build complete letter with greeting and closing
      final greeting = "Dear $recipientDisplayName,\n";
      final closing = "\nBest regards,\n$senderName";

      // Complete letter
      final fullLetter = "$greeting\n\n$bodyText\n\n$closing";

      final letterId = await _letterService.sendLetter(
        receiverUsername: recipient,
        contentText: fullLetter,
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
      resizeToAvoidBottomInset: true, // Handle keyboard showing up
      body: SafeArea(
        child: Column(
          children: [
            // 1. The Letter Paper (Expanded to take available space)
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipient Field
                      _buildRecipientField(),

                      const SizedBox(height: 16),
                      Divider(color: Colors.brown.shade200, thickness: 1),
                      const SizedBox(height: 16),

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
                        const SizedBox(height: 16),
                      ],

                      // The Editor (Expanded)
                      // This replaces the fixed height container and lets SuperEditor handle scrolling
                      Expanded(
                        child: IgnorePointer(
                          ignoring: isSending,
                          child: SuperEditor(
                            key: _docLayoutKey,
                            editor: _editor,
                            composer: _composer,
                            stylesheet: defaultStylesheet.copyWith(
                              addRulesAfter: [
                                StyleRule(
                                  BlockSelector.all,
                                      (doc, docNode) {
                                    return {
                                      Styles.textStyle: const TextStyle(
                                        fontFamily: 'Georgia',
                                        fontSize: 17,
                                        color: Colors.black87,
                                        height: 1.6,
                                        letterSpacing: 0.3,
                                      ),
                                    };
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Closing & Toolbar
                      const SizedBox(height: 16),
                      Text(
                        "Best regards,\n$senderName",
                        style: const TextStyle(
                          fontFamily: "Georgia",
                          fontSize: 17,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildToolbar(),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Guidelines (Placed below paper)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _buildGuidelines(),
            ),

            // 3. Send Button Area
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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

  Widget _buildRecipientField() {
    return Row(
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
              hintText: "Choose a username",
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
    );
  }

  Widget _buildToolbar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 4,
        runSpacing: 4,
        children: [
          _buildToolbarButton(
            icon: Icons.format_bold,
            tooltip: 'Bold',
            onPressed: () {
              _editor.execute([
                ToggleTextAttributionsRequest(
                  documentRange: _composer.selection!,
                  attributions: {boldAttribution},
                ),
              ]);
            },
          ),
          _buildToolbarButton(
            icon: Icons.format_italic,
            tooltip: 'Italic',
            onPressed: () {
              _editor.execute([
                ToggleTextAttributionsRequest(
                  documentRange: _composer.selection!,
                  attributions: {italicsAttribution},
                ),
              ]);
            },
          ),
          _buildToolbarButton(
            icon: Icons.format_underlined,
            tooltip: 'Underline',
            onPressed: () {
              _editor.execute([
                ToggleTextAttributionsRequest(
                  documentRange: _composer.selection!,
                  attributions: {underlineAttribution},
                ),
              ]);
            },
          ),
          _buildToolbarButton(
            icon: Icons.format_strikethrough,
            tooltip: 'Strikethrough',
            onPressed: () {
              _editor.execute([
                ToggleTextAttributionsRequest(
                  documentRange: _composer.selection!,
                  attributions: {strikethroughAttribution},
                ),
              ]);
            },
          ),
          const SizedBox(width: 8),
          _buildToolbarButton(
            icon: Icons.format_list_bulleted,
            tooltip: 'Bullet List',
            onPressed: () {
              _editor.execute([
                ConvertParagraphToListItemRequest(
                  nodeId: _composer.selection!.extent.nodeId,
                  type: ListItemType.unordered,
                ),
              ]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToolbarButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon, size: 20),
      tooltip: tooltip,
      onPressed: onPressed,
      color: Colors.brown.shade700,
      constraints: const BoxConstraints(
        minWidth: 36,
        minHeight: 36,
      ),
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildGuidelines() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.brown.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
          _buildTipItem("Be thoughtful... this is old-fashioned letter writing!"),
        ],
      ),
    );
  }

  Widget _buildTipItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
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