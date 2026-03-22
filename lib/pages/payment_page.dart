import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nike_sneakers/models/address.dart';
import 'package:nike_sneakers/models/cart.dart';
import 'package:nike_sneakers/pages/order_success_page.dart';
import 'package:nike_sneakers/services/notification_service.dart';

class PaymentPage extends StatefulWidget {
  final Address selectedAddress;
  
  const PaymentPage({super.key, required this.selectedAddress});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedPaymentMethod = 'card';
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController expiryController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  void dispose() {
    cardNumberController.dispose();
    cardNameController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<Cart>(
        builder: (context, cart, child) {
          return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Summary
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ...cart.getUserCart().map((cartItem) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${cartItem.shoe.name} x${cartItem.quantity}",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Text(
                            "\$${cartItem.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "\$${cart.calculateTotal()}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Delivery Address
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.grey[900], size: 24),
                        const SizedBox(width: 8),
                        const Text(
                          "Delivery Address",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.selectedAddress.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.selectedAddress.phoneNumber,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.selectedAddress.fullAddress,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Payment Method
              const Text(
                "Payment Method",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(15.0),
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    _buildPaymentOption('card', Icons.credit_card, 'Credit/Debit Card'),
                    const Divider(height: 20),
                    _buildPaymentOption('paypal', Icons.account_balance_wallet, 'PayPal'),
                    const Divider(height: 20),
                    _buildPaymentOption('apple', Icons.apple, 'Apple Pay'),
                  ],
                ),
              ),

              // Card Details (if card selected)
              if (selectedPaymentMethod == 'card') ...[
                const Text(
                  "Card Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: cardNumberController,
                  hint: "Card Number",
                  icon: Icons.credit_card,
                  keyboardType: TextInputType.number,
                  maxLength: 19,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: cardNameController,
                  hint: "Cardholder Name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: expiryController,
                        hint: "MM/YY",
                        icon: Icons.calendar_today,
                        keyboardType: TextInputType.number,
                        maxLength: 5,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildTextField(
                        controller: cvvController,
                        hint: "CVV",
                        icon: Icons.lock,
                        keyboardType: TextInputType.number,
                        maxLength: 3,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],

              // Pay Button
              GestureDetector(
                onTap: () async {
                  // Capture context and values before async operations
                  final navigatorContext = context;
                  final orderId = DateTime.now().millisecondsSinceEpoch.toString();
                  final shortOrderId = orderId.substring(orderId.length - 6);
                  final orderTotal = cart.calculateTotal();
                  
                  try {
                    // Show notification
                    await NotificationService.showOrderCompletedNotification(
                      orderTotal: orderTotal,
                      orderId: shortOrderId,
                    );
                  } catch (e) {
                    // If notification fails, continue anyway
                  }

                  // Navigate to success page
                  if (!mounted) return;
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacement(
                    navigatorContext,
                    MaterialPageRoute(
                      builder: (newContext) => OrderSuccessPage(
                        orderTotal: orderTotal,
                        orderId: shortOrderId,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(25),
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Center(
                    child: Text(
                      "Pay \$${cart.calculateTotal()}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        },
      ),
    );
  }

  Widget _buildPaymentOption(String method, IconData icon, String title) {
    final isSelected = selectedPaymentMethod == method;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.grey[900] : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[700],
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: Colors.grey[900],
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Colors.grey[900],
                size: 24,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int? maxLength,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLength: maxLength,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(18),
          counterText: '',
        ),
      ),
    );
  }

}

