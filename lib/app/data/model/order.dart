import 'package:cloud_firestore/cloud_firestore.dart';

class OrderLaundry {
  final String name;
  final String phone;
  final String address;
  final String houseNumber;
  final bool isCuciLipat;
  final bool isCuciSetrika;
  final double totalPrice;
  final double quantity;
  final String additionalNote;
  final String status;
  final DateTime orderDate;

  OrderLaundry({
    required this.name,
    required this.phone,
    required this.address,
    required this.houseNumber,
    required this.isCuciLipat,
    required this.isCuciSetrika,
    required this.totalPrice,
    required this.quantity,
    required this.additionalNote,
    required this.status,
    required this.orderDate,
  });

  factory OrderLaundry.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OrderLaundry(
      name: data['name'],
      phone: data['phone'],
      address: data['address'],
      houseNumber: data['houseNumber'],
      isCuciLipat: data['isCuciLipat'],
      isCuciSetrika: data['isCuciSetrika'],
      totalPrice: data['totalPrice'],
      quantity: data['quantity'],
      additionalNote: data['additionalNote'],
      status: data['status'],
      orderDate: (data['orderDate'] as Timestamp).toDate(),
    );
  }
}
