import 'package:asroo_shop/modules/log_in_page/log_in_page.dart';
import 'package:asroo_shop/modules/register_screen/register_screen.dart';
import 'package:asroo_shop/shared/components/components.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.0, 1.0),
                  end: Alignment(0.0, -1.0),
                  colors: [
                    const Color(0x00190202),
                    const Color(0x662f2a1a),
                    const Color(0x309e9e9e)
                  ],
                  stops: [0.0, 0.0, 1.0],
                ),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/images/Mas.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                ),
                const Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Circe',
                      fontSize: 36,
                      color: Color(0xff00be84),
                    ),
                    children: [
                      TextSpan(
                        text: 'Asroo ',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: 'Shop',
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  softWrap: false,
                ),
                Container(
                  height: 44,
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0x821c1c1c),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0.075, 0.04),
                      child: SizedBox(
                        width: 117.0,
                        height: 36.0,
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                            fontFamily: 'Circe',
                            fontSize: 28,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: false,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 90,
                ),
                ElevatedButton(
                  onPressed: () {
                    navigateAndFinish(context,LogInPage());

                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff00be84),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 44, vertical: 12),
                  ),
                  child: const Text(
                    'Get Start',
                    style: TextStyle(
                        fontFamily: 'Circe',
                        fontSize: 20,
                        color: Color(0xffffffff)),
                  ),
                ),
                Container(
                  height: 110,
                ),
                InkWell(
                  onTap: () {
                    navigateAndFinish(context,RegisterScreen());
                  },
                  child: const Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontFamily: 'Circe',
                        fontSize: 17,
                        color: Color(0xffffffff),
                        height: 1.2352941176470589,
                      ),
                      children: [
                        TextSpan(
                          text: 'Don\'t have an Account? ',
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    textHeightBehavior:
                        TextHeightBehavior(applyHeightToFirstAscent: false),
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
