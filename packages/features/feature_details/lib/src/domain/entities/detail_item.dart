class DetailItem {
  final String name;
  final int timestampMillis;

  const DetailItem({required this.name, required this.timestampMillis});

  String get displayTime {
    final date = DateTime.fromMillisecondsSinceEpoch(timestampMillis);
    final hh = date.hour.toString().padLeft(2, '0');
    final mm = date.minute.toString().padLeft(2, '0');
    return '$hh:$mm';
  }
}
