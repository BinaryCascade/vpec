import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/teacher_model.dart';
import '../../../ui/widgets/loading_indicator.dart';
import '../../../ui/widgets/teacher_card.dart';
import 'teachers_logic.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.search,
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        hintText:
            Provider.of<TeachersLogic>(context, listen: true).visibleTextMode,
        border: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.headline3,
      ),
      onChanged: (value) {
        Provider.of<TeachersLogic>(context, listen: false).search(value);
      },
    );
  }
}

class BuildChips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 4.0,
          children: [
            InputChip(
              label: Text('Фамилия'),
              selectedColor: Theme.of(context).accentColor,
              onPressed: () =>
                  Provider.of<TeachersLogic>(context, listen: false)
                      .setMode(SearchMode.familyName),
            ),
            InputChip(
              label: Text('Имя'),
              selectedColor: Theme.of(context).accentColor,
              onPressed: () =>
                  Provider.of<TeachersLogic>(context, listen: false)
                      .setMode(SearchMode.firstName),
            ),
            InputChip(
              label: Text('Отчество'),
              selectedColor: Theme.of(context).accentColor,
              onPressed: () =>
                  Provider.of<TeachersLogic>(context, listen: false)
                      .setMode(SearchMode.secondaryName),
            ),
            InputChip(
              label: Text('Предметы'),
              selectedColor: Theme.of(context).accentColor,
              onPressed: () =>
                  Provider.of<TeachersLogic>(context, listen: false)
                      .setMode(SearchMode.lesson),
            ),
            InputChip(
              label: Text('Кабинеты'),
              selectedColor: Theme.of(context).accentColor,
              onPressed: () =>
                  Provider.of<TeachersLogic>(context, listen: false)
                      .setMode(SearchMode.cabinet),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildTeachersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: Provider.of<TeachersLogic>(context, listen: true).stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return LoadingIndicator();
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 6.5, vertical: 5.5),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return TeacherCard(
                  teacher: TeacherModel.fromMap(
                      snapshot.data!.docs[index].data(),
                      snapshot.data!.docs[index].id),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
