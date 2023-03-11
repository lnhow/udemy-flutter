const baseUrl = 'shopp-9ad71-default-rtdb.asia-southeast1.firebasedatabase.app';
const apiKey = 'AIzaSyBryTnxUaYyfnVfZaITa2Ir5cYJOFPduH8';

Uri toUrl(String str, {String? auth}) {
  final Map<String, dynamic> queryParams = {};
  if (auth != null) {
    queryParams['auth'] = auth;
  }
  return Uri.https(baseUrl, str, queryParams);
}

class AuthHTTP {
  static Uri signInUrl = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');

  static Uri signUpUrl = Uri.parse(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
}
