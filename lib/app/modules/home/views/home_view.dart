import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List View (DataTables)'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
        width: double.maxFinite,
        alignment: Alignment.center,
        child: Obx(
          () => controller.isLoading.isTrue
              ? Center(
                  child: LoadingAnimationWidget.discreteCircle(color: Colors.blueAccent, size: 50.w),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _dataTablesContent(),
                    _optionBelowDataTables(),
                  ],
                ),
        ),
      ),
    );
  }

  SizedBox _dataTablesContent() {
    return SizedBox(
      height: 400.h,
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: Colors.blue,
          filterIconColor: Colors.white,
          filterIconHoverColor: Colors.red,
          rowHoverColor: Colors.yellow,
          rowHoverTextStyle: const TextStyle(color: Colors.red, fontSize: 14),
        ),
        child: SfDataGrid(
          allowFiltering: true,
          onFilterChanged: (value) {
            controller.calculateDataAfterFilter(value.column.columnName, value.filterConditions.first.value.toString());
          },
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          source: controller.fakeDataSource,
          columns: <GridColumn>[
            GridColumn(
              columnName: 'userId',
              filterPopupMenuOptions: const FilterPopupMenuOptions(canShowSortingOptions: false),
              label: Container(
                padding: const EdgeInsets.all(6.0),
                alignment: Alignment.center,
                child: const Text(
                  'User ID',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            GridColumn(
              columnName: 'id',
              filterPopupMenuOptions: const FilterPopupMenuOptions(canShowSortingOptions: false, filterMode: FilterMode.checkboxFilter),
              label: Container(
                padding: const EdgeInsets.all(6.0),
                alignment: Alignment.center,
                child: const Text(
                  'ID',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            GridColumn(
              columnName: 'title',
              filterPopupMenuOptions: const FilterPopupMenuOptions(canShowSortingOptions: false, filterMode: FilterMode.checkboxFilter),
              label: Container(
                padding: const EdgeInsets.all(18.0),
                alignment: Alignment.center,
                child: const Text(
                  'Title',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            GridColumn(
              columnName: 'body',
              filterPopupMenuOptions: const FilterPopupMenuOptions(canShowSortingOptions: false, filterMode: FilterMode.checkboxFilter),
              label: Container(
                padding: const EdgeInsets.all(18.0),
                alignment: Alignment.center,
                child: const Text(
                  'Body',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _optionBelowDataTables() {
    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        itemBorderWidth: 0.5,
        itemBorderColor: Colors.grey.shade400,
        itemBorderRadius: BorderRadius.circular(5),
        selectedItemColor: Colors.blue.shade500,
      ),
      child: SfDataPager(
        visibleItemsCount: controller.itemsCount.value,
        navigationItemWidth: 20.w,
        delegate: controller.fakeDataSource,
        pageCount: ((controller.fakeDataList.length / controller.rowsPerPage.value).ceil()).toDouble(),
        availableRowsPerPage: controller.rowsPage,
        onRowsPerPageChanged: (int? rowsPerPage) {
          controller.rowsPerPage.value = rowsPerPage!;
        },
        pageItemBuilder: (String itemName) {
          if (Get.width >= 1343) {
            if (itemName == 'Next') {
              return const Center(child: Text('Next'));
            }
            if (itemName == 'Previous') {
              return const Center(child: Text('Previous'));
            }
          }
          return null;
        },
      ),
    );
  }
}
