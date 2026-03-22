import 'package:flutter/material.dart';
import 'package:nike_sneakers/models/address.dart';
import 'package:nike_sneakers/pages/payment_page.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  List<Address> savedAddresses = [
    Address(
      id: '1',
      fullName: 'Manas Srivastava',
      phoneNumber: '9919496519',
      streetAddress: 'Rajarshee Colony',
      city: 'Mirzapur',
      state: 'Uttar Pradesh',
      zipCode: '231001',
      landmark: 'Police line',
      isDefault: true,
    ),
    Address(
      id: '2',
      fullName: 'Manas Srivastava',
      phoneNumber: '8787211543',
      streetAddress: 'Kiet College Tagore Hostel',
      city: 'Ghaziabad',
      state: 'Uttar Pradesh',
      zipCode: '201206',
      landmark: 'Meerut Road',
      isDefault: false,
    ),
  ];

  Address? selectedAddress;

  @override
  void initState() {
    super.initState();
    // Set default address as selected
    selectedAddress = savedAddresses.firstWhere((addr) => addr.isDefault,
        orElse: () => savedAddresses.first);
  }

  void _showAddAddressDialog() {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    final streetController = TextEditingController();
    final cityController = TextEditingController();
    final stateController = TextEditingController();
    final zipController = TextEditingController();
    final landmarkController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          "Add New Address",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(
                  controller: nameController,
                  label: "Full Name",
                  icon: Icons.person,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: phoneController,
                  label: "Phone Number",
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: streetController,
                  label: "Street Address",
                  icon: Icons.home,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: cityController,
                        label: "City",
                        icon: Icons.location_city,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _buildTextField(
                        controller: stateController,
                        label: "State",
                        icon: Icons.map,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: zipController,
                  label: "ZIP Code",
                  icon: Icons.pin,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _buildTextField(
                  controller: landmarkController,
                  label: "Landmark (Optional)",
                  icon: Icons.location_on,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  savedAddresses.add(Address(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    fullName: nameController.text,
                    phoneNumber: phoneController.text,
                    streetAddress: streetController.text,
                    city: cityController.text,
                    state: stateController.text,
                    zipCode: zipController.text,
                    landmark: landmarkController.text.isEmpty
                        ? null
                        : landmarkController.text,
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  void _proceedToCheckout() {
    if (selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please select an address"),
          backgroundColor: Colors.grey[900],
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(selectedAddress: selectedAddress!),
      ),
    );
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
          "Select Address",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: savedAddresses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_off,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No saved addresses",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: savedAddresses.length,
                    itemBuilder: (context, index) {
                      final address = savedAddresses[index];
                      final isSelected = selectedAddress?.id == address.id;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAddress = address;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.grey[900]!
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(18),
                          child: Row(
                            children: [
                              // Radio button
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.grey[900]!
                                        : Colors.grey[400]!,
                                    width: 2,
                                  ),
                                  color: isSelected
                                      ? Colors.grey[900]
                                      : Colors.transparent,
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 15),
                              // Address details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            address.fullName,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        if (address.isDefault)
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[900],
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: const Text(
                                              "DEFAULT",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      address.phoneNumber,
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      address.fullAddress,
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Add address button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: GestureDetector(
              onTap: _showAddAddressDialog,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[400]!),
                ),
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.grey[800]),
                    const SizedBox(width: 8),
                    Text(
                      "Add New Address",
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Proceed to checkout button
          Padding(
            padding: const EdgeInsets.all(20),
            child: GestureDetector(
              onTap: _proceedToCheckout,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: Text(
                    "Proceed to Checkout",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

