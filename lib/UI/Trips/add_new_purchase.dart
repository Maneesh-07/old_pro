import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:walletstone/API/Endtrip/endtrip.dart';
import 'package:walletstone/Responses/travel2_response.dart' as trip;
import 'package:walletstone/UI/Constants/strings.dart';
import 'package:walletstone/UI/Constants/text_styles.dart';
import 'package:walletstone/UI/Trips/provider/trip_provider.dart';
import '../../API/api_provider.dart';
import '../Constants/colors.dart';

class AddNewPurchasePage extends StatefulWidget {
  final trip.Travel2Response travel2response;
  const AddNewPurchasePage(this.travel2response, {super.key});

  @override
  State<AddNewPurchasePage> createState() => _AddNewPurchasePageState();
}

class _AddNewPurchasePageState extends State<AddNewPurchasePage> {
  // List<TravelList> travelList = <TravelList>[];
  bool isSwitch = true;
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController pricePaidController = TextEditingController();
  TextEditingController priceSoldController = TextEditingController();
  TextEditingController transportController = TextEditingController();
  TextEditingController hotelController = TextEditingController();
  TextEditingController foodController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

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
        // title: const Text("Trips",  style: TextStyle(
        //     color: whiteColor, fontSize: 20, fontWeight: FontWeight.w500
        // )
        // ),
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
                    Text("Add New Product",
                        style: LargeTextStyle.large20700(whiteColor)),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: width * 0.15,
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
                    Form(
                      key: _formKey,
                      child: Column(
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
                                Text("Name",
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
                                  child: TextFormField(
                                    autofocus: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: Colors.blue,
                                    controller: nameController,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: RegularTextStyle.regular16600(
                                        whiteColor),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      fillColor: fillColor,
                                      filled: true,
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1.0),
                                      ),
                                      errorStyle: const TextStyle(height: 0.1),
                                      errorMaxLines: 2,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter Name';
                                      }
                                      return null;
                                    },
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
                                Text("Trip Quantity",
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
                                  child: TextFormField(
                                    autofocus: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: Colors.blue,
                                    controller: quantityController,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: RegularTextStyle.regular16600(
                                        whiteColor),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      fillColor: fillColor,
                                      filled: true,
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1.0),
                                      ),
                                      errorStyle: const TextStyle(height: 0.1),
                                      errorMaxLines: 2,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an Quantity';
                                      } else if (!RegExp(r'^[0-9]+$')
                                          .hasMatch(value)) {
                                        return 'Amount should contain only numbers';
                                      }
                                      return null;
                                    },
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
                                Text("Price Paid",
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
                                  child: TextFormField(
                                    autofocus: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: Colors.blue,
                                    controller: pricePaidController,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: RegularTextStyle.regular16600(
                                        whiteColor),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      fillColor: fillColor,
                                      filled: true,
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1.0),
                                      ),
                                      errorStyle: const TextStyle(height: 0.1),
                                      errorMaxLines: 2,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an price';
                                      } else if (!RegExp(r'^[0-9]+$')
                                          .hasMatch(value)) {
                                        return 'Amount should contain only numbers';
                                      }
                                      return null;
                                    },
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
                                Text("Price Sold",
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
                                  child: TextFormField(
                                    autofocus: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor: Colors.blue,
                                    controller: priceSoldController,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    style: RegularTextStyle.regular16600(
                                        whiteColor),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      fillColor: fillColor,
                                      filled: true,
                                      enabledBorder: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(1)),
                                        borderSide: BorderSide(
                                            color: borderColor, width: 1.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(1),
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1.0),
                                      ),
                                      errorStyle: const TextStyle(height: 0.1),
                                      errorMaxLines: 2,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10, bottom: 10),
                                    ),
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an Price Sold';
                                      } else if (!RegExp(r'^[0-9]+$')
                                          .hasMatch(value)) {
                                        return 'Amount should contain only numbers';
                                      }
                                      return null;
                                    },
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
                              width: width * 0.6,
                              child: Consumer<TripProvider>(
                                builder: (context, value, child) =>
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: buttonColor2,
                                          surfaceTintColor: blackColor,
                                          shadowColor: whiteColor,
                                          elevation: 4,
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            List<Map<String, dynamic>> list =
                                                [];
                                            List<Map<String, dynamic>>
                                                expensesList = [];
                                            final SharedPreferences sharedPref =
                                                await SharedPreferences
                                                    .getInstance();
                                            final String? userName =
                                                sharedPref.getString('name');

                                            print(
                                                "name that for user${userNameController.text}");
                                            print(
                                                "nnn ${widget.travel2response.product!.length}");
                                            for (int i = 0;
                                                i <=
                                                    widget.travel2response
                                                            .product!.length -
                                                        1;
                                                i++) {
                                              list.add({
                                                "product_name": widget
                                                    .travel2response
                                                    .product![i]
                                                    .productName,
                                                "quantity": widget
                                                    .travel2response
                                                    .product![i]
                                                    .quantity,
                                                "price_paid": widget
                                                    .travel2response
                                                    .product![i]
                                                    .pricePaid,
                                                "price_sold": widget
                                                    .travel2response
                                                    .product![i]
                                                    .priceSold,
                                                "user": widget.travel2response
                                                    .product![i].user,
                                              });
                                            }
                                            list.add({
                                              "product_name":
                                                  nameController.text,
                                              "quantity": int.parse(
                                                  quantityController.text),
                                              "price_paid": int.parse(
                                                  pricePaidController.text),
                                              "price_sold": int.parse(
                                                  priceSoldController.text),
                                              "user": userName,
                                            });

                                            for (int i = 0;
                                                i <=
                                                    widget.travel2response
                                                            .expenses!.length -
                                                        1;
                                                i++) {
                                              expensesList.add({
                                                "expense_name": widget
                                                    .travel2response
                                                    .expenses![i]
                                                    .expenseName,
                                                "expense_amount": widget
                                                    .travel2response
                                                    .expenses![i]
                                                    .expenseAmount,
                                                "user": widget.travel2response
                                                    .expenses![i].user,
                                              });
                                            }

                                            Map<String, dynamic> addEvents = {
                                              "trip_name": widget
                                                  .travel2response.tripName,
                                              "product": list,
                                              "expenses": expensesList,
                                              "user":
                                                  widget.travel2response.user,
                                              "user_order": widget
                                                  .travel2response.userOrder,
                                            };

                                            print(addEvents);
                                            setState(() {
                                              isLoading = true;
                                            });
                                            ApiForEndTrip().resumeTrip(
                                                widget.travel2response.id!);
                                            var response = await ApiProvider()
                                                .processAddEvent(addEvents,
                                                    widget.travel2response.id!);
                                            value.fetch();
                                            if (response.message != null) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              Navigator.pop(context);
                                              var snackBar = const SnackBar(
                                                  content: Text(
                                                      "Event created successfully"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
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
                                          }
                                        },
                                        child: isLoading == true
                                            ? const CircularProgressIndicator(
                                                color: Colors.white,
                                              )
                                            : Text("Add Product",
                                                textAlign: TextAlign.center,
                                                style: RegularTextStyle
                                                    .regular14600(whiteColor))),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
