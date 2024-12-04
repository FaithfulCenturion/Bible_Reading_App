import 'package:flutter_riverpod/flutter_riverpod.dart';

//Providers for start and end date
final startDateProvider = StateProvider<DateTime?>((ref) => null);
final endDateProvider = StateProvider<DateTime?>((ref) => null);

// Providers for the toggles
final includeOldTestamentProvider = StateProvider<bool>((ref) => false);
final includeApocryphaProvider = StateProvider<bool>((ref) => false);
final includeNewTestamentProvider = StateProvider<bool>((ref) => false);

final isButtonEnabledProvider = Provider<bool>((ref) {
  final startDate = ref.watch(startDateProvider);
  final endDate = ref.watch(endDateProvider);
  final includeOldTestament = ref.watch(includeOldTestamentProvider);
  final includeApocrypha = ref.watch(includeApocryphaProvider);
  final includeNewTestament = ref.watch(includeNewTestamentProvider);
  // Button is enabled if:
  // 1. startDate and endDate are not null, AND
  // 2. At least one toggle is true
  return startDate != null &&
      endDate != null &&
      (includeOldTestament || includeApocrypha || includeNewTestament);
});
