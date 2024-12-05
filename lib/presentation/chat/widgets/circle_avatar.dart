import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyCirlceAvatar extends StatelessWidget {
  final String name;
  final String image;
  final bool isSpecialBorder;

  const MyCirlceAvatar(
      {super.key,
      required this.name,
      required this.image,
      required this.isSpecialBorder});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          Stack(
            children: [
              isSpecialBorder
                  ? SvgPicture.asset(
                      'assets/vectors/profile_border_1.svg',
                      width: 60,
                      height: 60,
                    )
                  : SvgPicture.asset(
                      'assets/vectors/profile_border_2.svg',
                      width: 60,
                      height: 60,
                    ),
              Positioned(
                top: 4,
                left: 2,
                right: 2,
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage(image),
                ),
              ),
            ],
          ),
          Container(
            height: 8,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
