class Category{
  int id;
  String name;
  String imageUrl;

  Category({this.id,this.name,this.imageUrl});

  factory Category.fromMap(Map<String, dynamic> jsonData){
    return Category(
      id: jsonData['id'],
      name: jsonData['name'],
      imageUrl: jsonData['imageUrl'],
    );
  }
}