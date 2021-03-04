import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class CreateAppointmentWidget extends StatelessWidget {
  final Field<bool> serviceWasSelected = Field.asBool();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EntityCarouselWidget<Service>(
          onSelect: (_) {
            serviceWasSelected.setValue(true);
          },
        ),
        BitObservable(
          field: serviceWasSelected,
          buildByState: {
            true: EntityCarouselWidget<Customer>(),
          },
        ),
      ],
    );
  }
}
