//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp."
#property link      "https://github.com/tradingtoolcrypto"
#property version   "1.00"
#property  script_show_inputs

#include <TradingToolCrypto/CBP/CBPFrameWork.mqh>

CBPFrameWork bot;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+

input group "Script Settings";
input bool BuyStops = false;



void OnStart()
  {
//---
   /*
   symbolName - The market that the robot or script is being attached to. such as BTCUSDT.bnf.all or BTCUSDT.bnf
   */

   Print("Market Name" + bot.symbolName()   + " Ask " +  bot.symbolAsk() + " Bid " + bot.symbolBid());

   /*
   Place Buy Stop orders above the current price
   */
   double ask = bot.symbolAsk();
   double buystopPrice1 = (ask * 0.01) + ask;
   double buystopPrice2 = (ask * 0.02) + ask;
   double buystopPrice3 = (ask * 0.03) + ask;
   
   if(BuyStops){
    if(bot.tradeBuyStop(Exchange_Lotsize, buystopPrice1) && bot.tradeBuyStop(Exchange_Lotsize, buystopPrice2) && bot.tradeBuyStop(Exchange_Lotsize, buystopPrice3) )
     {

      /*
      delete the orders
      tradeDeleteAll(bool longOnly)
      */

      if(bot.tradeDeleteAll(true) )
        {
         Alert(" Buy Stop Orders have been deleted ");
        }
     }
   }

  
     
     /*
     Place Buy Limit orders below the current price 
     */
     
   double bid = bot.symbolBid();
   double buyPrice1 = bid - (bid * 0.01) ;
   double buyPrice2 = bid - (bid * 0.02) ;
   double buyPrice3 = bid - (bid * 0.03) ;
   
   if(!BuyStops){
    if(bot.tradeBid(Exchange_Lotsize, buyPrice1) && bot.tradeBid(Exchange_Lotsize, buyPrice2) && bot.tradeBid(Exchange_Lotsize, buyPrice3) )
     {

      /*
      delete the orders
      tradeDeleteAll(bool longOnly)
      */

      if(bot.tradeDeleteAll(true) )
        {
         Alert(" Buy Limit Orders have been deleted ");
        }
     }
   
   }
     
     
     
     
     
     
     
     
     
     
  }
