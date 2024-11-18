import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(LineAwesomeIcons.angle_right_solid)),
        title: Text('tEditProfile', style: Theme.of(context).textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(image: AssetImage('assets/will_smith.png'))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey),
                      child: const Icon(LineAwesomeIcons.camera_solid, color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text('tFullName'), prefixIcon: Icon(LineAwesomeIcons.user)),
                    ),
                    const SizedBox(height:20),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("tEmail"), prefixIcon: Icon(LineAwesomeIcons.envelope)),
                    ),
                    const SizedBox(height:20),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("tPhoneNo"), prefixIcon: Icon(LineAwesomeIcons.phone_solid)),
                    ),
                    const SizedBox(height:20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text("tPassword"),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon:
                        IconButton(icon: const Icon(LineAwesomeIcons.eye_slash), onPressed: () {}),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const UpdateProfileScreen()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("tEditProfile", style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text.rich(
                          TextSpan(
                            text: "tJoined",
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: "tJoinedAt",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.red,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: const Text("tDelete"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}