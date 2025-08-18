import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  String? selectedUPI;
  String? selectedCard;
  final TextEditingController _upiIdController = TextEditingController();

  final List<Map<String, dynamic>> upiOptions = [
    {
      'name': 'Google Pay',
      'image': "assets/images/payment_methods/google-pay.png",
      'id': 'google_pay',
    },
    {
      'name': 'PhonePe',
      'image': "assets/images/payment_methods/phone-pay.png",
      'id': 'phonepe',
    },
    {
      'name': 'Paytm',
      'image': "assets/images/payment_methods/paytm.png",
      'id': 'paytm',
    },
    {
      'name': 'Apple Pay',
      'image': "assets/images/payment_methods/apple-pay.png",
      'id': 'apple_pay',
    },
    {
      'name': 'BHIM UPI',
      'image': "assets/images/payment_methods/upi.png",
      'id': 'bhim',
    },
  ];

  final List<Map<String, dynamic>> cardOptions = [
    {
      'name': 'Credit Card',
      'image': "assets/images/payment_methods/credit-card.png",
      'id': 'credit_card',
    },
    {
      'name': 'Debit Card',
      'image': "assets/images/payment_methods/debit-card.png",
      'id': 'debit_card',
    },
    {
      'name': 'Net Banking',
      'image': "assets/images/payment_methods/net-banking.png",
      'id': 'net_banking',
    },
  ];

  void _showUpiBottomSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20.0,
            right: 20.0,
            top: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add UPI ID',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // UPI ID Input
              TextField(
                controller: _upiIdController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'UPI ID',
                  labelStyle: TextStyle(color: Colors.black),
                  hintText: 'Enter your UPI ID (e.g., name@upi)',
                  hintStyle: TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  prefixIcon: Icon(Icons.payment, color: Colors.black),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Apply Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_upiIdController.text.isNotEmpty) {
                      // Add the new UPI ID to the list
                      setState(() {
                        upiOptions.add({
                          'name': 'Custom UPI',
                          'image': "assets/images/payment_methods/upi.png",
                          'id': 'custom_upi_${_upiIdController.text}',
                          'upiId': _upiIdController.text,
                        });
                        selectedPaymentMethod =
                            'custom_upi_${_upiIdController.text}';
                        selectedUPI = 'custom_upi_${_upiIdController.text}';
                        selectedCard = null;
                      });
                      _upiIdController.clear();
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('UPI ID added successfully!'),
                          backgroundColor: Color(0xFF00936D),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Apply',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  void _showUpiPaymentDialog(String upiName, String upiImage, String? upiId) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(
                      upiImage,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.payment,
                          color: Colors.black,
                          size: 32,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  'Pay with $upiName',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'You will be redirected to $upiName to complete your payment securely.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (upiId != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 16,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          upiId,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 24),

                // Amount Display
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '₹2,950',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Buttons Row
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Proceed Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // Navigate to payment processing page
                          _navigateToPaymentProcessing(upiName, upiId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Proceed',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToPaymentProcessing(String upiName, String? upiId) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                ),
                const SizedBox(height: 16),
                Text(
                  'Redirecting to $upiName...',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Simulate payment processing delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment initiated with $upiName'),
          backgroundColor: Color(0xFF00936D),
        ),
      );
      // Here you would typically navigate to the actual payment gateway
      // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentGatewayScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment Methods Section
              Text(
                'Pay with any UPI App',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // UPI Payment Options
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ...upiOptions.map(
                      (upi) => _buildUpiOption(
                        name: upi['name'],
                        image: upi['image'],
                        id: upi['id'],
                        upiId: upi['upiId'],
                      ),
                    ),
                    // Add New UPI ID option
                    GestureDetector(
                      onTap: _showUpiBottomSheet,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                "Add New UPI ID",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Cards Section
              Text(
                'Cards & Net Banking',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),

              // Card Payment Options
              GestureDetector(
                onTap: _showUpiBottomSheet,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          "Add New Card Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Pay Button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpiOption({
    required String name,
    required String image,
    required String id,
    String? upiId,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = selectedPaymentMethod == id;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.black : Colors.black,
          width: isSelected ? 1 : 0.5,
        ),
      ),
      child: Row(
        children: [
          // Payment Method Icon (Clickable area)
          GestureDetector(
            onTap: () => _showUpiPaymentDialog(name, image, upiId),
            child: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.payment, color: Colors.black, size: 20),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Payment Method Details (Clickable area)
          Expanded(
            child: GestureDetector(
              onTap: () => _showUpiPaymentDialog(name, image, upiId),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.black : Colors.black,
                    ),
                  ),
                  if (upiId != null)
                    Text(
                      upiId,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                ],
              ),
            ),
          ),
          // Radio Button (separate functionality)
          Radio<String>(
            value: id,
            groupValue: selectedPaymentMethod,
            onChanged: (value) {
              setState(() {
                selectedPaymentMethod = value;
                selectedUPI = value;
                selectedCard = null;
              });
            },
            activeColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String name,
    required String image,
    required String id,
    required String type,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = selectedPaymentMethod == id;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = id;
          if (type == 'upi') {
            selectedUPI = id;
            selectedCard = null;
          } else {
            selectedCard = id;
            selectedUPI = null;
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.black,
            width: isSelected ? 1 : 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        type == 'upi' ? Icons.payment : Icons.credit_card,
                        color: Colors.black,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.black : Colors.black,
                ),
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.black, size: 24),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _upiIdController.dispose();
    super.dispose();
  }
}
