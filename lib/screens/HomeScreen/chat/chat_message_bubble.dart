import 'package:ai_lab/models/home/Chat/message.dart';
import 'package:flutter/material.dart';
import 'suggestion_card.dart';

class ChatMessageBubble extends StatelessWidget {
  final Message message;

  const ChatMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isAi = message.sender == MessageSender.ai;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (isAi) _buildAiAvatar(),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              crossAxisAlignment: isAi ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isAi
                        ? const Color(0xFF333538).withValues(alpha: 0.4)
                        : const Color(0xFF282A2D),
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isAi ? 4 : 16),
                      bottomRight: Radius.circular(isAi ? 16 : 4),
                    ),
                    border: Border.all(
                      color: isAi
                          ? const Color(0xFF859399).withValues(alpha: 0.15)
                          : const Color(0xFF333538),
                    ),
                    boxShadow: isAi
                        ? [
                            BoxShadow(
                              color: const Color(0xFF00D2FF).withValues(alpha: 0.05),
                              blurRadius: 20,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : null,
                  ),
                  child: Text(
                    message.text,
                    style: const TextStyle(
                      color: Color(0xFFE2E2E6),
                      fontSize: 14,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                if (message.suggestion != null) ...[
                  const SizedBox(height: 8),
                  SuggestionCard(suggestion: message.suggestion!),
                ],
              ],
            ),
          ),
          if (!isAi) ...[
            const SizedBox(width: 12),
            _buildUserAvatar(),
          ],
        ],
      ),
    );
  }

  Widget _buildAiAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: const Color(0xFF333538),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D2FF).withValues(alpha: 0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: const Icon(
        Icons.psychology, // neurology equivalent
        size: 18,
        color: Color(0xFFA5E7FF),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 32,
      height: 32,
      decoration: const BoxDecoration(
        color: Color(0xFF333538),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.network(
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBSria-Eb2HGNqvsWQuH0_F1E7k5eAq8CQrDuh4ntNFK-or7duUmFcqg7vNlHkQyTZ1FEqRc5qjSSutNvYqYceX2R4uJRf11ulGumcxCdFxo_LGxiiUrTfyCX0-9P_MjX3Rz_5eL_r7KQ5qHxE54FbjWhlOWZc55EbGXcKz1nPIOcwOxvnfovFN0JcKsbeEMPODpnWbDcwgl82KmB5djQ87uw_f5AevVa2GayeQPsiWKfOO47k-wXacGA',
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(Icons.person, size: 18, color: Colors.white70),
        ),
      ),
    );
  }
}