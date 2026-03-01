// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Model for pagination details
class PaginationModel {
  final int total;
  final int pages;
  final int page;
  final int size;
  PaginationModel({
    required this.total,
    required this.pages,
    required this.page,
    required this.size,
  });

  PaginationModel copyWith({
    int? total,
    int? pages,
    int? page,
    int? size,
  }) {
    return PaginationModel(
      total: total ?? this.total,
      pages: pages ?? this.pages,
      page: page ?? this.page,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'pages': pages,
      'page': page,
      'size': size,
    };
  }

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      total: map['total'] as int,
      pages: map['pages'] as int,
      page: map['page'] as int,
      size: map['size'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationModel.fromJson(String source) =>
      PaginationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaginationModel(total: $total, pages: $pages, page: $page, size: $size)';
  }

  factory PaginationModel.empty() {
    return PaginationModel(total: 0, pages: 0, page: 0, size: 0);
  }
}
