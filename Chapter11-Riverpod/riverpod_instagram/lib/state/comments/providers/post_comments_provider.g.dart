// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comments_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postCommentsHash() => r'c7fdbae7620e521198b1a871f6944db78291e204';

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

typedef PostCommentsRef = AutoDisposeStreamProviderRef<Iterable<Comment>>;

/// See also [postComments].
@ProviderFor(postComments)
const postCommentsProvider = PostCommentsFamily();

/// See also [postComments].
class PostCommentsFamily extends Family<AsyncValue<Iterable<Comment>>> {
  /// See also [postComments].
  const PostCommentsFamily();

  /// See also [postComments].
  PostCommentsProvider call({
    required RequestForPostAndComments request,
  }) {
    return PostCommentsProvider(
      request: request,
    );
  }

  @override
  PostCommentsProvider getProviderOverride(
    covariant PostCommentsProvider provider,
  ) {
    return call(
      request: provider.request,
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
  String? get name => r'postCommentsProvider';
}

/// See also [postComments].
class PostCommentsProvider
    extends AutoDisposeStreamProvider<Iterable<Comment>> {
  /// See also [postComments].
  PostCommentsProvider({
    required this.request,
  }) : super.internal(
          (ref) => postComments(
            ref,
            request: request,
          ),
          from: postCommentsProvider,
          name: r'postCommentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postCommentsHash,
          dependencies: PostCommentsFamily._dependencies,
          allTransitiveDependencies:
              PostCommentsFamily._allTransitiveDependencies,
        );

  final RequestForPostAndComments request;

  @override
  bool operator ==(Object other) {
    return other is PostCommentsProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
