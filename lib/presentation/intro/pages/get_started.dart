import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/configs/assets/app_images.dart';
import 'package:spotify/core/configs/assets/app_vectors.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';
import 'package:spotify/presentation/choose_mode/pages/choose_mode.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.introBG),
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.15)),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(AppVectors.logo, width: 200),
                ),
                const Spacer(),
                const Text(
                  'Enjoy Listening To Music',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 21),
                const Text(
                  "Want  to discover new Music? \n Find music that you'll love today! Choose our curated playlists, new albums or get personalized music recommendations",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseMode(),
                      ),
                    );
                  },
                  title: "Get Started",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
