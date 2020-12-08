// To parse this JSON data, do
//
//     final stockPrice = stockPriceFromJson(jsonString);

import 'dart:convert';


StockPrice stockPriceFromJson(String str) => StockPrice.fromJson(json.decode(str));

String stockPriceToJson(StockPrice data) => json.encode(data.toJson());

class StockPrice {
    StockPrice({
        this.c,
        this.h,
        this.l,
        this.o,
        this.pc,
        this.t,
    });

    double c;
    double h;
    double l;
    double o;
    double pc;
    int t;

    factory StockPrice.fromJson(Map<String, dynamic> json) => StockPrice(
        c: json["c"].toDouble(),
        h: json["h"].toDouble(),
        l: json["l"].toDouble(),
        o: json["o"].toDouble(),
        pc: json["pc"].toDouble(),
        t: json["t"],
    );

    Map<String, dynamic> toJson() => {
        "c": c,
        "h": h,
        "l": l,
        "o": o,
        "pc": pc,
        "t": t,
    };
}
