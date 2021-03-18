import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(_) => MaterialApp(home: Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(title: Text('percent_indicator demo')),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => TablePage(),
          )),
          child: Icon(Icons.arrow_right_alt),
        ),
      );

  Widget _buildBody() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularPercentIndicator(
            radius: 100, //圆的半径
            percent: 0.56,
            animation: true,
            animationDuration: 1000,
            lineWidth: 8.0, //ring粗细
            // fillColor: Colors.purple, //rectangle的color
            backgroundColor: Colors.red, //remain color
            progressColor: Colors.deepPurple,
            circularStrokeCap: CircularStrokeCap.round, //圆角
            center: Text('控球率'),
            // linearGradient: LinearGradient(
            //   colors: [Colors.orange, Colors.white],
            // ), //线性渐变的 progressColor
            // arcType: ArcType.FULL, //只要上半环
            // arcBackgroundColor: Colors.yellow,
            // reverse: true, //progress和remain对调
            // widgetIndicator: SizedBox(
            //   child: VerticalDivider(color: Colors.orange, thickness: 2),
            // ),
          ),
          SizedBox(height: 20),
          LinearPercentIndicator(
            alignment: MainAxisAlignment.center,
            width: 150,
            percent: 0.2,
            progressColor: Colors.red,
            backgroundColor: Colors.deepPurple,
            leading: Text('83'),
            trailing: Text('81'),
            center: Text('进攻', style: TextStyle(color: Colors.white)),
            lineHeight: 20,
            padding: EdgeInsets.symmetric(horizontal: 15),
          ),
        ],
      );
}

class TablePage extends StatefulWidget {
  @override
  _TablePageState createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
  //data field
  List<Foo> foos = <Foo>[];
  FooDataSource fooDs;
  Image image = Image.asset(
    'assets/images/h5_icon_bollom.png',
    width: 20,
    height: 20,
    fit: BoxFit.cover,
  );

  //method
  @override
  void initState() {
    super.initState();
    foos = [
      Foo(2, 'bob', 'tom'),
      Foo(2, 'bob', 'tom'),
      Foo(2, 'bob', 'tom'),
      Foo(2, 'bob', 'tom'),
      Foo(2, 'bob', 'tom'),
    ];
    fooDs = FooDataSource(foos);
  }

  @override
  Widget build(_) => Scaffold(
        appBar: AppBar(title: Text('TablePage')),
        body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: SfDataGrid(
              source: fooDs,
              cellBuilder: (_, column, i) =>
                  column.mappingName == 'image' ? image : '',
              columns: [
                GridNumericColumn(
                  mappingName: 'alice',
                  headerText: '表头', //这儿可以自定义表头，不写就是默认的alice
                ),
                GridTextColumn(mappingName: 'bob'),
                GridTextColumn(mappingName: 'tom'),
                GridWidgetColumn(
                  mappingName: 'image',
                  headerText: '图片',
                ), //要与cellBuilder搭配使用,自定义组件的数据也非datasource中绑定的，是通过cellBuilder方法动态生成的
              ],
            ),
          ),
        ),
      );
}

class Foo {
  final int alice;
  final String bob;
  final String tom;
  Foo(this.alice, this.bob, this.tom);
}

class FooDataSource extends DataGridSource<Foo> {
  List<Foo> _foos;
  FooDataSource(List<Foo> foos) {
    _foos = foos;
  }
  @override
  List<Foo> get dataSource => _foos;
  @override
  Object getValue(Foo data, String columnName) {
    switch (columnName) {
      case 'alice':
        return data.alice;
        break;
      case 'bob':
        return data.bob;
        break;
      case 'tom':
        return data.tom;
        break;
      default:
        return '';
        break;
    }
  }
}
