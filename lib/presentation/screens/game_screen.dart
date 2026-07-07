import 'package:flutter/material.dart';
import 'package:zaffa_app/core/constants/app_colors.dart';
import 'package:zaffa_app/data/models/room_model.dart';

class GameScreen extends StatefulWidget {
  final RoomModel room;
  const GameScreen({super.key, required this.room});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // لعبة Tic-Tac-Toe بسيطة
  List<String> _board = List.filled(9, '');
  String _currentPlayer = 'X';
  String _winner = '';
  bool _isGameOver = false;

  void _resetGame() {
    setState(() {
      _board = List.filled(9, '');
      _currentPlayer = 'X';
      _winner = '';
      _isGameOver = false;
    });
  }

  void _makeMove(int index) {
    if (_board[index].isNotEmpty || _winner.isNotEmpty) return;

    setState(() {
      _board[index] = _currentPlayer;
      _checkWinner();
      if (!_isGameOver) {
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      }
    });
  }

  void _checkWinner() {
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var line in lines) {
      final a = line[0], b = line[1], c = line[2];
      if (_board[a].isNotEmpty && _board[a] == _board[b] && _board[a] == _board[c]) {
        _winner = _board[a];
        _isGameOver = true;
        return;
      }
    }

    if (!_board.contains('')) {
      _winner = 'Draw';
      _isGameOver = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🎮 ${widget.room.name} - Game'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Tic-Tac-Toe',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (_winner.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: _winner == 'Draw' ? Colors.grey : Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _winner == 'Draw'
                    ? '🤝 Draw!'
                    : '🎉 Player $_winner Wins!',
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          else
            Text(
              'Current Turn: $_currentPlayer',
              style: const TextStyle(fontSize: 18),
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: 300,
            height: 300,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _makeMove(index),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        _board[index],
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _board[index] == 'X'
                              ? Colors.blue
                              : Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _resetGame,
            icon: const Icon(Icons.restart_alt),
            label: const Text('Play Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}