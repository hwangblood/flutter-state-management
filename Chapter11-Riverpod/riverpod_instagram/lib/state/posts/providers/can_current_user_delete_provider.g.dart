// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'can_current_user_delete_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$canCurrentUserDeletePostHash() =>
    r'1fe8e58318aa08d38946571dba29a0669afe549c';

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

typedef CanCurrentUserDeletePostRef = AutoDisposeStreamProviderRef<bool>;

/// See also [canCurrentUserDeletePost].
@ProviderFor(canCurrentUserDeletePost)
const canCurrentUserDeletePostProvider = CanCurrentUserDeletePostFamily();

/// See also [canCurrentUserDeletePost].
class CanCurrentUserDeletePostFamily extends Family<AsyncValue<bool>> {
  /// See also [canCurrentUserDeletePost].
  const CanCurrentUserDeletePostFamily();

  /// See also [canCurrentUserDeletePost].
  CanCurrentUserDeletePostProvider call({
    required Post post,
  }) {
    return CanCurrentUserDeletePostProvider(
      post: post,
    );
  }

  @override
  CanCurrentUserDeletePostProvider getProviderOverride(
    covariant CanCurrentUserDeletePostProvider provider,
  ) {
    return call(
      post: provider.post,
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
  String? get name => r'canCurrentUserDeletePostProvider';
}

/// See also [canCurrentUserDeletePost].
class CanCurrentUserDeletePostProvider extends AutoDisposeStreamProvider<bool> {
  /// See also [canCurrentUserDeletePost].
  CanCurrentUserDeletePostProvider({
    required this.post,
  }) : super.internal(
          (ref) => canCurrentUserDeletePost(
            ref,
            post: post,
          ),
          from: canCurrentUserDeletePostProvider,
          name: r'canCurrentUserDeletePostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$canCurrentUserDeletePostHash,
          dependencies: CanCurrentUserDeletePostFamily._dependencies,
          allTransitiveDependencies:
              CanCurrentUserDeletePostFamily._allTransitiveDependencies,
        );

  final Post post;

  @override
  bool operator ==(Object other) {
    return other is CanCurrentUserDeletePostProvider && other.post == post;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, post.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
