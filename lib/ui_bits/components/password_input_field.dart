import 'package:cresce_flutter_app/ui_bits/ui_bits_internal.dart';

class BitInputPasswordField extends StatefulWidget {
  final FieldLabels messages;
  final Field<String> field;
  final BitAnimation animation;

  const BitInputPasswordField(
    this.messages, {
    this.field,
    this.animation = const BitNoAnimation(),
  });

  @override
  _BitInputPasswordFieldState createState() => _BitInputPasswordFieldState();
}

class _BitInputPasswordFieldState extends State<BitInputPasswordField> {
  var _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.animation.wrapWidget(
      child: TextFormField(
        obscureText: _obscureText,
        controller: widget.field?.controller,
        decoration: InputDecoration(
          labelText: widget.messages.label,
          prefixIcon: BitInputFieldIcon(widget.messages.icon),
          suffixIcon: _buildSuffixIcon(context),
        ),
      ),
    );
  }

  Widget _buildSuffixIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _obscureText = !_obscureText),
      child: BitFadeInAnimationWidget(
        duration: context.animation.short,
        animateAfter: widget.animation.animateAfter,
        child: BitToggleAnimation(
          _obscureText,
          BitInputFieldIcon(Icons.visibility),
          BitInputFieldIcon(Icons.visibility_off),
        ),
      ),
    );
  }
}
