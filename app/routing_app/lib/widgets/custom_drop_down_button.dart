import 'package:flutter/material.dart';
import 'package:routing_app/core/singleton/responsive_singleton.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({
    super.key,
    required this.lsItemsStatus,
    required this.hintText,
    required this.onChanged,
    required this.prefixIcon,
    this.selectedValue = 1,
  });

  final List<DropdownMenuItem<int>> lsItemsStatus;
  final String hintText;
  final ValueChanged<int?>? onChanged;
  final IconData? prefixIcon;
  final int selectedValue;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveSingleton.propotionalHeight(70),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.deepPurple.withOpacity(0.1),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  prefixIcon,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    value: selectedValue,
                    isExpanded: true,
                    decoration: InputDecoration.collapsed(hintText: ''),
                    borderRadius: BorderRadius.circular(10),
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.black,
                      fontSize: ResponsiveSingleton.proportionalFont(17),
                    ),
                    hint: Text(
                      hintText,
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.black,
                        fontSize: ResponsiveSingleton.proportionalFont(17),
                      ),
                    ),
                    items: lsItemsStatus,
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
