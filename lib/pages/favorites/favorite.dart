import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:curso_youtube_bloc/components/video_tile.dart';
import 'package:curso_youtube_bloc/models/video.dart';
import 'package:curso_youtube_bloc/environments/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final favoriteBloc = BlocProvider.of<FavoriteBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder<Map<String, Video>>(
        stream: favoriteBloc.getFavorites,
        initialData: {},
        builder: (context, snapshot) {
          if (snapshot.hasData ) {
            return ListView(
              children: snapshot.data.values.map( (item) {
                return InkWell(
                  child: VideoTile(item),
                  onTap: () {
                  },
                  onLongPress: () {
                    favoriteBloc.toggleFavorite(item);
                  },
                );
              }).toList(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}