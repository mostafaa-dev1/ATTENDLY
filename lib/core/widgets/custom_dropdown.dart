import 'package:academe_mobile_new/core/helpers/spacing.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class AppCustomDropDown extends StatelessWidget {
  const AppCustomDropDown(
      {super.key,
      required this.list,
      this.onChanged,
      required this.width,
      required this.height,
      required this.text,
      this.validator,
      required this.hintText});
  final List<String> list;
  final String? Function(String?)? onChanged;
  final double width;
  final double height;
  final String? Function(String?)? validator;
  final String text;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: Theme.of(context).textTheme.headlineMedium),
        verticalSpace(5),
        SizedBox(
          width: double.infinity,
          height: height,
          child: CustomDropdown(
              validator: (value) {
                return validator!(value);
              },
              hintText: hintText,
              enabled: true,
              closedHeaderPadding: const EdgeInsets.all(15),
              decoration: CustomDropdownDecoration(
                listItemDecoration: ListItemDecoration(
                  highlightColor: Theme.of(context).colorScheme.primary,
                ),
                expandedSuffixIcon: const Icon(Icons.arrow_drop_up),
                headerStyle: Theme.of(context).textTheme.headlineMedium,
                listItemStyle: Theme.of(context).textTheme.headlineMedium,
                expandedFillColor: Theme.of(context).colorScheme.primary,
                expandedBorder: Border.all(
                  color: Theme.of(context).colorScheme.surface,
                ),
                closedErrorBorder: Border.all(color: Colors.red),
                closedErrorBorderRadius: BorderRadius.circular(10),
                errorStyle: TextStyle(height: 1, color: Colors.red.shade100),
                closedBorderRadius: BorderRadius.circular(10),
                closedSuffixIcon: const Icon(Icons.arrow_drop_down),
                closedFillColor: Theme.of(context).scaffoldBackgroundColor,
                closedBorder: Border.all(
                  color: Theme.of(context).cardColor,
                ),
                hintStyle: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: Colors.grey[400]),
              ),
              items: list,
              onChanged: (v) {
                return onChanged!(v);
              }),
        ),
      ],
    );
  }
}
