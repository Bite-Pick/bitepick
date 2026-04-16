// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_edit_screen.controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goodsEditScreenControllerHash() =>
    r'80a1897a227fd78039b6cf791fdbc78c0363d61e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$GoodsEditScreenController
    extends BuildlessAutoDisposeNotifier<GoodsEditState> {
  late final (Goods, List<GoodsImagesList>?) param;

  GoodsEditState build((Goods, List<GoodsImagesList>?) param);
}

/// See also [GoodsEditScreenController].
@ProviderFor(GoodsEditScreenController)
const goodsEditScreenControllerProvider = GoodsEditScreenControllerFamily();

/// See also [GoodsEditScreenController].
class GoodsEditScreenControllerFamily extends Family<GoodsEditState> {
  /// See also [GoodsEditScreenController].
  const GoodsEditScreenControllerFamily();

  /// See also [GoodsEditScreenController].
  GoodsEditScreenControllerProvider call(
    (Goods, List<GoodsImagesList>?) param,
  ) {
    return GoodsEditScreenControllerProvider(param);
  }

  @override
  GoodsEditScreenControllerProvider getProviderOverride(
    covariant GoodsEditScreenControllerProvider provider,
  ) {
    return call(provider.param);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'goodsEditScreenControllerProvider';
}

/// See also [GoodsEditScreenController].
class GoodsEditScreenControllerProvider
    extends
        AutoDisposeNotifierProviderImpl<
          GoodsEditScreenController,
          GoodsEditState
        > {
  /// See also [GoodsEditScreenController].
  GoodsEditScreenControllerProvider((Goods, List<GoodsImagesList>?) param)
    : this._internal(
        () => GoodsEditScreenController()..param = param,
        from: goodsEditScreenControllerProvider,
        name: r'goodsEditScreenControllerProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$goodsEditScreenControllerHash,
        dependencies: GoodsEditScreenControllerFamily._dependencies,
        allTransitiveDependencies:
            GoodsEditScreenControllerFamily._allTransitiveDependencies,
        param: param,
      );

  GoodsEditScreenControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final (Goods, List<GoodsImagesList>?) param;

  @override
  GoodsEditState runNotifierBuild(
    covariant GoodsEditScreenController notifier,
  ) {
    return notifier.build(param);
  }

  @override
  Override overrideWith(GoodsEditScreenController Function() create) {
    return ProviderOverride(
      origin: this,
      override: GoodsEditScreenControllerProvider._internal(
        () => create()..param = param,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<GoodsEditScreenController, GoodsEditState>
  createElement() {
    return _GoodsEditScreenControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GoodsEditScreenControllerProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GoodsEditScreenControllerRef
    on AutoDisposeNotifierProviderRef<GoodsEditState> {
  /// The parameter `param` of this provider.
  (Goods, List<GoodsImagesList>?) get param;
}

class _GoodsEditScreenControllerProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          GoodsEditScreenController,
          GoodsEditState
        >
    with GoodsEditScreenControllerRef {
  _GoodsEditScreenControllerProviderElement(super.provider);

  @override
  (Goods, List<GoodsImagesList>?) get param =>
      (origin as GoodsEditScreenControllerProvider).param;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
