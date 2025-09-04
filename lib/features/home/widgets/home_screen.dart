import 'package:flutter/cupertino.dart';
import 'package:my_notes_app/features/home/widgets/card_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: const CupertinoThemeData(),
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              leading: const Icon(CupertinoIcons.person),
              largeTitle: const Text('Home'),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50),
                child: Padding(
                  padding: EdgeInsetsGeometry.only(left: 16),
                  child: Text(
                    'Chọn chức năng bên dưới',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              trailing: const Icon(CupertinoIcons.bell),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                CardItem(
                  imageUrl: "https://picsum.photos/200",
                  title: "Flutter",
                  description: "Build beautiful apps for mobile",
                  onTap: () => debugPrint("Tapped Flutter"),
                ),
                CardItem(
                  imageUrl: "https://picsum.photos/201",
                  title: "Dart",
                  description: "Powerful language for Flutter",
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
