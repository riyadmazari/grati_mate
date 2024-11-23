import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../data/local_storage/hive_storage.dart';
import '../../data/models/prompt_model.dart';

class CustomPromptsPage extends StatefulWidget {
  @override
  _CustomPromptsPageState createState() => _CustomPromptsPageState();
}

class _CustomPromptsPageState extends State<CustomPromptsPage> {
  final TextEditingController _promptController = TextEditingController();
  List<PromptModel> _prompts = [];
  List<PromptModel> _pinnedPrompts = [];

  final List<String> _preMadePrompts = [
    "What inspires you today?",
    "What’s one lesson you’ve learned recently?",
    "What are you most grateful for this week?",
    "What motivates you to keep going?",
  ];

  @override
  void initState() {
    super.initState();
    _loadPrompts();
  }

  Future<void> _loadPrompts() async {
    final prompts = await HiveStorage.getAllPrompts();
    setState(() {
      _prompts = prompts;
      _pinnedPrompts = prompts.where((prompt) => prompt.isPinned).toList();
    });
  }

  Future<void> _addPrompt(String text) async {
    final prompt = PromptModel(
      text: text,
      isPinned: false,
      date: DateTime.now(),
    );
    await HiveStorage.savePrompt(prompt);
    _loadPrompts();
  }

  Future<void> _togglePin(PromptModel prompt) async {
    await HiveStorage.togglePin(prompt);
    _loadPrompts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Prompts & Inspiration Wall"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Add Prompt Section
              Text(
                "Add Your Own Prompt:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _promptController,
                      decoration: const InputDecoration(
                        hintText: "Write your own prompt",
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_promptController.text.isNotEmpty) {
                        _addPrompt(_promptController.text);
                        _promptController.clear();
                      }
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Pre-Made Prompts Section
              Text(
                "Pre-Made Prompts:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _preMadePrompts.map((prompt) {
                  return Chip(
                    label: Text(prompt),
                    onDeleted: () {
                      _addPrompt(prompt);
                    },
                    deleteIcon: const Icon(Icons.add),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // Pinned Prompts Section
              if (_pinnedPrompts.isNotEmpty) ...[
                Text(
                  "Inspiration Wall (Pinned Prompts):",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Column(
                  children: _pinnedPrompts.map((prompt) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(prompt.text),
                        trailing: IconButton(
                          icon: Icon(
                            prompt.isPinned
                                ? Icons.push_pin
                                : Icons.push_pin_outlined,
                            color: AppColors.primaryColor,
                          ),
                          onPressed: () => _togglePin(prompt),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 20),

              // All Prompts Section
              Text(
                "All Prompts:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Column(
                children: _prompts.map((prompt) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(prompt.text),
                      trailing: IconButton(
                        icon: Icon(
                          prompt.isPinned
                              ? Icons.push_pin
                              : Icons.push_pin_outlined,
                          color: AppColors.primaryColor,
                        ),
                        onPressed: () => _togglePin(prompt),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
