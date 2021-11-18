
import 'package:class_9th_ncert_all/English/topicwithoutsubtopicEnglish/topicwithoutsubtopic.dart';
import 'package:class_9th_ncert_all/Hindi/topicwithoutsubtopicHindi/topicwithoutsubtopic.dart';
import 'package:class_9th_ncert_all/Modals/listdata.dart';
import 'package:class_9th_ncert_all/config/appcolor.dart';
import 'package:class_9th_ncert_all/config/constant.dart';
import 'package:class_9th_ncert_all/langauge/langauge_provider.dart';
import 'package:class_9th_ncert_all/theme/theme.dart';
import 'package:class_9th_ncert_all/topic/topics.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyBookandSolution extends StatefulWidget {
   
   final index1;
   final index2;
   final List<BookSolutionDataSet>  bookSolutionDataSet;
   final String subjectname;
  const MyBookandSolution(this.bookSolutionDataSet, this.index1, this.index2, this.subjectname);

  @override
  _MyBookandSolutionState createState() => _MyBookandSolutionState();
}

class _MyBookandSolutionState extends State<MyBookandSolution> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        shape: CustomShapeBorder(),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
         icon:Icon(Icons.arrow_back_outlined)
         ),
             actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.subjectname,
          ),
            ),

          ],
        
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:70),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          
          slivers: [
                
            SliverGrid(
              
                delegate: SliverChildBuilderDelegate((context, index) {
                 final isHindi=Provider.of<LangaugeProvider>(context).isHindi;
                   Size size = MediaQuery.of(context).size;
                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding/2,
                    vertical: kDefaultPadding /3,
                  ),
                  height: 160,
        
                  child: InkWell(
                    onTap: () {

           
                   if(widget.bookSolutionDataSet[index].topicDataset[1].subtopicDataSet.length==0)
                   {

                         if (isHindi) {

                              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>TopicWithoutSubTopicHindi(widget.bookSolutionDataSet[index].topicDataset,widget.index1,widget.index2,index,widget.bookSolutionDataSet[index].booksolutionname)),
                      );
                
                         } else {
                              Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>TopicWithoutSubTopicEnglish(widget.bookSolutionDataSet[index].topicDataset,widget.index1,widget.index2,index,widget.bookSolutionDataSet[index].booksolutionname)),
                      );
                         }

                   
                   }
                   else{


                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>Topics(widget.bookSolutionDataSet[index].topicDataset,widget.index1,widget.index2,index,widget.bookSolutionDataSet[index].booksolutionname)),
                      );
                   }

                     









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
                              widget.bookSolutionDataSet[index].booksolutionimagesrc,
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
                                  widget.bookSolutionDataSet[index].booksolutionname,
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

                
                }, childCount: widget.bookSolutionDataSet.length),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                )),
          ],
        ),
      ),
    );
  }
}

class CustomShapeBorder extends ContinuousRectangleBorder {
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()
    ..lineTo(0, rect.size.height)
    ..quadraticBezierTo(
      rect.size.width / 2,
      rect.size.height + 70 * 2,
      rect.size.width,
      rect.size.height,
    )
    ..lineTo(rect.size.width, 0)
    ..close();
}
