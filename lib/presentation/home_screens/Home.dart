import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fud/colors/Colors.dart';
import 'package:fud/models/mRecipe/mRecipe.dart';
import 'package:fud/models/meals/MealType.dart';
import 'package:fud/models/meals/MealType.dart';
import 'package:fud/models/recipes/Recipe.dart';
import 'package:fud/data/remote/ApiService.dart';
import 'package:fud/presentation/home_screens/RecipeCard.dart';
import 'package:fud/presentation/routes/AppRouter.gr.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/eRecipe/ERecipe.dart';


class Home extends StatefulWidget {
  @override
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<Home> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody:true,//helps the fab to have a transparent background
      backgroundColor: surfaceColor,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: surfaceColor,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.favorite_outline_sharp)),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_none_sharp)),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              userLogOut();

              //Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Center(
        child: getrecipesUI(),
       // child: cuisineUI(),
      ),
      floatingActionButton: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: textOrange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
          onPressed: () {
            context.router.push(AddRoute());
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          elevation: 0.0,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            color: Colors.white,
            elevation: 0, // Set this to 0 since the shadow is applied in the outer container
            surfaceTintColor: Colors.white,
            child: SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      context.router.push(SearchRoute());
                    },
                    icon: Icon(Icons.home_outlined, color: Colors.black54),
                  ),
                  IconButton(
                    onPressed: () {
                      context.router.push(SearchRoute());
                    },
                    icon: Icon(Icons.search_rounded, color: Colors.black54),
                  ),
                  SizedBox(width: 40),
                  IconButton(
                    onPressed: () {
                      context.router.push(ProfileRoute());
                    },
                    icon: Icon(Icons.star_border_sharp, color: Colors.black54),
                  ),
                  IconButton(
                    onPressed: () {
                      context.router.push(ProfileRoute());
                    },
                    icon: Icon(Icons.person_outline_rounded, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    Widget buildbody() {}
  }

/*
In Flutter, the FutureBuilder widget is used to asynchronously
 build the UI based on the result of a Future.
  It's a convenient way to handle asynchronous operations
   and update your user interface when the data becomes available.
FutureBuilder is a widget that takes two key parameters:
future: This parameter expects a Future object.
 It represents the asynchronous operation whose result you want to use to build the UI.
  In your case, you are calling ApiService().getRecipes() to get a Future that will fetch recipe data.
builder: This parameter is a callback function that takes two arguments, context and snapshot.
 It is called when the Future completes, and its result is available.
 The purpose of this callback is to build the UI based on the state of the Future.
  It's where you define how your UI should look based on whether the Future is still loading,
   has completed successfully, or encountered an error.
*/
  
  
  
  Column getrecipesUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: FutureBuilder<MealType>(
            future: ApiService().getrecipes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show a loading indicator while fetching data
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                // Handle error state
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (!snapshot.hasData) {
                // Handle the case when no data is available
                return const Center(
                  child: Text('No recipe data available.'),
                );
              } else {
                // Data is available, display the recipe content
                MealType? recipe = snapshot.data;
                log("${snapshot.data}");
                return RecipeWidget(snapshot); // working :)
                //   return RecipeWidget(recipe as AsyncSnapshot<MRecipe>); // Casting error
              }
            },
          ),
        ),
      ],
    );
  }

  Widget RecipeWidget(AsyncSnapshot<MealType> snapshot) {

    List<String> imagepath=[
      'assets/images/Indian_cuisine.jpg',
      'assets/images/american_cuisine_2.jpg',
      'assets/images/chinese_cuisine.jpg',
      'assets/images/japanese_cuisine.jpg',
      'assets/images/mexican.jpg',
      'assets/images/Thai_cuisines.jpg',
    ];
    List<String> cuisineName=[
      'Indian',
      'American',
      'Chinese',
      'Japanese',
      'Mexican',
      'Thai',
    ];
    List<String> categorypath=[
      'assets/images/breakfast_fud.jpg',
      'assets/images/lunch_fud.jpg',
      'assets/images/snacks.jpg',
      'assets/images/dinner.jpg',
      'assets/images/desert.jpg',
    ];
    List<String> categoryName=[
      'Breakfast',
      'Lunch',
      'Appetizer',
      'Dinner',
      'Dessert',
    ];
    return SingleChildScrollView(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: surfaceColor,
                child: greetWidget(),
              ),
              Container(
                height: 240,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return MyRecipeCard(snapshot: snapshot, index: index);
                        },
                        onPageChanged: (index) {
                          print('pagechanged $index');
                          // setState(() {
                          //   // _currentPage = index;
                          // });
                        },
                        // onPageChanged: (index) {
                        //   setState(() {
                        //     _currentPage = index;
                        //   });
                        // },
                      ),
                    ),
                    /*Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Indicator(
                          index: index,
                          currentIndex: 0,
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
              cuisineUI('Cuisine'),

              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 4,bottom: 8,left: 8,right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child:
                            Column(
                              children: [
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(160), // Adjust the radius as needed
                                  ),
                                  child: Container(
                                    width: 80, // Adjust the width as needed
                                    height: 80, // Adjust the height as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(160), // Same radius as the Card
                                      image: DecorationImage(
                                        image: AssetImage(imagepath[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),

                                ),

                                Text(cuisineName[index],),
                              ],
                            ),
                          ),

                        ],
                      ),
                    );

                  },
                ),
              ),
              cuisineUI('Category'),
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 4,bottom: 8,left: 8,right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child:
                            Column(
                              children: [
                                Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(160), // Adjust the radius as needed
                                  ),
                                  child: Container(
                                    width: 80, // Adjust the width as needed
                                    height: 80, // Adjust the height as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(160), // Same radius as the Card
                                      image: DecorationImage(
                                        image: AssetImage(categorypath[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(categoryName[index],),
                              ],
                            )

                          ),

                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(height: 20),
            ],
          );
        },
      ),

    );
  }
}

void userLogOut() async {
  FirebaseAuth.instance.signOut();
}

Column greetWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
       Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20,left: 12),
            child: Text(
              "Hi,",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 20,left: 12),
            child: Text(
              "${getUsername()}!" ?? "User!",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),

          ),

        ],

      ),
      Padding(padding: EdgeInsets.only(top: 4,left: 12,bottom: 20),
        child: Text(
          "What's on the menu today?",
          style: TextStyle(
              fontSize: 14,

              color: greyText),
        ),

      ),

    ],
  );
}

String? getUsername() {
  var username = FirebaseAuth.instance.currentUser?.displayName;
  return username;
}

Padding popularRecipes(AsyncSnapshot<MealType> snapshot, int index) {
  bool isFavorite = false;
  return Padding(
    padding: EdgeInsets.all(8), // Add padding from all sides
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Stack( 
            children: [
              
              AspectRatio(
                aspectRatio: 16/6,
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.network(
                    snapshot.data!.meals?[index].strMealThumb ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 10,right: 10,
                child: IconButton(icon:Icon(Icons.favorite_outline_sharp),
                  color: Colors.white,iconSize: 32,
                  onPressed: (){
                  Icon(Icons.favorite,color: Colors.red,);
                  },
                ),
              ),
            ],
          ),


          Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              snapshot.data!.meals?[index].strMeal ?? 'Food',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}






Column cuisineUI(String text1)
{
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 20,right: 0),
          child:  Text(text1,style: TextStyle(color: textOrange,fontWeight: FontWeight.w600),),
          ),
          Padding(padding: EdgeInsets.only(top: 20,bottom: 20,left: 0,right: 20),
          child:Text('Explore More >>',style: TextStyle(color: CupertinoColors.systemGrey,fontWeight: FontWeight.w600),),)
        ],
      )
    ],
  );

}

class Indicator extends StatelessWidget {
  final int index;
  final int currentIndex;

  const Indicator({Key? key, required this.index, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: index == currentIndex ? Colors.deepOrange : Colors.grey,
      ),
    );
  }
}

