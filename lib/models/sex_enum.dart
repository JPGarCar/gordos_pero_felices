enum Sex {
  male,
  female,
  other,
}
String getSexValue(Sex sex) {
  switch (sex) {
    case Sex.male:
      return 'Hombre';
    case Sex.female:
      return 'Mujer';
    case Sex.other:
      return 'Otro';
    default:
      return 'Otro';
  }
}

Sex getSexEnum(String sex) {
  switch (sex) {
    case 'Mujer':
      return Sex.female;
    case 'Hombre':
      return Sex.male;
    case 'Otro':
      return Sex.other;
    default:
      return Sex.other;
  }
}
