// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/routes/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    //Tự động chuyển sang màn hình Onboarding sau 3 giây
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRouter.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Màu nền dự phòng nếu ảnh lỗi
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E3A8A), // Xanh đậm
              Color(0xFF3B82F6), // Xanh biển
              Color(0xFFF59E0B), // Cam
            ],
          ),
        ),
        child: Stack(
          children: [
            // Ảnh nền (nếu có file ảnh)
            Image.asset(
              'assets/images/splash_bg.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink(); // Ẩn nếu lỗi, chỉ hiện gradient
              },
            ),
            
            // Lớp phủ màu đen để chữ dễ đọc hơn
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
            
            // Nội dung chính
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Icon(
                      Icons.flight_takeoff,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Tên app
                  const Text(
                    'Travel Planner',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Slogan
                  const Text(
                    'Hành trình của bạn, được chế tác tỉ mỉ.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Vòng tròn loading
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Text loading
                  const Text(
                    'ĐANG CHUẨN BỊ THẾ GIỚI CỦA BẠN...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 300),
                  
                  // Badge Premium
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.cyan,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'PHIÊN BẢN PREMIUM',
                        style: TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.cyan,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}