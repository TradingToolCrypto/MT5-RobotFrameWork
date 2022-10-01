//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link "https://github.com/tradingtoolcrypto"
#property version "1.00"
#property script_show_inputs

#include <TradingToolCrypto/CBP/CBPFrameWork.mqh>

CBPFrameWork bot;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
  //---
  /*
  symbolName - The market that the robot or script is being attached to. such as BTCUSDT.bnf.all or BTCUSDT.bnf
  */

  Print("Market Name" + bot.symbolName() + " Ask " + bot.symbolAsk() + " Bid " + bot.symbolBid());

  /*
  Place a Buy Stop 1% above the current price
  */
  double ask = bot.symbolAsk();
  double buystopPrice = (ask * 0.01) + ask;

  if (bot.tradeBuyStop(Exchange_Lotsize, buystopPrice))
  {

    string get_order_id = getOrderID();

    Alert(" Order Opened with ID |" + get_order_id + "|");

    /*
    delete the order
    */

    if (bot.tradeDelete(get_order_id))
    {
      Alert(" Order " + get_order_id + " has been deleted ");
    }
  }
}
/*
 orderPending - loads all the pending orders into arrays and returns the number of active orders that exist

 string exchange_name[];
 string exchange_symbol[];
 string exchange_ordertype[];
 string exchange_orderside[];
 double exchange_orderprice[];
 double exchange_ordersize[];
 int    exchange_orderindex[];
 string    exchange_orderid[];

*/

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string getOrderID()
{

  if (bot.orderPending() != 0)
  {
    int loop = ArraySize(exchange_name);
    for (int i = 0; i < loop; i++)
    {
      if (Exchange_Symbol_Name == exchange_symbol[i])
      {

        Print(" Order ID=" + exchange_orderid[i]);

        return (exchange_orderid[i]);
      }
    }
  }

  return ("");
}
//+------------------------------------------------------------------+
