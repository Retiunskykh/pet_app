class PetColorsDto {
  final String? primary;
  final String? secondary;
  final String? tertiary;

  PetColorsDto({
    required this.primary,
    required this.secondary,
    required this.tertiary,
  });

  factory PetColorsDto.fromJson(Map<String, dynamic> json) {
    return PetColorsDto(
      primary: json['primary'],
      secondary: json['secondary'],
      tertiary: json['tertiary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'primary': primary,
      'secondary': secondary,
      'tertiary': tertiary,
    };
  }
}
