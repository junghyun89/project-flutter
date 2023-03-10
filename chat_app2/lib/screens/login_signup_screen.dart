import 'package:chat_app2/config/palette.dart';
import 'package:chat_app2/service/database_service.dart';
import 'package:chat_app2/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  final _authentication = FirebaseAuth.instance;
  bool isSignUpScreen = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Palette.activeColor,
                ),
              )
            : Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 300,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('image/galaxy.jpg'),
                          fit: BoxFit.fill,
                          opacity: 0.9,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 90,
                          left: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Welcome',
                                style: const TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 25,
                                  color: Colors.white,
                                ),
                                children: [
                                  TextSpan(
                                    text: isSignUpScreen
                                        ? ' to Universe chat!'
                                        : ' back',
                                    style: const TextStyle(
                                      letterSpacing: 1.0,
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              isSignUpScreen
                                  ? 'Sign up to continue'
                                  : 'Signing to continue',
                              style: const TextStyle(
                                letterSpacing: 1.0,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    top: 180,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn,
                      padding: const EdgeInsets.all(20),
                      height: isSignUpScreen ? 280 : 250,
                      width: MediaQuery.of(context).size.width - 40,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5,
                          )
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignUpScreen = false;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'LOGIN',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSignUpScreen
                                              ? Palette.textColor1
                                              : Palette.activeColor,
                                        ),
                                      ),
                                      if (!isSignUpScreen)
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 4,
                                          ),
                                          height: 2,
                                          width: 55,
                                          color: Palette.activeColor,
                                        )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isSignUpScreen = true;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Text(
                                        'SIGN UP',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: isSignUpScreen
                                              ? Palette.activeColor
                                              : Palette.textColor1,
                                        ),
                                      ),
                                      if (isSignUpScreen)
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 4,
                                          ),
                                          height: 2,
                                          width: 55,
                                          color: Palette.activeColor,
                                        )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (isSignUpScreen)
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        onSaved: (value) {
                                          userName = value!;
                                        },
                                        onChanged: (value) {
                                          userName = value;
                                        },
                                        validator: (value) {
                                          return validateUserName(value);
                                        },
                                        key: const ValueKey(1),
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.account_circle,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          hintText: 'User name',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (value) {
                                          userEmail = value!;
                                        },
                                        onChanged: (value) {
                                          userEmail = value;
                                        },
                                        validator: (value) {
                                          return validateEmail(value);
                                        },
                                        key: const ValueKey(2),
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.mail,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        onSaved: (value) {
                                          userPassword = value!;
                                        },
                                        onChanged: (value) {
                                          userPassword = value;
                                        },
                                        key: const ValueKey(3),
                                        validator: (value) {
                                          return validatePassword(value);
                                        },
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if (!isSignUpScreen)
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 20,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onSaved: (value) {
                                          userEmail = value!;
                                        },
                                        onChanged: (value) {
                                          userEmail = value;
                                        },
                                        validator: (value) {
                                          return validateEmail(value);
                                        },
                                        key: const ValueKey(4),
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.mail,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      TextFormField(
                                        obscureText: true,
                                        onSaved: (value) {
                                          userPassword = value!;
                                        },
                                        onChanged: (value) {
                                          userPassword = value;
                                        },
                                        validator: (value) {
                                          return validatePassword(value);
                                        },
                                        key: const ValueKey(5),
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.lock,
                                            color: Palette.iconColor,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Palette.textColor1,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(35),
                                            ),
                                          ),
                                          hintText: 'Password',
                                          hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Palette.textColor1,
                                          ),
                                          contentPadding: EdgeInsets.all(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    top: isSignUpScreen ? 420 : 390,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _tryValidation();
                            signUpOrLogin();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Colors.blueGrey,
                                  Palette.activeColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                )
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    top: isSignUpScreen
                        ? MediaQuery.of(context).size.height - 125
                        : MediaQuery.of(context).size.height - 165,
                    right: 0,
                    left: 0,
                    child: Column(
                      children: [
                        isSignUpScreen
                            ? const Text(' or Sign Up with')
                            : const Text(' or Sign In with'),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            minimumSize: const Size(155, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Palette.googleColor,
                          ),
                          icon: const Icon(Icons.add),
                          label: const Text('Google'),
                        )
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void _tryValidation() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
    }
  }

  signUpOrLogin() async {
    late UserCredential newUser;
    try {
      if (isSignUpScreen) {
        newUser = await _authentication.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
        DatabaseService(uid: newUser.user!.uid)
            .saveUserData(userName, userEmail);
      } else if (!isSignUpScreen) {
        newUser = await _authentication.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword,
        );
      }
      if (newUser.user == null) {
        setState(() {
          _isLoading = false;
        });
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (e.code == 'email-already-in-use') {
        showSnackBar(
          context,
          Colors.red,
          'The email address is already in use by another account.',
        );
      } else if (e.code == 'wrong-password') {
        showSnackBar(
          context,
          Colors.red,
          'Please check your password.',
        );
      } else if (e.code == 'user-not-found') {
        showSnackBar(
          context,
          Colors.red,
          'There is no user record corresponding to this identifier.',
        );
      } else {
        showSnackBar(
          context,
          Colors.red,
          'Please check your email and password.',
        );
      }
      print(e);
    }
  }

  String? validateEmail(value) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? validateUserName(value) {
    if (value!.isEmpty || value.length < 4) {
      return 'Please enter at least 4 characters.';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty || value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }
}
