import 'package:account_app/constant/colors.dart';
import 'package:account_app/constant/text_styles.dart';
import 'package:account_app/controller/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String textHint;
  Function(String)? action;
  String? placeHolder;
  final VoidCallback? onTap;

  CustomTextFieldWidget({
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
      height: 50,
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
        style: myTextStyles.subTitle.copyWith(
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
                myTextStyles.body.copyWith(fontWeight: FontWeight.normal),
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

  CustomNumberFieldWidget({
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
      height: 50,
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
        textDirection: TextDirection.rtl,
        style: myTextStyles.subTitle
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
                myTextStyles.body.copyWith(fontWeight: FontWeight.normal),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}

class DetailTextFieldWidget extends StatefulWidget {
  final String textHint;
  Function(String)? action;
  String? placeHolder;
  final VoidCallback? onTap;
  TextEditingController controller;

  DetailTextFieldWidget(
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
      height: 50,
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
        style: myTextStyles.subTitle.copyWith(
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
                myTextStyles.body.copyWith(fontWeight: FontWeight.normal),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10)),
      ),
    );
  }
}
