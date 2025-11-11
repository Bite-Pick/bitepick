// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewRepositoryHash() => r'7eda43b044f8ce4f9523571dbfdec0f4d931c2be';

/// See also [reviewRepository].
@ProviderFor(reviewRepository)
final reviewRepositoryProvider = AutoDisposeProvider<ReviewRepository>.internal(
  reviewRepository,
  name: r'reviewRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ReviewRepositoryRef = AutoDisposeProviderRef<ReviewRepository>;
String _$reviewsHash() => r'3cdcd514709bef1f12adc8a178cc29e89af45141';

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

/// See also [reviews].
@ProviderFor(reviews)
const reviewsProvider = ReviewsFamily();

/// See also [reviews].
class ReviewsFamily extends Family<AsyncValue<List<Review>>> {
  /// See also [reviews].
  const ReviewsFamily();

  /// See also [reviews].
  ReviewsProvider call({
    required String goodsId,
    bool imageCheck = true,
    int page = 1,
    int size = 10,
  }) {
    return ReviewsProvider(
      goodsId: goodsId,
      imageCheck: imageCheck,
      page: page,
      size: size,
    );
  }

  @override
  ReviewsProvider getProviderOverride(covariant ReviewsProvider provider) {
    return call(
      goodsId: provider.goodsId,
      imageCheck: provider.imageCheck,
      page: provider.page,
      size: provider.size,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'reviewsProvider';
}

/// See also [reviews].
class ReviewsProvider extends AutoDisposeFutureProvider<List<Review>> {
  /// See also [reviews].
  ReviewsProvider({
    required String goodsId,
    bool imageCheck = true,
    int page = 1,
    int size = 10,
  }) : this._internal(
         (ref) => reviews(
           ref as ReviewsRef,
           goodsId: goodsId,
           imageCheck: imageCheck,
           page: page,
           size: size,
         ),
         from: reviewsProvider,
         name: r'reviewsProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$reviewsHash,
         dependencies: ReviewsFamily._dependencies,
         allTransitiveDependencies: ReviewsFamily._allTransitiveDependencies,
         goodsId: goodsId,
         imageCheck: imageCheck,
         page: page,
         size: size,
       );

  ReviewsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.goodsId,
    required this.imageCheck,
    required this.page,
    required this.size,
  }) : super.internal();

  final String goodsId;
  final bool imageCheck;
  final int page;
  final int size;

  @override
  Override overrideWith(
    FutureOr<List<Review>> Function(ReviewsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ReviewsProvider._internal(
        (ref) => create(ref as ReviewsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        goodsId: goodsId,
        imageCheck: imageCheck,
        page: page,
        size: size,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Review>> createElement() {
    return _ReviewsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReviewsProvider &&
        other.goodsId == goodsId &&
        other.imageCheck == imageCheck &&
        other.page == page &&
        other.size == size;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, goodsId.hashCode);
    hash = _SystemHash.combine(hash, imageCheck.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, size.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReviewsRef on AutoDisposeFutureProviderRef<List<Review>> {
  /// The parameter `goodsId` of this provider.
  String get goodsId;

  /// The parameter `imageCheck` of this provider.
  bool get imageCheck;

  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `size` of this provider.
  int get size;
}

class _ReviewsProviderElement
    extends AutoDisposeFutureProviderElement<List<Review>>
    with ReviewsRef {
  _ReviewsProviderElement(super.provider);

  @override
  String get goodsId => (origin as ReviewsProvider).goodsId;
  @override
  bool get imageCheck => (origin as ReviewsProvider).imageCheck;
  @override
  int get page => (origin as ReviewsProvider).page;
  @override
  int get size => (origin as ReviewsProvider).size;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
