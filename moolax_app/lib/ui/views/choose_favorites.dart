import 'package:flutter/material.dart';
import 'package:moolax/business_logic/view_models/choose_favorites_viewmodel.dart';
import 'package:moolax/services/service_locator.dart';
import 'package:provider/provider.dart';

import '../../business_logic/view_models/choose_favorites_viewmodel.dart';

class ChooseFavoriteCurrencyScreen extends StatefulWidget {
  @override
  _ChooseFavoriteCurrencyScreenState createState() =>
      _ChooseFavoriteCurrencyScreenState();
}

class _ChooseFavoriteCurrencyScreenState
    extends State<ChooseFavoriteCurrencyScreen> {
  // 1
  ChooseFavoritesViewModel model = serviceLocator<ChooseFavoritesViewModel>();

  // 2
  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Currencies'),
      ),
      body: buildListView(model),
    );
  }

  // Add buildListView() here.
  Widget buildListView(ChooseFavoritesViewModel viewModel) {
    // 1
    return ChangeNotifierProvider<ChooseFavoritesViewModel>(
      // 2
      create: (context) => viewModel,
      // 3
      child: Consumer<ChooseFavoritesViewModel>(
        builder: (context, model, child) => ListView.builder(
          itemCount: model.choices.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: SizedBox(
                  width: 60,
                  child: Text(
                    '${model.choices[index].flag}',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                // 4
                title: Text('${model.choices[index].alphabeticCode}'),
                subtitle: Text('${model.choices[index].longName}'),
                trailing: (model.choices[index].isFavorite)
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border),
                onTap: () {
                  // 5
                  model.toggleFavoriteStatus(index);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
