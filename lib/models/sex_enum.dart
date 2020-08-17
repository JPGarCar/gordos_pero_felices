enum Sex {
  male,
  female,
  other,
}
String getSexValue(Sex sex) {
  switch (sex) {
    case Sex.male:
      return 'Male';
      break;
    case Sex.female:
      return 'Female';
      break;
    case Sex.other:
      return 'Other';
      break;
    default:
      return 'Other';
  }
}
