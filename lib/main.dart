import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Future<bool> getWidget()  async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<bool> getWidget()  async{
      var connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult != ConnectivityResult.none;
  }

  void initState() {
    settimerout();
  }
  void settimerout(){
//    const timeout = const Duration(seconds: 10);
//    Timer(timeout, () {
//      //到时回调
//      setState(() {
//      });
//      print('afterTimer='+DateTime.now().toString());
//    });

    const period = const Duration(seconds: 10);
    Timer.periodic(period, (timer) {
      print("定时调用");
      print('currentTime='+DateTime.now().toString());
            setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return FutureBuilder<bool>(
          future:getWidget(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError ) {
                // 请求失败，显示错误
                return new MaterialApp(
                    home:
                    AlertDialog(
                      title: Text("提示"),
                      content: Text("检查到目前网络不畅通，请检查网络设置。我们将于10s之后再次检测"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("确定"),
                          onPressed: () => Navigator.of(context).pop(), //关闭对话框
                        ),
                      ],
                    )
                );
              } else{
                // 请求成功，显示数据
                print("result");
                print(snapshot.data);
                print(snapshot.connectionState);
                print("bbb");
                if(snapshot.data == true ){
                  return new MaterialApp(
                    routes: {
                      "/": (_) => new WebviewScaffold(
                        url: "http://www.necta.online/anfang/wall/shequ.html",
                        useWideViewPort: true,
                        displayZoomControls:true,
                        withOverviewMode: true,
                      ),
                    },
                  );
                }else{
//                  settimerout();
                  return new MaterialApp(
                      home: Builder(
                        builder: (context) =>
                            AlertDialog(
                          title: Text("提示"),
                          content: Text("检查到目前网络不畅通，请检查网络设置。我们将于10s之后再次检测"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("确定"),
                              onPressed: () => Navigator.of(context).pop(), //关闭对话框
                            ),
                          ],

                        ),
                      )
                  );

                }

              }
            }
            else {
              // 请求未结束，显示loading
                return CircularProgressIndicator();
            }

          }
      );


//    );
  }
}

