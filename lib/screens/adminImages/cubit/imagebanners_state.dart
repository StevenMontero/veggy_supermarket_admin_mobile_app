part of 'imagebanners_cubit.dart';

enum Status {
  pure,
  loading,
  exist,
  noExist,
}

class ImagebannersState extends Equatable {
  final List<String>? imageList;
  final File? photo;
  final Status existImage;
  final FormzStatus? status;

  const ImagebannersState(
      {this.imageList, this.photo, this.existImage = Status.pure, this.status,});

  ImagebannersState copyWith({
    List<String>? imageList,
    File? photo,
    Status? existImage,
    FormzStatus? status,
  }) {
    return ImagebannersState(
      imageList: imageList ?? this.imageList,
      photo: photo ?? this.photo,
      existImage: existImage ?? this.existImage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    imageList,
    photo,
    existImage,
    status,
  ];
}

