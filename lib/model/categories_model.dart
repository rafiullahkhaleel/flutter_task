class CategoriesModel {
  String? slug;
  String? name;
  String? url;

  CategoriesModel({this.slug, this.name, this.url});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
