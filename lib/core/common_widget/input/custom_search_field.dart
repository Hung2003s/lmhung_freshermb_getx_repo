import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSortPressed; // Sự kiện khi bấm nút Sort bên phải
  final bool showSortButton; // Có muốn hiển thị nút Sort hay không

  const CustomSearchField({
    super.key,
    this.controller,
    this.hintText = 'Tìm kiếm...',
    this.onChanged,
    this.onSortPressed,
    this.showSortButton = true, // Mặc định luôn hiện nút Sort như trong ảnh
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 1. Ô nhập liệu Tìm kiếm (Chiếm phần lớn hàng ngang)
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Colors.grey[600], // Màu chữ gợi ý xám tối trùng ảnh mẫu
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              // Kính lúp tìm kiếm ở đầu
              prefixIcon: Icon(
                Icons.search_rounded,
                color: Colors.grey[600],
                size: 22,
              ),
              filled: true,
              fillColor: const Color(0xFF14171A),
              // Nền xám đen thô
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
              // Trạng thái viền bình thường
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), // Bo góc 16 mềm mại
                borderSide: const BorderSide(
                  color: Color(0xFF24292E), // Viền siêu mờ
                  width: 1,
                ),
              ),
              // Trạng thái viền khi nhấn chọn gõ chữ
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.grey, width: 1),
              ),
            ),
          ),
        ),

        // Nếu bật thuộc tính hiển thị nút Sort thì mới vẽ khối code này
        if (showSortButton) ...[
          const SizedBox(width: 12), // Khoảng cách giữa ô tìm kiếm và nút sort
          // 2. Nút Sắp xếp (Sort Button) vuông bo góc bằng chiều cao TextField
          GestureDetector(
            onTap: onSortPressed,
            child: Container(
              width: 50,
              height: 50,
              // Chiều cao 50 khớp hoàn toàn với độ dày của TextField trên
              decoration: BoxDecoration(
                color: const Color(0xFF14171A), // Cùng màu nền với thanh Search
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF24292E), width: 1),
              ),
              child: Icon(
                Icons.swap_vert_rounded,
                // Icon mũi tên lên xuống đảo chiều giống ảnh
                color: Colors.grey[400],
                size: 24,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
