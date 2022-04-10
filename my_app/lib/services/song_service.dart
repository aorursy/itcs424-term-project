import 'package:dio/dio.dart';
import 'package:my_app/services/models/deezer_model.dart';

class SongService {
  Dio _dio = Dio();

  SongService() {
    BaseOptions options = BaseOptions(
        receiveTimeout: 100000,
        connectTimeout: 100000,
        baseUrl: 'https://api.deezer.com/track/');
    _dio = Dio(options);
  }
  Future<DeezerSongModel> getTrack(id) async {
    try {
      final response = await _dio.get('$id',
          options: Options(headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Accept': 'application/json;charset=UTF-8',
          }));
      DeezerSongModel result = DeezerSongModel.fromJson(response.data);
      return result;
    } on DioError catch (e) {
      if (e.response != null) {
        throw 'An error has occurred';
      } else {
        print(e.error);
        throw e.error;
      }
    }
  }
}
