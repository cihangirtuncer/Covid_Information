import 'dart:convert';

import 'package:covid_19_statistic/core/widget/countries_list_widget_.dart';
import 'package:covid_19_statistic/core/widget/null_return_widget.dart';
import 'package:covid_19_statistic/view/countries/model/countries.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CountriesModelView extends StatefulWidget {
  CountriesModelView({Key key}) : super(key: key);

  @override
  _CountriesModelStateView createState() => _CountriesModelStateView();
}

class _CountriesModelStateView extends State<CountriesModelView> {
  Countries countries;

  @override
  void initState() {
    super.initState();
    getApi();
  }

  getApi() async {
    try {
      final response = await http.get(
        'https://covid-193.p.rapidapi.com/countries',
        headers: {
          'x-rapidapi-host': 'covid-193.p.rapidapi.com',
          'x-rapidapi-key':
              '7230f0073fmsh19c10074c514c59p16793ejsn6aa0e35fe867',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final _countries = Countries.fromJson(data);

        setState(() {
          countries = _countries;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('$e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return countries == null
        ? nullReturn()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemBuilder: (contex, index) {
              final currentCountry = countries.countryList[index];

              return countriesListWidget(currentCountry, () {});
            },
            itemCount: countries.countryList?.length,
          );
  }
}