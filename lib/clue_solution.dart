import 'package:advent/clue_elements.dart';
import 'package:advent/solution_manager.dart';
import 'package:flutter/material.dart';

class ClueSolution extends StatefulWidget {
  final String taskID;
  final String userInput;
  final List<String> correctSolutions;

  const ClueSolution({
    super.key,
    required this.taskID,
    required this.userInput,
    required this.correctSolutions,
  });

  @override
  State<ClueSolution> createState() => _ClueSolutionState();
}

class _ClueSolutionState extends State<ClueSolution> {
  late TextEditingController _controller;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.userInput);
    _isCorrect = widget.correctSolutions.any((solution) => solution.toLowerCase() == widget.userInput.toLowerCase());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submitSolution() async {
    final solution = _controller.text.trim();
    
    // Save the solution
    await SolutionManager.setUserSolution(widget.taskID, solution);

    // Check if correct
    final isCorrect = widget.correctSolutions.any(
      (correctSolution) => correctSolution.toLowerCase() == solution.toLowerCase(),
    );

    if (mounted) {
      setState(() {
        _isCorrect = isCorrect;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClueRow([
      if (_isCorrect)
        const ClueText('✅')
      else if (_controller.text.isNotEmpty)
        const ClueText('❌'),

      // Input field
      Expanded(
        child: TextField(
          decoration: const InputDecoration(
            labelText: 'Megoldás',
            border: OutlineInputBorder(),
          ),
          controller: _controller,
          onSubmitted: (_) => _submitSolution(),
        ),
      ),

      // submit button
      ElevatedButton(
        onPressed: _submitSolution,
        child: const Text('Beküldés'),
      ),
    ]);
  }
}
