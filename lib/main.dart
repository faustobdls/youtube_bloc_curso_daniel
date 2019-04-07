import 'package:curso_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:curso_youtube_bloc/blocs/videos_bloc.dart';
import 'package:flutter/material.dart';
import 'package:curso_youtube_bloc/pages/home/home.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoriteBloc(),
        child: MaterialApp(
          title: 'YouTube Flutter',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ),
      )
    );
  }
}
