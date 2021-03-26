import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_stock/src/configs/app_route.dart';
import 'package:my_stock/src/constants/api.dart';
import 'package:my_stock/src/constants/app_setting.dart';
import 'package:my_stock/src/constants/asset.dart';
import 'package:my_stock/src/models/product_response.dart';
import 'package:my_stock/src/pages/login/background_theme.dart';
import 'package:my_stock/src/services/network.dart';
import 'package:my_stock/src/view_models/menu_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: CommonDrawer(),
      appBar: AppBar(
        title: Text("PRODUCT LIST"),
        centerTitle: false,
      ),
      body: FutureBuilder<List<ProductResponse>>(
        future: NetworkService().productAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final productList = snapshot.data;

          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: GridView.builder(
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraint) => ShopListItem(
                  constraint.maxHeight,
                  productList[index],
                  press: () async {
                    await Navigator.pushNamed(
                      context,
                      AppRoute.managementRoute,
                      arguments: productList[index],
                    );
                    setState(() {

                    });
                  },
                ),
              ),
              itemCount: productList.length,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(
            context,
            AppRoute.managementRoute,
          );
          setState(() {});
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("COZY_FLOAT"),
            accountEmail: Text("khunfloat@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://instagram.fbkk5-3.fna.fbcdn.net/v/t51.2885-19/s320x320/162042814_2893560307582029_1317492340961511045_n.jpg?tp=1&_nc_ht=instagram.fbkk5-3.fna.fbcdn.net&_nc_ohc=NnPcepcgx8sAX_TiiLH&ccb=7-4&oh=2fb9d8a1b117dfe38d67f28994a8944f&oe=6083811C&_nc_sid=7bff83",
              ),
            ),
            decoration: BoxDecoration(
              gradient: BackGroundThemedark.gradient,
            ),
          ),
          ...MenuViewModel()
              .items
              .map((e) => ListTile(
                    onTap: () {
                      e.onTap(context);
                    },
                    leading: Icon(
                      e.icon,
                      color: e.iconColor,
                    ),
                    title: Text(e.title),
                  ))
              .toList(),
          Spacer(),
          ListTile(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove(AppSetting.tokenSetting);

              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoute.loginRoute, (route) => false);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}

class ShopListItem extends StatelessWidget {
  final Function press;
  final double maxHeight;
  final ProductResponse product;

  const ShopListItem(this.maxHeight, this.product, {Key key, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.press,
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _buildImage(),
            Expanded(
              child: _buildInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildInfo() => Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '\$ ${product.price}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${product.stock} pieces',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ],
        ),
      );

  Stack _buildImage() {
    final height = maxHeight * 0.75;
    final productImage =
        // 'https://images.pexels.com/photos/3680219/pexels-photo-3680219.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
        product.image;
    return Stack(
      children: [
        productImage != null && productImage.isNotEmpty
            ? Image.network(
                "${API.IMAGE_URL}/$productImage",
                height: height,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Image.asset(
                Asset.noPhotoImage,
                height: height,
                width: double.infinity,
              ),
        if (product.stock <= 0)
          Positioned(
            top: 1,
            right: 1,
            child: Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.box,
                      size: 15.0,
                      color: Colors.black,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'out of stock',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
