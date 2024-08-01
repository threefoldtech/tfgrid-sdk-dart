part of '../models.dart';

class PageInfo {
  String startCursor;
  String endCursor;
  bool hasNextPage;
  bool hasPreviousPage;

  PageInfo({
    required this.startCursor,
    required this.endCursor,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PageInfo.fromJson(Map<String, dynamic> json) {
    return PageInfo(
      startCursor: json['startCursor'],
      endCursor: json['endCursor'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
    );
  }

  @override
  String toString() {
    return 'PageInfo{startCursor: $startCursor, endCursor: $endCursor, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage}';
  }
}
