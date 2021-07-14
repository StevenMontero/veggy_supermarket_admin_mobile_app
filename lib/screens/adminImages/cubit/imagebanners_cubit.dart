import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin/services/production/repositories/banners_repository.dart';

part 'imagebanners_state.dart';

class ImagebannersCubit extends Cubit<ImagebannersState> {
  ImagebannersCubit(this._bannerRepository) : super(ImagebannersState());
  final BannerRepository _bannerRepository;
  final picker = ImagePicker();
  File? _photo;
  
  void filePhotoChange(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
    emit(state.copyWith(photo: _photo));
  }

  void addNewImage() {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      _bannerRepository.addNewImage(_photo!);
      getAllBannersImages();
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void deleteImage(String imageURL, int index) {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      _bannerRepository.deleteImage(imageURL);
      var list = state.imageList;
      list!.removeAt(index);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, imageList: list));
    } catch (error) {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }

  void getAllBannersImages() async {
    emit(state.copyWith(existImage: Status.loading));
    var imageList = await _bannerRepository.allBannersImages();
    if (imageList.isNotEmpty) {
      emit(state.copyWith(imageList: imageList, existImage: Status.exist));
    } else {
      emit(state.copyWith(existImage: Status.noExist));
    }
  }
}
