import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;

class BannerRepository {
  Reference storageRef = FirebaseStorage.instance.ref().child('Banners');
  List<String> imagelist = [];

  /*Este método recibe una imagen en formato File para posteriormente cargarla
   al almacenamiento de firebase de las imagenes que se cargan al Carrouselk en la página web.
   @Params : File image, archivo de tipo imatgen.
   @Return : void*/
  Future<String> addNewImage(File file)async{
    String filePath = p.basename(file.path);
    await storageRef.child('$filePath').putFile(file);
    return await FirebaseStorage.instance.ref('Banners/' + '$filePath').getDownloadURL();
  }

  /*Este método trae de el almacenamiento de firebase todas las imagenes
    que se encuentren en la carpeta Banners para mostrarlas en la app administradora
    Return: Future<List<String>>*/
  Future<List<String>> allBannersImages() async {
    ListResult resultRefs =
        await storageRef.listAll(); // Obtiene todos los archivos del storage
    final urls = await _getDownloadUrls(resultRefs.items);
    return imagelist = urls
        .asMap()
        .map((index, url) {
          return MapEntry(index, url);
        })
        .values
        .toList();
  }

  /*Este método recibe una lista de referencias de firebase para obtener el url
   de cada imagen a la que hacer referencia
   @Params : List<Reference> resultRefs, lista de referencias de firebase
   @Return : Future<List<String>>, lista de las urls de cada imagen*/
  Future<List<String>> _getDownloadUrls(List<Reference> resultRefs) async {
    return Future.wait(resultRefs.map((ref) => ref.getDownloadURL()).toList());
  }

   /*Este método recibe la url de la imagen que el administrador deses eliminar
   de el almacenamiento de firebase.
   @Params : String imageURL, url que hace referencia a la imagen almacenada.
   @Return : void*/
  void deleteImage(String imageURL) async {
    storageRef = FirebaseStorage.instance.refFromURL(imageURL);
    await storageRef.delete();
  }
}
