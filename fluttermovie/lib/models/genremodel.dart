class GenreModel {
  final String name;
  final int id;

  GenreModel({required this.name, required this.id});

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      id: json['id'],
      name: json['name'],
    );
  }
}
//Sau khi được gọi, API trả về tên thể loại là “name” và id của nó là “id” và điều này về cơ bản đặt nó làm các biến bên trong Lớp GenreModel.

// /Các model ở đây sẽ cho phép bạn đặt dữ liệu bạn nhận được từ Json thành các biến thực tế bên trong lớp.