import 'package:cure/core/app_colors.dart';
import 'package:cure/features/booking/domain/entities/available_time_slot_entity.dart';
import 'package:cure/features/booking/presentation/view_model/booking_cubit.dart';
import 'package:cure/features/booking/presentation/view_model/booking_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'booking_steps_header.dart';
import 'continue_button.dart';
import 'step_one_time_selector.dart';
import 'step_three_summary.dart';
import 'step_two_notes_input.dart';

class BookingPageViews extends StatefulWidget {
  final String serviceId;
  final String serviceName;
  final String servicePrice;

  const BookingPageViews({
    super.key,
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
  });

  @override
  State<BookingPageViews> createState() => _BookingPageViewsState();
}

class _BookingPageViewsState extends State<BookingPageViews> {
  final PageController _pageController = PageController();
  final TextEditingController _notesController = TextEditingController();
  int _currentStep = 0;

  // Step 1 selected values
  AvailableTimeSlotEntity? _selectedDay;
  String? _selectedTime;

  @override
  void dispose() {
    _pageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  bool get _isStepOneValid => _selectedDay != null && _selectedTime != null;

  bool get _isContinueEnabled {
    if (_currentStep == 0) return _isStepOneValid;
    // Step 2 (notes) is always continuable – notes are optional
    return true;
  }

  // Step 3 is the last step – no continue button there
  bool get _showContinue => _currentStep < 2;

  void _onContinue() {
    if (_currentStep == 0 && _isStepOneValid) {
      _goToNextPage();
    } else if (_currentStep == 1) {
      _goToNextPage();
    }
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookingStepsHeader(
          currentStep: _currentStep,
          totalSteps: 3,
        ),
        SizedBox(height: 24.h),
        Expanded(
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (page) {
              setState(() {
                _currentStep = page;
              });
            },
            children: [
              BlocBuilder<BookingCubit, BookingState>(
                builder: (context, state) {
                  if (state is BookingStateLoading || state is BookingStateInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is BookingStateFailure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 48.r, color: AppColors.error),
                          SizedBox(height: 16.h),
                          Text(
                            state.error,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: () {
                              context.read<BookingCubit>().fetchAvailableTimes(widget.serviceId);
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is BookingStateSuccess) {
                    return SingleChildScrollView(
                      child: StepOneTimeSelector(
                        availableTimes: state.availableTimes,
                        selectedDay: _selectedDay,
                        selectedTime: _selectedTime,
                        onDaySelected: (day) {
                          setState(() {
                            _selectedDay = day;
                            _selectedTime = null;
                          });
                        },
                        onTimeSelected: (time) {
                          setState(() {
                            _selectedTime = time;
                          });
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              SingleChildScrollView(
                child: StepTwoNotesInput(controller: _notesController),
              ),

              StepThreeSummary(
                serviceId: widget.serviceId,
                serviceName: widget.serviceName,
                servicePrice: widget.servicePrice,
                selectedDay: _selectedDay?.dayName ?? '',
                selectedTime: _selectedTime ?? '',
                notesController: _notesController,
              ),
            ],
          ),
        ),
        if (_showContinue)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: ContinueButton(
              isEnabled: _isContinueEnabled,
              onPressed: _onContinue,
            ),
          ),
      ],
    );
  }
}
