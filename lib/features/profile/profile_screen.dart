import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String imageUrl = "";
  final String name = "John Smith";
  final String phoneNumber = "+998 99 992 16 84";
  final String phoneNumber2 = "+998 99 992 16 85";
  final String address = "Farg'ona";

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: screenSize.width * 0.9,
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(imageUrl),
              ),
              const SizedBox(height: 20),
              // Name
              Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              // Divider for spacing
              Divider(
                color: Colors.grey.shade300,
                thickness: 1,
              ),
              const SizedBox(height: 10),
              // Phone Number 1
              _profileDetailRow(Icons.phone, phoneNumber),
              const SizedBox(height: 10),
              // Phone Number 2
              _profileDetailRow(Icons.phone, phoneNumber2),
              const SizedBox(height: 10),
              // Address
              _profileDetailRow(Icons.location_on, address),
              const SizedBox(height: 30),
              // Edit Profile Button
              ElevatedButton.icon(
                onPressed: () {
                  // Handle edit profile action here
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileDetailRow(IconData icon, String detail) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blueAccent,
          size: 28,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            detail,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
