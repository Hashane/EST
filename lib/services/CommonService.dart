import 'dart:math';

class CommonService {
  int generateUniqueId() {
    // Get the current timestamp in milliseconds
    int timestamp = DateTime
        .now()
        .millisecondsSinceEpoch;

    // Generate a random number between 0 and 9999
    int randomNumber = Random().nextInt(10000);

    // Concatenate the timestamp and random number to form the unique ID
    int uniqueId = int.parse('$timestamp$randomNumber');

    return uniqueId;
  }
}