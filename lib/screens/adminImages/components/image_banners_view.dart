import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:admin/screens/adminImages/components/image_card.dart';
import 'package:admin/screens/adminImages/cubit/imagebanners_cubit.dart';

class ImageBannersView extends StatefulWidget {
  @override
  _ImageBannersViewState createState() => _ImageBannersViewState();
}

class _ImageBannersViewState extends State<ImageBannersView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagebannersCubit, ImagebannersState>(
      builder: (context, state) {
        if (state.existImage == Status.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.existImage == Status.noExist) {
          return Center(
            child: Text(
              'Error al cargar las imágenes. Intente más tarde.',
              textAlign: TextAlign.center,
            ),
          );
        }
        if (state.existImage == Status.exist) {
          if (state.imageList!.isEmpty) {
            return Center(
              child: Text(
                'No se encontraron imágenes para mostrar',
                textAlign: TextAlign.center,
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(5.0),
            itemCount: state.imageList!.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageCard(
                imageURL: state.imageList!.elementAt(index),
                onPressed: () {
                  context
                      .read<ImagebannersCubit>()
                      .deleteImage(state.imageList![index], index);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(content: Text('Eliminación Exitosa')),
                    );
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
