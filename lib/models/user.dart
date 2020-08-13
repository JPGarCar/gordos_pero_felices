/// This is the User class, it represents a real human using the app.
class User {
  String name;
  String lastName;
  String email;
  String city;
  int day;
  int month;
  int year;
  int age;

  // TODO see what I can use to connect to a firebase user authenticator

  User(
      {this.name,
      this.lastName,
      this.email,
      this.city,
      this.day,
      this.month,
      this.year}) {
    if (year != null) {
      setAge();
    } else {
      age = 0;
    }
  }

  /// Sets the users age by time difference to user's birth year
  void setAge() {
    var now = new DateTime.now();
    age = now.year - year;
  }
}
