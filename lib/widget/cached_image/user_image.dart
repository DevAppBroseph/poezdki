import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../const/server/server_data.dart';

class UserCachedImage extends StatelessWidget {
  final String? img;
  const UserCachedImage({Key? key, this.img}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        child: img != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(imageUrl: "$serverURL/$img"))
            : const FlutterLogo());
  }
}
