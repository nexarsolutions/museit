import 'package:intl/intl.dart';
import 'package:musit/services/api_service.dart';

extension CustomStringDisplay on String? {
  String get showImage {
    // Handle null or empty string first
    if (this == null || this!.isEmpty) return '';

    // If it already contains a full URL (from backend)
    if (this!.startsWith('http')) {
      return this!;
    }

    // Otherwise, append your base image URL
    return ApiService.imageUrl + this!;
  }

  String get withNa {
    // Handle null or empty string first
    if (this == null || this!.isEmpty) return 'N/A';

    // Otherwise, append your base image URL
    return this!;
  }
}

extension DateHandling on DateTime? {
  String get formatDate {
    if (this == null) return 'N/A';

    return DateFormat('dd-MM-yyyy').format(this!);
  }
}
