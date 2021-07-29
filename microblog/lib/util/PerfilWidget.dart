import 'package:flutter/material.dart';

class PerfilWidget extends StatelessWidget {
  final String linkImagem;

  const PerfilWidget({Key key, this.linkImagem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
        child: Stack(
      children: [buildImage()],
    ));
  }

  Widget buildImage() {
    final image = NetworkImage(linkImagem);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child:
            Ink.image(image: image, fit: BoxFit.cover, width: 150, height: 150),
      ),
    );
  }
}
