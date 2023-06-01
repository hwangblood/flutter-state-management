// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_by_search_term_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postsBySearchTermHash() => r'28be6d1757329f8f95a5b119ab40bd6cb1f38332';

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

typedef PostsBySearchTermRef = AutoDisposeStreamProviderRef<Iterable<Post>>;

/// See also [postsBySearchTerm].
@ProviderFor(postsBySearchTerm)
const postsBySearchTermProvider = PostsBySearchTermFamily();

/// See also [postsBySearchTerm].
class PostsBySearchTermFamily extends Family<AsyncValue<Iterable<Post>>> {
  /// See also [postsBySearchTerm].
  const PostsBySearchTermFamily();

  /// See also [postsBySearchTerm].
  PostsBySearchTermProvider call({
    required String searchTerm,
  }) {
    return PostsBySearchTermProvider(
      searchTerm: searchTerm,
    );
  }

  @override
  PostsBySearchTermProvider getProviderOverride(
    covariant PostsBySearchTermProvider provider,
  ) {
    return call(
      searchTerm: provider.searchTerm,
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
  String? get name => r'postsBySearchTermProvider';
}

/// See also [postsBySearchTerm].
class PostsBySearchTermProvider
    extends AutoDisposeStreamProvider<Iterable<Post>> {
  /// See also [postsBySearchTerm].
  PostsBySearchTermProvider({
    required this.searchTerm,
  }) : super.internal(
          (ref) => postsBySearchTerm(
            ref,
            searchTerm: searchTerm,
          ),
          from: postsBySearchTermProvider,
          name: r'postsBySearchTermProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postsBySearchTermHash,
          dependencies: PostsBySearchTermFamily._dependencies,
          allTransitiveDependencies:
              PostsBySearchTermFamily._allTransitiveDependencies,
        );

  final String searchTerm;

  @override
  bool operator ==(Object other) {
    return other is PostsBySearchTermProvider && other.searchTerm == searchTerm;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, searchTerm.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
