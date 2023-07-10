import 'package:fcm_thesis_publish/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../components/form_wid.dart';
import 'sign_up_screen.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authres = ref.watch(authenticationResponseProvider);
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
            // padding: const EdgeInsets.all(25),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: authres.when(
                data: (data) => Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          // text
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    'Sign In',
                                    style: GoogleFonts.roboto(fontSize: 35),
                                  ),
                                  const SizedBox(height: 20),

                                  // user-name
                                  FormWidget(
                                    controller: emailController,
                                    text: 'Email Address',
                                  ),
                                  const SizedBox(height: 10),
                                  // password
                                  FormWidget(
                                    obsecuretext: true,
                                    controller: passwordController,
                                    text: 'Password',
                                  ),
                                  const SizedBox(height: 20),

                                  // sign-in button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pink,
                                        // backgroundColor: Colors.pink,
                                      ),
                                      onPressed: () {
                                        ref
                                            .read(authenticationResponseProvider
                                                .notifier)
                                            .signIn(emailController.text,
                                                passwordController.text);
                                      },
                                      child: Text(
                                        'SIGN IN',
                                        style: GoogleFonts.poiretOne(),
                                      ),
                                    ),
                                  ),

                                  // create new account
                                  TextButton(
                                    onPressed: () {
                                      Get.to(const SignUpScreen());
                                    },
                                    child: Text(
                                      'Create an account',
                                      style: GoogleFonts.comfortaa(
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                error: (e, s) => Text("Something went wrong $e"),
                loading: () => const CircularProgressIndicator())),
      ),
    );
  }
}
