import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:flutter_pickers/time_picker/model/date_mode.dart';
import 'package:flutter_pickers/time_picker/model/suffix.dart';
import 'package:twst/tools/dateuti.dart';
import 'package:twst/view/common_appbar.dart';

import '../bean/eventbus.dart';
import '../config/textsize.dart';
import '../service/constans.dart';
import '../service/dioclent.dart';
import '../tools/datautil.dart';
import '../tools/dialogutil.dart';
import '../tools/logutils.dart';
import '../view/common_menu_item.dart';
import '../view/commontextform.dart';
import '../view/coomon_imagetext_item.dart';
import 'chooserecievebylistpage.dart';

class AddGsjDetailPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return AddGsjDetailPageState();
  }

}

class AddGsjDetailPageState extends State<AddGsjDetailPage>{
  List<Map> list=[];
  late String desc;//描述
  late String store='';//仓库
  late String location='';//仓库编号
  late String receiveby='';//领用人
  late String recipientno='';//领用人id
  late String receivetime='';//领用时间
  late String sendtime='';//发放时间
  late String udzydd='';//作业地点
  late String udzyhl='';//分类
  late String createdby='';//创建人
  late String dept='';
  late String createdtime='';//创建时间
  late String sitedec='';//地点
  late String sendby='';//发放人
  late String cost='';//成本
  late String usedtype="";//使用情况
  TextEditingController descController = TextEditingController();
  TextEditingController _uPwdController = TextEditingController();
  late String name;
  late String displyName='';//中文名
  late String siteid='';
  late String udbmbm='';//部门编码
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Constants.ADD_NEW_ONE,
          style:
          TextStyle(fontSize: TextSizeConfig.size20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body:Column(
        children: [
          Expanded(child:  SingleChildScrollView(
            child: Column(
              children: [
                //创建人
                Padding(
                  padding: const EdgeInsets.only(left: 10, top:5,right: 8),
                  child: CommonTextForm(
                      title: Constants.CREATED_BY,
                      titlecolor: Colors.black87,
                      titleSize: TextSizeConfig.size16,
                      content: displyName,
                      contentcolor: Colors.black,
                      contentSize: TextSizeConfig.size16),
                ),
                //创建部门
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8),
                  child: CommonTextForm(
                      title: Constants.CREATED_DEPT,
                      titlecolor: Colors.black87,
                      titleSize: TextSizeConfig.size16,
                      content: dept,
                      contentcolor: Colors.black,
                      contentSize: TextSizeConfig.size16),
                ),
                //创建日期
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8),
                  child: CommonTextForm(
                      title: Constants.CREATED_TIME,
                      titlecolor: Colors.black87,
                      titleSize: TextSizeConfig.size16,
                      content:createdtime,
                      contentcolor: Colors.black,
                      contentSize: TextSizeConfig.size16),
                ),
                //地点
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, right: 8),
                //   child: CommonTextForm(
                //       title: Constants.LOCATION,
                //       titlecolor: Colors.black87,
                //       titleSize: TextSizeConfig.size16,
                //       content:sitedec,
                //       contentcolor: Colors.black,
                //       contentSize: TextSizeConfig.size16),
                // ),
                //成本总价
                // Padding(
                //   padding: const EdgeInsets.only(left: 10, right: 8),
                //   child: CommonTextForm(
                //       title: Constants.COST_PRICE,
                //       titlecolor: Colors.black87,
                //       titleSize: TextSizeConfig.size16,
                //       content:widget.arguments['udcbzj'],
                //       contentcolor: Colors.black,
                //       contentSize: TextSizeConfig.size16),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 8),
                  child: CommonImageTextItem(
                      asserts: "images/must_fill.png",
                      text: '工属具借用归还说明:',
                      textcolor: Colors.black,
                      imagecolor: Colors.red,
                      onPressed: () {},
                      textSize: TextSizeConfig.size16,
                      imageSize: TextSizeConfig.size25),
                ),
                //描述
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.only(left: 10, right: 10, top: 3),
                        child: TextField(
                          maxLength: 300,
                          maxLines: 4,
                          minLines: 2,
                          controller: descController,
                          decoration: InputDecoration(
                            filled: true,
                            isCollapsed: true,
                            contentPadding: EdgeInsets.all(15),
                            hintStyle: TextStyle(fontSize: TextSizeConfig.size14),
                            hintText: Constants.PLEASE_INPUT,
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(right: 5),
                    //   width:25,
                    //   child: InkWell(child: Image.asset("images/commit.png",width: 25,height: 25,color: Colors.blueAccent,),onTap:(){
                    //     // commit(description: descController.text, fromstoreloc: "", recipient: "", recipientdate: "", udissueddate: "", udzydd: "", udzyhl: "");
                    //   } ,),
                    // )

                  ],
                ),
//仓库
                CommonMenuItem(
                  icon: "images/must_fill.png",
                  title: Constants.STOREHOUSE,
                  onPressed: () async {
                    final result = await Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ChooseRecieveByListPage(tag:'store')));
                    LogD('result=${result}');
                    setState(() {
                      store=result['DESCRIPTION'];
                      location=result['LOCATION'];
                    });
                  },
                  flag: 1,
                  note: store,
                  color: Colors.red,
                ),
                //领用人
                CommonMenuItem(
                  icon: "images/person.png",
                  title: Constants.RECIEVE_BY,
                  onPressed: () async {
                    final result = await Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ChooseRecieveByListPage(tag:'recieve')));
                    LogD('result=${result}');
                    setState(() {
                      receiveby=result['DISPLAYNAME'];
                      recipientno=result['PERSONID'];
                    });
                  },
                  flag: 1,
                  note: receiveby,
                  // color: Colors.red,
                ),
                //领用时间
                CommonMenuItem(
                  icon: "images/calendar.png",
                  title: Constants.RECIEVE_DATE,
                  onPressed: () {
                    Pickers.showDatePicker(context,
                        mode: DateMode.YMDHM,
                        suffix: Suffix(),
                        pickerStyle: PickerStyle(
                            cancelButton: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                Constants.CANAELED,
                                style: TextStyle(
                                    fontSize: TextSizeConfig.size16,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            commitButton: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                Constants.CONFIRM,
                                style: TextStyle(
                                    fontSize: TextSizeConfig.size16,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            headDecoration: const BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            backgroundColor: Colors.white,
                            textColor: Colors.black87),
                        onConfirm: ( p) {
                          LogD('返回${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}');

                          setState(() {
                            receivetime='${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}';
                          });
                          // commit(description:"", fromstoreloc:"", recipient:"", recipientdate:receivetime, udissueddate:"", udzydd:"", udzyhl:"");

                        });
                  },
                  flag: 1,
                  note: receivetime,
                  // color: Colors.red,
                ),
                //发放时间
                CommonMenuItem(
                  icon: "images/calendar.png",
                  title: Constants.SEND_TO_DATE,
                  onPressed: () {
                    Pickers.showDatePicker(context,
                        mode: DateMode.YMDHM,
                        suffix: Suffix(),
                        pickerStyle: PickerStyle(
                            cancelButton: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                Constants.CANAELED,
                                style: TextStyle(
                                    fontSize: TextSizeConfig.size16,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            commitButton: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                Constants.CONFIRM,
                                style: TextStyle(
                                    fontSize: TextSizeConfig.size16,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            headDecoration: const BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            backgroundColor: Colors.white,
                            textColor: Colors.black87),
                        onConfirm: ( p) {
                          LogD('返回${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}');
                          setState(() {
                            sendtime='${p.year}-${p.month}-${p.day} ${p.hour}:${p.minute}';
                          });
                          // commit(description:"", fromstoreloc:"", recipient:"", recipientdate:"", udissueddate:sendtime, udzydd:"", udzyhl:"");

                        });
                  },
                  flag: 1,
                  note: sendtime,
                  // color: Colors.red,
                ),
                //作业地点
                CommonMenuItem(
                  icon: "images/location.png",
                  title: Constants.WORK_LOCATION,
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Text('data');
                        },
                        context: this.context);
                  },
                  flag: 1,
                  note: udzydd,
                  // color: Colors.red,
                ),
                //作业货类
                CommonMenuItem(
                  icon: "images/category.png",
                  title: Constants.WORK_TYPE,
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        builder: (BuildContext context) {
                          return Text('data');
                        },
                        context: this.context);
                  },
                  flag: 1,
                  note: udzyhl,
                  // color: Colors.red,
                ),



              ],
            ),
          )),
          InkWell(
            onTap: _addNewOne,
            child: Container(
              margin: EdgeInsets.all(8),
              alignment: Alignment.center,
              // width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: new BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(colors: <Color>[
                  Colors.lightBlue,
                  Colors.black45,
                ]),
              ),
              height: 50,
                child: Text(
                  Constants.COMMIT,
                  style: TextStyle(
                      color: Colors.white, fontSize: TextSizeConfig.size20,letterSpacing: 10),
                ),
                // splashColor: Colors.green,

            ),
          ),
        ],
      ),
    );
  }

  Future<void> initData() async {
    //登陆手机号
   String  loginname = await DataUtils.getString("loginname");
    //展示中文名
   String username= await DataUtils.getString("username");
    //部门
   String udbm= await DataUtils.getString("udbm");
    //
   String currenttime=DateUtil.getYYYYMMDDHHMMSS(DateTime.now(), '-','-');
   //id
   String id=await DataUtils.getString("siteid");
   //部门编码
   String deptno=await DataUtils.getString("udbmbm");
    setState(()  {
     name=loginname;
     displyName=username;
     dept=udbm;
     createdtime=currenttime;
     siteid=id;
     udbmbm=deptno;
    });

  }

  _addNewOne() async {
    LogD('addNewOne');
    if(descController.text.isEmpty){
      EasyLoading.showToast('请输入借用/归还说明');
      return;
    }
    if(store.isEmpty){
      EasyLoading.showToast('请选择仓库');
      return;
    }

    DiaLogUtil.show(context, Colors.black12, "加载中...");
    String option = Constants.ADD;
    Map map = {
      "objectName":"UDINVUSE",
      "keyName":"UDINVUSENUM",
      "keyValue": 'keyValue',
        "description":descController.text,
        "FROMSTORELOC":location,
        "udcreatby":name,
        "RECIPIENT":recipientno,
      "DEPTNUM":udbmbm,
        "UDISSUEDBY":name,
      "UDISSUEDDATE":sendtime,
        "UDZYDD":udzydd,
        "UDZYHL":udzyhl,
      "STATUS":Constants.ADD_NEW_ONE,
      "SITEID":siteid,


    };

    try{
      Map<String, dynamic> resultMap =
          await DioClient.DioPost('${name}', option, map);
      if (resultMap['code'] == Constants.CODE_OK) {
        DiaLogUtil.disMiss(context);
        EasyLoading.showSuccess(resultMap['msg']);
        eventBus.fire(EventA(  Constants.REFRESH_GSJ));
        Navigator.of(context).pop();
      }else{
        EasyLoading.showToast(resultMap['msg']);
        // DiaLogUtil.disMiss(context);
      }
    }catch(e){
      LogE(e.toString());
      DiaLogUtil.disMiss(context);
    }

  }
}