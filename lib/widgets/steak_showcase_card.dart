import 'package:flutter/material.dart';
import 'dart:async';

class SteakShowcaseCard extends StatefulWidget {
  final List<String> steakImages;
  final VoidCallback onTap;

  const SteakShowcaseCard({
    super.key,
    required this.onTap,
    required this.steakImages,
  });

  @override
  State<SteakShowcaseCard> createState() => _SteakShowcaseCardState();
}

class _SteakShowcaseCardState extends State<SteakShowcaseCard> {
  int _currentSteakIndex = 0;
  Timer? _steakTimer;

  @override
  void initState() {
    super.initState();
    _steakTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _currentSteakIndex = (_currentSteakIndex + 1) % widget.steakImages.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _steakTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                child: Image.asset(
                  widget.steakImages[_currentSteakIndex],
                  key: ValueKey<int>(_currentSteakIndex),
                  fit: BoxFit.cover, 
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Lagi Pengen Steak?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Eksplore aneka olahan daging steak terbaik',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}