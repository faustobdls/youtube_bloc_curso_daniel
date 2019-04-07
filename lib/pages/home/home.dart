import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:curso_youtube_bloc/blocs/favorite_bloc.dart';
import 'package:curso_youtube_bloc/blocs/videos_bloc.dart';
import 'package:curso_youtube_bloc/components/video_tile.dart';
import 'package:curso_youtube_bloc/delegates/data_search.dart';
import 'package:curso_youtube_bloc/pages/favorites/favorite.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset('assets/yt_logo_rgb_dark.png'),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: StreamBuilder(
              stream: BlocProvider.of<FavoriteBloc>(context).getFavorites,
              initialData: {},
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data.length}');
                } else {
                  return Text('0');
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute( builder: (context)=>FavoritePage())
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result = await showSearch(context: context, delegate: DataSearch());
              if ( result != null ) {
                BlocProvider.of<VideosBloc>(context).searchVideos.add(result);
              }
            },
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: BlocProvider.of<VideosBloc>(context).getVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData ) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if ( index < snapshot.data.length ) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  BlocProvider.of<VideosBloc>(context).searchVideos.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else {
                  return Container();
                }
              },
              itemCount: snapshot.data.length + 1,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}