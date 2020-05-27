import 'package:azkar/models/args.dart';
import 'package:azkar/models/fehris_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts_arabic/fonts.dart';

class FehrisScreen extends StatefulWidget {
  @override
  _FehrisScreenState createState() => _FehrisScreenState();
}

class _FehrisScreenState extends State<FehrisScreen> {
  var list = <FehrisItemModel>[];

  @override
  void initState() {
    super.initState();

    setState(() {
      list.add(
        FehrisItemModel(
          title: "المقدمة",
          icon: "",
        ),
      );

      list.add(
        FehrisItemModel(
          title: "أذكار الصباح",
          icon: "",
        ),
      );

      list.add(
        FehrisItemModel(
          title: "أذكار المساء",
          icon: "",
        ),
      );

      list.add(
        FehrisItemModel(
          title: "أذكار الإستيقاظ",
          icon: "",
        ),
      );

      list.add(
        FehrisItemModel(
          title: "أذكار الخلاء",
          icon: "",
        ),
      );

      list.add(
        FehrisItemModel(
          title: "أذكار الوضوء",
          icon: "",
        ),
      );

      list.add(
        FehrisItemModel(
          title: "أذكار اللباس",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار دخول البيت والخروج",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار المسجد",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار الآذان",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار الصلاة",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار الركوع",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار السجود",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار القنوت",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار النوم",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "الأذكار والدعوات للأمور العارضة",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار المرض",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار الموت",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار الصلاة علي الميت",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار الصيام",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أدعية الحج والعمرة",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار المسافر",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار الغزو والجهاد",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار الأكل والشرب",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار العطاس",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار النكاح",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أذكار تتعلق باﻷمور العلوية",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "الأذكار المتفرقة",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "أولا:من القرآن الكريم",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "ثانيا:أذكار متفرقةمن السنة الشريفة",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "كفارة المجلس",
          icon: "",
        ),
      );
      
      list.add(
        FehrisItemModel(
          title: "الأدعية المطلقة",
          icon: "",
        ),
      );
      list.add(
        FehrisItemModel(
          title: "الأذكار المطلقة",
          icon: "",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          list.length,
          (int index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              duration: const Duration(milliseconds: 755),
              columnCount: 3,
              child: ScaleAnimation(
                child: FadeInAnimation(
                  child: buildItem(index),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildItem(int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              child: ListTile(
                title: Text(
                  list[index].title,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontFamily: ArabicFonts.Tajawal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    package: 'google_fonts_arabic',
                  ),
                ),
                //title: list.icon,
                onTap: () {
                  var args = setArgs(index);
                  Navigator.pushNamed(context, '/image-slider',
                      arguments: args);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Args setArgs(int index) {
    Args ret = Args();
    switch (index) {
      case 0:
        ret.start = 1;
        ret.end = 8;
        break;
      case 1:
        ret.start = 9;
        ret.end = 14;
        break;
      case 2:
        ret.start = 15;
        ret.end = 30;
        break;
      case 3:
        ret.start = 31;
        ret.end = 31;
        break;
      case 4:
        ret.start = 31;
        ret.end = 31;
        break;
      case 5:
        ret.start = 32;
        ret.end = 32;
        break;
      case 6:
        ret.start = 33;
        ret.end = 34;
        break;
      case 7:
        ret.start = 35;
        ret.end = 35;
        break;
      case 8:
        ret.start = 36;
        ret.end = 38;
        break;
      case 9:
        ret.start = 39;
        ret.end = 43;
        break;
      case 10:
        ret.start = 44;
        ret.end = 48;
        break;
      case 11:
        ret.start = 49;
        ret.end = 51;
        break;
      case 12:
        ret.start = 52;
        ret.end = 54;
        break;
      case 13:
        ret.start = 55;
        ret.end = 76;
        break;
      case 14:
        ret.start = 77;
        ret.end = 85;
        break;

      case 15:
        ret.start = 86;
        ret.end = 92;
        break;
      case 16:
        ret.start = 93;
        ret.end = 99;
        break;
      case 17:
        ret.start = 100; 
        ret.end = 104;
        break;
      case 18:
        ret.start = 105;
        ret.end = 108;
        break;
        case 19:
        ret.start = 109;
        ret.end = 110;
        break;
      case 20:
        ret.start = 111;
        ret.end = 128;
        break;
      case 21:
        ret.start = 129;
        ret.end = 135;
        break;
      case 22:
        ret.start = 136;
        ret.end = 139;
        break;

      case 23:
        ret.start = 140;
        ret.end = 142;
        break;
      case 24:
        ret.start = 143;
        ret.end = 144;
        break;
      case 25:
        ret.start = 145;
        ret.end = 147;
        break;
      case 26:
        ret.start = 148;
        ret.end = 149;
        break;
      case 27:
        ret.start = 150;
        ret.end = 150;
        break;
      case 28:
        ret.start = 150;
        ret.end = 153;
        break;
      case 29:
        ret.start = 154;
        ret.end = 161;
        break;
      case 30:
        ret.start = 161;
        ret.end = 161;
        break;
      case 31:
        ret.start = 162;
        ret.end = 192;
        break;
      case 32:
        ret.start = 193;
        ret.end = 215;
        break;
      // case 32:
      //   ret.start = 1;
      //   ret.end = 8;
      //   break;
      // case 33:
      //   ret.start = 1;
      //   ret.end = 8;
      //   break;
      default:
        ret.start = 1;
        ret.end = 8;
        break;
    }
    return ret;
  }
}
