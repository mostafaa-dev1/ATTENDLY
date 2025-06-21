import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final Uri facebookUrl = Uri.parse('https://www.facebook.com/m0stafa.ma7moud');
  final Uri githubUrl = Uri.parse('https://github.com/mostafaa-dev1');
  final Uri instagramUrl =
      Uri.parse('https://www.instagram.com/m0stafa._.ma7moud/');
  final Uri linkedinUrl =
      Uri.parse('https://www.linkedin.com/in/mostafa-mahmoud-174529224');
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'mostafaa.dev1@gmail.com',
  );
// Function to launch URLs
  void _launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void launchEmail(String email) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text('About',
                style: Theme.of(context).textTheme.headlineLarge)),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('About the developer',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                    'Hello! I am Mostafa, the developer of this app. I am passionate about providing students with an interactive and efficient learning experience. I have created this app with the aim of simplifying attendance management and providing students with easy access to their study information.',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
              const SizedBox(height: 16),
              Text('What is the App do?',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: 10),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                      '• Use the QR code scanner to efficiently record attendance.\n'
                      '• Lecturers can easily access and record student attendance information in the app.\n'
                      '• Students can easily access to their attendance.\n'
                      '• Community for sharing knowledge and programming information.\n'
                      '• Participate in quizzes designed to improve your programming skills.\n'
                      '• Stay organized and keep track of your academic progress.\n',
                      style: Theme.of(context).textTheme.headlineMedium)),
              Text(
                  'For any queries or suggestions, feel free to reach out to me using the links below.',
                  style: Theme.of(context).textTheme.headlineLarge),
              const Spacer(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            _launchURL(facebookUrl);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            size: width > 500 ? 25 : 20,
                          )),
                      IconButton(
                          onPressed: () {
                            _launchURL(githubUrl);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.github,
                            size: width > 500 ? 25 : 20,
                          )),
                      IconButton(
                          onPressed: () {
                            _launchURL(instagramUrl);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.instagram,
                            size: width > 500 ? 25 : 20,
                          )),
                      IconButton(
                          onPressed: () {
                            _launchURL(linkedinUrl);
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.linkedin,
                            size: width > 500 ? 25 : 20,
                          )),
                      IconButton(
                          onPressed: () {
                            launchUrl(emailLaunchUri);
                          },
                          icon: FaIcon(
                            Icons.email_outlined,
                            size: width > 500 ? 26 : 20,
                          )),
                    ],
                  ),
                  const Text(
                    'v1.1',
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
