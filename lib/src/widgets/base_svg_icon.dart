import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:magambell/src/constants/index.dart';
import 'package:magambell/src/core/theme/mg_color.dart';

class BaseSvgIcon extends StatelessWidget {
  BaseSvgIcon({
    String? assetName,
    Color? color,
    double? size,
    this.hasColorFilter = true,
  }) : _assetName = assetName,
       _color = color,
       _size = size,
       super(key: Key(assetName ?? ""));

  // Regular icons
  factory BaseSvgIcon.alignJustify({double? size, Color? color}) =>
      _makeIcon('align-justify.svg', size, color);

  factory BaseSvgIcon.bell({double? size, Color? color}) =>
      _makeIcon('bell.svg', size, color);

  factory BaseSvgIcon.bookmark({double? size, Color? color}) =>
      _makeIcon('bookmark.svg', size, color);

  factory BaseSvgIcon.check({double? size, Color? color}) =>
      _makeIcon('check.svg', size, color);

  factory BaseSvgIcon.close({double? size, Color? color}) =>
      _makeIcon('close.svg', size, color);

  factory BaseSvgIcon.copy({double? size, Color? color}) =>
      _makeIcon('copy.svg', size, color);

  factory BaseSvgIcon.down({double? size, Color? color}) =>
      _makeIcon('down.svg', size, color);

  factory BaseSvgIcon.download({double? size, Color? color}) =>
      _makeIcon('download.svg', size, color);

  factory BaseSvgIcon.eyeOff({double? size, Color? color}) =>
      _makeIcon('eye-off.svg', size, color);

  factory BaseSvgIcon.eye({double? size, Color? color}) =>
      _makeIcon('eye.svg', size, color);

  factory BaseSvgIcon.file({double? size, Color? color}) =>
      _makeIcon('file.svg', size, color);

  factory BaseSvgIcon.folder({double? size, Color? color}) =>
      _makeIcon('folder.svg', size, color);

  factory BaseSvgIcon.heart({double? size, Color? color}) =>
      _makeIcon('heart.svg', size, color);

  factory BaseSvgIcon.helpCircle({double? size, Color? color}) =>
      _makeIcon('help-circle.svg', size, color);

  factory BaseSvgIcon.image({double? size, Color? color}) =>
      _makeIcon('image.svg', size, color);

  factory BaseSvgIcon.info({double? size, Color? color}) =>
      _makeIcon('info.svg', size, color);

  factory BaseSvgIcon.left({double? size, Color? color}) =>
      _makeIcon('left.svg', size, color);

  factory BaseSvgIcon.link({double? size, Color? color}) =>
      _makeIcon('link.svg', size, color);

  factory BaseSvgIcon.mapPin({double? size, Color? color}) =>
      _makeIcon('map-pin.svg', size, color);

  factory BaseSvgIcon.messageCircle({double? size, Color? color}) =>
      _makeIcon('message-circle.svg', size, color);

  factory BaseSvgIcon.messageSquare({double? size, Color? color}) =>
      _makeIcon('message-square.svg', size, color);

  factory BaseSvgIcon.minus({double? size, Color? color}) =>
      _makeIcon('minus.svg', size, color);

  factory BaseSvgIcon.moreHorizontal({double? size, Color? color}) =>
      _makeIcon('more-horizontal.svg', size, color);

  factory BaseSvgIcon.moreVertical({double? size, Color? color}) =>
      _makeIcon('more-vertical.svg', size, color);

  factory BaseSvgIcon.paperclip({double? size, Color? color}) =>
      _makeIcon('paperclip.svg', size, color);

  factory BaseSvgIcon.phone({double? size, Color? color}) =>
      _makeIcon('phone.svg', size, color);

  factory BaseSvgIcon.plus({double? size, Color? color}) =>
      _makeIcon('plus.svg', size, color);

  factory BaseSvgIcon.right({double? size, Color? color}) =>
      _makeIcon('right.svg', size, color);

  factory BaseSvgIcon.rotateCw({double? size, Color? color}) =>
      _makeIcon('rotate-cw.svg', size, color);

  factory BaseSvgIcon.search({double? size, Color? color}) =>
      _makeIcon('search.svg', size, color);

  factory BaseSvgIcon.settings({double? size, Color? color}) =>
      _makeIcon('settings.svg', size, color);

  factory BaseSvgIcon.share({double? size, Color? color}) =>
      _makeIcon('share.svg', size, color);

  factory BaseSvgIcon.star({double? size, Color? color}) =>
      _makeIcon('star.svg', size, color);

  factory BaseSvgIcon.thumbDown({double? size, Color? color}) =>
      _makeIcon('thumb-down.svg', size, color);

  factory BaseSvgIcon.time({double? size, Color? color}) =>
      _makeIcon('time.svg', size, color);

  factory BaseSvgIcon.trash({double? size, Color? color}) =>
      _makeIcon('trash.svg', size, color);

  factory BaseSvgIcon.up({double? size, Color? color}) =>
      _makeIcon('up.svg', size, color);

  factory BaseSvgIcon.upload({double? size, Color? color}) =>
      _makeIcon('upload.svg', size, color);

  // Filled icons
  factory BaseSvgIcon.heartFilled({double? size, Color? color}) =>
      _makeIcon('filled/heart.svg', size, color);

  factory BaseSvgIcon.kakaoFilled({double? size, Color? color}) =>
      _makeIcon('filled/kakao.svg', size, color);

  factory BaseSvgIcon.mapPinFilled({double? size, Color? color}) =>
      _makeIcon('filled/map-pin.svg', size, color);

  factory BaseSvgIcon.share2Filled({double? size, Color? color}) =>
      _makeIcon('filled/share-2.svg', size, color);

  factory BaseSvgIcon.speakerFilled({double? size, Color? color}) =>
      _makeIcon('filled/speaker.svg', size, color);

  factory BaseSvgIcon.starFilled({double? size, Color? color}) =>
      _makeIcon('filled/star.svg', size, color);

  factory BaseSvgIcon.kakao({double? size, Color? color}) =>
      _makeIcon('filled/kakao.svg', size, color);


  BaseSvgIcon copyWith({Color? color, double? size, bool? hasColorFilter}) {
    return BaseSvgIcon(
      assetName: _assetName,
      color: color ?? _color,
      size: size ?? _size,
      hasColorFilter: hasColorFilter ?? true,
    );
  }

  static BaseSvgIcon _makeIcon(String assetName, double? size, Color? color) =>
      BaseSvgIcon(assetName: assetName, color: color, size: size);

  final String? _assetName;
  final double? _size;
  final Color? _color;
  final bool hasColorFilter;

  @override
  Widget build(BuildContext context) {
    final key = Key('BaseSvgIcon-$_assetName');
    final iconThemeData = Theme.of(context).iconTheme;

    final size = _size ?? iconThemeData.size ?? MgSizes.xxl;
    final color = _color ?? iconThemeData.color;

    return SvgPicture.asset(
      'assets/icons/svg/$_assetName',
      key: key,
      width: size,
      height: size,
      colorFilter: hasColorFilter
          ? ColorFilter.mode(color ?? MgColorScheme.text, BlendMode.srcIn)
          : null,
    );
  }
}

final mockImage =
    "https://d1xe26zpyg8fzv.cloudfront.net/STORE/OWNER/758244341543821802/1_b02.jpg";

extension BaseSvgIconExtension on BaseSvgIcon {
  BaseSvgIcon color(Color? color) {
    return copyWith(color: color);
  }

  BaseSvgIcon size(double? size) {
    return copyWith(size: size);
  }

  BaseSvgIcon removeColorFilter() {
    return copyWith(hasColorFilter: false);
  }

  BaseSvgIcon primary() => copyWith(color: MgColorScheme.primary);
  BaseSvgIcon secondary() => copyWith(color: MgColorScheme.secondary);
  BaseSvgIcon gray() => copyWith(color: MgColorScheme.gray5);
  BaseSvgIcon white() => copyWith(color: MgColorScheme.white);
  BaseSvgIcon black() => copyWith(color: MgColorScheme.black);
}
