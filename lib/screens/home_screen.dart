import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transaction_dispute/config/app_color.dart';
import 'package:transaction_dispute/constants/constant_config.dart';
import 'package:transaction_dispute/controllers/transaction_controller.dart';
import 'package:transaction_dispute/utils/app_utils.dart';
import 'package:transaction_dispute/utils/data.dart';
import 'package:transaction_dispute/widgets/app_components.dart';
import 'package:transaction_dispute/widgets/card_tile.dart';
import 'package:transaction_dispute/widgets/transaction_details_bottomsheet.dart';
import 'package:transaction_dispute/widgets/transaction_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final AppComponents appComponents = AppComponents();
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    if (cardData.isNotEmpty) {
      Get.find<TransactionController>().setSelectedCard(
        cardData[0]['id'].toString(),
        transactionData,
      );
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final transactionController = Get.find<TransactionController>();
    transactionController.filterTransactionsByName(_searchController.text);
  }

  void _showTransactionDetailsBottomSheet(
      BuildContext context, String transactionId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return TransactionDetailsBottomsheet(
          transactionId: transactionId,
          onDisputeRaised: () {
            Navigator.pop(context);
            appComponents.showSuccessBottomSheet(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringConstant.appTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              decoration: BoxDecoration(
                color: ColorFile.grey200,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    StringConstant.transactionLimit,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(StringConstant.oneLac, style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 20,
                ),
                child: Row(
                  children: List.generate(
                    cardData.length,
                    (index) {
                      final card = cardData[index];
                      return Obx(() {
                        final selectedCardId = Get.find<TransactionController>()
                            .selectedCardId
                            .value;
                        return CardTile(
                          card: card,
                          isSelected: selectedCardId == card['id'].toString(),
                          onTap: () {
                            Get.find<TransactionController>().setSelectedCard(
                                card['id'].toString(), transactionData);
                            debugPrint(card['id'].toString());
                          },
                        );
                      });
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // SearchBar & TabNavigation
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorFile.black,
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: StringConstant.searchPlaceholder,
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => appComponents.selectDateRange(context),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                _tabNavigation(),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      ((kToolbarHeight + 100) * 1.1),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    children: [
                      SingleChildScrollView(
                        child: _transactionSection(context),
                      ),
                      SingleChildScrollView(
                        child: appComponents.services(context),
                      ),
                      SingleChildScrollView(
                        child: appComponents.accountDetails(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabNavigation() {
    double tabWidth = (AppUtils.screenWidth(context) / 3);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tabItem(StringConstant.lastTenTrans, 0),
              _tabItem(StringConstant.services, 1),
              _tabItem(StringConstant.acctDetails, 2),
            ],
          ),
        ),
        Stack(
          children: [
            SizedBox(height: 5),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: (_currentIndex * tabWidth) + (tabWidth / 2 - tabWidth / 4),
              child: Container(
                width: tabWidth / 2,
                height: 5,
                decoration: BoxDecoration(
                  color: ColorFile.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(height: 1, color: ColorFile.grey300),
      ],
    );
  }

  Widget _tabItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setState(() {
          _currentIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: _currentIndex == index ? ColorFile.blue600 : ColorFile.grey,
          ),
        ),
      ),
    );
  }

  Widget _transactionSection(BuildContext context) {
    return Obx(
      () {
        final transactions =
            Get.find<TransactionController>().filteredTransactions;
        return Container(
          color: ColorFile.grey200.withOpacity(0.5),
          padding: EdgeInsets.only(top: 20, bottom: 50),
          child: transactions.isEmpty
              ? Center(child: Text(StringConstant.noTransactionsAvailable))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    final transactionId =
                        transaction['transactionId'] as String;
                    return TransactionTile(
                      transaction: transaction,
                      transactionId: transactionId,
                      onTap: () {
                        _showTransactionDetailsBottomSheet(
                            context, transactionId);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
