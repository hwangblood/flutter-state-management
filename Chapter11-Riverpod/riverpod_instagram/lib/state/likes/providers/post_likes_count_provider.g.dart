// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_likes_count_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postLikesCountHash() => r'c86de54d621bad2c68304db236c2ca0d9712d838';

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

typedef PostLikesCountRef = AutoDisposeStreamProviderRef<int>;

/// See also [postLikesCount].
@ProviderFor(postLikesCount)
const postLikesCountProvider = PostLikesCountFamily();

/// See also [postLikesCount].
class PostLikesCountFamily extends Family<AsyncValue<int>> {
  /// See also [postLikesCount].
  const PostLikesCountFamily();

  /// See also [postLikesCount].
  PostLikesCountProvider call({
    required String postId,
  }) {
    return PostLikesCountProvider(
      postId: postId,
    );
  }

  @override
  PostLikesCountProvider getProviderOverride(
    covariant PostLikesCountProvider provider,
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
  String? get name => r'postLikesCountProvider';
}

/// See also [postLikesCount].
class PostLikesCountProvider extends AutoDisposeStreamProvider<int> {
  /// See also [postLikesCount].
  PostLikesCountProvider({
    required this.postId,
  }) : super.internal(
          (ref) => postLikesCount(
            ref,
            postId: postId,
          ),
          from: postLikesCountProvider,
          name: r'postLikesCountProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postLikesCountHash,
          dependencies: PostLikesCountFamily._dependencies,
          allTransitiveDependencies:
              PostLikesCountFamily._allTransitiveDependencies,
        );

  final String postId;

  @override
  bool operator ==(Object other) {
    return other is PostLikesCountProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
