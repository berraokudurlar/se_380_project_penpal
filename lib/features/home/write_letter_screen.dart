import 'package:flutter/material.dart';

class WriteLetterScreen extends StatefulWidget {
  const WriteLetterScreen({super.key});

  @override
  State<WriteLetterScreen> createState() => _WriteLetterScreenState();
}

class _WriteLetterScreenState extends State<WriteLetterScreen> {
  final toController = TextEditingController();
  final contentController = TextEditingController();

  // TODO: Replace with actual logged in user name.
  final String senderName = "YourDisplayName";

  @override
  void initState() {
    super.initState();

    // Update template whenever recipient changes
    toController.addListener(_updateTemplate);
  }

  void _updateTemplate() {
    final recipient = toController.text.trim();

    final template = """
Dear ${recipient.isEmpty ? "..." : recipient},

 

Best regards,
$senderName
""";

    final currentText = contentController.text;

    // Only overwrite if user hasn't started typing meaningfully
    if (currentText.trim().isEmpty || currentText.startsWith("Dear")) {
      contentController.text = template;

      // Place cursor between greeting and closing
      final middlePos = template.indexOf("\n\n") + 2;
      contentController.selection = TextSelection.collapsed(offset: middlePos);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Recipient field
            TextField(
              controller: toController,
              decoration: const InputDecoration(
                labelText: "To (username)",
                prefixIcon: Icon(Icons.person_outline),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.brown.shade200),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: contentController,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Start writing...",
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Send button
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[700],
                  foregroundColor: Colors.white,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  shadowColor: Colors.brown.withOpacity(0.4),
                ),
                onPressed: () {
                  if (!mounted) return;

                  final content = contentController.text.trim();
                  final toUser = toController.text.trim();

                  // TODO: Firestore send

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Letter sent!"),
                      backgroundColor: Colors.brown[800],
                    ),
                  );

                  // Safe: only pops if possible (no crash)
                  Navigator.of(context).maybePop();
                },
                child: const Text(
                  "Send Letter",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
