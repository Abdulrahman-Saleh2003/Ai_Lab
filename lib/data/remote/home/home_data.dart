
import 'dart:io';

import 'package:ai_lab/core/class/crud.dart';
import 'package:ai_lab/core/constant/app_link_api.dart';

class HomeData {
  final Crud crud;

  HomeData({required this.crud});

  // ─── رفع الصورة (Multipart) ───
  Future postData({required File image}) async {

    print("____________________________________");

    print(    AppLinkApi.analyze);
    print("____________________________________");

    return await crud.addRequestWithImageOne(
      linkUrl: AppLinkApi.analyze,
      // ⚠️ مهم: عدّل "image" ليطابق تماماً اسم الحقل يلي الـ Django API
      // متوقعه (شوف serializer/view تبع /api/lab-reports/analyze/)
      nameRequest: "image",
      data: const {},
      image: image,
    );
  }

  // ─── سؤال السيرفر عن حالة التحليل (Polling) ───
  Future checkResult(String jobId) async {

    print("____________________________________");

    print(    "${AppLinkApi.result}$jobId/");
    print("____________________________________");

    return await crud.getData(
      linkUrl: "${AppLinkApi.result}$jobId/",
    );
  }

  // ─── جلب كل التقارير (سجل التحاليل السابقة) ───
  Future getAllReports() async {
    return await crud.getData(
      linkUrl: AppLinkApi.reports,
    );


  }



// ─── سؤال الشات عن تقرير محدد ───
  Future askReportQuestion({
    required String reportId,
    required String question,
  }) async {
    return await crud.postData(
      linkUrl: "${AppLinkApi.chatReportBase}$reportId/",
      data: {"question": question},
    );
  }
}