import 'package:date_format/date_format.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gsy_github_app_flutter/common/style/m_style.dart';
import 'package:numberpicker/numberpicker.dart';

/**
 * Created by mai on 2019-12-18.
 */
class BirthdayDialog extends StatefulWidget {
  @override
  _BirthdayDialogState createState() => _BirthdayDialogState();
}

/*区分年月日选择器*/
enum NUM_TYPE {
  NUM_TYPE_YEAR,
  NUM_TYPE_MONTH,
  NUM_TYPE_DAY,
}

class _BirthdayDialogState extends State<BirthdayDialog> {
  /*最下年份*/
  int _minYear = 2000;

  /*最大年份*/
  int _maxYear = 2019;

  /*当前选中年份*/
  int _seleYear = 2000;

  /*最小月份*/
  int _minMonth = 1;

  /*最大月份*/
  int _maxMonth = 12;

  /*当前选中月份*/
  int _seleMonth = 1;

  /*最小日*/
  int _minDay = 1;

  /*最大日*/
  int _maxDay = 30;

  /*当前选中日*/
  int _seleDay = 1;

  /*当前年份*/
  int _currentYear = 0;

  /*当前月份*/
  int _currentMonth = 0;

  /*当前日*/
  int _currentDay = 0;

  List<String> monthEN = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  void initState() {
    // TODO: implement initState
    MConstant.birthDaySet = "";
    MConstant.birthDaySetEN = "";
    _getCurrentDate(); //获取当前时间
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: 200,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: new NumberPicker.integer(
                                initialValue: _seleMonth,
                                minValue: _minMonth,
                                maxValue: _maxMonth,
                                changeValueCallback: (value) {
                                  return monthEN[value - 1];
                                },
                                onChanged: (n) {
                                  _numChanged(n, NUM_TYPE.NUM_TYPE_MONTH);
                                }),
                          ),
                          Expanded(
                            flex: 1,
                            child: new NumberPicker.integer(
                                initialValue: _seleDay,
                                minValue: _minDay,
                                maxValue: _maxDay,
                                onChanged: (n) {
                                  _numChanged(n, NUM_TYPE.NUM_TYPE_DAY);
                                }),
                          ),
                          Expanded(
                            flex: 1,
                            child: new NumberPicker.integer(
                                initialValue: _seleYear,
                                minValue: _minYear,
                                maxValue: _maxYear,
                                itemExtent: 50,
                                infiniteLoop: false,
                                onChanged: (n) {
                                  _seleYear = n;
                                  _numChanged(n, NUM_TYPE.NUM_TYPE_YEAR);
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*选择器变化时*/
  void _numChanged(int newNum, NUM_TYPE type) {
    setState(() {
      if (type == NUM_TYPE.NUM_TYPE_YEAR) {
        _seleYear = newNum;
        if (_seleYear == _currentYear) {
          //选到了今年
          _maxMonth = 12;
          if (_seleMonth >= _currentMonth) {
            //选中月份大于当前月份
            _seleMonth = _currentMonth;
            if (_seleDay > _currentDay) {
              //选中日大于当前日
              _seleDay = _currentDay;
              _maxDay = _currentDay;
            }
          }
        } else {
          //如果当前选择的不是当前年份
          _maxMonth = 12;
          //根据年点年份月份获取当前月天数
          _maxDay = getDaysNum(_seleYear, _seleMonth);
          if (_seleDay > _maxDay) {
            //如果当前选中日大于当前日
            _seleDay = _maxDay;
          }
        }
      } else if (type == NUM_TYPE.NUM_TYPE_MONTH) {
        //选择月份
        _seleMonth = newNum;
        if (_seleMonth == _currentMonth && _seleYear == _currentYear) {
          _maxDay = _currentDay;
        } else {
          _maxDay = getDaysNum(_seleYear, _seleMonth);
        }
        if (_seleDay > _maxDay) {
          //如果当前选中日大于当前日
          _seleDay = _maxDay;
        }
      } else if (type == NUM_TYPE.NUM_TYPE_DAY) {
        //选择日
        _seleDay = newNum;
      }
    });

    MConstant.birthDaySetEN = monthEN[_seleMonth - 1] +
        " " +
        _digits(_seleDay, 2) +
        " " +
        '$_seleYear';

    MConstant.birthDaySet = '$_seleYear' +
        "-" +
        _digits(_seleMonth, 2) +
        "-" +
        _digits(_seleDay, 2);
  }

  String _digits(int value, int length) {
    String ret = '$value';
    if (ret.length < length) {
      ret = '0' * (length - ret.length) + ret;
    }
    return ret;
  }

  /*获取当前时间*/
  void _getCurrentDate() {
    DateTime dateTime;

    String birthDay = MConstant.birthDay;
    print("初始化$birthDay");
    List<String> birs = birthDay.split(" ");
    if (birs.length == 3) {
      dateTime = new DateTime(
          int.parse(birs[2]), monthEN.indexOf(birs[0]) + 1, int.parse(birs[1]));
    } else {
      dateTime = DateTime.now();
    }

    _currentYear = int.parse(formatDate(DateTime.now(), [yyyy]));
    _currentMonth = int.parse(formatDate(DateTime.now(), [mm]));
    _currentDay = int.parse(formatDate(DateTime.now(), [dd]));
    _seleYear =  int.parse(formatDate(dateTime, [yyyy]));
    _seleMonth = int.parse(formatDate(dateTime, [mm]));
    _seleDay = int.parse(formatDate(dateTime, [dd]));
    print("选中时间：${_seleYear}-${_seleMonth}-${_seleDay}");

    print("当前时间：${_currentYear}-${_currentMonth}-${_currentDay}");
    setState(() {
      _seleYear =  int.parse(formatDate(dateTime, [yyyy]));
      _seleMonth = int.parse(formatDate(dateTime, [mm]));
      _seleDay = int.parse(formatDate(dateTime, [dd]));

      _maxYear = _currentYear;
//      _maxMonth = _currentMonth;
      _maxDay = getDaysNum(_seleYear, _seleMonth);
    });

  }

  /*根据年份月份获取当前月有多少天*/
  int getDaysNum(int y, int m) {
    if (m == 1 || m == 3 || m == 5 || m == 7 || m == 8 || m == 10 || m == 12) {
      return 31;
    } else if (m == 2) {
      if (((y % 4 == 0) && (y % 100 != 0)) || (y % 400 == 0)) {
        //闰年 2月29
        return 29;
      } else {
        //平年 2月28
        return 28;
      }
    } else {
      return 30;
    }
  }
}
