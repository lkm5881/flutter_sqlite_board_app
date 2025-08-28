import 'package:uuid/uuid.dart';

class Board {
  static final Uuid _uuid = Uuid();

  final int? no;
  final String id;
  late String? title;
  late String? writer;
  late String? content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  // 생성자
  Board(
    {
      this.no, 
      String? id,
      required this.title,
      required this.writer,
      required this.content,
      this.createdAt, 
      this.updatedAt,
    }
  ) : id = id ?? _uuid.v4();

  // 객체 -> Map
  Map<String, dynamic> toMap() {
    return {
      'no' : no,
      'id' : id,
      'title' : title,
      'writer' : writer,
      'content' : content,
      'created_at' : createdAt?.toIso8601String(),
      'updated_at' : updatedAt?.toIso8601String()
    };
  }

  // Map -> 객체
  // factory
  // : 조건에 맞게 새로운 객체를 생성하는 생성자
  //   * 반환값을 객체로 지정하는 키워드
  factory Board.fromMap(Map<String, dynamic> map){
    return Board(
      no: map['no'],
      id: map['id'],
      title: map['title'],
      writer: map['writer'],
      content: map['content'],
      createdAt: map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
    );
  }

}