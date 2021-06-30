import 'package:admin/models/carouselModel.dart';
import 'package:firebase_storage/firebase_storage.dart';


class BannerRepository {
  Reference storageRef = FirebaseStorage.instance.ref().child('Banners');
  List<CarouselModel> carouselList = [];

  Future<List<CarouselModel>> allBannersImages() async {
    // try {
    ListResult resultRefs =
        await storageRef.listAll(); // Obtiene todos los archivos del storage
    final urls = await _getDownloadUrls(resultRefs.items);
    return carouselList = urls
        .asMap()
        .map((index, url) {
          return MapEntry(
              index, new CarouselModel(index: index, image: url, isSelected: false));
        })
        .values
        .toList();
    // } on FirebaseException catch (exception) {
    // manejo de excepciones
    // }
  }

  Future<List<String>> _getDownloadUrls(List<Reference> resultRefs) async {
    return Future.wait(resultRefs.map((ref) => ref.getDownloadURL()).toList());
  }
}
