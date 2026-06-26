import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';
import 'package:apploan/views/views.dart';
import 'shared_coborrower_guarantor.dart';

class GuarantorFormSheet extends GetView<GuarantorController> {
  const GuarantorFormSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: Get.back,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'addGuarantors'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.grey),
                  onPressed: Get.back,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BorrowerFieldLabel('fullName'.tr, required: true),
                    _buildTextField(
                      controller.fullNameController,
                      'fullName'.tr,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BorrowerFieldLabel('dob'.tr),
                              BorrowerDatePickerField(
                                obs: controller.selectedDate,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BorrowerFieldLabel('gender'.tr),
                              BorrowerGenderDropdown(
                                selected: controller.selectedGender,
                                options: controller.genderOptions,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    BorrowerFieldLabel('phoneNumber'.tr, required: true),
                    _buildTextField(
                      controller.phoneController,
                      'phoneNumber'.tr,
                      keyboard: TextInputType.phone,
                    ),
                    const SizedBox(height: 20),
                    BorrowerFieldLabel('typeOfId'.tr, required: true),
                    BorrowerIdTypeDropdown<GuarantorIdTypeModel>(
                      selected: controller.selectedIdType,
                      items: controller.idTypes,
                    ),
                    const SizedBox(height: 20),
                    BorrowerFieldLabel('idNumber'.tr, required: true),
                    _buildTextField(
                      controller.nationalIdController,
                      'numbersId'.tr,
                      keyboard: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    BorrowerFieldLabel('relationship'.tr, required: true),
                    BorrowerIdTypeDropdown<GuarantorRelationshipModel>(
                      selected: controller.selectedRelationship,
                      items: controller.relationships,
                    ),
                    const SizedBox(height: 32),
                    BorrowerSubmitButton(onPressed: controller.submit),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController ctrl,
    String hint, {
    TextInputType? keyboard,
  }) {
    return TextFormField(
      controller: ctrl,
      keyboardType: keyboard,
      validator:
          (v) =>
              (v == null || v.trim().isEmpty) ? 'thisFieldIsRequired'.tr : null,
      decoration: borrowerInputDecoration(hint),
    );
  }
}
