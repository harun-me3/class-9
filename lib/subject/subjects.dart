import 'package:class_9th_ncert_all/Modals/listdata.dart';
import 'package:class_9th_ncert_all/book_solution/book_solution.dart';
import 'package:class_9th_ncert_all/config/constant.dart';
import 'package:class_9th_ncert_all/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Subject extends StatefulWidget {


  final index1;
  final List<SubjectDataSet> subjectDataSet;
  final String bookname;

  const Subject(this.subjectDataSet,this.index1, this.bookname) ;

  @override
  _SubjectState createState() => _SubjectState();
}

class _SubjectState extends State<Subject> {




  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
        
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background:  Lottie.asset('assets/header/subjectheader.json'),
            ),
            snap: true,
            pinned: true,
            floating: true,
            elevation: 5,
            expandedHeight: 150,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              tooltip: 'Menu',
              onPressed: () =>  Navigator.pop(context),
            
            ),
                actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.bookname,
          ),
            ),

          ], //IconButton
          
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
              
                 Size size = MediaQuery.of(context).size;
            
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding/2,
                    vertical: kDefaultPadding /3,
                  ),
                  height: 160,
        
              
                  child: InkWell(
                    onTap: () async{

                   
                      Navigator.push(
                        context,
          MaterialPageRoute(builder: (context) => MyBookandSolution(widget.subjectDataSet[index].bookSolutionDataSet,widget.index1,index,widget.subjectDataSet[index].subjectName)),
                      );
                    },
                    child: Stack(
                      
                      alignment: Alignment.bottomCenter,



                      children: <Widget>[
                        // Those are our background
                        Container(
                         
                       
                          height: 136,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22),
                            color: index.isEven ? kBlueColor : kSecondaryColor,
                            boxShadow: [kDefaultShadow],
                          ),
                          child: Container(
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                             color:Provider.of<ThemeProvider>(context).isLightTheme?Color(0xFF3A3B3C):Color(0xFFFFFFFF),
                              borderRadius: BorderRadius.circular(22),
                             

                            ),
                          ),
                        ),




                        // our product image
                        Positioned(
                          
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding),
                            height: 88,
                            // image is square but we add extra 20 + 20 padding thats why width is 128
                           width: 128,
                            child: Image.asset(
                             widget.subjectDataSet[index].subjectimagesrc,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),


                        // Product title and price
                        Positioned(
                          top: -20,
                          left: 0,
                          child: SizedBox(
                            height: 160,
                            // our image take 200 width, thats why we set out total width - 200
                            width: size.width - 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: kDefaultPadding),
                                  child: Text(
                                  widget.subjectDataSet[index].subjectName,
                                     style: Theme.of(context).accentTextTheme.bodyText1,
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                          
                        ),



                      ],



                    ),
                  ),
                );

                  ///////////////////////////
              },
               childCount: widget.subjectDataSet.length
              ),

              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              )
              ),
        ],
      ),
    );
  }
}