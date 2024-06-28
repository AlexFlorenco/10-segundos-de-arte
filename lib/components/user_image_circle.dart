import 'package:artes/components/gap.dart';
import 'package:artes/core/theme/app_text_style.dart';
import 'package:flutter/widgets.dart';

class UserImageCircle extends StatelessWidget {
  final String photoUrl;
  final String? displayName;
  final double size;

  const UserImageCircle({
    super.key,
    required this.photoUrl,
    this.displayName,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.network(
            photoUrl,
            width: size,
            height: size,
          ),
        ),
        displayName != null ? Gap.h(8) : const SizedBox.shrink(),
        displayName != null
            ? Text(
                displayName!.split(' ')[0],
                style: const TextStyle().body,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
