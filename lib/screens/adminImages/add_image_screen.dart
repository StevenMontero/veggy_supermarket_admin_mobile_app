import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/screens/adminImages/cubit/imagebanners_cubit.dart';
import 'package:admin/services/production/repositories/banners_repository.dart';

class AddImageScreen extends StatefulWidget {
  @override
  _AddImageScreenState createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImagebannersCubit(BannerRepository()),
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _titlePage(context) as PreferredSizeWidget,
      //backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          _viewPhoto(),
          SizedBox(
            width: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Row(
              children: [
                Expanded(child: _addButton()),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: _saveButton()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _viewPhoto() {
    return BlocBuilder<ImagebannersCubit, ImagebannersState>(
      buildWhen: (previous, current) => previous.photo != current.photo,
      builder: (context, state) {
        if (state.photo != null) {
          return Image(
            image: FileImage(state.photo!),
            height: 400.0,
            fit: BoxFit.cover,
          );
        } else {
          return Image(
            image: AssetImage('assets/images/imagen_no_disponible.png'),
            height: 300.0,
            width: 300,
            fit: BoxFit.fill,
          );
        }
      },
    );
  }

  Widget _saveButton() {
    return BlocBuilder<ImagebannersCubit, ImagebannersState>(
        builder: (context, state) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            padding: EdgeInsets.all(15.0),
            primary: Colors.white,
            textStyle: TextStyle(
              color: Colors.black,
            )),
        onPressed: () {
          if (state.photo == null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Debe agregar una imagen')),
              );
          } else {
            context.read<ImagebannersCubit>().addNewImage();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Imagen agregada éxitosamente')),
              );
            Navigator.pushNamed(context, 'images');
          }
        },
        icon: Icon(
          Icons.save,
          color: Colors.black,
        ),
        label: Text('Guardar', style: TextStyle(color: Colors.black)),
      );
    });
  }

  Widget _addButton() {
    return BlocBuilder<ImagebannersCubit, ImagebannersState>(
        builder: (context, state) {
      return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            padding: EdgeInsets.all(15.0),
            primary: Colors.white,
            textStyle: TextStyle(
              color: Colors.white,
            )),
        onPressed: () => _selectImage(context),
        icon: Icon(
          Icons.add_a_photo,
          color: Colors.black,
        ),
        label: Text('Agregar', style: TextStyle(color: Colors.black)),
      );
    });
  }

  Future<void> _selectImage(BuildContext _contxt) {
    return showDialog(
        context: _contxt,
        builder: (context) {
          return AlertDialog(
            title: Text("Seleccione el medio"),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                    child: Text("Galería"),
                    onTap: () {
                      _contxt.read<ImagebannersCubit>()
                        ..filePhotoChange(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                    child: Text("Cámara"),
                    onTap: () {
                      _contxt.read<ImagebannersCubit>()
                        ..filePhotoChange(ImageSource.camera);
                      Navigator.of(context).pop();
                    }),
              ],
            )),
          );
        });
  }

  Widget _titlePage(BuildContext context) {
    return AppBar(
      leading: SafeArea(
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      centerTitle: true,
      title: Text('Agregar Imagenes'),
    );
  }
}
