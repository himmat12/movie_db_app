import 'package:get/get.dart';

import '../../service_locator.dart';
import '../configs/strings.dart';
import '../models/peoples/people_model.dart';
import '../models/results/movie_result_model.dart';
import '../models/results/tv_result_model.dart';
import '../services/search_service.dart';
import '../utils/auth.dart';
import 'base_controller.dart';

class SearchController extends BaseController {
  final _service = sl<SearchService>();

  var searchState = ViewState.idle.obs;

  var movieSearchResults = <MovieResultModel>[].obs;
  var tvSearchResults = <TvResultsModel>[].obs;
  var peopleSearchResults = <PeopleModel>[].obs;

  var searchHistoryMovie = [].obs;
  var searchHistoryTv = [].obs;

  var resultType = movieString.obs;

  @override
  void onInit() {
    initSearchHistory();
    super.onInit();
  }

  // set result type
  void setResultType(String value) => resultType.value = value;

  // reset search satate
  void resetSearchState() => searchState.value = ViewState.idle;

// init search history list
  void initSearchHistory() {
    searchHistoryMovie.value = Auth().searchHistoryMovie;
    searchHistoryTv.value = Auth().searchHistoryTv;
  }

// search history
  /// set movie search history
  void setSearchHistoryMovie(String query) {
    if (searchHistoryMovie.contains(query) != true) {
      searchHistoryMovie.add(query);
      Auth().setSearchHistoryMovie(searchHistoryMovie);
    }
  }

  /// set tv search history
  void setSearchHistoryTv(String query) {
    if (searchHistoryTv.contains(query) != true) {
      searchHistoryTv.add(query);
      Auth().setSearchHistoryMovie(searchHistoryTv);
    }
  }

  void clearSearchHistoryMovie() {
    searchHistoryMovie.clear();
    Auth().setSearchHistoryMovie(searchHistoryMovie);
  }

  void clearSearchHistoryTv() {
    searchHistoryTv.clear();
    Auth().setSearchHistoryTv(searchHistoryTv);
  }

  // search query
  void search({
    required String query,
    required String resultType,
  }) async {
    searchState.value = ViewState.busy;
    print(searchState.value);
    await _service.search(query: query, resultType: resultType).then((value) {
      switch (resultType) {
        case movieString:
          movieSearchResults.value = List.from(
              (value as List).map((e) => MovieResultModel.fromJson(e)));
          for (var i in movieSearchResults) {
            print(i.title);
          }
          searchState.value = ViewState.retrived;
          movieSearchResults.refresh();
          update(['movie_search_result']);
          break;

        case tvString:
          tvSearchResults.value =
              List.from((value as List).map((e) => TvResultsModel.fromJson(e)));
          print(tvSearchResults);

          searchState.value = ViewState.retrived;
          update(['tv_search_result']);
          break;
        case personString:
          peopleSearchResults.value =
              List.from((value as List).map((e) => PeopleModel.fromJson(e)));
          print(peopleSearchResults);

          searchState.value = ViewState.retrived;
          update(['people_search_result']);
          break;

        default:
          break;
      }
    });
    print(searchState.value);
  }
}
