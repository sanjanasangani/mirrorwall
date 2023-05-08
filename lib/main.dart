import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mirrorwall/Providers/Connectivity_providers.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ConnectivityProvider(),
      )
    ],
    builder: (context, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Mirror_wall(),
      );
    },
  ));
}

class Mirror_wall extends StatefulWidget {
  const Mirror_wall({Key? key}) : super(key: key);

  @override
  State<Mirror_wall> createState() => _Mirror_wallState();
}

class _Mirror_wallState extends State<Mirror_wall> {

  void initState() {
    super.initState();
    Provider.of<ConnectivityProvider>(context, listen: false)
        .checkInternetConnectivity();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue
      ),
          onRefresh: () async {
        await mywebcontroller?.reload();
        await Future.delayed(Duration(seconds: 1));
        pullToRefreshController?.endRefreshing();
    }
    );

  }

  late InAppWebViewController mywebcontroller;
  late PullToRefreshController pullToRefreshController;
  String myurl =
      'https://www.google.com/search?gs_ssp=eJzj4tTP1TcwMU02T1JgNGB0YPBiS8_PT89JBQBASQXT&q=google&oq=goo&aqs=chrome.2.69i57j35i39i650j46i131i199i433i465i512j0i131i433i512j0i433i512j0i131i433i512l2j0i433i512j0i131i433i512j0i512.1862j0j15&sourceid=chrome&ie=UTF-8';
  String data = '';
  String SelectedOption = '';
  String urlBookmark = "";
  List CBookMark = [];
  List CurlBookmark = [];
  TextEditingController SearchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert, color: Colors.white),
               itemBuilder: (context)=>[
             PopupMenuItem(
               value: "item1",
               child: Row(
                 children: [
                   const Icon(Icons.bookmark,
                       color: Colors.black),
                   SizedBox(
                     width: 10,
                   ),
                   const Text("All BookMark"),
                 ],
               ),
             ),
                 PopupMenuItem(
                   value: "item2",
                   child: Row(
                     children: [
                       const Icon(Icons.screen_search_desktop_outlined, color: Colors.black),
                       SizedBox(
                         width:10,
                       ),
                       const Text("Search Engine"),
                     ],
                   ),
                 ),
           ],
              onSelected: (selectedOption) {
                setState(() {
                  SelectedOption = selectedOption;
                });
                if (selectedOption == "item1") {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        height: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 300,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          icon: Icon(
                                            Icons.close,
                                          ),
                                        ),
                                        Text(
                                          "Dismiss",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Container(
                                child: ListView.builder(
                                  itemCount: CurlBookmark.length,
                                  itemBuilder: (context, i) => ListTile(
                                    title: Text("${CBookMark[i]}"),
                                    subtitle: Text("${CurlBookmark[i]}"),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          CBookMark.remove(CBookMark[i]);
                                          CurlBookmark.remove(CurlBookmark[i]);
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (selectedOption == "item2") {
                  setState(() {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Search Engine"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RadioListTile(
                              title: Text("Google"),
                              value: "https://www.google.com/",
                              groupValue: myurl,
                              onChanged: (val) {
                                setState(() {
                                  SearchController.clear();
                                  myurl = val!;
                                });
                                mywebcontroller!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.parse(myurl),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                            RadioListTile(
                              title: Text("Yahoo"),
                              value: "https://in.search.yahoo.com/?fr2=inr",
                              groupValue: myurl,
                              onChanged: (val) {
                                setState(() {
                                  SearchController.clear();
                                  myurl = val!;
                                });
                                mywebcontroller!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.parse(myurl),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                            RadioListTile(
                              title: Text("Bing"),
                              value: "https://www.bing.com/",
                              groupValue: myurl,
                              onChanged: (val) {
                                setState(() {
                                  SearchController.clear();
                                  myurl = val!;
                                });
                                mywebcontroller!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.parse(myurl),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                            RadioListTile(
                              title: Text("Duck Duck Go"),
                              value: "https://duckduckgo.com/",
                              groupValue: myurl,
                              onChanged: (val) {
                                setState(() {
                                  SearchController.clear();
                                  myurl = val!;
                                });
                                mywebcontroller!.loadUrl(
                                  urlRequest: URLRequest(
                                    url: Uri.parse(myurl),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }
              },
    )],

        title: Text("Mirror_wall"),
        centerTitle: true,
      ),
      body: (Provider.of<ConnectivityProvider>(context)
          .connectivityModel
          .Connectivitystatus ==
          "waiting")
          ? Center(
        child: Text(
          "Offline",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      )
          : InAppWebView(
        pullToRefreshController: pullToRefreshController,
        onLoadStart: (controller ,uri){
          setState(() {
            mywebcontroller = controller;
            urlBookmark = myurl.toString();
          });
        },
        onLoadStop: (controller, url) async {
          await pullToRefreshController?.endRefreshing();
        },
        initialUrlRequest: URLRequest(
            url: Uri.parse(myurl)
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: SearchController,
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search,
                color: Colors.black,
              ),
              hintText: "Search or type web address",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          onChanged: (val) {
            setState(() {
              data = val;
            });
          },

          onSubmitted: (v) {
            String controller = SearchController.text;
            myurl = 'https://www.google.com/search?gs_ssp=eJzj4tTP1TcwMU02T1JgNGB0YPBiS8_PT89JBQBASQXT&q=$data&oq=$data&aqs=chrome.2.69i57j35i39i650j46i131i199i433i465i512j0i131i433i512j0i433i512j0i131i433i512l2j0i433i512j0i131i433i512j0i512.1862j0j15&sourceid=chrome&ie=UTF-8';
            mywebcontroller.loadUrl(
                urlRequest: URLRequest(url: Uri.parse(myurl)));
          },
        ),
      ),
      bottomNavigationBar: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              mywebcontroller?.goBack();
            },
          ),
          SizedBox(width: 3,),
          IconButton(
            onPressed: () async {
              setState(() async {
                CBookMark.add(
                    await mywebcontroller?.getTitle(),
                );
                CurlBookmark.add(
                await mywebcontroller?.getUrl(),
                );
              });
              },
            icon: Icon(Icons.bookmark_add_outlined),
          ),
          SizedBox(width: 3,),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () async {
              if(await mywebcontroller!.canGoBack()) {
              await mywebcontroller?.goBack();
              }
            },
          ),
          SizedBox(width: 3,),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () async {
              if(await mywebcontroller!.canGoForward()) {
                await mywebcontroller?.goForward();
              }
              },
          ),
          SizedBox(width: 3,),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              mywebcontroller?.reload();
            },
          ),
        ],
      ),
    );
  }
}
