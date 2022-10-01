//+------------------------------------------------------------------+
//|                                                   test class.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link "https://www.mql5.com"
#property version "1.00"
#property script_show_inputs

// Import the Crypto Bridge Robot FrameWork
#include <TradingToolCrypto/CBP/CBPFrameWork.mqh>
/*
   - class (RobotFrameWork) becomes an object
   - give the class a pointer name (btc,bnb,etc)
*/
RobotFrameWork btc;
RobotFrameWork bnb;

CBPFrameWork crypto_bot;
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
   //--- STEP 1:  assign a pair to the RobotFrameWork object that you created above
   btc.Init_Symbol("BTCUSDT");
   bnb.Init_Symbol("BNBUSDT");

   //--- STEP 2: use any of the preset functions within the object such as the bid and ask
   Print(" BNB " + bnb.symbolBid() + " BTC " + btc.symbolAsk());

   Print(" BARS " + bnb.symbolBars() + " BARS " + btc.symbolBars());

   //--- STEP 3: place trades

   // uncomment any

   //  crypto_bot.tradeBuy(0.01); crypto_bot.tradeSell(0.01);

   //  crypto_bot.tradeBid(0.01);  crypto_bot.tradeAsk(0.01);

   //  crypto_bot.tradeBid(0.01,36555); crypto_bot.tradeAsk(0.01,66555);

   //  crypto_bot.tradeBuyStop(0.01,61000);

   //  crypto_bot.tradeSellStop(0.01,58000);

   /*
   btcusd = 61,000 now
   place an ask at current price if price hits 58000
   */

   // crypto_bot.tradeSellStopLimit(0.01,58000);

   /*
   btcusd = 61,000 now
   place a bid at current price if price hits 62000
   */

   //  crypto_bot.tradeBuyStopLimit(0.01,62000);

   // crypto_bot.tradeBuyStopLimit(0.01,62000,60000);
}
//+------------------------------------------------------------------+
