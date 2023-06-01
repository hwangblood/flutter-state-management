// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'has_liked_post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hasLikedPostHash() => r'2cf51f95d12f1d5bd8c3ceca050a7e4175726ae3';

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

typedef HasLikedPostRef = AutoDisposeStreamProviderRef<bool>;

/// check if logged user has liked the post or not
///
/// Copied from [hasLikedPost].
@ProviderFor(hasLikedPost)
const hasLikedPostProvider = HasLikedPostFamily();

/// check if logged user has liked the post or not
///
/// Copied from [hasLikedPost].
class HasLikedPostFamily extends Family<AsyncValue<bool>> {
  /// check if logged user has liked the post or not
  ///
  /// Copied from [hasLikedPost].
  const HasLikedPostFamily();

  /// check if logged user has liked the post or not
  ///
  /// Copied from [hasLikedPost].
  HasLikedPostProvider call({
    required String postId,
  }) {
    return HasLikedPostProvider(
      postId: postId,
    );
  }

  @override
  HasLikedPostProvider getProviderOverride(
    covariant HasLikedPostProvider provider,
  ) {
    return call(
      postId: provider.postId,
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
  String? get name => r'hasLikedPostProvider';
}

/// check if logged user has liked the post or not
///
/// Copied from [hasLikedPost].
class HasLikedPostProvider extends AutoDisposeStreamProvider<bool> {
  /// check if logged user has liked the post or not
  ///
  /// Copied from [hasLikedPost].
  HasLikedPostProvider({
    required this.postId,
  }) : super.internal(
          (ref) => hasLikedPost(
            ref,
            postId: postId,
          ),
          from: hasLikedPostProvider,
          name: r'hasLikedPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$hasLikedPostHash,
          dependencies: HasLikedPostFamily._dependencies,
          allTransitiveDependencies:
              HasLikedPostFamily._allTransitiveDependencies,
        );

  final String postId;

  @override
  bool operator ==(Object other) {
    return other is HasLikedPostProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
