extension StringExt on String {
  String get obscureEmail {
    // split the email into username and domain
    final index = indexOf('@');
    var userName = substring(0, index);
    final domain = substring(index + 1);

    // Obscure the username and display only the first and last characters
    userName = '${userName[0]}****${userName[userName.length - 1]}';

    return '$userName@$domain';
  }
}
