import 'package:calender_test/features/auth/presentation/providers/auth_providers_di.dart'; // 경로 수정
import 'package:calender_test/features/auth/presentation/viewmodels/login_viewmodel.dart'; // 경로 및 타입 수정
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final userIdController = TextEditingController(text: "mobile"); // 테스트용 기본값
  final passwordController = TextEditingController(
    text: "stecdev1234!",
  ); // 테스트용 기본값

  @override
  void dispose() {
    userIdController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ViewModel과 State 참조 변경
    final loginVM = ref.read(loginViewModelProvider.notifier);
    final loginState = ref.watch(loginViewModelProvider);

    // 로그인 상태 변경 감지 및 화면 이동 / 오류 메시지 처리
    ref.listen<LoginStatus>(loginViewModelProvider, (previous, next) {
      if (next == LoginStatus.success) {
        context.go('/calendar'); // 로그인 성공 시 캘린더 화면으로 이동
      }
      if (next == LoginStatus.error) {
        // 오류 메시지 표시 (예: SnackBar)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("로그인 실패")));
      }
    });

    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              _inputField('아이디', userIdController), // 한글 힌트
              const SizedBox(height: 16),
              _inputField(
                '비밀번호',
                passwordController,
                isPassword: true,
              ), // 한글 힌트
              const SizedBox(height: 16),
              _loginButton(loginVM, loginState), // ViewModel과 State 전달
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton(
    LoginViewModel vm,
    LoginStatus state, // 타입 변경
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
          ),
          backgroundColor: const WidgetStatePropertyAll<Color>(
            Color(0xff0A80ED),
          ),
        ),
        onPressed:
            state ==
                LoginStatus
                    .loading // 로딩 중일 때 버튼 비활성화
            ? null
            : () {
                vm.login(userIdController.text, passwordController.text);
              },
        child:
            state ==
                LoginStatus
                    .loading // 로딩 상태 확인 변경
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text(
                '로그인',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ), // 한글 및 스타일 추가
      ),
    );
  }

  Widget _inputField(
    String hintText,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: TextInputType.name, // 이메일/텍스트에 따라 변경 가능
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16, color: Color(0xff61758A)),
          filled: true,
          fillColor: const Color(0xffF0F2F5),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text(
        'S-TEC 로그인', // 타이틀 변경
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
