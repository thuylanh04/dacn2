class User {
  final String? id;
  final String fullName;
  final String email;
  final String mobileNumber;
  final String dateOfBirth;
  final String? profileImage;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.mobileNumber,
    required this.dateOfBirth,
    this.profileImage,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? mobileNumber,
    String? dateOfBirth,
    String? profileImage,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}