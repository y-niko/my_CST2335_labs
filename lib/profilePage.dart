import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'userRepository.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage();

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: UserRepository.firstName);
    _lastNameController = TextEditingController(text: UserRepository.lastName);
    _phoneController = TextEditingController(text: UserRepository.phone);
    _emailController = TextEditingController(text: UserRepository.email);

    _firstNameController.addListener(_saveData);
    _lastNameController.addListener(_saveData);
    _phoneController.addListener(_saveData);
    _emailController.addListener(_saveData);
  }

  void _saveData() {
    UserRepository.firstName = _firstNameController.text;
    UserRepository.lastName = _lastNameController.text;
    UserRepository.phone = _phoneController.text;
    UserRepository.email = _emailController.text;
    UserRepository.saveData();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Error"),
          content: Text("This URL is not supported on your device."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Page")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Welcome Back, ${UserRepository.username}", style: Theme.of(context).textTheme.headlineSmall),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () => _launchUrl("tel:${_phoneController.text}"),
                ),
                IconButton(
                  icon: Icon(Icons.sms),
                  onPressed: () => _launchUrl("sms:${_phoneController.text}"),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.mail),
                  onPressed: () => _launchUrl("mailto:${_emailController.text}"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
