import 'package:admin/models/product_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductRepository {
  late CollectionReference<Map<String, dynamic>> _productsCategoryRef;
  /*
    category = nombre de la categoria
    
    startDocumentId = el utimo ID de producto que se tenga en la lista, 
    si se envia null devuelve los primeros 10 productos de la categoria
   */
  Future<List<ProductApi>> getProductsByCategory(String category) async {
    _productsCategoryRef =
        FirebaseFirestore.instance.collection(category.toUpperCase());

    final QuerySnapshot<Map<String, dynamic>> _resul;

    _resul = await _productsCategoryRef.limit(10).get();

    return _resul.docs.map((e) => ProductApi.fromJson(e.data())).toList();
  }

  Future<ProductApi> getOneProductsByCategory(
      String category, String documentId) async {
    _productsCategoryRef =
        FirebaseFirestore.instance.collection(category.toUpperCase());

    final DocumentSnapshot<Map<String, dynamic>> _startDocument =
        await _productsCategoryRef.doc(documentId).get();

    return ProductApi.fromJson(_startDocument.data()!);
  }

  Future<bool> updateStateProductsByCategory(
      String category, String documentId, int active) async {
    _productsCategoryRef =
        FirebaseFirestore.instance.collection(category.toUpperCase());
    try {
      await _productsCategoryRef.doc(documentId).update({'active': active});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> addProduct(
    String category,
    ProductApi productApi,
  ) {
    _productsCategoryRef =
        FirebaseFirestore.instance.collection(category.toUpperCase());
    return _productsCategoryRef
        .doc(productApi.code)
        .set(productApi.toJson())
        .then((value) => print("Product Added"))
        .catchError((error) => print("Failed to add product: $error"));
  }

  /*
  no funciona del todo, la busque es complicada, no usar de momento o intenrar mejorla
   */
  Future<List<ProductApi>> searchProductsByCategory(
      String category, String searchparamenter) async {
    _productsCategoryRef =
        FirebaseFirestore.instance.collection(category.toUpperCase());

    final _resul = await _productsCategoryRef
        .where('name', whereIn: [searchparamenter]).get();

    return _resul.docs.map((e) => ProductApi.fromJson(e.data())).toList();
  }
}
