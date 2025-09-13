/// Item displayed in the details feature.
library;

/// Represents an item displayed in the details feature.
class DetailItem {
  /// Creates a [DetailItem] with a [name] and [timestampMillis].
  const DetailItem({required this.name, required this.timestampMillis});

  /// The name of the detail item.
  final String name;

  /// The timestamp in milliseconds since epoch.
  final int timestampMillis;

  /// Returns the formatted time in HH:mm from [timestampMillis].
  String get displayTime {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
    final hh = date.hour.toString().padLeft(2, '0');
    final mm = date.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }
}
