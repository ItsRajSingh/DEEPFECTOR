class Movie{
  static List<Movie> getMovies() => [
    Movie("Avatar", "2009",
         "PG-13",
         "18 Dec 2009",
         "162 min",
         "Action, Adventure, Fantasy",
         "James Cameron",
         "James Cameron",
         "Sam Worthington, Zoe Saldana, Sigourney Weaver, Stephen Lang",
         "A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.",
         "English, Spanish",
         "USA, UK",
         "Won 3 Oscars. Another 80 wins & 121 nominations.",
         "http://ia.media-imdb.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg",
         "83",
         "7.9",
         "890,617",
         "tt0499549",
         "movie",
         "True",
         [
        "https://images-na.ssl-images-amazon.com/images/M/MV5BMjEyOTYyMzUxNl5BMl5BanBnXkFtZTcwNTg0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
        "https://images-na.ssl-images-amazon.com/images/M/MV5BNzM2MDk3MTcyMV5BMl5BanBnXkFtZTcwNjg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
        "https://images-na.ssl-images-amazon.com/images/M/MV5BMTY2ODQ3NjMyMl5BMl5BanBnXkFtZTcwODg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
        "https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxOTEwNDcxN15BMl5BanBnXkFtZTcwOTg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
        "https://images-na.ssl-images-amazon.com/images/M/MV5BMTYxMDg1Nzk1MV5BMl5BanBnXkFtZTcwMDk0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg"
        ],),
    Movie("Avatar", "2009",
        "PG-13",
        "18 Dec 2009",
        "162 min",
        "Action, Adventure, Fantasy",
        "James Cameron",
        "James Cameron",
        "Sam Worthington, Zoe Saldana, Sigourney Weaver, Stephen Lang",
        "A paraplegic marine dispatched to the moon Pandora on a unique mission becomes torn between following his orders and protecting the world he feels is his home.",
        "English, Spanish",
        "USA, UK",
        "Won 3 Oscars. Another 80 wins & 121 nominations.",
        "http://ia.media-imdb.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg",
        "83",
        "7.9",
        "890,617",
        "tt0499549",
        "movie",
        "True",
        [
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMjEyOTYyMzUxNl5BMl5BanBnXkFtZTcwNTg0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BNzM2MDk3MTcyMV5BMl5BanBnXkFtZTcwNjg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTY2ODQ3NjMyMl5BMl5BanBnXkFtZTcwODg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTMxOTEwNDcxN15BMl5BanBnXkFtZTcwOTg0MTUzNA@@._V1_SX1777_CR0,0,1777,999_AL_.jpg",
          "https://images-na.ssl-images-amazon.com/images/M/MV5BMTYxMDg1Nzk1MV5BMl5BanBnXkFtZTcwMDk0MTUzNA@@._V1_SX1500_CR0,0,1500,999_AL_.jpg"
        ])
  ];

  String title = 'NOT SET';
  String year = 'NOT SET';
  String rated = 'NOT SET';
  String released = 'NOT SET';
  String runtime = 'NOT SET';
  String genre = 'NOT SET';
  String director = 'NOT SET';
  String writer = 'NOT SET';
  String actors = 'NOT SET';
  String plot = 'NOT SET';
  String language = 'NOT SET';
  String country = 'NOT SET';
  String awards = 'NOT SET';
  String poster = 'NOT SET';
  String metascore = 'NOT SET';
  String imdbRating = 'NOT SET';
  String imdbVotes= 'NOT SET';
  String imdbID = 'NOT SET';
  String type = 'NOT SET';
  String response = 'NOT SET';
  List<String> images = [];

  Movie(
      this.title,
      this.year,
      this.rated,
      this.released,
      this.runtime,
      this.genre,
      this.director,
      this.writer,
      this.actors,
      this.plot,
      this.language,
      this.country,
      this.awards,
      this.poster,
      this.metascore,
      this.imdbRating,
      this.imdbVotes,
      this.imdbID,
      this.type,
      this.response,
      this.images);
}
