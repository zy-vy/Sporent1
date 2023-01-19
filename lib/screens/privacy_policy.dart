import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Transform(
          transform: Matrix4.translationValues(-15.0, 0.0, 0.0),
          child: const Text("Privacy Policy"),
        ),
        backgroundColor: HexColor("4164DE"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: _size.height / 30, horizontal: _size.width / 18),
        child: ListView(
          children: [
            title("Privacy Policy for Sporent", _size),
            description("At Sporent, one of our main priorities is the privacy of our visitors. This Privacy Policy document contains types of information that is collected and recorded by Sporent and how we use it.", _size),
            description("If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.", _size),
            title("Log Files", _size),
            description("Sporent follows a standard procedure of using log files. These files log visitors when they visit websites. All hosting companies do this and a part of hosting services' analytics. The information collected by log files include internet protocol (IP) addresses, browser type, Internet Service Provider (ISP), date and time stamp, referring/exit pages, and possibly the number of clicks. These are not linked to any information that is personally identifiable. The purpose of the information is for analyzing trends, administering the site, tracking users' movement on the website, and gathering demographic information.  Sporent also collected information about username, email, phone number, history and other. The information is being used to show information and analytics.", _size),
            title("Children's Information", _size),
            description("Another part of our priority is adding protection for children while using the internet. We encourage parents and guardians to observe, participate in, and/or monitor and guide their online activity.", _size),
            description("Sporent does not knowingly collect any Personal Identifiable Information from children under the age of 13. If you think that your child provided this kind of information on our website, we strongly encourage you to contact us immediately and we will do our best efforts to promptly remove such information from our records.", _size)
          ],
        ),
      ),
    );
  }
}

Column title(String text, Size _size) => Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: _size.height / 60),
      ],
    );

Column description(String text, Size _size) => Column(
      children: [
        Text(text,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            )),
        SizedBox(height: _size.height / 60),
      ],
    );
