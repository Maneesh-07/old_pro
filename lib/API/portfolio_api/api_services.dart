
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walletstone/API/shared_preferences.dart';
import 'package:walletstone/UI/Constants/urls.dart';
import 'package:walletstone/UI/Model/portfolio/portfolio_model.dart';
import 'package:walletstone/main.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Portfolio>> getData() async {
    setupHttpOverrides();
    try {
      final response = await _dio.get(
        portfolio,
        options: Options(
          headers: {
            "Cookie":
                "csrftoken=${MySharedPreferences().getCsrfToken(await SharedPreferences.getInstance())}; sessionid=${MySharedPreferences().getSessionId(await SharedPreferences.getInstance())}",
            "X-CSRFToken": MySharedPreferences()
                .getCsrfToken(await SharedPreferences.getInstance()),
          },
          sendTimeout: const Duration(seconds: 1),
          receiveTimeout: const Duration(seconds: 30 * 1000),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final filteredData =
            data.where((item) => item['sub_cat'] == 0).toList();
        return filteredData.map((item) => Portfolio.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Handle DioError related to bad response
        throw Exception(
            "Error: ${e.response!.statusCode} - ${e.response!.statusMessage}");
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception("Error: Timeout occurred while fetching data");
      } else {
        throw Exception('Error: $e');
      }
    } catch (e) {
      // Handle generic exceptions
      throw Exception('Error: $e');
    }
  }

  Future<List<Portfolio>> getData1() async {
    setupHttpOverrides();
    try {
      final response = await _dio.get(
        portfolio,
        options: Options(
          headers: {
            "Cookie":
                "csrftoken=${MySharedPreferences().getCsrfToken(await SharedPreferences.getInstance())}; sessionid=${MySharedPreferences().getSessionId(await SharedPreferences.getInstance())}",
            "X-CSRFToken": MySharedPreferences()
                .getCsrfToken(await SharedPreferences.getInstance())
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        print(response);
        final List<dynamic> data = response.data;

        final filteredData =
            data.where((item) => item['sub_cat'] == 1).toList();

        return filteredData.map((item) => Portfolio.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Handle DioError related to bad response
        throw Exception(
            "Error: ${e.response!.statusCode} - ${e.response!.statusMessage}");
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        // Handle DioError related to timeout
        throw Exception("Error: Timeout occurred while fetching data");
      } else {
        // Handle other DioErrors
        throw Exception('Error: $e');
      }
    } catch (e) {
      // Handle generic exceptions
      throw Exception('Error: $e');
    }
  }

  Future<List<Portfolio>> getDataForCash() async {
    setupHttpOverrides();
    try {
      final response = await _dio.get(
        portfolio,
        options: Options(
          headers: {
            "Cookie":
                "csrftoken=${MySharedPreferences().getCsrfToken(await SharedPreferences.getInstance())}; sessionid=${MySharedPreferences().getSessionId(await SharedPreferences.getInstance())}",
            "X-CSRFToken": MySharedPreferences()
                .getCsrfToken(await SharedPreferences.getInstance())
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final filteredData =
            data.where((item) => item['sub_cat'] == 2).toList();

        return filteredData.map((item) => Portfolio.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Handle DioError related to bad response
        throw Exception(
            "Error: ${e.response!.statusCode} - ${e.response!.statusMessage}");
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        // Handle DioError related to timeout
        throw Exception("Error: Timeout occurred while fetching data");
      } else {
        // Handle other DioErrors
        throw Exception('Error: $e');
      }
    } catch (e) {
      // Handle generic exceptions
      throw Exception('Error: $e');
    }
  }

  // Future<bool> getDataForLoan() async {
  //   setupHttpOverrides();
  //   try {
  //     final response = await _dio.get(
  //       portfolio,
  //       options: Options(
  //         headers: {
  //           "Cookie":
  //               "csrftoken=${MySharedPreferences().getCsrfToken(await SharedPreferences.getInstance())}; sessionid=${MySharedPreferences().getSessionId(await SharedPreferences.getInstance())}",
  //           "X-CSRFToken": MySharedPreferences()
  //               .getCsrfToken(await SharedPreferences.getInstance())
  //         },
  //         sendTimeout: const Duration(seconds: 10),
  //         receiveTimeout: const Duration(seconds: 10),
  //       ),
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data;

  //       final filteredData =
  //           data.where((item) => item['sub_cat'] == 3).toList();
  //       for (var db in filteredData) {
  //         var local = Portfolio.fromJson(db);

  //         LocalDatabase.insertPortfolioData(local);
  //       }
  //         LocalDatabase.insertSavedTime(3);

  //       // return filteredData.map((item) => Portfolio.fromJson(item)).toList();
  //       return true;
  //     } else {
  //       print('Failed to load data${response.statusCode}');
  //       return false;
  //     }
  //   } on DioException catch (e) {
  //     if (e.type == DioExceptionType.badResponse && e.response != null) {
  //       // Handle DioError related to bad response
  //       throw Exception(
  //           "Error: ${e.response!.statusCode} - ${e.response!.statusMessage}");
  //     } else if (e.type == DioExceptionType.connectionTimeout ||
  //         e.type == DioExceptionType.receiveTimeout) {
  //       // Handle DioError related to timeout
  //       throw Exception("Error: Timeout occurred while fetching data");
  //     } else {
  //       // Handle other DioErrors
  //       throw Exception('Error: $e');
  //     }
  //   } catch (e) {
  //     // Handle generic exceptions
  //     throw Exception('Error: $e');
  //   }
  // }
  // Future<void> removeCachedData() async {
  //   await APICacheManager().deleteCache("Get_Loan");
  // }

  Future<List<Portfolio>> getDataForLoan() async {
    setupHttpOverrides();

    try {
      final response = await _dio.get(
        portfolio,
        options: Options(
          headers: {
            "Cookie":
                "csrftoken=${MySharedPreferences().getCsrfToken(await SharedPreferences.getInstance())}; sessionid=${MySharedPreferences().getSessionId(await SharedPreferences.getInstance())}",
            "X-CSRFToken": MySharedPreferences()
                .getCsrfToken(await SharedPreferences.getInstance())
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final filteredData =
            data.where((item) => item['sub_cat'] == 3).toList();

        return filteredData.map((item) => Portfolio.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Handle DioError related to bad response
        throw Exception(
            "Error: ${e.response!.statusCode} - ${e.response!.statusMessage}");
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        // Handle DioError related to timeout
        throw Exception("Error: Timeout occurred while fetching data");
      } else {
        // Handle other DioErrors
        throw Exception('Error: $e');
      }
    } catch (e) {
      // Handle generic exceptions
      throw Exception('Error: $e');
    }
  }

  Future<List<Portfolio>> getDataForTrip() async {
    setupHttpOverrides();
    try {
      final response = await _dio.get(
        portfolio,
        options: Options(
          headers: {
            "Cookie":
                "csrftoken=${MySharedPreferences().getCsrfToken(await SharedPreferences.getInstance())}; sessionid=${MySharedPreferences().getSessionId(await SharedPreferences.getInstance())}",
            "X-CSRFToken": MySharedPreferences()
                .getCsrfToken(await SharedPreferences.getInstance())
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final filteredData =
            data.where((item) => item['sub_cat'] == 4).toList();
        return filteredData.map((item) => Portfolio.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Handle DioError related to bad response
        throw Exception(
            "Error: ${e.response!.statusCode} - ${e.response!.statusMessage}");
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        // Handle DioError related to timeout
        throw Exception("Error: Timeout occurred while fetching data");
      } else {
        // Handle other DioErrors
        throw Exception('Error: $e');
      }
    } catch (e) {
      // Handle generic exceptions
      throw Exception('Error: $e');
    }
  }

  Future<List<Portfolio>> getDataForChart() async {
    setupHttpOverrides();
    try {
      final response = await _dio.get(
        portfolio,
        options: Options(
          headers: {
            "Cookie":
                "csrftoken=${MySharedPreferences().getCsrfToken(await SharedPreferences.getInstance())}; sessionid=${MySharedPreferences().getSessionId(await SharedPreferences.getInstance())}",
            "X-CSRFToken": MySharedPreferences()
                .getCsrfToken(await SharedPreferences.getInstance())
          },
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final filteredData = data
            .where(
              (item) =>
                  item['sub_cat'] == 0 ||
                  item['sub_cat'] == 1 ||
                  item['sub_cat'] == 2 ||
                  item['sub_cat'] == 3 ||
                  item['sub_cat'] == 4,
            )
            .toList();
        return filteredData.map((item) => Portfolio.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse && e.response != null) {
        // Handle DioError related to bad response
        throw Exception(
            "Error: ${e.response!.statusCode} - ${e.response!.statusMessage}");
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        // Handle DioError related to timeout
        throw Exception("Error: Timeout occurred while fetching data");
      } else {
        // Handle other DioErrors
        throw Exception('Error: $e');
      }
    } catch (e) {
      // Handle generic exceptions
      throw Exception('Error: $e');
    }
  }
}
