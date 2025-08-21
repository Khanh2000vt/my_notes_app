import 'package:mix/mix.dart';

class ButtonVariant extends Variant {
  const ButtonVariant._(super.name);

  static const filled = ButtonVariant._('filled');
  static const outlined = ButtonVariant._('outlined');
  static const elevated = ButtonVariant._('elevated');
  static const link = ButtonVariant._('link');
}
