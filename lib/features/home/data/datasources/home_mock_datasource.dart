import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../models/service_model.dart';

@lazySingleton
class HomeMockDataSource {
  Future<List<ServiceModel>> fetchServices() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      ServiceModel(
        id: '1',
        title: 'General Nursing Care',
        description: 'Routine health checkups, vital signs monitoring, and basic nursing services.',
        iconCodePoint: Icons.medical_services_outlined.codePoint,
        price: 'From 1500 EGP',
      ),
      ServiceModel(
        id: '2',
        title: 'Post-Surgical Care',
        description: 'Wound dressing, medication management, and recovery assistance post-surgery.',
        iconCodePoint: Icons.healing_outlined.codePoint,
        price: 'From 2200 EGP',
      ),
      ServiceModel(
        id: '3',
        title: 'Elderly & Geriatric Care',
        description: 'Daily living assistance, cognitive support, and dedicated companion care.',
        iconCodePoint: Icons.elderly_outlined.codePoint,
        price: 'From 2500 EGP',
      ),
      ServiceModel(
        id: '4',
        title: 'Medication Management',
        description: 'Assistance with injections, intravenous therapy, and medication schedule supervision.',
        iconCodePoint: Icons.vaccines_outlined.codePoint,
        price: 'From 1000 EGP',
      ),
    ];
  }
}
