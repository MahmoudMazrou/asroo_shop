
class ProdectModel {
  late  int id;
  late String title;
  late double price;
  late String description;
  late String category;
  late String image;
  late double rate;
  late int count;

  ProdectModel(
      {
        required this.id,
        required  this.title,
        required  this.price,
        required  this.description,
        required  this.category,
        required this.image,
        required this.rate,
        required this.count,
      });


  ProdectModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id;'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rate = json['rate'];
    count = json['count'];
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rate': rate,
      'count': count,
    };
  }

}


