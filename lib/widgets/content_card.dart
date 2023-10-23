import 'package:flutter/material.dart';
import '../models/models.dart';
import '../utils/utils.dart';

class ContentCard extends StatefulWidget {
  final String type;
  final CourseContent content;
  const ContentCard({Key? key, required this.type, required this.content}) : super(key: key);

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                  color: Colors.deepPurple
                ),
                child:  Text(widget.content.course ?? "", style: const TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w400),),
              ),
              widget.type != "courseContent" ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${widget.type} # ${widget.content.serialNo}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              )
                  : const SizedBox(),
              const SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.content.fileNames!.length,
                    itemBuilder: (context, index)
                    {
                      return InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.deepPurple.shade400),

                          onTap: () async
                          {
                            await Common.downloadFile(
                              context: context,
                                url: widget.content.fileUrls![index],
                                fileName: widget.content.fileNames![index] ?? "abc.pdf", index: index,
                              progressCallBack: (value)
                                {
                                  setState((){
                                    progress = value;
                                  });
                                }
                            );


                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.download),
                                  const SizedBox(width: 8,),
                                  Text(widget.content.fileNames![index])
                                ],
                              ),
                              progress > 0 && progress <1   ?  LinearProgressIndicator(
                                value: progress,
                                backgroundColor: Colors.blue,
                              ) : const SizedBox()
                            ],
                          )
                      );
                    }
                ),
              ),
              const SizedBox(height: 10,)

            ],
          ),
        ),
      ),
    );
  }

}
