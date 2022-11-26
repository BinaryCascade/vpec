import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../utils/theme_helper.dart';
import '../../settings/settings_logic.dart';
import 'editor_logic.dart';

class EditorHeader extends StatelessWidget {
  const EditorHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        'Новое объявление',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: CachedNetworkImage(imageUrl: imagePath),
    );
  }
}

class UploadAttachmentButton extends StatelessWidget {
  const UploadAttachmentButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorLogic>(
      builder: (context, logic, _) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: ThemeHelper.isDarkMode
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            type: MaterialType.transparency,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: logic.pickImage,
              child: SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.attachment_outlined,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            'Прикрепить картинку',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      if (logic.photoUploadProgress != null)
                        LinearProgressIndicator(
                          value: logic.photoUploadProgress,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TitleEditorField extends StatelessWidget {
  const TitleEditorField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 3,
      controller: context.read<EditorLogic>().announcementTitleController,
      onChanged: (_) =>
          context.read<EditorLogic>().checkAndUpdatePublishButtonActiveStatus(),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.headline3!.copyWith(fontSize: 18),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.edit_outlined),
        hintText: 'Введите заголовок..',
        hintStyle: TextStyle(
          fontSize: 18,
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}

class BodyEditorField extends StatelessWidget {
  const BodyEditorField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: null,
      controller: context.read<EditorLogic>().announcementBodyController,
      onChanged: (_) =>
          context.read<EditorLogic>().checkAndUpdatePublishButtonActiveStatus(),
      textInputAction: TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      style: Theme.of(context).textTheme.headline3,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.edit_outlined),
        hintText: 'Введите сообщение..',
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    );
  }
}

class AuthorName extends StatelessWidget {
  const AuthorName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => SettingsLogic.changeName(context),
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, bottom: 13),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 5,
            children: [
              ValueListenableBuilder(
                valueListenable:
                    Hive.box('settings').listenable(keys: ['username']),
                builder: (context, Box box, child) {
                  return Text(
                    box.get('username', defaultValue: 'Имя не указано'),
                    style: Theme.of(context).textTheme.subtitle1,
                  );
                },
              ),
              Icon(
                Icons.edit_outlined,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditorUI extends StatelessWidget {
  const EditorUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorLogic>(
      builder: (context, logic, _) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                logic.photoUrl == null
                    ? const UploadAttachmentButton()
                    : ImagePreview(imagePath: logic.photoUrl!),
                const TitleEditorField(),
                const BodyEditorField(),
                const AuthorName(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class VisibilityPicker extends StatelessWidget {
  const VisibilityPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorLogic>(
      builder: (context, logic, _) {
        return Column(
          children: [
            Text(
              'Выберите видимость:',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            CheckboxListTile(
              checkColor: Theme.of(context).scaffoldBackgroundColor,
              activeColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['students'],
              title: Text(
                'Студентам',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('students', value ?? false);
              },
            ),
            CheckboxListTile(
              checkColor: Theme.of(context).scaffoldBackgroundColor,
              activeColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['parents'],
              title: Text(
                'Родителям',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('parents', value ?? false);
              },
            ),
            CheckboxListTile(
              checkColor: Theme.of(context).scaffoldBackgroundColor,
              activeColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['teachers'],
              title: Text(
                'Преподавателям',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('teachers', value ?? false);
              },
            ),
            CheckboxListTile(
              checkColor: Theme.of(context).scaffoldBackgroundColor,
              activeColor: Theme.of(context).colorScheme.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: logic.publishFor['admins'],
              title: Text(
                'Администрации',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              onChanged: (value) {
                logic.updateCheckbox('admins', value ?? false);
              },
            ),
          ],
        );
      },
    );
  }
}

class DialogButtons extends StatelessWidget {
  const DialogButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: [
        TextButton(
          onPressed: () {
            context.read<EditorLogic>().cleanUp();

            Navigator.pop(context);
          },
          child: const Text('Закрыть'),
        ),
        ElevatedButton(
          onPressed: context.watch<EditorLogic>().publishButtonActive
              ? () async {
                  await context.read<EditorLogic>().publishAnnouncement();
                  Navigator.pop(context);
                }
              : null,
          child: const Text('Опубликовать'),
        ),
      ],
    );
  }
}
