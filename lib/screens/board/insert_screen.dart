import 'package:flutter/material.dart';
import 'package:sqlite_board_app/models/board.dart';
import 'package:sqlite_board_app/service/board_service.dart';

class InsertScreen extends StatefulWidget {
  const InsertScreen({super.key});

  @override
  State<InsertScreen> createState() => _InsertScreenState();
}

class _InsertScreenState extends State<InsertScreen> {
  // state
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _writerController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final boardService = BoardService();

  // 게시글 등록 처리
  Future<void> insert() async {
    // 유효성 검사
    if(!_formKey.currentState!.validate()) {
      print('게시글 입력 정보가 유효하지 않습니다.');
      return;
    }
    // 게시글 객체 생성
    Board board = Board(
      title: _titleController.text, 
      writer: _writerController.text, 
      content: _contentController.text
    );

  print("board - id : ${board.id}");

    // 데이터 등록
    int result = await boardService.insert(board);
    if(result > 0) {
      print("게시글 등록 성공!");
      // 게시글 목록으로 이동
      Navigator.pushReplacementNamed(context, "/board/list");
    } 
    else {
      print("게시글 등록 실패!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, "/board/list");
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("게시글 등록"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0,),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // 제목
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '제목',
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "제목을 입력하세요.";
                  }
                  return null;
                },
              ),

              // 작성자
              TextFormField(
                controller: _writerController,
                decoration: const InputDecoration(
                  labelText: '작성자',
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "작성자을 입력하세요.";
                  }
                  return null;
                },
              ),

              SizedBox(height: 20.0,),
              // 내용
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: '내용',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "내용을 입력하세요.";
                  }
                  return null;
                },
                maxLines: 5,      // 여러줄 입력 설정 (5줄)
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // 게시글 데이터 등록 처리
              insert();
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,  // 테두리 곡률 제거
              ),
            ), 
            child: const Text("등록하기"),
          ),
        ),
      ),
    );
  }
}