import '../utils/country_region.dart';

class LetterDeliveryService {
  static int calculateArrivalDays({
    required String senderCountryCode,
    required String receiverCountryCode,
  }) {
    // Same country
    if (senderCountryCode == receiverCountryCode) {
      return 1;
    }

    final senderRegion = countryRegionMap[senderCountryCode];
    final receiverRegion = countryRegionMap[receiverCountryCode];

    // Same region (ama farklı ülke)
    if (senderRegion != null &&
        receiverRegion != null &&
        senderRegion == receiverRegion) {
      return 3;
    }

    // Default: different region
    return 7;
  }
}
