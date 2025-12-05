import 'package:caffeine/features/profile/cubit/user_data_state.dart';
import 'package:caffeine/features/profile/data/user_data.dart';
import 'package:caffeine/features/profile/data/user_repo.dart';
import 'package:caffeine/features/profile/helpers/image_helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit({required UserDataRepository userRepository})
      : _userRepository = userRepository,
        super(const UserDataInitial());

  final UserDataRepository _userRepository;
  final ImagePicker _imagePicker = ImagePicker();
  
  UserData? _cachedUserData;
  Future<void> fetchUserData() async {
    emit(const UserDataLoading());
    
    final result = await _userRepository.getUserData();
    
    result.fold(
      (error) => emit(UserDataFailure(message: error)),
      (data) {
        _cachedUserData = data;
        emit(UserDataSuccess(userData: data));
      },
    );
  }

//================================================================

Future<String?> pickImageFromGallery() async {
  try {
    emit(const ImagePicking());
    
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1080,
      maxHeight: 1080,
    );

    if (image == null) {
      emit(const ImageSelectionCancelled());
      return null;
    }

    // Emit a state with the local path so UI can preview the picked image
    emit(ImagePicked(localPath: image.path));

    return image.path;
  } catch (e) {
    emit(UserDataFailure(message: 'Failed to pick image: $e'));
    return null;
  }
}

Future<String?> uploadImageToCloudinary() async {
  try {
    final String? imagePath = await pickImageFromGallery();

    if (imagePath == null || imagePath.isEmpty) {
      emit(const UserDataFailure(message: 'No image selected'));
      return null;
    }

    final url = await ImageHelpers.uploadToCloudinary(imagePath);
    emit(ImageUploaded(image: url));
    
    return url; 
  } catch (e) {
    emit(UserDataFailure(message: 'Failed to upload image: $e'));
    return null;
  }
}


  Future<void> updateProfile({
    required String name,
    required String imageUrl,
  }) async {
    emit(const UserDataLoading());

    final result = await _userRepository.updateProfile(
      name: name,
      imageUrl: imageUrl,
    );

    result.fold(
      (error) => emit(UserDataFailure(message: error)),
      (_) {
        _cachedUserData = UserData(
          name: name,
          email: _cachedUserData?.email ?? '',
          imageUrl: imageUrl,
        );
        
        emit(ProfileUpdateSuccess(
          name: name,
          imageUrl: imageUrl,
        ));
      },
    );
  }
}