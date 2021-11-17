// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

import 'colors.dart';
import 'login.dart';
import 'backdrop.dart';
import 'home.dart';
import 'category_menu_page.dart';
import 'model/product.dart';
import 'app.dart';

// Pas très catholique, mais pour éviter les getter qui pose problème je mets des variables globales qui collectent la valeur à l'intérieur du constructeur de la classe
String libelle;
int prix;

class ProductFeaturesCardPage extends StatefulWidget {
  String _Name;
  int _Price;

  ProductFeaturesCardPage(String name, int price) {
    this._Name = name;
    this._Price = price;
    // ça évite le getter et j'ai la varialb en globale pour l'utiliser dans la classe suivante
    libelle = name;
    prix = price;
  }

  @override
  _ProductFeaturesCardPageState createState() => _ProductFeaturesCardPageState();
}

class _ProductFeaturesCardPageState extends State<ProductFeaturesCardPage> {
  final _category = TextEditingController();
  final _id = TextEditingController();
  final _isFeatured = TextEditingController();
  final _name = TextEditingController()..text = libelle;
  final _price = TextEditingController()..text = prix.toString();
  final _location = TextEditingController();
  final _vendorId = TextEditingController();

  Category _currentCategory = Category.all;

  //_price.Text = getPrice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                SizedBox(height: 16.0),
                Text(
                  'BRANDED',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
            SizedBox(height: 6.0),
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _category,
                decoration: InputDecoration(
                  labelText: 'category',
                ),
              ),
            ),
            SizedBox(height: 6.0),
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _id,
                decoration: InputDecoration(
                  labelText: 'id',
                ),
              ),
            ),
            SizedBox(height: 6.0),
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _isFeatured,
                decoration: InputDecoration(
                  labelText: 'feature',
                ),
              ),
            ),
            SizedBox(height: 6.0),
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _name,
                decoration: InputDecoration(
                  labelText: 'name',
                ),
              ),
            ),
            SizedBox(height: 6),
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _price,
                decoration: InputDecoration(
                  labelText: 'price',
                ),
              ),
            ),
            SizedBox(height: 6),
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _location,
                decoration: InputDecoration(
                  labelText: 'location',
                ),
              ),
            ),
            SizedBox(height: 6),
            AccentColorOverride(
              color: kShrineBrown900,
              child: TextField(
                controller: _vendorId,
                decoration: InputDecoration(
                  labelText: 'idVendor',
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('Reset'),
                  elevation: 8.0,
                  color: kShrineErrorOrange,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    print("Reset Pressed : confirm");
                    _id.clear();
                    _price.clear();
                  },
                ),
                RaisedButton(
                  child: Text('confirm'),
                  elevation: 8.0,
                  color: kShrineErrorGreen,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  onPressed: () {
                    print("confirm Pressed : confirm");

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          // passage a la page des produits MAIS AJOUT DE LA FLECHE BACK ...
                          // Il faut beaucoup de paramètres pour appeler la page backdrop ...
                          //pour gerer le backdrop justement. La page appelé est ici backdrop
                          // Cette classe qui désigne la page produit est présente dans le fichier
                          // backdrop.dart
                          builder: (BuildContext context) => Backdrop(
                                currentCategory: _currentCategory,
                                frontLayer: HomePage(category: _currentCategory),
                                backLayer: CategoryMenuPage(
                                  currentCategory: _currentCategory,
                                  onCategoryTap: _onCategoryTap,
                                ),
                                frontTitle: Text('BRANDED'),
                                backTitle: Text('FILTERS'),
                              )),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // IL A FALLU AJOUTER CETTE FONCTION SUR LES CATEGORIES POUR APPELER LA PAGE BACKDROP
  // suite à l'appui du bouton confirm de la page confirm.
  // la page back à besoin de connaître les catégories choisies actives.
  /// Function to call when a [Category] is tapped.
  void _onCategoryTap(Category category) {
    setState(() {
      _currentCategory = category;
      print("category pressed : category");
    });
  }
}

class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child}) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(
        accentColor: color,
        brightness: Brightness.dark,
      ),
    );
  }
}
