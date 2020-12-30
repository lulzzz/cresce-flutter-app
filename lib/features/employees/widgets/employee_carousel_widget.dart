import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:flutter/widgets.dart';
import 'package:ui_bits/ui_bits.dart';
import 'package:cresce_flutter_app/service_configuration.dart';

class EmployeeCarouselWidget extends StatefulWidget {
  @override
  _EmployeeCarouselWidgetState createState() => _EmployeeCarouselWidgetState();
}

class _EmployeeCarouselWidgetState extends State<EmployeeCarouselWidget> {
  List<Employee> _employees;

  @override
  void initState() {
    super.initState();

    context.get<EmployeeServices>().fetchEmployees(
      Organization(name: 'myOrganization'),
      onSuccess: (employees) {
        setState(() {
          _employees = employees;
        });
      },
      onFailure: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_employees == null) {
      return Container();
    }

    return BitCarousel(
      children: _employees.map((e) {
        return BitThumbnail(
          width: 200,
          data: ThumbnailData(
            title: e.name,
            subTitle: e.title,
            image: Future.value(e.image),
          ),
        );
      }).toList(),
    );
  }
}
