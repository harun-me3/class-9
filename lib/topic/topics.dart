import 'package:class_9th_ncert_all/English/sub_topic_english/sub_topics.dart';
import 'package:class_9th_ncert_all/Hindi/sub_topic_hindi/sub_topics.dart';
import 'package:class_9th_ncert_all/Modals/listdata.dart';
import 'package:class_9th_ncert_all/config/appcolor.dart';
import 'package:class_9th_ncert_all/config/constant.dart';
import 'package:class_9th_ncert_all/langauge/langauge_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Topics extends StatefulWidget {

   final index1;
   final index2;
   final index3;
  
final List<TopicDataSet> topicDataSet;
final String booksolutionname;
  const Topics(this.topicDataSet, this.index1, this.index2, this.index3, this.booksolutionname);

  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       elevation: 0.0,
        backgroundColor: AppColor.orange,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
         bottomLeft: Radius.circular(400)
            
          )
        ),

         bottom: PreferredSize( 
          preferredSize: Size.fromHeight(200),
          child: SizedBox(),
         
         ),
        leading: IconButton(
              icon: Icon(Icons.arrow_back_outlined),
              tooltip: 'Menu',
              onPressed: () =>  Navigator.pop(context),
          
            ),

                actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.booksolutionname,
          ),
            ),

          ],
    
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
                     final isHindi=Provider.of<LangaugeProvider>(context).isHindi;
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding / 2,
                    vertical: kDefaultPadding / 3),
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding,
                ),
                decoration: BoxDecoration(
                  color: AppColor.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {

                     
                     if (isHindi) 
                     {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubTopicHindi(widget.topicDataSet[index].subtopicDataSet,widget.index1,widget.index2,widget.index3,index, widget.topicDataSet[index].topicName),
                      ),
                    );
                     }
                     else
                     {
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubTopicEnglish(widget.topicDataSet[index].subtopicDataSet,widget.index1,widget.index2,widget.index3,index, widget.topicDataSet[index].topicName),
                      ),
                    );
                     } 
                     
                   
                     



                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text(index.toString(),
                        
                        ),
                      )),
                      Flexible(
                        child: Text(
                          widget.topicDataSet[index].topicName,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                         style: Theme.of(context).accentTextTheme.headline2,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
              );
            }, childCount:widget.topicDataSet.length),
          ),
        ],
      ),
    );
  }



  
}
