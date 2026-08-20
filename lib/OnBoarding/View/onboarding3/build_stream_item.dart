import 'package:ai_lab/core/constant/app_size.dart';
import 'package:flutter/material.dart';

class BuildStreamItem extends StatelessWidget {
  const BuildStreamItem({
    super.key,
    required this.num,
    required this.title,
    required this.nodeId,
    required this.status,
    required this.time,
    required this.color,
  });

  final String num;
  final String title;
  final String nodeId;
  final String status;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final scale = AppSize.scale(context);

    return Container(
      padding: EdgeInsets.all(20 * scale),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C1F),
        borderRadius: BorderRadius.circular(16 * scale),
        border: Border(
          left: BorderSide(
            color: color,
            width: 5 * scale,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔢 الرقم
          Text(
            num,
            style: TextStyle(
              fontSize: 24 * scale,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          SizedBox(width: 20 * scale),

          // 📄 المعلومات الرئيسية
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13 * scale,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  nodeId,
                  style: TextStyle(
                    fontSize: 11 * scale,
                    color: Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(width: 10 * scale),

          // 📊 الحالة والوقت
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 12 * scale,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 10 * scale,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}