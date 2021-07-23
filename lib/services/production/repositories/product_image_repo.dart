
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';


class ProductImageRepository {
  Reference storageRef = FirebaseStorage.instance.ref().child('Products');
  List<String> imagelist = [];

  /*Este método recibe una imagen en formato Unit8list para posteriormente cargarla
   al almacenamiento de firebase de las imagenes que se cargan al Products en la página web.
   @Params : Unit8list image64, archivo de tipo imatgen, String code.
   @Return : String*/
  Future<String> addNewImage(Uint8List image64,String code)async{
    await storageRef.child('$code').putData(image64);
    return await FirebaseStorage.instance.ref('Products/' + '$code').getDownloadURL();
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