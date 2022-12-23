import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'cards.dart';

class TextCardData extends BaseCardData {
  static const type = 'text';

  final String text;
  final String? prefixIcon;
  final String? suffixIcon;

  TextCardData.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        prefixIcon = json['prefix_icon'],
        suffixIcon = json['suffix_icon'],
        super(json);

  @override
  Widget widget() => _Text(textCardData: this);
}

class _Text extends StatelessWidget {
  final TextCardData textCardData;

  const _Text({Key? key, required this.textCardData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (textCardData.prefixIcon != null) ...[
            CachedNetworkImage(imageUrl: textCardData.prefixIcon!, height: 20),
            const SizedBox(width: 10)
          ],
          Text(
            textCardData.text,
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
          ),
          if (textCardData.suffixIcon != null) ...[
            const SizedBox(width: 10),
            CachedNetworkImage(imageUrl: textCardData.suffixIcon!, height: 20),
          ],
        ],
      ),
    );
  }
}
