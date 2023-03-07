const baseUrl = 'shopp-9ad71-default-rtdb.asia-southeast1.firebasedatabase.app';

Uri toUrl(String str) {
  return Uri.https(baseUrl, str);
}
