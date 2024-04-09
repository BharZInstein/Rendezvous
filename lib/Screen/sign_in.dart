import 'package:flutter/material.dart';

import '../Utils/colors.dart'; // Import your colors file

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              backgroundColor2, // Define colors in a separate file
              backgroundColor2,
              backgroundColor4,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: size.height * 0.03),
              Text(
                "Hello Again!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 37,
                  color: textColor1, // Define colors in a separate file
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Wellcome back you've\nbeen missed!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 27, color: textColor2, height: 1.2),
              ),
              SizedBox(height: size.height * 0.08),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    // Sign In button with centered text and slightly shifted icon
                    SizedBox(height: size.height * 0.05),
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: buttonColor, // Define color in a separate file
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the text
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22, // Adjust font size if needed
                            ),
                          ),
                          const SizedBox(width: 15), // Shift the icon slightly to the left
                          socialIcon("images/google.png", height: 18),
                        ],
                      ),
                    ),
                    // ... other widgets (unchanged)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container socialIcon(String image, {double height = 18}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10, // Adjusted padding for a smaller overall icon
        vertical: 5,
      ),

      child: Image.asset(
        image,
        height: height,
      ),
    );
  }
}
