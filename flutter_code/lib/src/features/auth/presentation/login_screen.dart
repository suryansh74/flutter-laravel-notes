import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_app/src/features/auth/presentation/auth_controller.dart';
import 'package:notes_app/src/features/notes/presentation/notes_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // Always dispose controllers to prevent memory leaks
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Listen for successful login to navigate automatically
    ref.listen(authControllerProvider, (previous, next) {
      if (!next.isLoading && next.hasValue && next.value != null) {
        // Navigate to NotesScreen and remove LoginScreen from the backstack
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const NotesScreen()),
        );
      }
    });

    // 2. Watch the current state to show loading spinners or errors
    final state = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 32),

            // 3. Show a loading indicator if the state is loading, otherwise show the button
            state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              orElse: () => ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  // Hide the keyboard
                  FocusScope.of(context).unfocus();

                  // Trigger the login logic
                  await ref
                      .read(authControllerProvider.notifier)
                      .login(
                        _emailController.text.trim(),
                        _passwordController.text,
                      );

                  // Show an error snackbar if it failed
                  if (ref.read(authControllerProvider).hasError && mounted) {
                    final error = ref.read(authControllerProvider).error;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.toString()),
                        backgroundColor: Colors.red.shade800,
                      ),
                    );
                  }
                },
                child: const Text('Login', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

