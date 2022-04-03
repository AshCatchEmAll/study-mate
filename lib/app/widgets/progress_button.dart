import 'package:flutter/material.dart';
import 'package:wespark_student/flashcard/constants/all_constants.dart';

class ProgressButton extends StatefulWidget {
  const ProgressButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      this.buttonStyle,
      this.size})
      : super(key: key);
  final Widget child;
  final ButtonStyle? buttonStyle;
  final Function? onPressed;
  final Size? size;
  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading == false
        ? TextButton(
            style: widget.buttonStyle ??
                ButtonStyle(
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                  ),
                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.transparent, width: 1)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) =>
                        states.contains(MaterialState.disabled)
                            ? const Color(0xffdddddd)
                            : buttonColor,
                  ),
                ),
            onPressed: widget.onPressed == null
                ? null
                : () async {
                    try {
                      setState(() {
                        _isLoading = true;
                      });

                      await widget.onPressed!();
                      setState(() {
                        _isLoading = false;
                      });
                    } catch (e) {
                      setState(() {
                        _isLoading = false;
                      });
                      rethrow;
                    }
                  },
            child: widget.child)
        : SizedBox(
            width: widget.size != null ? widget.size!.width : null,
            height: widget.size != null ? widget.size!.height : null,
            child: const Center(child: CircularProgressIndicator()));
  }
}
