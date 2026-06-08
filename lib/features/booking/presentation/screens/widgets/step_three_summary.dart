import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cure/core/app_colors.dart';
import 'package:cure/core/booking_strings.dart';
import 'package:cure/features/booking/presentation/view_model/booking_cubit.dart';
import 'package:cure/features/booking/presentation/view_model/booking_states.dart';
import 'booking_detail_card.dart';
import 'booking_notes_card.dart';
import 'booking_cost_card.dart';
import 'booking_confirm_button.dart';

class StepThreeSummary extends StatelessWidget {
  final String serviceId;
  final String serviceName;
  final String servicePrice;
  final String selectedDay;
  final String selectedTime;
  final TextEditingController notesController;

  const StepThreeSummary({
    super.key,
    required this.serviceId,
    required this.serviceName,
    required this.servicePrice,
    required this.selectedDay,
    required this.selectedTime,
    required this.notesController,
  });

  double get _serviceAmount {
    final match = RegExp(r'\d+').firstMatch(servicePrice);
    return match != null ? double.tryParse(match.group(0)!) ?? 0 : 0;
  }

  double get _total => _serviceAmount + BookingStrings.serviceFee;

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingStateSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 20.r),
                  SizedBox(width: 8.w),
                  Text(
                    BookingStrings.bookingSuccess,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ],
              ),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.all(16.w),
            ),
          );
        } else if (state is BookingStateSubmitFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.white, size: 20.r),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      state.error,
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              margin: EdgeInsets.all(16.w),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              BookingStrings.summaryTitle,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 20.h),
            BookingDetailCard(
              serviceName: serviceName,
              selectedDay: selectedDay,
              selectedTime: selectedTime,
              serviceLabel: BookingStrings.summaryServiceLabel,
              dayLabel: BookingStrings.summarySelectedDay,
              timeLabel: BookingStrings.summarySelectedTime,
            ),
            SizedBox(height: 16.h),
            BookingNotesCard(
              title: BookingStrings.summaryNotes,
              notes: notesController.text,
              placeholder: BookingStrings.summaryNoNotes,
            ),
            SizedBox(height: 16.h),
            BookingCostCard(
              serviceAmount: _serviceAmount,
              serviceFee: BookingStrings.serviceFee,
              total: _total,
              serviceCostLabel: BookingStrings.summaryServiceCost,
              feeCostLabel: BookingStrings.summaryFeeCost,
              totalLabel: BookingStrings.summaryTotal,
              currencyLabel: BookingStrings.summaryCurrencyLabel,
            ),
            SizedBox(height: 24.h),
            BookingConfirmButton(
              serviceName: serviceName,
              selectedDay: selectedDay,
              selectedTime: selectedTime,
              notesController: notesController,
            ),
          ],
        ),
      ),
    );
  }
}
