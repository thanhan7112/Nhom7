String getPosterImage(String input) {
  return "https://image.tmdb.org/t/p/original/$input";
}
// hình ảnh áp phích mà chúng ta nhận được từ API không phải là url đầy đủ, vì vậy ta tạo một hàm getPosterImage trong thư mục global.dart
//Hàm này dành riêng cho TMDb api và trả về url hình ảnh đầy đủ