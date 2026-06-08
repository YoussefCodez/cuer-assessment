// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_states.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState()';
}


}

/// @nodoc
class $BookingStateCopyWith<$Res>  {
$BookingStateCopyWith(BookingState _, $Res Function(BookingState) __);
}


/// Adds pattern-matching-related methods to [BookingState].
extension BookingStatePatterns on BookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BookingStateInitial value)?  initial,TResult Function( BookingStateLoading value)?  loading,TResult Function( BookingStateSuccess value)?  success,TResult Function( BookingStateFailure value)?  failure,TResult Function( BookingStateSubmitting value)?  submitting,TResult Function( BookingStateSubmitted value)?  submitted,TResult Function( BookingStateSubmitFailure value)?  submitFailure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BookingStateInitial() when initial != null:
return initial(_that);case BookingStateLoading() when loading != null:
return loading(_that);case BookingStateSuccess() when success != null:
return success(_that);case BookingStateFailure() when failure != null:
return failure(_that);case BookingStateSubmitting() when submitting != null:
return submitting(_that);case BookingStateSubmitted() when submitted != null:
return submitted(_that);case BookingStateSubmitFailure() when submitFailure != null:
return submitFailure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BookingStateInitial value)  initial,required TResult Function( BookingStateLoading value)  loading,required TResult Function( BookingStateSuccess value)  success,required TResult Function( BookingStateFailure value)  failure,required TResult Function( BookingStateSubmitting value)  submitting,required TResult Function( BookingStateSubmitted value)  submitted,required TResult Function( BookingStateSubmitFailure value)  submitFailure,}){
final _that = this;
switch (_that) {
case BookingStateInitial():
return initial(_that);case BookingStateLoading():
return loading(_that);case BookingStateSuccess():
return success(_that);case BookingStateFailure():
return failure(_that);case BookingStateSubmitting():
return submitting(_that);case BookingStateSubmitted():
return submitted(_that);case BookingStateSubmitFailure():
return submitFailure(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BookingStateInitial value)?  initial,TResult? Function( BookingStateLoading value)?  loading,TResult? Function( BookingStateSuccess value)?  success,TResult? Function( BookingStateFailure value)?  failure,TResult? Function( BookingStateSubmitting value)?  submitting,TResult? Function( BookingStateSubmitted value)?  submitted,TResult? Function( BookingStateSubmitFailure value)?  submitFailure,}){
final _that = this;
switch (_that) {
case BookingStateInitial() when initial != null:
return initial(_that);case BookingStateLoading() when loading != null:
return loading(_that);case BookingStateSuccess() when success != null:
return success(_that);case BookingStateFailure() when failure != null:
return failure(_that);case BookingStateSubmitting() when submitting != null:
return submitting(_that);case BookingStateSubmitted() when submitted != null:
return submitted(_that);case BookingStateSubmitFailure() when submitFailure != null:
return submitFailure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<AvailableTimeSlotEntity> availableTimes)?  success,TResult Function( String error)?  failure,TResult Function()?  submitting,TResult Function( BookingEntity booking)?  submitted,TResult Function( String error)?  submitFailure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BookingStateInitial() when initial != null:
return initial();case BookingStateLoading() when loading != null:
return loading();case BookingStateSuccess() when success != null:
return success(_that.availableTimes);case BookingStateFailure() when failure != null:
return failure(_that.error);case BookingStateSubmitting() when submitting != null:
return submitting();case BookingStateSubmitted() when submitted != null:
return submitted(_that.booking);case BookingStateSubmitFailure() when submitFailure != null:
return submitFailure(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<AvailableTimeSlotEntity> availableTimes)  success,required TResult Function( String error)  failure,required TResult Function()  submitting,required TResult Function( BookingEntity booking)  submitted,required TResult Function( String error)  submitFailure,}) {final _that = this;
switch (_that) {
case BookingStateInitial():
return initial();case BookingStateLoading():
return loading();case BookingStateSuccess():
return success(_that.availableTimes);case BookingStateFailure():
return failure(_that.error);case BookingStateSubmitting():
return submitting();case BookingStateSubmitted():
return submitted(_that.booking);case BookingStateSubmitFailure():
return submitFailure(_that.error);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<AvailableTimeSlotEntity> availableTimes)?  success,TResult? Function( String error)?  failure,TResult? Function()?  submitting,TResult? Function( BookingEntity booking)?  submitted,TResult? Function( String error)?  submitFailure,}) {final _that = this;
switch (_that) {
case BookingStateInitial() when initial != null:
return initial();case BookingStateLoading() when loading != null:
return loading();case BookingStateSuccess() when success != null:
return success(_that.availableTimes);case BookingStateFailure() when failure != null:
return failure(_that.error);case BookingStateSubmitting() when submitting != null:
return submitting();case BookingStateSubmitted() when submitted != null:
return submitted(_that.booking);case BookingStateSubmitFailure() when submitFailure != null:
return submitFailure(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class BookingStateInitial implements BookingState {
  const BookingStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState.initial()';
}


}




/// @nodoc


class BookingStateLoading implements BookingState {
  const BookingStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState.loading()';
}


}




/// @nodoc


class BookingStateSuccess implements BookingState {
  const BookingStateSuccess(final  List<AvailableTimeSlotEntity> availableTimes): _availableTimes = availableTimes;
  

 final  List<AvailableTimeSlotEntity> _availableTimes;
 List<AvailableTimeSlotEntity> get availableTimes {
  if (_availableTimes is EqualUnmodifiableListView) return _availableTimes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableTimes);
}


/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStateSuccessCopyWith<BookingStateSuccess> get copyWith => _$BookingStateSuccessCopyWithImpl<BookingStateSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStateSuccess&&const DeepCollectionEquality().equals(other._availableTimes, _availableTimes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_availableTimes));

@override
String toString() {
  return 'BookingState.success(availableTimes: $availableTimes)';
}


}

/// @nodoc
abstract mixin class $BookingStateSuccessCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingStateSuccessCopyWith(BookingStateSuccess value, $Res Function(BookingStateSuccess) _then) = _$BookingStateSuccessCopyWithImpl;
@useResult
$Res call({
 List<AvailableTimeSlotEntity> availableTimes
});




}
/// @nodoc
class _$BookingStateSuccessCopyWithImpl<$Res>
    implements $BookingStateSuccessCopyWith<$Res> {
  _$BookingStateSuccessCopyWithImpl(this._self, this._then);

  final BookingStateSuccess _self;
  final $Res Function(BookingStateSuccess) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? availableTimes = null,}) {
  return _then(BookingStateSuccess(
null == availableTimes ? _self._availableTimes : availableTimes // ignore: cast_nullable_to_non_nullable
as List<AvailableTimeSlotEntity>,
  ));
}


}

/// @nodoc


class BookingStateFailure implements BookingState {
  const BookingStateFailure(this.error);
  

 final  String error;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStateFailureCopyWith<BookingStateFailure> get copyWith => _$BookingStateFailureCopyWithImpl<BookingStateFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStateFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'BookingState.failure(error: $error)';
}


}

/// @nodoc
abstract mixin class $BookingStateFailureCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingStateFailureCopyWith(BookingStateFailure value, $Res Function(BookingStateFailure) _then) = _$BookingStateFailureCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$BookingStateFailureCopyWithImpl<$Res>
    implements $BookingStateFailureCopyWith<$Res> {
  _$BookingStateFailureCopyWithImpl(this._self, this._then);

  final BookingStateFailure _self;
  final $Res Function(BookingStateFailure) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(BookingStateFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BookingStateSubmitting implements BookingState {
  const BookingStateSubmitting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStateSubmitting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState.submitting()';
}


}




/// @nodoc


class BookingStateSubmitted implements BookingState {
  const BookingStateSubmitted(this.booking);
  

 final  BookingEntity booking;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStateSubmittedCopyWith<BookingStateSubmitted> get copyWith => _$BookingStateSubmittedCopyWithImpl<BookingStateSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStateSubmitted&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,booking);

@override
String toString() {
  return 'BookingState.submitted(booking: $booking)';
}


}

/// @nodoc
abstract mixin class $BookingStateSubmittedCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingStateSubmittedCopyWith(BookingStateSubmitted value, $Res Function(BookingStateSubmitted) _then) = _$BookingStateSubmittedCopyWithImpl;
@useResult
$Res call({
 BookingEntity booking
});




}
/// @nodoc
class _$BookingStateSubmittedCopyWithImpl<$Res>
    implements $BookingStateSubmittedCopyWith<$Res> {
  _$BookingStateSubmittedCopyWithImpl(this._self, this._then);

  final BookingStateSubmitted _self;
  final $Res Function(BookingStateSubmitted) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? booking = null,}) {
  return _then(BookingStateSubmitted(
null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as BookingEntity,
  ));
}


}

/// @nodoc


class BookingStateSubmitFailure implements BookingState {
  const BookingStateSubmitFailure(this.error);
  

 final  String error;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStateSubmitFailureCopyWith<BookingStateSubmitFailure> get copyWith => _$BookingStateSubmitFailureCopyWithImpl<BookingStateSubmitFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStateSubmitFailure&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'BookingState.submitFailure(error: $error)';
}


}

/// @nodoc
abstract mixin class $BookingStateSubmitFailureCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingStateSubmitFailureCopyWith(BookingStateSubmitFailure value, $Res Function(BookingStateSubmitFailure) _then) = _$BookingStateSubmitFailureCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$BookingStateSubmitFailureCopyWithImpl<$Res>
    implements $BookingStateSubmitFailureCopyWith<$Res> {
  _$BookingStateSubmitFailureCopyWithImpl(this._self, this._then);

  final BookingStateSubmitFailure _self;
  final $Res Function(BookingStateSubmitFailure) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(BookingStateSubmitFailure(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
