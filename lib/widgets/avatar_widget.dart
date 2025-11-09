import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../utils/avatar_generator.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final double radius;
  final bool isDoctor;
  final String? fallbackText;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? child;

  const AvatarWidget({
    Key? key,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.gender,
    this.radius = 20.0,
    this.isDoctor = false,
    this.fallbackText,
    this.backgroundColor,
    this.textColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? avatarUrl = imageUrl;
    
    // Если нет изображения или это стандартный аватар, генерируем новый
    if (avatarUrl == null || 
        avatarUrl.isEmpty || 
        AvatarGenerator.isDefaultAvatar(avatarUrl)) {
      
      final seed = AvatarGenerator.generateSeedFromName(firstName, lastName);
      final userGender = gender ?? AvatarGenerator.getGenderFromUserData({
        'first_name': firstName,
        'gender': gender,
      });
      
      if (isDoctor) {
        avatarUrl = AvatarGenerator.generateDoctorAvatar(
          seed: seed,
          gender: userGender,
        );
      } else {
        avatarUrl = AvatarGenerator.generatePatientAvatar(
          seed: seed,
          gender: userGender,
        );
      }
    }

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey[300],
      child: child ?? _buildAvatarContent(avatarUrl),
    );
  }

  Widget _buildAvatarContent(String avatarUrl) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: avatarUrl,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildPlaceholder(),
        errorWidget: (context, url, error) => _buildErrorWidget(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: radius * 2,
      height: radius * 2,
      color: Colors.grey[300],
      child: Icon(
        Icons.person,
        size: radius,
        color: Colors.grey[600],
      ),
    );
  }

  Widget _buildErrorWidget() {
    // Если ошибка загрузки, показываем инициалы
    String initials = _getInitials();
    
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.blue[400],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: radius * 0.6,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  String _getInitials() {
    if (fallbackText != null && fallbackText!.isNotEmpty) {
      return fallbackText!.substring(0, 1).toUpperCase();
    }
    
    String firstInitial = '';
    String lastInitial = '';
    
    if (firstName != null && firstName!.isNotEmpty) {
      firstInitial = firstName!.substring(0, 1).toUpperCase();
    }
    
    if (lastName != null && lastName!.isNotEmpty) {
      lastInitial = lastName!.substring(0, 1).toUpperCase();
    }
    
    if (firstInitial.isEmpty && lastInitial.isEmpty) {
      return '?';
    }
    
    return firstInitial + lastInitial;
  }
}

/// Специализированный виджет для аватара врача
class DoctorAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final double radius;
  final Widget? child;

  const DoctorAvatarWidget({
    Key? key,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.gender,
    this.radius = 20.0,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarWidget(
      imageUrl: imageUrl,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      radius: radius,
      isDoctor: true,
      backgroundColor: Colors.blue[50],
      textColor: Colors.blue[800],
      child: child,
    );
  }
}

/// Специализированный виджет для аватара пациента
class PatientAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final double radius;
  final Widget? child;

  const PatientAvatarWidget({
    Key? key,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.gender,
    this.radius = 20.0,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AvatarWidget(
      imageUrl: imageUrl,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      radius: radius,
      isDoctor: false,
      backgroundColor: Colors.green[50],
      textColor: Colors.green[800],
      child: child,
    );
  }
}






