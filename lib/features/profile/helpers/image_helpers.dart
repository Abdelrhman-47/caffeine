
import 'dart:developer';
import 'package:cloudinary_public/cloudinary_public.dart';

/// Helper class for image operations
class ImageHelpers {
  // Cloudinary configuration
  static const String _cloudName = 'dgpabwmog';
  static const String _uploadPreset = 'caffien';

  /// 
  static Future<String> uploadToCloudinary(String imagePath) async {
    try {
      log('Starting image upload to Cloudinary...');
      log('Image path: $imagePath');

      final cloudinary = CloudinaryPublic(
        _cloudName,
        _uploadPreset,
        cache: false,
      );

      final response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePath,
          resourceType: CloudinaryResourceType.Image,
        ),
      );

      if (response.secureUrl.isEmpty) {
        log('Warning: Cloudinary returned empty URL');
        return '';
      }

      log('Image uploaded successfully');
      log('Secure URL: ${response.secureUrl}');
      
      return response.secureUrl;
      
    } on CloudinaryException catch (e) {
      log('Cloudinary error: ${e.message}');
      return '';
    } catch (e) {
      log('Unexpected error uploading to Cloudinary: $e');
      return '';
    }
  }

  /// Validates if a string is a valid image URL
  static bool isValidImageUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute && 
             (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}