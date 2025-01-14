import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:walletstone/API/add_assets/add_assets.dart';
import 'package:walletstone/UI/Constants/colors.dart';
import 'package:walletstone/UI/Constants/text_styles.dart';
import 'package:walletstone/UI/Model/portfolio/portfolio_model.dart' as port;
import 'package:walletstone/UI/Model/portfolio/search_model.dart';
import 'package:walletstone/UI/portfolio/controller/asset_provider.dart';
import 'package:walletstone/UI/portfolio/controller/assets_controller.dart';
import 'package:walletstone/UI/portfolio/controller/cash_controller.dart';
import 'package:walletstone/UI/portfolio/controller/loan_controller.dart';
import 'package:walletstone/UI/portfolio/controller/portfolip_controller.dart';
import 'package:walletstone/UI/portfolio/controller/trip_controller.dart';
import 'package:walletstone/widgets/global.dart';

class UpdateAssetsScreen extends StatefulWidget {
  final int index;
  final port.Portfolio portfolios;
  final SearchData? searchData;

  // final List<port.Portfolio> cashportfolios;
  // final List<port.Portfolio> assetsportfolios;
  const UpdateAssetsScreen({
    super.key,
    required this.index,
    required this.portfolios,
    this.searchData,
  });

  @override
  State<UpdateAssetsScreen> createState() => UpdateAssetsScreenState();
}

class UpdateAssetsScreenState extends State<UpdateAssetsScreen> {
  // List<TravelList> travelList = <TravelList>[];
  bool isSwitch = true;
  bool isLoading = false;

  TextEditingController assestNameController = TextEditingController();
  TextEditingController assestAmountController = TextEditingController();
  List<TextEditingController> expenseController = [];

  final controller = Get.put(PortfolioController());
  final cashcontroller = Get.put(PortfolioController3());
  final assetscontroller = Get.put(PortfolioController2());

  final loancontroller = Get.put(PortfolioControllerLoan());
  final tripcontroller = Get.put(PortfolioControllerTrip());

  @override
  void initState() {
    super.initState();

    // Initialize expenseController with enough elements
    for (int i = 0; i < 500; i++) {
      expenseController.add(TextEditingController());
    }

    // if (widget.index < widget.portfolios.length) {
    //   print(widget.portfolios[widget.index].quantity);
    //   print(widget.portfolios[widget.index].coinName);
    //   print(widget.index);
    // }

    final selectedPortfolio = widget.portfolios;
    assestNameController.text = selectedPortfolio.coinName;
    assestAmountController.text = selectedPortfolio.quantity.toString();
    expenseController[0].text = selectedPortfolio.coinName;
    expenseController[1].text = selectedPortfolio.quantity.toString();
    expenseController[2].text = selectedPortfolio.subCat.toString();

    print(selectedPortfolio.quantity);
    // print(widget.portfolios[widget.index].quantity);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(widget.index);
    print(widget.portfolios);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarBackgroundColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/background_new_wallet.png"),
              fit: BoxFit.fill,
            )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.04,
                ),
                Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [newGradient5, newGradient6],
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          Text("Update",
                              style: LargeTextStyle.large20700(whiteColor)),
                          IconButton(
                            onPressed: () async {
                              _showDeleteConfirmationDialog(context);
                            },
                            icon: const Icon(
                              CupertinoIcons.delete,
                              color: dotColor,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: width * 0.4,
                        height: 2,
                        color: lineColor,
                      ),
                      Container(
                        width: width * 0.9,
                        height: 1,
                        color: lineColor2,
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const SizedBox(height: 30,),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Assets Name",
                                    style: RegularTextStyle.regular16600(
                                        Colors.white)),
                                const SizedBox(
                                  height: 6,
                                ),
                                SizedBox(
                                  height: 45,
                                  width: width,
                                  // padding: EdgeInsets.only(left: 15, right: 15),
                                  // alignment: Alignment.center,
                                  child: TextField(
                                    // autofocus: true,
                                    cursorColor: Colors.blue,
                                    controller: expenseController[0],
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: RegularTextStyle.regular16600(
                                        whiteColor),
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      fillColor: fillColor,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      contentPadding: EdgeInsets.only(left: 20),
                                    ),
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Assets Amount",
                                    style: RegularTextStyle.regular16600(
                                        Colors.white)),
                                const SizedBox(
                                  height: 6,
                                ),
                                SizedBox(
                                  height: 45,
                                  width: width,
                                  // padding: EdgeInsets.only(left: 15, right: 15),
                                  // alignment: Alignment.center,
                                  child: TextField(
                                    // autofocus: true,
                                    cursorColor: Colors.blue,
                                    controller: expenseController[1],

                                    textAlign: TextAlign.start,
                                    keyboardType: TextInputType.number,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: RegularTextStyle.regular16600(
                                        whiteColor),
                                    decoration: const InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      fillColor: fillColor,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      contentPadding: EdgeInsets.only(left: 20),
                                    ),

                                    textInputAction: TextInputAction.next,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SizedBox(
                              height: 45,
                              width: width * 0.8,
                              child: Consumer<AssetProvider>(
                                builder: (context, value, child) =>
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: buttonColor2,
                                            surfaceTintColor: blackColor,
                                            shadowColor: whiteColor,
                                            elevation: 4),
                                        onPressed: () async {
                                          // // List <Map<String, dynamic>> productList = [];

                                          var response =
                                              await ApiServiceForADDAssets()
                                                  .update(
                                            expenseController[0].text,
                                            double.parse(
                                                expenseController[1].text),
                                            int.parse(
                                                expenseController[2].text),
                                          );
                                          controller.update();
                                          assetscontroller.update();
                                          cashcontroller.update();
                                          loancontroller.update();
                                          tripcontroller.update();
                                          value.getAsset();
                                          value.getLoans();
                                          value.getCash();
                                          if (response.message != null) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            Get.back();
                                           alert(response.message!);
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            var snackBar = const SnackBar(
                                                content: Text(
                                                    "Something gone wrong"));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        },
                                        child: isLoading == true
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text("Update",
                                                textAlign: TextAlign.center,
                                                style: RegularTextStyle
                                                    .regular14600(whiteColor))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete',
            style: RegularTextStyle.regular14600(blackColor),
          ),
          content: Text(
            'Are you sure you want to Delete?',
            style: RegularTextStyle.regular14600(blackColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: RegularTextStyle.regular14600(blackColor),
              ),
            ),
            Consumer<AssetProvider>(
              builder: (context, value, child) => TextButton(
                onPressed: () async {
                  var response = await ApiServiceForADDAssets().delete(
                    expenseController[0].text,
                    double.parse(expenseController[1].text),
                    int.parse(expenseController[2].text),
                  );
                  controller.update();
                  cashcontroller.update();
                  assetscontroller.update();
                  loancontroller.update();
                  tripcontroller.update();
                  value.getAsset();
                  value.getLoans();
                  value.getCash();
                  if (response.message != null) {
                    setState(() {
                      isLoading = false;
                    });
                    Get.back();
                   alert(response.message!);
                    // var snackBar = SnackBar(
                    //     content: Text(
                    //         "Assets created successfully"));
                    // ScaffoldMessenger.of(context)
                    //     .showSnackBar(snackBar);
                  } else {
                    setState(() {
                      isLoading = false;
                    });
                    Get.snackbar(
                      "Something gone wrong",
                      '',
                      backgroundColor: newGradient6,
                      colorText: whiteColor,
                      padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
                      duration: const Duration(milliseconds: 4000),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  'Delete',
                  style: RegularTextStyle.regular14600(dotColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
