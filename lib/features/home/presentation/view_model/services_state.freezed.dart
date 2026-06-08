// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServicesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServicesState()';
}


}

/// @nodoc
class $ServicesStateCopyWith<$Res>  {
$ServicesStateCopyWith(ServicesState _, $Res Function(ServicesState) __);
}


/// Adds pattern-matching-related methods to [ServicesState].
extension ServicesStatePatterns on ServicesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServicesInitial value)?  initial,TResult Function( ServicesLoading value)?  loading,TResult Function( ServicesLoaded value)?  loaded,TResult Function( ServicesFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServicesInitial() when initial != null:
return initial(_that);case ServicesLoading() when loading != null:
return loading(_that);case ServicesLoaded() when loaded != null:
return loaded(_that);case ServicesFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServicesInitial value)  initial,required TResult Function( ServicesLoading value)  loading,required TResult Function( ServicesLoaded value)  loaded,required TResult Function( ServicesFailure value)  failure,}){
final _that = this;
switch (_that) {
case ServicesInitial():
return initial(_that);case ServicesLoading():
return loading(_that);case ServicesLoaded():
return loaded(_that);case ServicesFailure():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServicesInitial value)?  initial,TResult? Function( ServicesLoading value)?  loading,TResult? Function( ServicesLoaded value)?  loaded,TResult? Function( ServicesFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ServicesInitial() when initial != null:
return initial(_that);case ServicesLoading() when loading != null:
return loading(_that);case ServicesLoaded() when loaded != null:
return loaded(_that);case ServicesFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<ServiceEntity> services)?  loaded,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServicesInitial() when initial != null:
return initial();case ServicesLoading() when loading != null:
return loading();case ServicesLoaded() when loaded != null:
return loaded(_that.services);case ServicesFailure() when failure != null:
return failure(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<ServiceEntity> services)  loaded,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ServicesInitial():
return initial();case ServicesLoading():
return loading();case ServicesLoaded():
return loaded(_that.services);case ServicesFailure():
return failure(_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<ServiceEntity> services)?  loaded,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ServicesInitial() when initial != null:
return initial();case ServicesLoading() when loading != null:
return loading();case ServicesLoaded() when loaded != null:
return loaded(_that.services);case ServicesFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ServicesInitial implements ServicesState {
  const ServicesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServicesState.initial()';
}


}




/// @nodoc


class ServicesLoading implements ServicesState {
  const ServicesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServicesState.loading()';
}


}




/// @nodoc


class ServicesLoaded implements ServicesState {
  const ServicesLoaded(final  List<ServiceEntity> services): _services = services;
  

 final  List<ServiceEntity> _services;
 List<ServiceEntity> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}


/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicesLoadedCopyWith<ServicesLoaded> get copyWith => _$ServicesLoadedCopyWithImpl<ServicesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesLoaded&&const DeepCollectionEquality().equals(other._services, _services));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_services));

@override
String toString() {
  return 'ServicesState.loaded(services: $services)';
}


}

/// @nodoc
abstract mixin class $ServicesLoadedCopyWith<$Res> implements $ServicesStateCopyWith<$Res> {
  factory $ServicesLoadedCopyWith(ServicesLoaded value, $Res Function(ServicesLoaded) _then) = _$ServicesLoadedCopyWithImpl;
@useResult
$Res call({
 List<ServiceEntity> services
});




}
/// @nodoc
class _$ServicesLoadedCopyWithImpl<$Res>
    implements $ServicesLoadedCopyWith<$Res> {
  _$ServicesLoadedCopyWithImpl(this._self, this._then);

  final ServicesLoaded _self;
  final $Res Function(ServicesLoaded) _then;

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? services = null,}) {
  return _then(ServicesLoaded(
null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<ServiceEntity>,
  ));
}


}

/// @nodoc


class ServicesFailure implements ServicesState {
  const ServicesFailure(this.message);
  

 final  String message;

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicesFailureCopyWith<ServicesFailure> get copyWith => _$ServicesFailureCopyWithImpl<ServicesFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServicesState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServicesFailureCopyWith<$Res> implements $ServicesStateCopyWith<$Res> {
  factory $ServicesFailureCopyWith(ServicesFailure value, $Res Function(ServicesFailure) _then) = _$ServicesFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ServicesFailureCopyWithImpl<$Res>
    implements $ServicesFailureCopyWith<$Res> {
  _$ServicesFailureCopyWithImpl(this._self, this._then);

  final ServicesFailure _self;
  final $Res Function(ServicesFailure) _then;

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServicesFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
