import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF181818),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 42,
                  height: 42,
                ),
                SizedBox(width: 16),
                Text(
                  'Tasky',
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 28.0,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    height: 0.857,
                  ),
                  textHeightBehavior: const TextHeightBehavior(
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
              ],
            ),
            SizedBox(height: 108),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome To Tasky',
                  style: TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                    height: 0.857,
                  ),
                  textHeightBehavior: const TextHeightBehavior(
                    leadingDistribution: TextLeadingDistribution.even,
                  ),
                ),
                SizedBox(width: 8),
                SvgPicture.asset(
                  'assets/images/waving_hand.svg',
                  width: 28,
                  height: 28,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Your productivity journey starts here.',
              style: TextStyle(
                color: Color(0XFFFFFCFC),
                fontSize: 16,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),
            SvgPicture.asset(
              'assets/images/hero_image.svg',
              width: 215,
              height: 204.39,
            ),
            SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: Color(0XFFFFFCFC),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'e.g. Abdelaaiz Ouakala',
                      hintStyle: TextStyle(color: Color(0XFF8A8A8A)),
                      filled: true,
                      fillColor: Color(0XFF282828),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFF15B86C),
                foregroundColor: Color(0XFFFFFCFC),
                fixedSize: Size(343, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: Text(
                'GLet’s Get Started',

                style: TextStyle(
                  color: Color(0XFFFFFCFC),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.1,
                  height: 1.42,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
