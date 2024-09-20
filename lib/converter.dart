String convertToDotNet(String rawUri) {
  if (rawUri.startsWith("jdbc")) {
    return _convertFromJdbc(rawUri);
  } else {
    return _convertFromUri(rawUri);
  }
}

String _convertFromJdbc(String rawUri) {
  final uri = Uri.parse(rawUri.substring("jdbc:".length));
  final params = [
    "Server=${uri.host}",
    if (uri.hasPort) "Port=${uri.port}",
    if (!uri.hasEmptyPath) "DB=${uri.pathSegments.first}",
    if (uri.hasQuery) ...[
      if (uri.queryParameters.containsKey("user"))
        "UID=${uri.queryParameters["user"]}",
      if (uri.queryParameters.containsKey("password"))
        "PWD=${uri.queryParameters["password"]}",
      if (uri.queryParameters.containsKey("ssl"))
        "SslMode=${uri.queryParameters["ssl"]}"
    ]
  ];
  return params.join(";");
}

String _convertFromUri(String rawUri) {
  final uri = Uri.parse(rawUri);
  final params = [
    "Server=${uri.host}",
    if (uri.hasPort) "Port=${uri.port}",
    if (!uri.hasEmptyPath) "DB=${uri.pathSegments.first}",
    if (uri.hasAuthority) ..._convertAuthority(uri.authority),
    if (uri.hasQuery) ...[
      if (uri.queryParameters.containsKey("sslmode"))
        "SslMode=${uri.queryParameters["sslmode"]}",
    ]
  ];
  return params.join(";");
}

List<String> _convertAuthority(String authority) {
  final parts = authority.split("@").first.split(":");
  return [
    if (parts.isNotEmpty) "UID=${parts[0]}",
    if (parts.length > 1) "PWD=${parts[1].split("@").first}",
  ];
}
