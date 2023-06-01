// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_posts_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userPostsHash() => r'ff07d2420959ae5f22514783932718dd6cd0a349';

/// See also [userPosts].
@ProviderFor(userPosts)
final userPostsProvider = AutoDisposeStreamProvider<Iterable<Post>>.internal(
  userPosts,
  name: r'userPostsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userPostsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserPostsRef = AutoDisposeStreamProviderRef<Iterable<Post>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
