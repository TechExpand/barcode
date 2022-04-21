import 'package:barcode/provider/provider.dart';


class ProductModel {
  final  id;
  final proDes;
  final picture;
  final proPrice;
  final proName;
  final productDiscount;
  final   createdAt;

  const ProductModel({
    this.id,
    this.proPrice,
    this.proDes,
    this.proName,
    this.productDiscount,
    this.picture,
    this.createdAt,
  });

  ProductModel.fromMap(snapshot, String id)
      : id = id,
        productDiscount = snapshot['productDiscount'],
        proName = snapshot['proName'] ,
        proDes = snapshot['proDes'] ,
        proPrice = snapshot['proPrice'] ,
        picture = snapshot['picture'] ,
        createdAt = Utils.toDateTime(snapshot['createdAt']);

  Map<String, dynamic> toJson() => {
    'proName': proName,
    'productDiscount':productDiscount,
    'proDes': proDes,
    'proPrice': proPrice,
    'picture': picture,
    'createdAt': Utils.fromDateTimeToJson(createdAt),
  };
}
