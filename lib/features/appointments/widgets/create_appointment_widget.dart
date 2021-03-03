import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';

class CreateAppointmentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EntityCarouselWidget<Service>(),
        Container(),
      ],
    );
  }
}
