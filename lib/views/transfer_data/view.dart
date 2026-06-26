import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';
import 'package:intl/intl.dart';

class TransferDataView extends GetView<TransferDataController> {
  const TransferDataView({Key? key}) : super(key: key);
  void onSearch() async {
    controller.sendDataToServer();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isLoading.value) {
          bool shouldClose = await showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text("Confirm Exit"),
                  content: Text(
                    "Data transfer is in progress. Are you sure you want to exit?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text("No"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text("Yes"),
                    ),
                  ],
                ),
          );
          return shouldClose;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.datatransfer.tr,
          onBack: () => Navigator.pop(context, false),
        ),
        bottomNavigationBar: AppBottomNav(items: controller.getItems()),
        body: SingleChildScrollView(
          child:
              UserRepository.shared.isEco
                  ? const _CashTransferToBmForm()
                  : Column(
                    children: [
                      20.height,
                      Obx(() {
                        if (controller.isLoadings.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFFFF0000),
                                  Color(0xFFFF8386),
                                  Color(0xFFFF0000),
                                ],
                              ),
                            ),
                            child: GlassStatsCard(
                              left: GlassStatItem(
                                label: LocaleKeys.totalClient.tr,
                                value: controller.clientCount.value.toString(),
                                count: '',
                              ),
                              right: GlassStatItem(
                                label: 'amount'.tr,
                                value:
                                    '៛${NumberFormat('#,##0').format(controller.totalRepaymentKhr.value)}',
                                count: '',
                              ),
                            ),
                          ),
                        );
                      }),
                      20.height,
                      Padding(
                        padding: UIConstants.spacing.padHorizontal,
                        child: Form(
                          key: controller.formKey,
                          child: Text(
                            LocaleKeys.waitUntilSuccess.tr,
                            style: AppTextStyle.normalRedBold,
                          ),
                        ),
                      ),
                      20.height,
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LinearProgressIndicator(
                                value: controller.progress.value,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.red,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                '${(controller.progress.value * 100).toStringAsFixed(0)}% ${'transferred'.tr}',
                              ),
                            ],
                          ),
                        );
                      }),
                      20.height,
                      Obx(() {
                        return PrimaryButton(
                          text: LocaleKeys.transfer.tr,
                          width: 100,
                          onPressed:
                              controller.isLoading.value ? null : onSearch,
                        );
                      }),
                    ],
                  ),
        ),
      ),
    );
  }
}

class _CashTransferToBmForm extends StatelessWidget {
  const _CashTransferToBmForm();

  @override
  Widget build(BuildContext context) {
    final c = Get.find<TransferDataController>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Form(
        key: c.cashTransferFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('transferCashToBM'.tr, style: AppTextStyle.normalPrimaryBold),
            16.height,
            LabeledField(
              label: 'branchManager'.tr,
              required: true,
              child: Obx(
                () => SearchDropDown<StaffModel>(
                  items: c.bmList,
                  itemAsString: (item) => item.full_name,
                  onChanged: c.onBmChanged,
                  selectedItem: c.selectedBM.value,
                  label: 'selectBM'.tr,
                ),
              ),
            ),
            16.height,
            LabeledField(
              label: 'amount'.tr,
              required: true,
              child: CustomTextField(
                controller: c.cashAmountCtl,
                keyboardType: TextInputType.number,
                hintText: '0',
                validator: (v) => FormValidator.empty(v),
              ),
            ),
            16.height,
            LabeledField(
              label: 'note'.tr,
              child: CustomTextField(
                controller: c.cashNoteCtl,
                hintText: 'optionalNote'.tr,
              ),
            ),
            16.height,
            Obx(
              () => PrimaryButton(
                text: 'sendToBM'.tr,
                onPressed:
                    c.isSubmittingCashTransfer.value
                        ? null
                        : c.submitCashTransferToBM,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
