import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:financial_apps/database/api_endpoints.dart';
import 'package:financial_apps/models/category_model.dart';
import 'package:financial_apps/models/history_model.dart';
import 'package:financial_apps/models/total_per_type_model.dart';

class RemoteDataSource {
  // ===================== CATEGORY =====================
  // SAVE CATEGORY
  static Future<bool> saveCategory(dynamic data) async {
    try {
      var url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.savecategories;
      Response response = await Dio().post(url,
          data: jsonEncode(data),
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  // UPDATE CATEGORY STATUS
  static Future<bool> updateCategory(int id, dynamic data) async {
    try {
      data['id'] = id;
      var url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.updateCategory;
      Response response = await Dio().post(url,
          data: jsonEncode(data),
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  static Future<bool> updateStatusCategory(int id, bool status) async {
    try {
      var rawFormat = jsonEncode({'id': id, 'status': !status});
      var url = ApiEndPoints.baseUrl +
          ApiEndPoints.authEndpoints.updatecategorystatus;
      Response response = await Dio().post(url,
          data: rawFormat,
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  //DELETE CATEGORY
  static Future<bool> deleteCategory(int id) async {
    try {
      var rawFormat = jsonEncode({'id': id});
      var url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.deletecategory;
      Response response = await Dio().post(url,
          data: rawFormat,
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (error) {
      return false;
    }
  }

  // LIST CATEGORIES
  static Future<List<CategoryModel>?> listCategories(Object kategori) async {
    try {
      var rawFormat = jsonEncode({'kategori': kategori});
      var url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.listcategories;
      Response response = await Dio().post(url,
          data: rawFormat,
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((e) => CategoryModel.fromJson(e)).toList();
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // CATEGORY DETAIL
  static Future<CategoryModel?> detailCategory(int id) async {
    try {
      var url =
          ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.detailcategory;
      final response = await Dio().get('$url?id=$id');
      if (response.statusCode == 200) {
        dynamic jsonData = response.data;
        return CategoryModel.fromJson(jsonData);
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // ===================== TRANSACTION =====================
  static Future<TotalPerTypeModel?> totalPerType() async {
    try {
      var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.totalpertype;
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final TotalPerTypeModel res = TotalPerTypeModel.fromJson(response.data);
        return res;
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<FinancialHistoryModel?> history(String kategori) async {
    try {
      var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.history;
      final response = await Dio().get('$url?kategori=$kategori');
      if (response.statusCode == 200) {
        final FinancialHistoryModel res =
            FinancialHistoryModel.fromJson(response.data);
        return res;
      }
      return null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<FinancialHistoryModel?> historyByDate(
      DateTime startdate,
      DateTime enddate,
      DateTime singledate,
      bool checksingledate,
      Object kategori) async {
    try {
      var rawFormat = (jsonEncode({
        'startDate': startdate.toString(),
        'endDate': enddate.toString(),
        'singleDate': singledate.toString(),
        'checkSingleDate': checksingledate,
        'kategori': kategori
      }));
      var url = ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.historybydate;
      Response response = await Dio().post(url,
          data: rawFormat,
          options: Options(
            contentType: Headers.jsonContentType,
          ));
      if (response.statusCode == 200) {
        final FinancialHistoryModel res =
            FinancialHistoryModel.fromJson(response.data);
        return res;
      }
      return null;
    } catch (e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }
}
