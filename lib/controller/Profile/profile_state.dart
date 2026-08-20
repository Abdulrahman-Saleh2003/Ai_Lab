import 'package:flutter/material.dart';

enum ProfileStatus { initial, loading, success, failure }

@immutable
class PatientProfile {
  final String name;
  final String patientId;
  final String age;
  final String gender;
  final String email;
  final String avatarUrl;

  const PatientProfile({
    required this.name,
    required this.patientId,
    required this.age,
    required this.gender,
    required this.email,
    required this.avatarUrl,
  });

  PatientProfile copyWith({
    String? name,
    String? patientId,
    String? age,
    String? gender,
    String? email,
    String? avatarUrl,
  }) {
    return PatientProfile(
      name: name ?? this.name,
      patientId: patientId ?? this.patientId,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

@immutable
class ProfileState {
  final PatientProfile profile;
  final ProfileStatus status;
  final String? errorMessage;

  const ProfileState({
    this.profile = const PatientProfile(
      name: 'Ahmed Mohammed',
      patientId: '#LS-8829-X',
      age: '28 Years',
      gender: 'Male',
      email: 'ahmed.m@email.com',
      avatarUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuChIah-LYn2BD2fZMC_hbGBuFcLVZ1MhJTUWSgcVuQzcANlG_L4WoZ7x7lTqqu4No6eeUOmMrFDD2GxEuynMjidAUKXR3dcraJuZ11NNUapjK2a1_QZio5Fsjs74BGr0CtHVGHZMaWLun7-bbkAcV4tO5sVFCP2IuLcSJAyT0tSYfV1v2tyksTwDIKUojrGTUX3ZoFHbHk39hmPc186lORIb4T5gVHCs2qksjyjK6WCI1AKlZJUiu_uqJvuErZ9pwQHO_cNtkWwMxl-',
    ),
    this.status = ProfileStatus.initial,
    this.errorMessage,
  });

  ProfileState copyWith({
    PatientProfile? profile,
    ProfileStatus? status,
    String? errorMessage,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
