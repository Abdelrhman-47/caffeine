import 'package:caffeine/features/profile/data/user_data.dart';
import 'package:equatable/equatable.dart';

/// Base class for all UserData states
sealed class UserDataState extends Equatable {
  const UserDataState();

  @override
  List<Object?> get props => [];
}

// ==================== Initial State ====================

/// Initial state when cubit is created
final class UserDataInitial extends UserDataState {
  const UserDataInitial();
}

// ==================== Loading States ====================

/// Loading state for general data operations
final class UserDataLoading extends UserDataState {
  const UserDataLoading();
}

/// State when user is picking an image from gallery
final class ImagePicking extends UserDataState {
  const ImagePicking();
}

/// State when image is being uploaded to Cloudinary
final class ImageUploaded extends UserDataState {
  final String image;
  const ImageUploaded({required this.image});
    @override
  List<Object> get props => [image];
}

/// State when user has picked an image (local path available)
final class ImagePicked extends UserDataState {
  final String localPath;
  const ImagePicked({required this.localPath});

  @override
  List<Object> get props => [localPath];
}

// ==================== Success States ====================

/// State when user data is successfully fetched
final class UserDataSuccess extends UserDataState {
  final UserData userData;

  const UserDataSuccess({required this.userData});

  @override
  List<Object> get props => [userData];
}

/// State when profile is successfully updated
final class ProfileUpdateSuccess extends UserDataState {
  final String name;
  final String imageUrl;

  const ProfileUpdateSuccess({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [name, imageUrl];
}

// ==================== Failure States ====================

/// State when any operation fails
final class UserDataFailure extends UserDataState {
  final String message;

  const UserDataFailure({required this.message});

  @override
  List<Object> get props => [message];
}

/// State when user cancels image selection
final class ImageSelectionCancelled extends UserDataState {
  const ImageSelectionCancelled();
}