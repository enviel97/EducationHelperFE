import 'package:education_helper/constants/colors.dart';
import 'package:education_helper/constants/typing.dart';
import 'package:education_helper/helpers/extensions/state.x.dart';
import 'package:education_helper/helpers/extensions/string_x.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KDateField extends StatefulWidget {
  final String hintText;
  final bool isClearButton;
  final String? initDate;
  final String formatDate;
  final Function(String date) onChange;
  final DateTime? minDate;
  final DateTime? maxDate;
  const KDateField({
    required this.hintText,
    required this.onChange,
    Key? key,
    this.isClearButton = true,
    this.initDate,
    this.formatDate = 'dd/MM/yyyy',
    this.minDate,
    this.maxDate,
  }) : super(key: key);

  @override
  _KDateFieldState createState() => _KDateFieldState();
}

class _KDateFieldState extends State<KDateField> {
  late String value;
  DateTime? selectedDateTime;
  @override
  void initState() {
    super.initState();
    value = widget.initDate?.toDateString() ?? '';
    selectedDateTime =
        value.isEmpty ? DateTime.now() : DateTime.tryParse(value);
  }

  Color get iconColor => isLightTheme ? kPrimaryLightColor : kSecondaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectedDatePicker,
      child: Container(
        constraints: const BoxConstraints(minWidth: 200.0, minHeight: 54.0),
        decoration: BoxDecoration(
            color: isLightTheme ? kWhiteColor : kBlackColor,
            border: Border.all(
                color: isLightTheme ? kPrimaryDarkColor : kPrimaryLightColor),
            boxShadow: [
              const BoxShadow(
                color: kPrimaryLightColor,
                blurRadius: 0,
                offset: Offset(5, 5),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                Icons.date_range_outlined,
                color: iconColor,
              ),
            ),
            Expanded(
              child: Text(
                value.isEmpty ? widget.hintText : value,
                style: TextStyle(
                  fontSize: SPACING.M.size,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: _buildClearButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    if (!widget.isClearButton || value.isEmpty) {
      return const SizedBox.shrink();
    }
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: IconButton(
          icon: const Icon(Icons.cancel_rounded),
          color: kSecondaryColor,
          splashColor: kBlackColor,
          highlightColor: kBlackColor,
          onPressed: () {
            if (mounted) {
              setState(() {
                value = '';
                selectedDateTime = null;
              });
            }
          }),
    );
  }

  Future<void> _selectedDatePicker() async {
    final picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTime ?? DateTime.now(),
        firstDate: widget.minDate ?? DateTime(1700),
        lastDate: widget.maxDate ?? DateTime(2500),
        initialEntryMode: DatePickerEntryMode.calendar,
        helpText: widget.hintText,
        cancelText: 'Cancel',
        confirmText: 'Set',
        fieldHintText: widget.formatDate,
        builder: (_, __) {
          final ColorScheme colorScheme = isLightTheme
              ? const ColorScheme.light()
              : const ColorScheme.dark();
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: colorScheme,
              dialogBackgroundColor: colorScheme.background,
            ),
            child: SizedBox.shrink(child: __),
          );
        });

    if (picked != null && picked != selectedDateTime) {
      setState(() {
        selectedDateTime = picked;
        value = DateFormat(widget.formatDate).format(picked);
      });
      widget.onChange(picked.toString());
    }
  }
}
