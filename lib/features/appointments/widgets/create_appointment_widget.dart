import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';

class CreateAppointmentWidget extends StatefulWidget {
  @override
  _CreateAppointmentWidgetState createState() =>
      _CreateAppointmentWidgetState();
}

class _CreateAppointmentWidgetState extends State<CreateAppointmentWidget> {
  final Field<Service> serviceField = Field.as<Service>();
  final Field<Customer> customerField = Field.as<Customer>();
  final Field<Step> stepField = Field.as<Step>();

  @override
  void initState() {
    super.initState();
    stepField.setValue(Step.promptService);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BitObservable(
          field: stepField,
          buildByState: {
            Step.promptService: buildServiceSelection(),
            Step.promptCustomer: buildCustomerSelection(),
            Step.finalize: Container(
              child: Text('final'),
            ),
          },
        ),
        SizedBox(height: context.sizes.medium),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Row(
            children: [
              BitObservable(
                field: serviceField,
                hasValue: (service) => BitThumbnail(
                  onTap: () {
                    serviceField.setValue(null);
                    customerField.setValue(null);
                    stepField.setValue(Step.promptService);
                  },
                  width: 200,
                  data: service.toThumbnailData(),
                ),
              ),
              SizedBox(width: context.sizes.medium),
              BitObservable(
                field: customerField,
                hasValue: (customer) => BitThumbnail(
                  onTap: () {
                    customerField.setValue(null);
                    stepField.setValue(Step.promptCustomer);
                  },
                  width: 200,
                  data: customer.toThumbnailData(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCustomerSelection() {
    return Container(
      child: Column(
        children: [
          BitText('Escolhe o cliente', style: BitTextStyles.h3),
          EntityCarouselWidget<Customer>(
            onSelect: (customer) {
              customerField.setValue(customer);
              stepField.setValue(Step.finalize);
            },
          ),
        ],
      ),
    );
  }

  Widget buildServiceSelection() {
    return Container(
      child: Column(
        children: [
          BitText('Escolhe o serviço', style: BitTextStyles.h3),
          EntityCarouselWidget<Service>(
            onSelect: (service) {
              serviceField.setValue(service);
              stepField.setValue(Step.promptCustomer);
            },
          ),
        ],
      ),
    );
  }
}

enum Step {
  promptService,
  promptCustomer,
  promptDuration,
  finalize,
}
