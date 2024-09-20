import 'package:connection_strings/converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Convert from Aiven", () {
    const uri =
        "postgres://username:password@hostname:5432/database?sslmode=require";
    const expected =
        "Server=hostname;Port=5432;DB=database;UID=username;PWD=password;SslMode=require";

    final actual = convertToDotNet(uri);
    final diff = difference(actual.split(";"), expected.split(";"));
    expect(diff, isEmpty);
  });

  test("Convert JDBC format", () {
    const uri =
        "jdbc:postgresql://hostname:5432/database?ssl=require&user=username&password=password";
    const expected =
        "Server=hostname;Port=5432;DB=database;UID=username;PWD=password;SslMode=require";

    final actual = convertToDotNet(uri);
    final diff = difference(actual.split(";"), expected.split(";"));
    expect(diff, isEmpty);
  });
}

List<String> difference(List<String> first, List<String> second) {
  return [
    ...Set.of(first).difference(Set.of(second)),
    ...Set.of(second).difference(Set.of(first)),
  ];
}
