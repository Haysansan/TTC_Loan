import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apploan/core/core.dart';
import 'package:apploan/models/models.dart';

class CustomerDetailView extends StatelessWidget {
  const CustomerDetailView({Key? key, required this.client}) : super(key: key);

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(
        title: LocaleKeys.customers.tr,
        onBack: () => Navigator.pop(context),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Header(client: client),
          16.height,
          _IdCardSection(client: client),
          16.height,
          _InfoSection(
            title: 'personalInformation'.tr,
            rows: [
              _DetailRow(label: 'clientCode'.tr, value: client.client_code),
              _DetailRow(label: 'firstName'.tr, value: client.first_name),
              _DetailRow(label: 'lastName'.tr, value: client.last_name),
              _DetailRow(label: 'gender'.tr, value: client.gender),
              _DetailRow(
                label: 'mobile'.tr,
                value: client.mobile,
                onTap:
                    client.mobile.isNotEmpty && client.mobile != 'N/A'
                        ? () => UrlLauncherManager.call(client.mobile)
                        : null,
              ),
              _DetailRow(label: 'email'.tr, value: client.email),
              _DetailRow(label: 'address'.tr, value: client.address),
            ],
          ),
          12.height,
          _InfoSection(
            title: 'loanBranchInfo'.tr,
            rows: [
              _DetailRow(label: 'branch'.tr, value: client.branch),
              _DetailRow(label: 'staff'.tr, value: client.staff),
              _DetailRow(
                label: 'loanOfficerId'.tr,
                value: client.loan_officer_id,
              ),
              _DetailRow(label: 'externalId'.tr, value: client.external_id),
            ],
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.client});

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 72,
              height: 72,
              color: AppColor.softPink,
              child:
                  client.photo.isNotEmpty
                      ? CustomNetworkImage(
                        imageUrl: client.photo,
                        width: 72,
                        height: 72,
                      )
                      : const Icon(
                        Icons.person,
                        size: 36,
                        color: AppColor.primary,
                      ),
            ),
          ),
          12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(client.displayName, style: AppTextStyle.mediumPrimaryBold),
                4.height,
                Text(client.client_code, style: AppTextStyle.normalGreyRegular),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IdCardSection extends StatelessWidget {
  const _IdCardSection({required this.client});

  final ClientModel client;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('idCardPhoto'.tr, style: AppTextStyle.normalPrimaryBold),
          12.height,
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: 180,
              color: AppColor.softPink,
              child:
                  client.id_card_photo.isNotEmpty
                      ? CustomNetworkImage(
                        imageUrl: client.id_card_photo,
                        width: double.infinity,
                        height: 180,
                        fit: BoxFit.cover,
                      )
                      : const Icon(
                        Icons.badge,
                        size: 48,
                        color: AppColor.primary,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  const _InfoSection({required this.title, required this.rows});

  final String title;
  final List<_DetailRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyle.normalPrimaryBold),
          12.height,
          for (int i = 0; i < rows.length; i++) ...[
            rows[i],
            if (i != rows.length - 1) 10.height,
          ],
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, this.onTap});

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(label, style: AppTextStyle.normalGreyRegular),
        ),
        Expanded(
          flex: 3,
          child:
              onTap != null
                  ? GestureDetector(
                    onTap: onTap,
                    child: Text(
                      value,
                      style: AppTextStyle.normalPrimaryBold.copyWith(
                        color: AppColor.primary,
                      ),
                    ),
                  )
                  : Text(value, style: AppTextStyle.normalPrimarySemiBold),
        ),
      ],
    );
  }
}
