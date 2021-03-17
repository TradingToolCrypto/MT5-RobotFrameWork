//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"
#property version "1.00"

#include <TradingToolCrypto/TT/RobotFrameWork.mqh>
#include <TradingToolCrypto/CBP/CryptoBridgeProClass.mqh>
CryptoBridge bridge;
class CBPFrameWork: public RobotFrameWork
  {
private:
   string            frameworkPrefix;
   string            exchangeName;
public:
                     CBPFrameWork();
                    ~CBPFrameWork();

   bool              hedgeMode(bool hedgemode);

   bool              tradeBuy(double volume);
   bool              tradeSell(double volume);

   bool              tradeBuyStop(double volume);
   bool              tradeSellStop(double volume);
   bool              tradeBuyStop(double volume,double price);
   bool              tradeSellStop(double volume, double price);

   bool              tradeBuyStopLimit(double volume,double trigger);
   bool              tradeSellStopLimit(double volume,double trigger);
   bool              tradeBuyStopLimit(double volume,double trigger, double orderprice);
   bool              tradeSellStopLimit(double volume,double trigger,double orderprice);

   bool              tradeBid(double volume);
   bool              tradeAsk(double volume);
   bool              tradeBid(double volume, double price);
   bool              tradeAsk(double volume, double price);
   //--- HEDGE MODE CLOSE ORDERS --
   bool              tradeCloseMarket(bool isLong, double volume);
   bool              tradeCloseLimit(bool isLong, double volume);
   bool              tradeCloseLimit(bool isLong,double volume, double price);
   bool              tradeCloseStop(double volume);
   bool              tradeCloseStop(double volume, double price);
   bool              tradeCloseStopLimit(double volume, double trigger);
   bool              tradeCloseStopLimit(double volume, double trigger, double orderprice);
   //--- HEDGE MODE CLOSE ORDERS --

   bool              tradeDelete(string orderid);
   bool              tradeDeleteAll();
   bool              tradeDeleteAll(bool longOnly);
   bool              tradeDeleteLimit(bool longOnly);
   bool              tradeDeleteStop(bool longOnly);

   bool              tradeTotalPending();
   int               tradeTotalPendingLimitLong;
   int               tradeTotalPendingLimitShort;
   int               tradeTotalPendingStopLong;
   int               tradeTotalPendingStopShort;

   bool              tradeTotal();
   int               tradeTotalLong;
   int               tradeTotalShort;
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBPFrameWork::CBPFrameWork()
  {
   exchangeName = bridge.Get_Exchange_Name(Exchange_Number);
   frameworkPrefix = (string)Exchange_Number + "." + exchangeName + ".";
   tradeTotalLong=0;
   tradeTotalShort=0;
   RobotFrameWork::Init_Symbol(Symbol());

   Print(" Check RobotFrameWork Symbol's Price " + RobotFrameWork::symbolAsk());

   if(bridge.Init_Api_Keys(Exchange_Number))
     {
      Print("CBPFrameWork Initization Loaded Api Keys");
     }
   else
     {
      Print("CBPFrameWork Initization Failed to load Api Keys");
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBPFrameWork::~CBPFrameWork()
  {
   bridge.Deinit_Api_Keys(Exchange_Number);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::hedgeMode(bool hedgemode)
  {
   return(bridge.Hedge_Mode(hedgemode,Exchange_Number));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuy(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"BUY","MARKET",DoubleToString(volume,Exchange_Lot_Precision),"",Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSell(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"SELL","MARKET",DoubleToString(volume,Exchange_Lot_Precision),"",Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuyStop(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double ask = RobotFrameWork::symbolAsk();
   if(bridge.Open_Trade_Stop(Exchange_Symbol_Name,"BUY","STOP_LOSS",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(ask,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSellStop(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double bid = RobotFrameWork::symbolBid();
   if(bridge.Open_Trade_Stop(Exchange_Symbol_Name,"SELL","STOP_LOSS",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(bid,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuyStop(double volume, double price)
  {
   string order_id = frameworkPrefix + GetTickCount64();
   if(bridge.Open_Trade_Stop(Exchange_Symbol_Name,"BUY","STOP_LOSS",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSellStop(double volume, double price)
  {
   string order_id = frameworkPrefix + GetTickCount64();
   if(bridge.Open_Trade_Stop(Exchange_Symbol_Name,"SELL","STOP_LOSS",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBid(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double bid = RobotFrameWork::symbolBid();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(bid,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeAsk(double volume)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double ask = RobotFrameWork::symbolAsk();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(ask,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBid(double volume, double price)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeAsk(double volume, double price)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   if(bridge.Open_Trade(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuyStopLimit(double volume,double trigger)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double price = RobotFrameWork::symbolBid();
   if(bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"BUY","STOP_LOSS_LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),DoubleToString(trigger,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSellStopLimit(double volume,double trigger)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double price = RobotFrameWork::symbolAsk();
   if(bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"SELL","STOP_LOSS_LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),DoubleToString(trigger,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeBuyStopLimit(double volume,double trigger, double orderprice)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double price = orderprice;
   if(bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"BUY","STOP_LOSS_LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),DoubleToString(trigger,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeSellStopLimit(double volume,double trigger, double orderprice)
  {
   string order_id = frameworkPrefix  + GetTickCount64();
   double price = orderprice;
   if(bridge.Open_Trade_StopLimit(Exchange_Symbol_Name,"SELL","STOP_LOSS_LIMIT",DoubleToString(volume,Exchange_Lot_Precision),DoubleToString(price,Exchange_Quote_Precision),DoubleToString(trigger,Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number,order_id))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeCloseMarket(bool isLong, double volume)
  {
   if(isLong)
     {
      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"SELL","MARKET",DoubleToString(volume,Exchange_Lot_Precision), "",Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   if(!isLong)
     {
      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"BUY","MARKET",DoubleToString(volume,Exchange_Lot_Precision), "",Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeCloseLimit(bool isLong, double volume)
  {
   if(isLong)
     {
      double price = RobotFrameWork::symbolAsk();
      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(volume,Exchange_Lot_Precision), DoubleToString(price, Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   if(!isLong)
     {
      double price = RobotFrameWork::symbolBid();
      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(volume,Exchange_Lot_Precision), DoubleToString(price, Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeCloseLimit(bool isLong, double volume, double price)
  {
   if(isLong)
     {

      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"SELL","LIMIT",DoubleToString(volume,Exchange_Lot_Precision), DoubleToString(price, Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   if(!isLong)
     {

      if(bridge.Margin_Close_Position(Exchange_Symbol_Name,"BUY","LIMIT",DoubleToString(volume,Exchange_Lot_Precision), DoubleToString(price, Exchange_Quote_Precision),Exchange_Quote_Precision,Exchange_Lot_Precision,Exchange_Number))
        {
         return(true);
        }
     }
   return(false);
  }
/*

   run this function once and get the position exist within
   tradeTotalLong;
   tradeTotalShort;

   Currently exchanges only allow 1 position (netting), while binanceFutures allow 1 buy and 1 sell
   - however, this could change in the future with Hedging Account Types

*/
bool CBPFrameWork::tradeTotal()
  {
   tradeTotalLong = 0;
   tradeTotalShort = 0;

   if(bridge.Get_Position(Exchange_Symbol_Name,Exchange_Number,Exchange_Quote_Precision))
     {
      bridge.Parse_Positions(exchangeName,275,200,Exchange_Quote_Precision);
      int loop = ArraySize(exchange_name_p);
      if(loop == 0)
        {
         return(true);
        }
      Print("CBPFrameWork::tradeTotal() | Array Size | " + IntegerToString(loop));
      for(int i = 0; i<loop; i++)
        {
         Print(" Loop " + exchange_symbol_p[i] + " Match with | " + Exchange_Symbol_Name);
         if(Exchange_Symbol_Name ==  exchange_symbol_p[i])
           {
            Print(" Exchange Symbol Matched " + exchange_orderside_p[i]  + " | Natch with buy or sell | ") ;
            if(exchange_orderside_p[i] == "BUY")
              {
               tradeTotalLong++;
               Print(" Exchange Symbol Matched BUY |"  + tradeTotalLong + " |") ;
              }
            if(exchange_orderside_p[i] == "SELL")
              {
               tradeTotalShort++;
               Print(" Exchange Symbol Matched SELL | "  + tradeTotalShort + " |") ;
              }
           }
        }
      return(true);
     }
   else
     {
      Print("Failed to Get_Position: " + exchangeName);
     }
   return(false);
  }

/*
   int               tradeTotalPendingLimitLong;
   int               tradeTotalPendingLimitShort;
   int               tradeTotalPendingStopLong;
   int               tradeTotalPendingStopShort;
*/
bool CBPFrameWork::tradeTotalPending()
  {
   if(bridge.Get_OpenOrders(Exchange_Symbol_Name,Exchange_Number,Exchange_Quote_Precision))
     {
      bridge.Parse_Orders(exchangeName,640, 1000);
      int loop = ArraySize(exchange_name);
      for(int i = 0; i<loop; i++)
        {
         if(Exchange_Symbol_Name ==  exchange_symbol[i])
           {
            if(exchange_orderside[i] == "BUY")
              {
               if(exchange_ordertype[i] == "LIMIT")
                 {
                  tradeTotalPendingLimitLong++;
                  Print(" Exchange Symbol Matched BUY LIMIT |"  + tradeTotalPendingLimitLong + " |") ;
                 }

              }
            if(exchange_orderside[i] == "SELL")
              {
               if(exchange_ordertype[i] == "LIMIT")
                 {
                  tradeTotalPendingLimitShort++;
                  Print(" Exchange Symbol Matched SELL LIMIT | "  + tradeTotalPendingLimitShort + " |") ;
                 }


              }


           }

        }
      return(true);
     }
   return(false);
  }

//+------------------------------------------------------------------+
/*
   bool              tradeDelete(string orderid);
   bool              tradeDeleteAll();
   bool              tradeDeleteAll(bool longOnly);
   bool              tradeDeleteLimit(bool longOnly);
   bool              tradeDeleteStop(bool longOnly);
*/
//+------------------------------------------------------------------+
bool CBPFrameWork::tradeDeleteAll()
  {

   if(bridge.Cancel_Trade_All(Exchange_Symbol_Name,Exchange_Number))
     {
      return(true);
     }
   return(false);
  }
//+------------------------------------------------------------------+
