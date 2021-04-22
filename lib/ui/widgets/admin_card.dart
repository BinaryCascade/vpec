import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/admin_model.dart';

class AdminCard extends StatelessWidget {
  final AdminModel? admin;

  const AdminCard({Key? key, this.admin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Text(
                  admin!.name!,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Text(
                  admin!.post!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SelectableLinkify(
                      text: admin!.contact!,
                      style: Theme.of(context).textTheme.subtitle1,
                      onOpen: (value) async {
                        if (await canLaunch(value.url)) {
                          await launch(value.url);
                        }
                      },
                    ),
                  ),
                  if (admin!.cabinet != '')
                    Text(
                      "Кабинет ${admin!.cabinet}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
