import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../providers/persona_providers.dart';
import '../widgets/animated_background.dart';
import '../widgets/animated_controls.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signInWithEmail(_emailController.text.trim(), _passwordController.text);
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogle() async {
    setState(() => _isLoading = true);
    try {
      final auth = ref.read(authServiceProvider);
      await auth.signInWithGoogle();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
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
                                children: [
                                  Text('Schrolar', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w700)),
                                  const SizedBox(height: 6),
                                  Text('Gain info via scrolling', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[600])),
                                  const SizedBox(height: 16),
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
                          label: _isLoading ? 'Signing in…' : 'Sign In',
                          onPressed: _isLoading ? null : _handleSignIn,
                        ),
                        const SizedBox(height: 8),
                        OutlinedButton.icon(
                          onPressed: _isLoading ? null : _handleGoogle,
                          icon: const Icon(Icons.g_mobiledata, size: 24),
                          label: const Text('Continue with Google'),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () => Navigator.of(context).pushReplacementNamed('/signup'),
                          child: const Text('Create account'),
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


