import 'package:ai_lab/OnBoarding/View/widget.dart';
import 'package:ai_lab/core/constant/app_color.dart';

class BuildLiveFeedCard extends StatelessWidget {
  const BuildLiveFeedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 680;

    return Container(
      decoration: BoxDecoration(
        color: AppMyColor.charcoalBlack,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppMyColor.blueColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'LIVE LABORATORY FEED',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 11 : 12,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'CAM_042',
                  style: TextStyle(
                    color: AppMyColor.blueColor,
                    fontSize: isSmallScreen ? 11 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Image Area
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.asset(
                    AppImageAsset.onboarding,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[900],
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              color: Colors.grey, size: 50),
                        ),
                      );
                    },
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),

                  Positioned(
                    top: isSmallScreen ? 12 : 16,
                    left: isSmallScreen ? 12 : 16,
                    right: isSmallScreen ? 12 : 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildScanOverlay(
                          icon: Icons.qr_code_2,
                          title: 'Scanning Vial',
                          value: '#VX-992-04',
                          color: AppMyColor.blueColor,
                        ),
                        const SizedBox(height: 12),
                        BuildScanOverlay(
                          icon: Icons.biotech,
                          title: 'Molecular Integrity',
                          value: '99.84%',
                          color: AppMyColor.lightLavenderPinkColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
