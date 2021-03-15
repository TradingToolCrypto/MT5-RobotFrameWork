//+------------------------------------------------------------------+
//|                                                  BPFrameWork.mqh |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <TradingToolCrypto/CBP/RobotFrameWork.mqh>
#include <TradingToolCrypto/CBP/CryptoBridgeProClass.mqh>
CryptoBridge bridge;
RobotFrameWork symbol;
class CBPFrameWork: public RobotFrameWork
  {
private:
   string            frameworkPrefix;
public:
                     CBPFrameWork();
                    ~CBPFrameWork();

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
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
CBPFrameWork::CBPFrameWork()
  {
   frameworkPrefix = (string)Exchange_Number + "." + bridge.Get_Exchange_Name(Exchange_Number) + ".";
   bridge.Init_Api_Keys(Exchange_Number);
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
   double ask = symbol.symbolAsk();
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
   double bid = symbol.symbolBid();
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
   double bid = symbol.symbolBid();
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
   double ask = symbol.symbolAsk();
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
   double price = symbol.symbolBid();
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
   double price = symbol.symbolAsk();
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
