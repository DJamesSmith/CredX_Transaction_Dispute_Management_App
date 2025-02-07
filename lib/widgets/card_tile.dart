import 'package:flutter/material.dart';
import 'package:transaction_dispute/config/app_color.dart';
import 'package:transaction_dispute/constants/string_constant.dart';

class CardTile extends StatefulWidget {
  final Map<String, dynamic> card;
  final VoidCallback? onTap;
  final bool isSelected;

  const CardTile({
    super.key,
    required this.card,
    this.onTap,
    required this.isSelected,
  });

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: -10.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.8 + 20,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    if (widget.isSelected)
                      BoxShadow(
                        color: ColorFile.grey300,
                        blurRadius: 10,
                        spreadRadius: 2,
                        offset: Offset(0, 10),
                      ),
                  ],
                  gradient: LinearGradient(
                    colors: (widget.card['colorCombo'] as List<Color>?) ??
                        [ColorFile.black, ColorFile.red],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        (widget.card['imgIcon'] as String?) ?? '',
                        height: 50,
                        width: 100,
                        color: widget.card['imgIcon'] == StringConstant.visa ||
                                widget.card['imgIcon'] ==
                                    StringConstant.discover ||
                                widget.card['imgIcon'] ==
                                    StringConstant.unionPay
                            ? ColorFile.white
                            : null,
                      ),
                      Center(
                        child: Text(
                          (widget.card['cardNumber'] as String?) ?? '',
                          style: TextStyle(
                            color: ColorFile.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 7,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringConstant.cardholderName,
                                  style: TextStyle(
                                    color: ColorFile.grey300,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  (widget.card['name'] as String?) ?? 'aaa bbb',
                                  style: TextStyle(
                                    color: ColorFile.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  StringConstant.expires,
                                  style: TextStyle(
                                    color: ColorFile.grey300,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  (widget.card['expiryDate'] as String?) ??
                                      '00/00',
                                  style: TextStyle(
                                    color: ColorFile.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (widget.isSelected)
          AnimatedBuilder(
            animation: _bounceAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _bounceAnimation.value),
                child: child,
              );
            },
            child: Image.network(
              StringConstant.upArrowIcon,
              height: 50,
            ),
          ),
      ],
    );
  }
}
