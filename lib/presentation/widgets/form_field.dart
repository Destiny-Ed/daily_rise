import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  bool obscure;
  final String hint;
  final bool password;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  CustomTextField(
  this.controller,
  {
    super.key,
    this.password = true,
    this.obscure = false,
    this.hint = '',
    this.suffixIcon,
    this.onChanged,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  Icon? visibility;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.titleMedium,
        controller: widget.controller,
        obscureText: widget.obscure,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          suffixIcon:
              widget.suffixIcon ??
              (widget.password == true
                  ? GestureDetector(
                      key: widget.key,
                      onTap: () {
                        //Show and hide password
                        if (widget.obscure == true) {
                          setState(() {
                            widget.obscure = false;
                            visibility = Icon(
                              Icons.visibility_off,
                              color: Theme.of(context).primaryColor,
                            );
                          });
                        } else {
                          setState(() {
                            widget.obscure = true;
                            visibility = Icon(
                              Icons.visibility,
                              color: Theme.of(context).primaryColor,
                            );
                          });
                        }
                      },
                      child:
                          visibility ??
                          Icon(
                            Icons.visibility,
                            color: Theme.of(context).primaryColor,
                          ),
                    )
                  : const Text("")),

          hintText: widget.hint,
        ),
      ),
    );
  }
}
