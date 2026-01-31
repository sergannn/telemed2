import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctorq/app_export.dart';
import 'package:doctorq/stores/doctors_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

class AutolayouthorItemWidgetZapisi extends StatefulWidget {
  final int index;
  final Map<String, dynamic> item;

  const AutolayouthorItemWidgetZapisi({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  @override
  State<AutolayouthorItemWidgetZapisi> createState() =>
      _AutolayouthorItemWidgetZapisiState();
}

class _AutolayouthorItemWidgetZapisiState
    extends State<AutolayouthorItemWidgetZapisi> {
  static final GetIt _getIt = GetIt.instance;

  final Duration _slideInterval = const Duration(seconds: 5);

  late final DoctorsStore _doctorsStore;
  ReactionDisposer? _doctorsReaction;
  Timer? _timer;

  List<Map<dynamic, dynamic>> _doctors = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _doctorsStore = _getIt.get<DoctorsStore>();
    _syncDoctors();
    _doctorsReaction = reaction<List<Map<dynamic, dynamic>>>(
      (_) => _doctorsStore.doctorsDataList.toList(),
      (list) {
        if (!mounted) return;
        setState(() {
          _doctors = _prepareDoctors(list);
          if (_doctors.isNotEmpty) {
            _currentIndex = _currentIndex % _doctors.length;
          } else {
            _currentIndex = 0;
          }
        });
      },
    );
    _timer = Timer.periodic(_slideInterval, (_) => _advanceSlide());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _doctorsReaction?.call();
    super.dispose();
  }

  void _syncDoctors() {
    final initial = _doctorsStore.doctorsDataList.toList();
    _doctors = _prepareDoctors(initial);
  }

  List<Map<dynamic, dynamic>> _prepareDoctors(
      List<Map<dynamic, dynamic>> source) {
    return source.where((doc) {
      final name =
          (doc['first_name'] ?? doc['username'] ?? doc['last_name'] ?? '')
              .toString();
      final photo = doc['photo'] as String?;
      return name.isNotEmpty || (photo != null && photo.isNotEmpty);
    }).toList();
  }

  void _advanceSlide() {
    if (!mounted || _doctors.isEmpty) return;
    setState(() {
      _currentIndex = (_currentIndex + 1) % _doctors.length;
    });
  }

  Map<dynamic, dynamic>? get _currentDoctor {
    if (_doctors.isEmpty) return null;
    return _doctors[_currentIndex % _doctors.length];
  }

  List<Map<dynamic, dynamic>> get _currentAvatarGroup {
    if (_doctors.isEmpty) {
      return <Map<dynamic, dynamic>>[];
    }
    final total = _doctors.length;
    final count = total >= 3 ? 3 : total;
    return List.generate(count, (offset) {
      final index = (_currentIndex + offset) % total;
      return _doctors[index];
    });
  }

  int _seedForDoctor(Map<dynamic, dynamic> doctor, int salt) {
    final id = doctor['doctor_id'] ??
        doctor['user_id'] ??
        doctor['username'] ??
        doctor.hashCode.toString();
    return id.hashCode ^ salt;
  }

  double _ratingFor(Map<dynamic, dynamic> doctor) {
    final rand = Random(_seedForDoctor(doctor, 17));
    return 3.8 + rand.nextDouble() * 1.2;
  }

  int _experienceFor(Map<dynamic, dynamic> doctor) {
    final rand = Random(_seedForDoctor(doctor, 23));
    return 3 + rand.nextInt(18);
  }

  int _patientsFor(Map<dynamic, dynamic> doctor) {
    final rand = Random(_seedForDoctor(doctor, 31));
    return 120 + rand.nextInt(480);
  }

  int _reviewsFor(Map<dynamic, dynamic> doctor) {
    final rand = Random(_seedForDoctor(doctor, 47));
    return 10 + rand.nextInt(90);
  }

  String _doctorName(Map<dynamic, dynamic> doctor) {
    final firstName = (doctor['first_name'] ?? '').toString();
    final lastName = (doctor['last_name'] ?? '').toString();
    final username = (doctor['username'] ?? '').toString();
    final parts = [firstName, lastName]
        .where((part) => part.isNotEmpty)
        .toList(growable: false);
    if (parts.isNotEmpty) {
      return parts.join(' ');
    }
    return username.isNotEmpty ? username : 'Специалист';
  }

  String _doctorSpecialization(Map<dynamic, dynamic> doctor) {
    final specs = doctor['specializations'];
    if (specs is List && specs.isNotEmpty) {
      final first = specs.first;
      if (first is Map && first['name'] != null) {
        return first['name'].toString();
      }
      if (first is String) {
        return first;
      }
    }
    final fallback = (widget.item['name'] ?? widget.item['title'])?.toString();
    if (fallback != null && fallback.isNotEmpty) {
      return fallback;
    }
    return 'Медицинский консультант';
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getHorizontalSize(16.0)),
        color: widget.index % 2 == 0
            ? ColorConstant.fromHex("C8E0FF")
            : ColorConstant.fromHex("FFFCBB"),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Онлайн приемы появятся скоро',
          style: TextStyle(
            fontFamily: 'Source Sans Pro',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctor = _currentDoctor;
    if (doctor == null) {
      return _buildPlaceholder(context);
    }

    final avatars = _currentAvatarGroup;
    final rating = _ratingFor(doctor).toStringAsFixed(1);
    final experience = '${_experienceFor(doctor)} ';
    final patients = '${_patientsFor(doctor)}';
    final reviews = '${_reviewsFor(doctor)}';
    final name = _doctorName(doctor);
    final specialization = _doctorSpecialization(doctor);

    return Container(
      width: MediaQuery.of(context).size.width / 1.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(getHorizontalSize(16.0)),
        color: widget.index % 2 == 0
            ? ColorConstant.fromHex("C8E0FF")
            : ColorConstant.fromHex("FFFCBB"),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderRow(avatars),
            const SizedBox(height: 12),
            Text(
              'Онлайн прием',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              name,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              specialization,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[700],
                fontFamily: 'Source Sans Pro',
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            _buildStatsRow(
              rating: rating,
              experience: experience,
              patients: patients,
              reviews: reviews,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(List<Map<dynamic, dynamic>> avatars) {
    final stackWidth =
        avatars.isEmpty ? 40.0 : 40.0 + (avatars.length - 1) * 18.0;
    
    // Порядок рендеринга: сначала крайние, потом центральный (чтобы он был поверх)
    List<int> renderOrder;
    if (avatars.length >= 3) {
      renderOrder = [0, 2, 1]; // левый, правый, центральный (сверху)
    } else if (avatars.length == 2) {
      renderOrder = [0, 1];
    } else {
      renderOrder = avatars.isNotEmpty ? [0] : [];
    }
    
    return Row(
      children: [
        SizedBox(
          height: 40,
          width: stackWidth,
          child: Stack(
            clipBehavior: Clip.none,
            children: renderOrder.map((index) {
              final doctor = avatars[index];
              final isCenter = index == 1 && avatars.length >= 3;
              final photo = doctor['photo'] as String?;
              return Positioned(
                left: index * 18.0,
                child: Opacity(
                  opacity: isCenter ? 1.0 : 0.5,
                  child: ClipOval(
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey[200],
                      child: photo != null && photo.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: photo,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                              memCacheWidth: 80,
                              memCacheHeight: 80,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                                child: const Icon(Icons.person, size: 20, color: Colors.grey),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/11.png',
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/images/11.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const Spacer(),
        const Icon(Icons.star, color: Color(0xFFFFBA55)),
        const SizedBox(width: 4),
        const Text(
          'TOP',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Source Sans Pro',
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow({
    required String rating,
    required String experience,
    required String patients,
    required String reviews,
  }) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               _buildStatItem(
                  icon: Icons.star_rate_rounded,
                  value: rating,
                  label: 'Рейтинг',
                  iconColor: const Color(0xFFFFBA55), // Желтая звездочка
              ),

              _buildStatItem(
                  icon: Icons.school_outlined,
                  value: experience,
                  label: 'Стаж',
              ),
            
              _buildStatItem(
                  icon: Icons.people_alt_outlined,
                  value: patients,
                  label: 'Пациенты',
              ),

              _buildStatItem(
                  icon: Icons.rate_review_outlined,
                  value: reviews,
                  label: 'Отзывы',
              ),
                    
        ])]),
      
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 16,
                color: iconColor ?? ColorConstant.blueA400,
              ),
              const SizedBox(width: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF101623),
                  fontFamily: 'Source Sans Pro',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: ColorConstant.bluegray400,
              fontFamily: 'Source Sans Pro',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
