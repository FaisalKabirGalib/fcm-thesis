import 'package:fcm_thesis_publish/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/form_wid.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fristNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final registrationNoController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    final authres = ref.watch(authenticationResponseProvider);

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Center(
          child: authres.when(
              data: (data) {
                debugPrint("data: $data");
                if (data.containsValue("Sign Up Success")) {
                  Future.delayed(Duration.zero).then((value) => {Get.back()});
                }
                return ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          children: [
                            // sign up
                            Text(
                              'Sign Up',
                              style: GoogleFonts.roboto(fontSize: 35),
                            ),
                            const SizedBox(height: 20),

                            // first name
                            FormWidget(
                              text: 'First Name',
                              controller: fristNameController,
                            ),
                            const SizedBox(height: 10),

                            // last name
                            FormWidget(
                              text: 'Last Name',
                              controller: lastNameController,
                            ),
                            const SizedBox(height: 10),

                            // email address
                            FormWidget(
                              text: 'Email Address',
                              controller: emailController,
                            ),
                            const SizedBox(height: 10),

                            // registration no
                            FormWidget(
                              text: 'Registration No.',
                              controller: registrationNoController,
                            ),
                            const SizedBox(height: 10),

                            // password
                            FormWidget(
                              text: 'Password',
                              obsecuretext: true,
                              controller: passwordController,
                            ),
                            const SizedBox(height: 10),
                            // confirm password
                            FormWidget(
                              text: 'Confirm Password',
                              obsecuretext: true,
                              controller: confirmPasswordController,
                            ),
                            const SizedBox(height: 20),

                            // sign-up button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                ),
                                onPressed: () {
                                  final data = {
                                    "firstName": fristNameController.text,
                                    "lastName": lastNameController.text,
                                    "email": emailController.text,
                                    "registrationNumber":
                                        registrationNoController.text,
                                    "password": passwordController.text,
                                    "confirmPassword": passwordController.text
                                  };

                                  ref
                                      .read(authenticationResponseProvider
                                          .notifier)
                                      .signUp(data);
                                },
                                child: Text(
                                  'SIGN Up',
                                  style: GoogleFonts.poiretOne(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (e, s) => Center(child: Text("Somethings went wrong $e")),
              loading: () => const Center(child: CircularProgressIndicator())),
        ),
      ),
    ));
  }
}
