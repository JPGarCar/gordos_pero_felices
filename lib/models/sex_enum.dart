enum Sex {
  male,
  female,
  other,
}
String getSexValue(Sex sex) {
  switch (sex) {
    case Sex.male:
      return 'Hombre';
      break;
    case Sex.female:
      return 'Mujer';
      break;
    case Sex.other:
      return 'Otro';
      break;
    default:
      return 'Otro';
  }
}
