import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomFavoriteList extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String subtitle;
  final VoidCallback onTap;

  const CustomFavoriteList({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomFavoriteList> createState() => _CustomFavoriteListState();
}

class _CustomFavoriteListState extends State<CustomFavoriteList> {
  @override
  Widget build(BuildContext context) {
    final Screenheight = MediaQuery.of(context).size.height;
    final Screenwidth = MediaQuery.of(context).size.width;
    final rowheight = Screenheight * 0.15;
    final imageWidth = Screenwidth * 0.25;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: Screenwidth,
        height: rowheight,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.imageUrl,
                width: imageWidth,
                height: rowheight * 0.8,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_right, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}
