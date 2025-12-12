import 'package:flutter/material.dart';
import 'package:kpostal/kpostal.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';
import 'package:magambell/src/core/theme/mg_text_style.dart';
import 'package:magambell/src/widgets/mg_button.dart';
import 'package:magambell/src/widgets/mg_reactive_textfield.dart';
import 'package:magambell/src/widgets/mixins/form_section_builder_mixin.dart';

class StoreInfoSection extends StatefulWidget {
  final List<String> localImages;
  final Function(List<String>) onAddImages;
  final Function(int) onRemoveImage;
  final Function(String address)? onGeocodeAddress;
  final Function({
    required String postalCode,
    required String address,
    double? latitude,
    double? longitude,
  })? onUpdateAddress;
  final bool enabled;

  const StoreInfoSection({
    super.key,
    required this.localImages,
    required this.onAddImages,
    required this.onRemoveImage,
    this.onGeocodeAddress,
    this.onUpdateAddress,
    this.enabled = true,
  });

  @override
  State<StoreInfoSection> createState() => _StoreInfoSectionState();
}

class _StoreInfoSectionState extends State<StoreInfoSection>
    with FormSectionBuilderMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. 매장 이름
        buildSectionTitle('매장 이름', subtitle: '체인점일 경우, 지점명까지 해주세요'),
        Gaps.h8,
        MgReactiveTextField(
          formControlName: 'storeName',
          hintText: '매장 이름 ',
          enabled: widget.enabled,
        ),

        // 2. 매장 주소
        buildSectionTitle('매장 주소'),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: MgReactiveTextField(
                formControlName: 'postalCode',
                hintText: '우편번호',
                enabled: false,
              ),
            ),
            Gaps.w8,
            MgButton(
              onPressed: widget.enabled ? _findPostalCode : null,
              content: const Text('주소 찾기').bold(),
              borderRadius: MgRadius.md,
              borderColor: MgColorScheme.gray1,
              backgroundColor: MgColorScheme.white,
              textColor: MgColorScheme.text,
            ),
          ],
        ),
        MgReactiveTextField(
          formControlName: 'address',
          hintText: '주소',
          enabled: false,
        ),
        MgReactiveTextField(
          formControlName: 'addressDetail',
          hintText: '상세주소 ',
          enabled: widget.enabled,
        ),

        buildSectionTitle("주차안내"),
        MgReactiveTextField(
          formControlName: 'parkingDescription',
          enabled: widget.enabled,
        ),

        buildSectionTitle("대표 이미지"),
        // ImageUploadSection(
        //   images: widget.localImages
        //   onAddImages: widget.onAddImages,
        //   onRemoveImage: widget.onRemoveImage,
        // ),
      ],
    );
  }

  void _findPostalCode() async {
    if (!widget.enabled) return;

    await Navigator.push<Kpostal>(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          callback: (Kpostal result) async {
            double? latitude;
            double? longitude;

            if (widget.onGeocodeAddress != null) {
              // Geocoding 로직은 부모에서 처리
              // 여기서는 콜백만 호출
              widget.onGeocodeAddress!(result.address);
            }

            if (widget.onUpdateAddress != null) {
              widget.onUpdateAddress!(
                postalCode: result.postCode,
                address: result.address,
                latitude: latitude,
                longitude: longitude,
              );
            }
          },
        ),
      ),
    );
  }
}
