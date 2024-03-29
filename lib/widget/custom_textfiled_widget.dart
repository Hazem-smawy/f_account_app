import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/sizes.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String textHint;
  final Function(String)? action;
  final String? placeHolder;
  final VoidCallback? onTap;

  const CustomTextFieldWidget({
    required this.textHint,
    this.action,
    this.placeHolder = "",
    super.key,
    this.onTap,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: textFieldSize,
      alignment: Alignment.center,

      //padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.containerSecondColor,
      ),
      child: TextFormField(
        initialValue: widget.placeHolder ?? "",
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: MyTextStyles.subTitle.copyWith(
          color: MyColors.blackColor,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          if (widget.action != null) {
            widget.action!(value);
            CEC.errorMessage.value = "";
          }
        },
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.textHint,
            hintStyle:
                MyTextStyles.body.copyWith(fontWeight: FontWeight.normal),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}

class CustomNumberFieldWidget extends StatefulWidget {
  final String textHint;
  final Function(String)? action;
  final String? placeHolder;
  final VoidCallback? onTap;

  const CustomNumberFieldWidget({
    required this.textHint,
    this.action,
    this.placeHolder = "",
    this.onTap,
    super.key,
  });

  @override
  State<CustomNumberFieldWidget> createState() =>
      _CustomNumberFieldWidgetState();
}

class _CustomNumberFieldWidgetState extends State<CustomNumberFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: textFieldSize,
      alignment: Alignment.center,
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.containerSecondColor,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        initialValue: widget.placeHolder ?? "",
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
        style: MyTextStyles.subTitle
            .copyWith(color: MyColors.blackColor, fontWeight: FontWeight.bold),
        onChanged: (value) {
          if (widget.action != null) {
            widget.action!(value);
            CEC.errorMessage.value = "";
          }
        },
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.textHint,
            hintStyle:
                MyTextStyles.body.copyWith(fontWeight: FontWeight.normal),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}

class DetailTextFieldWidget extends StatefulWidget {
  final String textHint;
  final Function(String)? action;
  final String? placeHolder;
  final VoidCallback? onTap;
  final TextEditingController controller;

  const DetailTextFieldWidget(
      {required this.textHint,
      this.action,
      this.placeHolder = "",
      super.key,
      this.onTap,
      required this.controller});

  @override
  State<DetailTextFieldWidget> createState() => _DetailTextFieldWidgetState();
}

class _DetailTextFieldWidgetState extends State<DetailTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: textFieldSize,
      alignment: Alignment.center,
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.containerSecondColor,
      ),
      child: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: MyTextStyles.subTitle.copyWith(
          color: MyColors.blackColor,
          fontWeight: FontWeight.bold,
        ),
        onChanged: (value) {
          if (widget.action != null) {
            widget.action!(value);
            CEC.errorMessage.value = "";
          }
        },
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.textHint,
            hintStyle:
                MyTextStyles.body.copyWith(fontWeight: FontWeight.normal),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}

class CustomCurencyFieldWidget extends StatefulWidget {
  final String textHint;
  final Function(String)? action;

  final VoidCallback? onTap;
  final TextEditingController controller;

  const CustomCurencyFieldWidget({
    required this.textHint,
    required this.controller,
    this.action,
    this.onTap,
    super.key,
  });

  @override
  State<CustomCurencyFieldWidget> createState() =>
      _CustomCurencyFieldWidgetState();
}

class _CustomCurencyFieldWidgetState extends State<CustomCurencyFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: textFieldSize,
      alignment: Alignment.center,
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MyColors.containerSecondColor,
      ),
      child: TextFormField(
        controller: widget.controller,
        inputFormatters: [
          NumericTextFormatter(),
          LengthLimitingTextInputFormatter(20),
        ],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
        style: MyTextStyles.subTitle
            .copyWith(color: MyColors.blackColor, fontWeight: FontWeight.bold),
        onChanged: (value) {
          if (widget.action != null) {
            widget.action!(value);
            CEC.errorMessage.value = "";
          }
        },
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.textHint,
            hintStyle:
                MyTextStyles.body.copyWith(fontWeight: FontWeight.normal),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      var value = newValue.text;
      if (newValue.text.length > 2) {
        value = value.replaceAll(RegExp(r'\D'), '');
        value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
      }
      return TextEditingValue(
        text: value,
        selection: TextSelection.collapsed(
            offset: value.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
