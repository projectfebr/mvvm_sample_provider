import 'package:flutter/material.dart';
import 'package:mvvm_sample_provider/ui/widgets/example_widget.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChangeNotifierProvider<ViewModel>(
        create: (context) {
          return ViewModel();
        },
        child: const ExampleWidget(),
      ),
    );
  }
}
