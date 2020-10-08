import 'package:beauty_network_boticario/models/post_model.dart';
import 'package:beauty_network_boticario/repository/news_repository.dart';

abstract class NewsControllerInterface {
  Future<List<PostModel>> getAllNews();
}

class NewsController implements NewsControllerInterface {
  NewsRepositoryInterface _newsRepository;

  NewsController(this._newsRepository);

  Future<List<PostModel>> getAllNews() async {
    try {
      final response = await _newsRepository.fetchAlbum();

      List<PostModel> fetchedNews = List();

      response.forEach((post) {
        fetchedNews.add(PostModel.fromJson(post));
      });

      return fetchedNews;
    } catch (error) {
      throw (error);
    }
  }
}
