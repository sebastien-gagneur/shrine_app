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
import 'package:intl/intl.dart';
import '../login.dart';
import '../product_features_card.dart';
import '../model/product.dart';

Widget tapableText(String text, Function onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Text(text),
  );
}

class ProductCard extends StatelessWidget {
  ProductCard({this.imageAspectRatio: 33 / 49, this.product}) : assert(imageAspectRatio == null || imageAspectRatio > 0);

  final double imageAspectRatio;
  final Product product;

  static final kTextBoxHeight = 65.0;

  @override
  Widget build(BuildContext context) {
    String str;
    str = product.name + "\n v-" + product.vendorId.toString();

    final NumberFormat formatter = NumberFormat.simpleCurrency(decimalDigits: 0, locale: Localizations.localeOf(context).toString());
    final ThemeData theme = Theme.of(context);

    final imageWidget = Image.asset(
      product.assetName,
      package: product.assetPackage,
      fit: BoxFit.cover,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: imageAspectRatio,
          child: imageWidget,
        ),
        SizedBox(
          height: kTextBoxHeight * MediaQuery.of(context).textScaleFactor,
          width: 121.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // pour rendre le texte du produit clickable et aller sur la fiche produit.
              new InkWell(
                child: Text(str),
                onTap: () {
                  print("click");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => ProductFeaturesCardPage(product.price)),
                  );
                },
              ),
              // les textes par défaut ne prennent pas les clics. Impossible d'ajouter un évéènement sur un text en natif
              //Text(
              //product == null ? '' : str,
              //style: theme.textTheme.headline6,
              //softWrap: false,
              //overflow: TextOverflow.ellipsis,
              //maxLines: 2,
              //),
              SizedBox(height: 4.0),
              Text(
                product == null ? '' : formatter.format(product.price),
                style: theme.textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
