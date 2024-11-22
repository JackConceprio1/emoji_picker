import 'package:flutter/material.dart';

Widget buildEmojiCategories(
    List<Map<String, Object>> emojiData, ScrollController scrollController) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal, // This will allow horizontal scrolling
    controller: scrollController, // Add a ScrollController
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: emojiData.map((categoryData) {
        final title = categoryData['category'] as String;
        final emojisList =
            List<String>.from(categoryData['emojisList'] as List);

        // Calculate the number of emojis per row
        int totalEmojis = emojisList.length;
        int emojisPerRow = (totalEmojis / 4).floor();
        int remainingEmojis = totalEmojis % 4;

        // Split emojis into 4 rows and distribute leftovers
        List<List<String>> emojiRows = List.generate(4, (index) {
          int start = index * emojisPerRow +
              (index < remainingEmojis ? index : remainingEmojis);
          int end = start + emojisPerRow + (index < remainingEmojis ? 1 : 0);
          return emojisList.sublist(
              start, end > totalEmojis ? totalEmojis : end);
        });

        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category title
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              // Emoji rows (each row is horizontally scrollable)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: emojiRows.map((row) {
                  return Row(
                    children: row
                        .map((emoji) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                child: Text(
                                  emoji,
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ),
                            ))
                        .toList(),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    ),
  );
}

Future<void> showEmojiPicker({
  required BuildContext context,
  required Function(String) onEmojiSelected,
}) async {
  final emojiData = [
    {
      "category": "Smileys & People",
      "emojisList": [
        "😀",
        "😃",
        "😄",
        "😁",
        "😆",
        "😅",
        "😂",
        "🙂",
        "🙃",
        "😉",
        "😊",
        "😇",
        "🥰",
        "😍"
      ],
    },
    {
      "category": "Animals & Nature",
      "emojisList": [
        "🐶",
        "🐱",
        "🐭",
        "🐹",
        "🐰",
        "🦊",
        "🐻",
        "🐼",
        "🐨",
        "🐯",
        "🦁",
        "🐮"
      ],
    },
    {
      "category": "Food & Drink",
      "emojisList": [
        "🍏",
        "🍎",
        "🍉",
        "🍊",
        "🍌",
        "🍍",
        "🥭",
        "🍓",
        "🍒",
        "🍑",
        "🍋",
        "🍈"
      ],
    },
  ];

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Allows the modal to size based on content
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (BuildContext context) {
      // Create a ScrollController
      ScrollController scrollController = ScrollController();

      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // This makes the modal as small as possible
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar for filtering emojis
            TextField(
              decoration: InputDecoration(
                hintText: "Search Emojis",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (searchTerm) {
                // Implement search filtering logic (optional)
              },
            ),
            const SizedBox(height: 10),
            buildEmojiCategories(emojiData, scrollController),
          ],
        ),
      );
    },
  );
}
