import 'package:flutter/material.dart';
import 'Movie_Data_Model.dart';
import 'movie_api_service.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  MovieModel? movie;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadMovie();
  }

  Future<void> loadMovie() async {
    movie = await MovieApiService().fetchMovie();
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie Details")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : movie == null
          ? const Center(child: Text("No data"))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Poster
            Image.network(movie!.poster!, height: 300),

            const SizedBox(height: 12),

            /// Title
            Text(
              movie!.title!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text("Year: ${movie!.year}"),
            Text("Rated: ${movie!.rated}"),
            Text("Runtime: ${movie!.runtime}"),
            Text("Genre: ${movie!.genre}"),
            Text("Director: ${movie!.director}"),
            Text("Writer: ${movie!.writer}"),
            Text("Actors: ${movie!.actors}"),
            Text("Language: ${movie!.language}"),
            Text("Country: ${movie!.country}"),

            const SizedBox(height: 10),

            /// Plot
            Text(
              movie!.plot!,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 12),

            /// Ratings
            const Text(
              "Ratings",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),

            ...movie!.ratings!.map((rating) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(rating.source!),
                trailing: Text(rating.value!),
              );
            }),

            const Divider(),

            /// Extra Info
            Text("Metascore: ${movie!.metascore}"),
            Text("IMDb Rating: ${movie!.imdbRating}"),
            Text("IMDb Votes: ${movie!.imdbVotes}"),
            Text("Box Office: ${movie!.boxOffice}"),
            Text("Awards: ${movie!.awards}"),
          ],
        ),
      ),
    );
  }
}
