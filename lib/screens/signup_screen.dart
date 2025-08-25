import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../providers/persona_providers.dart';
import '../widgets/animated_background.dart';
import '../widgets/animated_controls.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signUpWithEmail(_emailController.text.trim(), _passwordController.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/onboarding');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final persona = ref.watch(personaControllerProvider).persona;
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackground(persona: persona),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TweenAnimationBuilder<double>(
                          duration: const Duration(milliseconds: 450),
                          tween: Tween(begin: 0, end: 1),
                          builder: (_, v, __) => Opacity(
                            opacity: v,
                            child: Transform.translate(
                              offset: Offset(0, (1 - v) * 12),
                              child: Column(
                                children: const [
                                  Text('Create your account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                                  SizedBox(height: 12),
                                ],
                              ),
                            ),
                          ),
                        ),
                        AnimatedTextField(icon: Icons.email_outlined, label: 'Email', controller: _emailController, keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 12),
                        AnimatedTextField(icon: Icons.lock_outline, label: 'Password', controller: _passwordController, obscureText: true),
                        const SizedBox(height: 20),
                        AnimatedPrimaryButton(
                          label: _isLoading ? 'Creating…' : 'Create Account',
                          onPressed: _isLoading ? null : _handleSignUp,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed('/signin'),
                          child: const Text('Already have an account? Sign in'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


