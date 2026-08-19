import 'package:flutter/material.dart';

class BuildRecordCard extends StatelessWidget {
  const BuildRecordCard({super.key, required this.id, required this.title, required this.subtitle, required this.progress, required this.nameImage});
    final String id;
  final String title;
  final String subtitle;
  final int progress;
  final String nameImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(

              nameImage
              ,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(id, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                    Icon(Icons.circle, size: 10, color: progress > 50 ? Colors.green : Colors.orange),
                  ],
                ),
                const SizedBox(height: 8),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16
                    ,color: Colors.white
                )),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: progress / 100,
                  backgroundColor: Colors.grey[800],
                  color: const Color(0xFF00D2FF),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
