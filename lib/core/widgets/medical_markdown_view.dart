import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:markdown/markdown.dart' as md;

/// ويدجت ذكي لعرض المخرجات الطبية سواء كانت بصيغة HTML أو Markdown
/// يعتمد على flutter_widget_from_html مع تنسيق Dark Theme مخصص للأجهزة والجداول الطبية.
class MedicalMarkdownView extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final bool isSelectable;

  const MedicalMarkdownView({
    super.key,
    required this.data,
    this.style,
    this.isSelectable = true,
  });

  String _prepareHtml(String input) {
    var raw = input.trim();
    if (raw.isEmpty) return '<p>لا توجد بيانات</p>';

    // إزالة أخطاء صياغة الذكاء الاصطناعي
    raw = raw.replaceAll('**:', '**');
    raw = raw.replaceAll(':**', '**');

    // فحص ما إذا كان النص يحتوي على وسوم HTML بالفعل
    final hasHtmlTags = RegExp(r'<[a-z][\s\S]*>', caseSensitive: false).hasMatch(raw);

    if (hasHtmlTags) {
      return raw;
    }

    // إذا كان ماركداون، نحوله إلى HTML مهيكل مع دعم الجداول (GitHub Flavored Markdown)
    return md.markdownToHtml(
      raw,
      extensionSet: md.ExtensionSet.gitHubFlavored,
    );
  }

  @override
  Widget build(BuildContext context) {
    final htmlContent = _prepareHtml(data);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: HtmlWidget(
        htmlContent,
        textStyle: style ??
            const TextStyle(
              fontFamily: 'Cairo',
              color: Color(0xFFE2E2E6),
              fontSize: 13.5,
              height: 1.7,
            ),
        customStylesBuilder: (element) {
          final tag = element.localName?.toLowerCase();

          switch (tag) {
            case 'table':
              return {
                'border': '1px solid #3C494E',
                'border-collapse': 'collapse',
                'width': '100%',
                'margin': '14px 0',
                'background-color': '#16181D',
              };

            case 'thead':
            case 'th':
              return {
                'background-color': '#1E2630',
                'color': '#00D2FF',
                'font-weight': 'bold',
                'font-size': '12.5px',
                'padding': '10px 8px',
                'border': '1px solid #3C494E',
                'text-align': 'center',
                'font-family': 'Cairo',
              };

            case 'tbody':
            case 'td':
              return {
                'padding': '9px 8px',
                'border': '1px solid #282A2D',
                'color': '#F0F0F3',
                'font-size': '12px',
                'text-align': 'center',
                'font-family': 'Cairo',
              };

            case 'h1':
              return {
                'color': '#00D2FF',
                'font-size': '18px',
                'font-weight': 'bold',
                'margin': '16px 0 8px 0',
                'font-family': 'Cairo',
              };

            case 'h2':
              return {
                'color': '#00D2FF',
                'font-size': '16px',
                'font-weight': 'bold',
                'margin': '14px 0 8px 0',
                'padding-bottom': '4px',
                'border-bottom': '1px solid rgba(0, 210, 255, 0.25)',
                'font-family': 'Cairo',
              };

            case 'h3':
              return {
                'color': '#EDB1FF',
                'font-size': '14.5px',
                'font-weight': 'bold',
                'margin': '12px 0 6px 0',
                'font-family': 'Cairo',
              };

            case 'p':
              return {
                'margin': '6px 0',
                'line-height': '1.7',
                'color': '#E2E2E6',
                'font-family': 'Cairo',
              };

            case 'strong':
            case 'b':
              return {
                'color': '#FFFFFF',
                'font-weight': 'bold',
                'font-family': 'Cairo',
              };

            case 'ul':
            case 'ol':
              return {
                'margin': '8px 0',
                'padding-inline-start': '20px',
                'font-family': 'Cairo',
              };

            case 'li':
              return {
                'margin': '4px 0',
                'color': '#E2E2E6',
                'font-family': 'Cairo',
              };

            case 'hr':
              return {
                'border': '0',
                'border-top': '1px solid #3C494E',
                'margin': '16px 0',
              };

            default:
              return null;
          }
        },
      ),
    );
  }
}
