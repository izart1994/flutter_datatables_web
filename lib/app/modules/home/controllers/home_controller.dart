import 'package:flutter/material.dart';
import 'package:flutter_website/app/data/models/fake_data_model.dart';
import 'package:flutter_website/app/data/repo/fake_data_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FakeDataRepository fakeDataRepo = FakeDataRepository();

  //// variables for home view =================
  RxList<FakeTitleBodyData> fakeDataList = <FakeTitleBodyData>[].obs;
  late FakeTitleBodyData fakeData;
  late FakeTitleBodyDataSource fakeDataSource;
  List<FakeTitleBodyData> get dataSource => fakeDataList;

  RxBool isLoading = false.obs;
  RxInt rowsPerPage = 10.obs;
  RxInt itemsCount = 3.obs;
  RxList<int> rowsPage = [10, 20, 30, 40, 50].obs;

  @override
  void onInit() {
    super.onInit();
    getFakeData();
  }

  @override
  void onClose() {
    super.onClose();
    fakeDataList = <FakeTitleBodyData>[].obs;
    fakeDataSource = FakeTitleBodyDataSource(fakeTitleBodyData: fakeDataList);
  }

  ///// get data from the fake data repo and change it to selected variables
  Future<void> getFakeData() async {
    isLoading(true);
    try {
      final response = await fakeDataRepo.getFakeTitleBodyData();
      if (response.data is List) {
        fakeDataList.value = (response.data as List).map((data) => FakeTitleBodyData.fromJson(data)).toList();
        fakeDataSource = FakeTitleBodyDataSource(fakeTitleBodyData: fakeDataList);
      }
      isLoading(false);
    } catch (e) {
      isLoading(false);
      rethrow;
    }
  }

  //// page display
  void calculateDataAfterFilter(String columnName, String dataFilter) {
    itemsCount.value = int.parse(((columnName == 'id'
                ? fakeDataList.where((e) => e.id.toString().contains(dataFilter)).length
                : columnName == 'userId'
                    ? fakeDataList.where((e) => e.userId.toString().contains(dataFilter)).length
                    : columnName == 'title'
                        ? fakeDataList.where((e) => e.title.toString().contains(dataFilter)).length
                        : fakeDataList.where((e) => e.body.toString().contains(dataFilter)).length) /
            10)
        .toString());
  }
}
