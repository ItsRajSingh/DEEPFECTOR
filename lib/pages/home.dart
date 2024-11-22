import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_flutter_app/pages/login_or_register.dart';
import 'package:first_flutter_app/util/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';
import '../model/movie.dart';

class MovieListView extends StatelessWidget {
  final List<Movie> movieList = Movie.getMovies();

  final List movies =
  [
    'Titanic',
    "Blade Runner",
    "Rambo",
    "The Avengers",
    "I am a Legend",
    "300",
    "The Wolf of Wall Street",
    "Interstellar",
    "Game of Thrones",
    "Vikings"


  ];
  final user = FirebaseAuth.instance.currentUser!;

  MovieListView({super.key});
  void signUserOut(BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop(); // Close loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully signed out')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginOrRegisterPage()), 
      );
    } catch (e) {
      Navigator.of(context).pop(); // Close loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign out failed: $e')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No user signed in')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=>signUserOut(context),
        icon: const Icon(Icons.logout))
        ],
        title: const Text(
          "CODEHEIST DETECTOR",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blue.shade50,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://i.pinimg.com/564x/03/79/76/037976f6d2e65a90ec0d1eff55051657.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text("You are signed in as : ${user.email!}", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                    const SizedBox(height: 350),
                    Card(
                      elevation: 4.5,
                      color: Colors.white,

                      child: ListTile(
                        title: const Center(
                          child: Text(
                            "Upload Video or Paste URL Here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetectorPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20), // Add some space between the tiles
                    Card(
                      elevation: 4.5,
                      color: Colors.white,
                      child: ListTile(
                        title: const Center(
                          child: Text(
                            "Allow interface to run in background",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetectorPage(),
                            ),
                          );
                          // Add your onTap functionality here
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

 /* MovieListViewDetails extends StatelessWidget {
  final String movieName;
  final Movie movie;





  const MovieListViewDetails({super.key, required this.movieName, required this.movie});
  //Key allows flutter to control how one widget replaces another widget


*/
class DetectorPage extends StatefulWidget {
  const DetectorPage({super.key});

  @override
  State<DetectorPage> createState() => _DetectorPageState();
}

class _DetectorPageState extends State<DetectorPage> {
  List<MediaFile> _selectedFiles = [];
  List<String> items = [];
  List<String> FilteredItems = [];

  void filterItems(String query) {
    FilteredItems =
        items.where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }

  @override
  void initState() {
    FilteredItems = items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Files to Detect "),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: _buildUI(),
      floatingActionButton: _selectImageFromGalleryButton(context),
      /* body: Center(
        child: Container(
          child : ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Go back ${this.movie.director}")
          )
        ),
      )
*/

    );
  }

  Widget _selectImageFromGalleryButton(context) {
    return FloatingActionButton(onPressed: () async {
      List<MediaFile> mediaFiles = await GalleryPicker.pickMedia(
          context: context,
          singleMedia: false) ?? [];
      setState(() {
        _selectedFiles = mediaFiles;
      });
    },
      child: const Icon(
        Icons.image,
      ),);
  }

  Widget _buildUI() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            onChanged: (value) {
              // Implement your search logic here
            },
          ),
        ),
        Expanded(
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 0,
              crossAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            itemCount: _selectedFiles.length,
            padding: const EdgeInsets.all(8),
            controller: ScrollController(),
            itemBuilder: (context, index) {
              MediaFile file = _selectedFiles[index];
              if (file.isImage) {
                return PhotoProvider(media: file, fit: BoxFit.fitHeight);
              } else if (file.isVideo) {
                return VideoProvider(media: file, width: 500, height: 500);
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}

  class BillSplitter extends StatefulWidget {
  const BillSplitter({super.key});

  @override
  State<BillSplitter> createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  final Color _purple = HexColor("#6908D6");

  calculateTotalTip(double billAmount, int splitBy, int tipPercentage){
    double totalTip = 0.0;

    if(billAmount<0 || billAmount.toString().isEmpty){

    }
    else{
      totalTip = (billAmount * tipPercentage)/ 100;

    }
    return totalTip;

  }
  calculateTotalPerPerson( double billAmount , int splitBy, int tipPercentage){
    var totalPerPerson = (calculateTotalTip(billAmount, splitBy,tipPercentage) + billAmount)/splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: MediaQuery
              .of(context)
              .size
              .height * 0.1),
          alignment: Alignment.center,
          color: Colors.white,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20.5),
            children: <Widget> [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: _purple.withOpacity(0.1), //Colors.pinkAccent.shade100,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(" Total Per Person ", style:
                        TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15.0,
                          color: _purple
                        )),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("${calculateTotalPerPerson(_billAmount,_personCounter,_tipPercentage)}", style: TextStyle(
                            fontSize: 34.9,
                            color: _purple,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                      ]),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.blueGrey.shade100,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        style: TextStyle(color: _purple), // Colors.grey),
                        decoration: InputDecoration(
                          prefixText: "Bill Amount",
                          prefixIcon: const Icon(Icons.attach_money),
                          iconColor: Colors.greenAccent.shade100,


                        ),
                        onChanged: (String value) {
                          try {
                            _billAmount = double.parse(value);
                          } catch (exception) {
                            _billAmount = 0.0;
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Split", style: TextStyle(
                              color: Colors.grey.shade700
                          ))
                          , Row(
                            children: <Widget>[
                              InkWell(
                                onTap: ()=>
                                setState(() {
                                  if (_personCounter > 1) {
                                    _personCounter--;
                                  }
                                  else {
                                    //do nothing
                                  }
                                }),
                             child: Container(
                               width: 40,
                               height: 40,
                               margin: const EdgeInsets.all(10.0),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(7.0),
                                 color: _purple.withOpacity(0.1)
                               ),
                               child: Center(
                                 child: Text(
                                   "-",style: TextStyle(
                                   color: _purple,
                                   fontWeight: FontWeight.bold,
                                   fontSize: 17.0

                                 )
                                 ),
                               )
                             ) ,
                              ),
                              Text("$_personCounter", style: TextStyle(
                                color: _purple,
                                fontWeight: FontWeight.bold,

                              )),
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    _personCounter++;
                                  });
                                },
                                child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: _purple.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(7.0),
                                  ),
                                  child: Center(
                                    child: Text("+",style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17.0,
                                      color: _purple,
                                    ),),
                                  ),
                                ),
                              ),
                              //Tip

                            ],
                          )
                        ],
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:<Widget> [
                            Text("Tip", style: TextStyle(
                              color: Colors.grey.shade700,
                            )) ,
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Text("${calculateTotalTip(_billAmount,_personCounter,_tipPercentage)}", style: TextStyle(
                                color: _purple,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,


                              )),
                            )
                          ]
                      ),
                      Column(
                        children: <Widget>[
                          Text("$_tipPercentage%", style:
                          TextStyle(
                            color: _purple,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold
                          )),
                          Slider(
                              min:0,
                              max:100,
                              activeColor: _purple,
                              inactiveColor: Colors.grey,
                              divisions: 20,
                              value: _tipPercentage.toDouble(), onChanged: (double newValue){
                            setState(() {
                              _tipPercentage = newValue.round();

                            });
                          })
                        ],
                      )

                    ],
                  )
              )
            ],
          ),
        ));
  }

}

class Wisdom extends StatefulWidget {
  const Wisdom({super.key});

  @override
  State<Wisdom> createState() => _WisdomState();
}

class _WisdomState extends State<Wisdom> {
  int _index = 0;

  List<String> Quotes = [
    "“To be, or not to be, that is the question.” – William Shakespeare" "",
    "“I think, therefore I am.” – René Descartes",
    "“The only thing we have to fear is fear itself.” – Franklin D. Roosevelt",
    "“That which does not kill us makes us stronger.” – Friedrich Nietzsche",
    "“In the middle of difficulty lies opportunity.” – Albert Einstein",
    "“Life is what happens when you’re busy making other plans.” – John Lennon",
    "“You must be the change you wish to see in the world.” – Mahatma Gandhi",
    "“The greatest glory in living lies not in never falling, but in rising every time we fall.” – Nelson Mandela",
    "“If life were predictable it would cease to be life, and be without flavour.” – Eleanor Roosevelt",
    "“The future belongs to those who believe in the beauty of their dreams.” – Eleanor Roosevelt"
  ];

  void _showQuote() {
    setState(() {
      _index += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('First Quote'),
            Container(
                width: 350,
                height: 200,
                margin: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14.5)),
                child: Center(
                  child: Text(
                    Quotes[_index % Quotes.length],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 16.5,
                    ),
                  ),
                )),
            const Divider(
              thickness: 1.3,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: TextButton.icon(
                  onPressed: _showQuote,
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade700),
                  icon: const Icon(Icons.wb_sunny),
                  label: const Text(
                    "Inspire Me!",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class BizCard extends StatelessWidget {
  const BizCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BizCard"),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              _getCard(),
              _getAvatar(),
            ],
          ),
        ));
  }

  Container _getCard() {
    return Container(
      width: 350,
      height: 200,
      margin: const EdgeInsets.all(50.0),
      decoration: BoxDecoration(
          color: Colors.blueAccent, borderRadius: BorderRadius.circular(14.5)),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Raj Singh",
            style: TextStyle(
                fontSize: 20.9,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          Text("raj.singh.physica@gmail.com"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person_outline),
              Text("T: Do bizness with me")
            ],
          )
        ],
      ),
    );
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        border: Border.all(color: Colors.redAccent, width: 1.2),
        image: const DecorationImage(
            image: NetworkImage("https://picsum.photos/300/300"),
            fit: BoxFit.cover),
      ),
    );
  }
}

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  _tapButton() {
    debugPrint("tapped button");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Scaffold"),
            centerTitle: true,
            backgroundColor: Colors.amberAccent.shade700,
            actions: <Widget>[
              IconButton(
                  onPressed: () => debugPrint("Email Tapped"),
                  icon: const Icon(Icons.email)),
              IconButton(
                icon: const Icon(Icons.access_alarm),
                onPressed: _tapButton,
              )
            ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightGreen,
          onPressed: () => debugPrint("The floating button has been pressed"),
          child: const Icon(Icons.missed_video_call),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "First"),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Second"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: "Third"),
          ],
          onTap: (int index) => debugPrint("Tapped Item : ${index + 1}"),
        ),
        backgroundColor: Colors.redAccent.shade100,
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomButton()
                // InkWell(
                //   child: Text(
                //     "Tap Me!",
                //     style: TextStyle(fontSize: 23.4),
                //   ),
                //   onTap: () => debugPrint("Tapped...."),
                // )
              ],
            )));
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          backgroundColor: Colors.amberAccent.shade700,
          content: const Text("Hello Again"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
//Context Knows the location of the widget in the widget tree
//It is a widget of the widgets
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.pinkAccent, borderRadius: BorderRadius.circular(8.0)),
        child: const Text("Button"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.deepOrange,
      child: Center(
          child: Text(
            "Hello Flutter!",
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 23.4,
              fontStyle: FontStyle.italic,
            ),
          )), //Text directionality passed
    );
  }
}
