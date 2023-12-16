import 'package:adamulti_mobile_clone_new/constant/constant.dart';
import 'package:adamulti_mobile_clone_new/locator.dart';
import 'package:adamulti_mobile_clone_new/model/carousel_data.dart';
import 'package:adamulti_mobile_clone_new/model/kategori_with_menu_response.dart';
import 'package:adamulti_mobile_clone_new/model/main_menu_mobile.dart';
import 'package:adamulti_mobile_clone_new/model/popup_response.dart';
import 'package:adamulti_mobile_clone_new/model/setting_kategori_response.dart';
import 'package:adamulti_mobile_clone_new/services/secure_storage.dart';
import 'package:dio/dio.dart';

class BackOfficeService {
  final _dio = Dio();

  Future<List<SettingKategoriResponse>> getSettingKategoriByKategori(String kategori) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.post("$baseUrlAuth/setting-kategori/kategori/many", data: {
      "kategori": kategori
    }, options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => SettingKategoriResponse.fromJson(e)).toList();
  }

  Future<List<MainMenuMobile>> getMainMenuMobile() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/menu-mobile/many", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => MainMenuMobile.fromJson(e)).toList();
  }

  Future<KategoriWithMenuResponse> getSpecificMenuByKategori(int id) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/setting-menu-kategori/with-menu/specific/$id", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return KategoriWithMenuResponse.fromJson(response.data);
  }
  
  Future<List<KategoriWithMenuResponse>> getAllMenuByKategoriExclude(int id) async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/setting-menu-kategori/with-menu/exclude/$id", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => KategoriWithMenuResponse.fromJson(e)).toList();
  }

  Future<PopupResponse> getPopupImage() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/setting-popup/1", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return PopupResponse.fromJson(response.data);
  }

  Future<List<CarouselData>> getCarouselImage() async {
    final token = await locator.get<SecureStorageService>().readSecureData("jwt");

    final response = await _dio.get("$baseUrlAuth/carousel/many", options: Options(
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${token!}'
      }
    ));

    return (response.data as List).map((e) => CarouselData.fromJson(e)).toList();
  }
  
}