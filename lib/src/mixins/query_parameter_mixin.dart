import '../utils/auth.dart';

mixin QueryParameterMixin {
  String api = "1a5ebef58b08ad825f24591860b26990";
  // String authorization =
  //     "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTVlYmVmNThiMDhhZDgyNWYyNDU5MTg2MGIyNjk5MCIsInN1YiI6IjYwYTM1OTI2NzMxNGExMDA3OGZjZTRkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.VJG0GMDEpcYQBtm5VZlCHEmqTY5jH4kfIkYhosKqOA0";

  late Map<String, String> queryParma;

  Map<String, String> setQueryParameters({required Map<String, String> query}) {
    queryParma = {"api_key": api};
    queryParma.addAll(query);
    if (Auth().isLoggedIn == true) {
      queryParma["session_id"] = Auth().sessionId;
    }
    if (Auth().isGuestLoggedIn == true) {
      queryParma["guest_session_id"] = Auth().guestSessionId;
    }
    return queryParma;
  }
}
