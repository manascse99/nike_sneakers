import 'package:flutter/material.dart';
import 'package:nike_sneakers/models/cart.dart';
import 'package:nike_sneakers/pages/home_page.dart';
import 'package:provider/provider.dart';

class OrderSuccessPage extends StatefulWidget {
  final String orderTotal;
  final String orderId;

  const OrderSuccessPage({
    super.key,
    required this.orderTotal,
    required this.orderId,
  });

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  late AnimationController _pulseController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.3).chain(
        CurveTween(curve: Curves.easeOut),
      ), weight: 0.6),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0).chain(
        CurveTween(curve: Curves.easeIn),
      ), weight: 0.4),
    ]).animate(_scaleController);

    // Rotation animation
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _rotationAnimation = Tween<double>(
      begin: -0.2,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeOutBack,
      ),
    );

    // Fade animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeIn,
      ),
    );

    // Pulse animation for background circle
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    // Start animations
    _scaleController.forward();
    _rotationController.forward();
    _fadeController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _fadeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    // Clear cart
    Provider.of<Cart>(context, listen: false).clearCart();

    // Navigate to home page and clear stack
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated success icon
                AnimatedBuilder(
                  animation: Listenable.merge([
                    _scaleAnimation,
                    _rotationAnimation,
                    _pulseAnimation,
                  ]),
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value * _pulseAnimation.value,
                      child: Transform.rotate(
                        angle: _rotationAnimation.value,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green[100],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withValues(alpha: 0.3),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 120,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 50),

                // Success message
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      const Text(
                        "Order Completed!",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Your order of \$${widget.orderTotal} has been placed successfully!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Order ID: ${widget.orderId}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),

                // Continue Shopping button
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: GestureDetector(
                    onTap: _navigateToHome,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: const Center(
                        child: Text(
                          "Continue Shopping",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

