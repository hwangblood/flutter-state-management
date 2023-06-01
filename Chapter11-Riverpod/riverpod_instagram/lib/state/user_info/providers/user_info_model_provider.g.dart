// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userInfoModelHash() => r'727f0abf1c89ae6cbd9c074bcc6b0c8b67dfe9f2';

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

typedef UserInfoModelRef = AutoDisposeStreamProviderRef<UserInfoModel>;

/// See also [userInfoModel].
@ProviderFor(userInfoModel)
const userInfoModelProvider = UserInfoModelFamily();

/// See also [userInfoModel].
class UserInfoModelFamily extends Family<AsyncValue<UserInfoModel>> {
  /// See also [userInfoModel].
  const UserInfoModelFamily();

  /// See also [userInfoModel].
  UserInfoModelProvider call({
    required String userId,
  }) {
    return UserInfoModelProvider(
      userId: userId,
    );
  }

  @override
  UserInfoModelProvider getProviderOverride(
    covariant UserInfoModelProvider provider,
  ) {
    return call(
      userId: provider.userId,
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
  String? get name => r'userInfoModelProvider';
}

/// See also [userInfoModel].
class UserInfoModelProvider extends AutoDisposeStreamProvider<UserInfoModel> {
  /// See also [userInfoModel].
  UserInfoModelProvider({
    required this.userId,
  }) : super.internal(
          (ref) => userInfoModel(
            ref,
            userId: userId,
          ),
          from: userInfoModelProvider,
          name: r'userInfoModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userInfoModelHash,
          dependencies: UserInfoModelFamily._dependencies,
          allTransitiveDependencies:
              UserInfoModelFamily._allTransitiveDependencies,
        );

  final String userId;

  @override
  bool operator ==(Object other) {
    return other is UserInfoModelProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
