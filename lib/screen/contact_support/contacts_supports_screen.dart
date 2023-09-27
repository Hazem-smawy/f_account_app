import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// class ContactAndSupportsScreen extends StatelessWidget {
//   const ContactAndSupportsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           children: [
//             const CustomBackBtnWidget(title: "الإ تصال و الدعم"),
//             const SizedBox(
//               height: 50,
//             ),
//             const TitleWidget(
//               title: 'الهاتف',
//               icon: Icons.phone_enabled_outlined,
//             ),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(10),
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: MyColors.bg.withOpacity(0.5),
//               ),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "7743232323",
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: MyColors.secondaryTextColor,
//                     ),
//                   ),
//                   Divider(),
//                   Text(
//                     "7743232323",
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: MyColors.secondaryTextColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),

//             // whatsaap

//             const TitleWidget(
//               title: 'واتساب',
//               icon: FontAwesomeIcons.whatsapp,
//             ),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(10),
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: MyColors.bg.withOpacity(0.5),
//               ),
//               child: const Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "7743232323",
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: MyColors.secondaryTextColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),

//             // emails
//             const TitleWidget(
//               title: 'البريد الإ لكتروني',
//               icon: FontAwesomeIcons.envelope,
//             ),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(10),
//               margin: const EdgeInsets.symmetric(vertical: 10),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: MyColors.bg.withOpacity(0.5),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text(
//                     "hazemsmawy@gmail.com",
//                     style: MyTextStyles.subTitle,
//                   ),
//                 ],
//               ),
//             ),
//             const Spacer(),
//             Text(
//               'v:1.1.0',
//               style: MyTextStyles.body,
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

class ContactAndSupportsScreen extends StatelessWidget {
  const ContactAndSupportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColors.bg,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TitleWidget(
              title: 'الهاتف',
              icon: Icons.phone_enabled_outlined,
              action: () async {
                final Uri phoneUri = Uri(scheme: "tel", path: '775426836');
                try {
                  if (await launchUrlString(phoneUri.toString())) {
                    await launchUrlString(phoneUri.toString());
                  }
                } catch (error) {
                  throw ("Cannot dial");
                }
              },
            ),

            // whatsaap

            // emails
            TitleWidget(
                title: 'تيلجرام',
                icon: FontAwesomeIcons.telegram,
                action: () async {
                  final web = Uri.parse(
                    'https://t.me/haz_sma',
                  );
                  if (await canLaunchUrl(web)) {
                    launchUrl(web);
                  } else {
                    print('Could not launch $web');
                  }
                }),
            TitleWidget(
              title: 'الفيس بوك',
              icon: FontAwesomeIcons.facebook,
              action: () async {
                final web = Uri.parse(
                  'https://www.facebook.com/profile.php?id=100005699237303',
                );
                if (await canLaunchUrl(web)) {
                  launchUrl(web);
                } else {
                  print('Could not launch $web');
                }
              },
            ),
            TitleWidget(
              title: 'تويتر',
              icon: FontAwesomeIcons.twitter,
              action: () async {
                const web = 'https://twitter.com/';
                if (await canLaunchUrlString(web)) {
                  launchUrlString(web);
                } else {
                  print('Could not launch $web');
                }
              },
            ),
            TitleWidget(
              title: 'واتساب',
              icon: FontAwesomeIcons.whatsapp,
              action: () async {
                const url = "whatsapp://send?phone=775426836&text=هلا";

                if (await canLaunchUrlString(url)) {
                  launchUrlString(url);
                } else {
                  print('Could not launch $url');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  final VoidCallback action;
  final String title;
  final IconData icon;
  const TitleWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: MyColors.secondaryTextColor),
              // color: MyColors.lessBlackColor.withOpacity(0.9),
            ),
            child: FaIcon(
              icon,
              size: 20,
              color: MyColors.lessBlackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style:
                  MyTextStyles.title2.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
