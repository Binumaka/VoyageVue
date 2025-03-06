class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/";
  static const String baseUrl = "http://192.168.1.69:3000/api/";

// ============Auth==================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getById = "user/";
  static const String updateById = "user/";
  static const String uploadImage = "auth/uploadImage";

  //===============Guide===============
  static const String getAllGuide = "guides";

//============Destination=================
  static const String getAllDestinations = "destination/";
  static const String addDestination = "destination/";
  static const String getDestinationById = "destination/";
  static const String getDestinationsByCategory = "destination/category/";
  static const String getDestinationsBySection = "destination/section/";
  static const String deleteDestination = "destination/";
  static const String updateDestination = "destination/";

  //==============Accommodation==================
  static const String getAllAccommodations = "accommodation/";
  static const String getAccommodationsByDestination =
      "accommodation/destination/";
  static const String getAccommodationById = "accommodation/select/";
  static const String createAccommodation = "accommodation/";
  static const String updateAccommodation = "accommodation/";
  static const String deleteAccommodation = "accommodation/";

  //=============booking=====================
  static const String deleteBooking = 'booking/';
  static const String getBooking = 'booking/';
  static const String createBooking = 'booking/create';

  //==============bucketlist================
  static const String addToBuketlist = 'bucket-list/';
  static const String getBucketlist = 'bucket-list/';
  static const String removeBucketlist = 'bucket-list/';
}
