// GRID TRADING WITH CRYPTO ROOBOTS
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link "https://www.mql5.com"
#property version "1.00"
/* CryptoBridgeProClass variables

      string exchange_name[];
      string exchange_symbol[];
      string exchange_ordertype[];
      string exchange_orderside[];
      double exchange_orderprice[];˝
      double exchange_ordersize[];
      int    exchange_orderindex[];
      string    exchange_orderid[];


*/

#include <TradingToolCrypto/CBP/CBPFrameWork.mqh>

CBPFrameWork cb;
/*
   - class (RobotFrameWork) becomes an object and is imported within CBPFramework
   - give the class a pointer name (btc,bnb,etc)
*/
RobotFrameWork btc;
RobotFrameWork eth;

input string RobotParamSymbolA = "BTCUSD.byb.all";
input string RobotParamSymbolB = "ETHUSD.byb.all";

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
{
  btc.Init_Symbol(RobotParamSymbolA);
  eth.Init_Symbol(RobotParamSymbolB);
  //---
  return (INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
  //--- destroy timer
  EventKillTimer();
}

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
double LastPrice_Asset_A = 0;
void OnTick()
{
  int API_CALLS = 0;
  bool trigger = false;
  double compare_Asset_A = btc.symbolAsk();
  double compare_Asset_AB = btc.symbolBid();
  double spr = compare_Asset_A - compare_Asset_AB;
  double fifty_Cents = 0.5;
  double fiveDollars = fifty_Cents * 10;
  double tenDollars = fiveDollars * 2;
  double fiftyDollars = tenDollars * 5;
  if (LastPrice_Asset_A != compare_Asset_A)
  {
    LastPrice_Asset_A = compare_Asset_A;
    trigger = true;
  }
  if (trigger)
  {
    //--- Only Run Logic when the price is changing
    Print(RobotParamSymbolA + " | " + btc.symbolAsk() + " | " + RobotParamSymbolB + " | " + eth.symbolAsk() +
          " BARS RANGE " + btc.symbolRange(10) + " | " + eth.symbolRange(10));
    // get positions
    int loop = cb.orderPending();
    API_CALLS++;
    for (int i = 0; i < loop; i++)
    {
    }
    int bids = cb.orderPendingLimitLong;
    int asks = cb.orderPendingLimitShort;
    Print("BID # | " + bids + " |  ASK # | " + asks);
    if (loop > 0 && bids > 0)
    {
      cb.tradeDeleteAll(true);
      API_CALLS++;
    }
    else if (asks > 0)
    {
      cb.tradeDeleteAll(false);
      API_CALLS++;
    }
    // Place a Bid?
    if (cb.positionTotal() && cb.position_avg_price_buy > compare_Asset_A)
    {
      // only average in
      API_CALLS++;
      cb.tradeBid(Exchange_Lotsize);
      API_CALLS++;
      cb.tradeBid(Exchange_Lotsize * 2, compare_Asset_AB - fiveDollars);
      API_CALLS++;
      cb.tradeBid(Exchange_Lotsize * 3, compare_Asset_AB - tenDollars);
      API_CALLS++;
      cb.tradeBid(Exchange_Lotsize * 4, compare_Asset_AB - tenDollars * 2);
      API_CALLS++;
      cb.orderPending(); // Add the Order Lines on the Chart
      API_CALLS++;
    }
    else if (cb.position_avg_price_buy < compare_Asset_AB)
    {
      cb.tradeAsk(Exchange_Lotsize);
      API_CALLS++;
      cb.tradeAsk(Exchange_Lotsize * 2, compare_Asset_A + fiveDollars);
      API_CALLS++;
      cb.tradeAsk(Exchange_Lotsize * 3, compare_Asset_A + tenDollars);
      API_CALLS++;
      cb.tradeAsk(Exchange_Lotsize * 4, compare_Asset_A + tenDollars * 2);
      API_CALLS++;
      cb.orderPending(); // Add the Order Lines on the Chart
      API_CALLS++;
    }
  }
  if (API_CALLS > 0)
  {
    Print("API CALLS THIS LOOP " + (string)API_CALLS);
  }
}
//+------------------------------------------------------------------+
