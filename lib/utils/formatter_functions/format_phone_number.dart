String formatPhoneNumber(String phoneNumber) {
  // Format the phone number into the desired pattern
  return '+998 ${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)} ${phoneNumber.substring(5, 7)} ${phoneNumber.substring(7)}';
}
