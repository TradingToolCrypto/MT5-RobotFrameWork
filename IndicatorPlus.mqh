#property copyright "Copyright 2020, TradingToolCrypto Corp"
#property link "https://github.com/TradingToolCrypto"
#property version "1.00"
input group "--------------START INDICATORS ------------------"

input string PLEASE_ADJUST_BB_STATEGY     = "------------------------------------";
input int MA_PERIOD_A                     = 0;
input ENUM_MA_METHOD MA_TYPE              = MODE_EMA;
input ENUM_APPLIED_PRICE MA_DATA_TYPE     = PRICE_MEDIAN;
input double MA_DEVIATION                 = 2.0;
input int MA_BAR_SHIFT                    = 0;

input string PLEASE_ADJUST_EMA_STATEGY    = "------------------------------------";
input int EMA_PERIOD_A                    = 0;
input int EMA_PERIOD_B                    = 0;
input ENUM_MA_METHOD EMA_TYPE             = MODE_EMA;
input ENUM_APPLIED_PRICE EMA_DATA_TYPE    = PRICE_CLOSE;
input int EMA_BAR_SHIFT                   = 0;

input double EMASPREAD_BUY                = -0.60;
input double EMASPREAD_SELL               = 0.60;

input string PLEASE_ADJUST_RSI_STATEGY    = "------------------------------------";
input int RSI_PERIOD_A                    = 0;
input ENUM_APPLIED_PRICE RSI_DATA_TYPE    = PRICE_CLOSE;
input double RSI_BUY                      = 20;
input double RSI_SELL                     = 80;

input string PLEASE_ADJUST_FRACTAL_STATEGY = "------------------------------------";
input int ExtDepth                         = 6;
input int ExtDeviation                     = 5;
input int ExtBackStep                      = 3;

input string PLEASE_ADJUST_CUSTOM_RSI_STATEGY = "------------------------------------";
input int  CUSTOM_RSI_PERIOD                  = 0;
input int  CUSTOM_RSI_SMOOTHING               = 0;
input double CUSTOM_RSI_LEVEL_UP              = 80;
input double CUSTOM_RSI_LEVEL_DN              = 20;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class IndicatorPlus
  {
private:
   int               instance;
   string            market_name;
   int               MA_handle_1;
   int               STD_handle_1;
   int               EMA_handle_1;
   int               EMA_handle_2;
   int               RSI_handle_1;
   int               ZZ_handle_1;
   int               CUSTOM_RSI_handle_1;
   double            RSI[], EMA_1[], EMA_2[];
   double            BBUp[], BBLow[], BBMidle[];
   double            StdDevBuffer[];
   double            CRSI1[];
   double            ZZ[];
   enum enPrices
     {
      pr_close,      // Close
      pr_open,       // Open
      pr_high,       // High
      pr_low,        // Low
      pr_median,     // Median
      pr_typical,    // Typical
      pr_weighted,   // Weighted
      pr_average,    // Average (high+low+open+close)/4
      pr_medianb,    // Average median body (open+close)/2
      pr_tbiased,    // Trend biased price
      pr_tbiased2,   // Trend biased (extreme) price
      pr_haclose,    // Heiken ashi close
      pr_haopen,     // Heiken ashi open
      pr_hahigh,     // Heiken ashi high
      pr_halow,      // Heiken ashi low
      pr_hamedian,   // Heiken ashi median
      pr_hatypical,  // Heiken ashi typical
      pr_haweighted, // Heiken ashi weighted
      pr_haaverage,  // Heiken ashi average
      pr_hamedianb,  // Heiken ashi median body
      pr_hatbiased,  // Heiken ashi trend biased price
      pr_hatbiased2  // Heiken ashi trend biased (extreme) price
     };
   enum enRsiTypes
     {
      rsi_cut,  // Cuttler's RSI
      rsi_ehl,  // Ehlers' smoothed RSI
      rsi_har,  // Harris' RSI
      rsi_rap,  // Rapid RSI
      rsi_rsi,  // RSI
      rsi_rsx,  // RSX
      rsi_slo   // Slow RSI
     };
   enum enColorOn
     {
      cc_onSlope,   // Change color on slope change
      cc_onMiddle,  // Change color on middle line cross
      cc_onLevels   // Change color on outer levels cross
     };
   enum enMaTypes
     {
      ma_sma,    // Simple moving average
      ma_ema,    // Exponential moving average
      ma_smma,   // Smoothed MA
      ma_lwma    // Linear weighted MA
     };
public:
                     IndicatorPlus();
                     IndicatorPlus(int pointer);
                    ~IndicatorPlus();
   bool              Init_IndicatorPlus(string what_market);
   double            get_zig_direction(int copy_count);
   double            get_zag_direction(int copy_count);
   double            get_zig(bool isHigh, int copy_count);
   double            get_zig_any(bool isHigh, int copy_count, int thisHighLow);
   double            get_signal_bands(int buffer, int bar_index);
   double            get_ma_deviation(int bar_index);
   double            get_custom_rsi(int bar_index, int buffer);
   double            get_standard_deviation_price(int bar_index);
   double            get_rsi(int bar_index);
   double            get_ema_spread(int bar_index);

   string            get_standard_deviation_signal();
   string            get_ema_cross_signal();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
IndicatorPlus::IndicatorPlus(int pointer)
  {
    instance = pointer;
    Print("RobotFrameWork Loaded: Instance(" + IntegerToString(pointer) + ")");
  }
  IndicatorPlus::IndicatorPlus()
  {
   
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
IndicatorPlus::~IndicatorPlus()
  {
  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IndicatorPlus::Init_IndicatorPlus(string what_market)
  {

   market_name = what_market;

   if(MA_PERIOD_A != 0)
     {
      MA_handle_1 = iBands(what_market, PERIOD_CURRENT, MA_PERIOD_A, MA_BAR_SHIFT, MA_DEVIATION, MA_DATA_TYPE);
      //--- report if there was an error in object creation
      if(MA_handle_1 < 0)
        {
         Print("The creation of iMA has failed: MA_handle=", INVALID_HANDLE);
         Print("Runtime error = ", GetLastError());
         //--- forced program termination
         return (false);
        }
     }

   if(EMA_PERIOD_A != 0)
     {
      EMA_handle_1 = iMA(what_market, PERIOD_CURRENT, EMA_PERIOD_A, EMA_BAR_SHIFT, EMA_TYPE, EMA_DATA_TYPE);
      if(EMA_handle_1 < 0)
        {
         Print("The creation of iMA has failed: EMA_handle_1 =", INVALID_HANDLE);
         Print("Runtime error = ", GetLastError());
         //--- forced program termination
         return (false);
        }
     }

   if(EMA_PERIOD_A != 0)
     {
      EMA_handle_2 = iMA(what_market, PERIOD_CURRENT, EMA_PERIOD_B, EMA_BAR_SHIFT, EMA_TYPE, EMA_DATA_TYPE);
      if(EMA_handle_2 < 0)
        {
         Print("The creation of iMA has failed: EMA_handle_2 =", INVALID_HANDLE);
         Print("Runtime error = ", GetLastError());
         //--- forced program termination
         return (false);
        }
     }

   if(RSI_PERIOD_A != 0)
     {
      RSI_handle_1 = iRSI(what_market, PERIOD_CURRENT, RSI_PERIOD_A, RSI_DATA_TYPE);
      //--- report if there was an error in object creation
      if(RSI_handle_1 < 0)
        {
         Print("The creation of iRSI has failed: RSI_handle=", INVALID_HANDLE);
         Print("Runtime error = ", GetLastError());
         //--- forced program termination
         return (false);
        }
     }

   if(MA_PERIOD_A != 0)
     {
      STD_handle_1=  iStdDev(what_market,PERIOD_CURRENT,MA_PERIOD_A,MA_BAR_SHIFT,MA_TYPE,MA_DATA_TYPE);
      //--- report if there was an error in object creation
      if(STD_handle_1<0)
        {
         Print("The creation of iSTD has failed: STD_handle=",INVALID_HANDLE);
         Print("Runtime error = ",GetLastError());
         //--- forced program termination
         return(false);
        }
     }

   if(ExtDepth != 0)
     {
      ZZ_handle_1 = iCustom(Symbol(), PERIOD_CURRENT, "Examples\\ZigZag", ExtDepth, ExtDeviation, ExtBackStep);
      //--- report if there was an error in object creation
      if(ZZ_handle_1<0)
        {
         Print("The creation of iCustom has failed:=",INVALID_HANDLE);
         Print("Runtime error = ",GetLastError());
         //--- forced program termination
         return(false);
        }
     }



   if(CUSTOM_RSI_PERIOD != 0 )
     {
      CUSTOM_RSI_handle_1 = iCustom(Symbol(), PERIOD_CURRENT, "RSI_FISHER",
                                    CUSTOM_RSI_PERIOD,
                                    (enPrices)pr_close,
                                    (enRsiTypes)rsi_rsi,
                                    CUSTOM_RSI_SMOOTHING,
                                    (enMaTypes)ma_ema,
                                    (enColorOn)cc_onLevels,
                                    (int)50,
                                    CUSTOM_RSI_LEVEL_UP,
                                    CUSTOM_RSI_LEVEL_DN);
      if(CUSTOM_RSI_handle_1<0)
        {
         Print("The creation of iCustom has failed:=",INVALID_HANDLE);
         Print("Runtime error = ",GetLastError());
         //--- forced program termination
         return(false);
        }
     }



// everything is ok
   Print("init_Indicators ok");
   return (true);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_zig_direction(int copy_count)
  {
   int copied = CopyBuffer(ZZ_handle_1, 0, 0, copy_count, ZZ);
   ArraySetAsSeries(ZZ, true);
   for(int i = 0; i< copied; i++)
     {
      if(ZZ[i] != 0)
        {
         return(ZZ[i]);
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_zag_direction(int copy_count)
  {

   int copied = CopyBuffer(ZZ_handle_1, 0, 0, copy_count, ZZ);
   ArraySetAsSeries(ZZ, true);
   int count  =0;
   for(int i = 0; i< copied; i++)
     {
      if(ZZ[i] != 0)
        {
         count++;
         if(count==2)
           {
            return(ZZ[i]);
           }
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_zig(bool isHigh, int copy_count)
  {
   int copied = CopyBuffer(ZZ_handle_1, 0, 0, copy_count, ZZ);
   double price = iOpen(market_name,PERIOD_CURRENT,1);
   ArraySetAsSeries(ZZ, true);
   for(int i = 0; i< copied; i++)
     {
      if(i>=3)
        {
         if(ZZ[i] != 0)
           {
            if(isHigh)
              {
               if(ZZ[i] > price)
                 {
                  return(ZZ[i]);
                 }
              }
            if(!isHigh)
              {
               if(ZZ[i] < price)
                 {
                  return(ZZ[i]);
                 }
              }
           }
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_zig_any(bool isHigh, int copy_count, int thisHighLow)
  {
   int counter = 0;
   double last_zig = 0;
   int copied = CopyBuffer(ZZ_handle_1, 0, 0, copy_count, ZZ);
   double price = iOpen(market_name,PERIOD_CURRENT,1);
   double high =  iHigh(market_name,PERIOD_CURRENT,0);
   double low =  iLow(market_name,PERIOD_CURRENT,0);
   ArraySetAsSeries(ZZ, true);
   for(int i = 0; i< copied; i++)
     {
      if(ZZ[i] != 0)
        {
         if(isHigh)
           {
            if(ZZ[i] > price && i != 0)
              {
               counter++;
               if(counter >= thisHighLow && ZZ[i] > last_zig && last_zig != 0 && ZZ[i] > high)
                 {
                  return(ZZ[i]);
                 }
               last_zig = ZZ[i];
              }
           }
         if(!isHigh)
           {
            if(ZZ[i] < price && i != 0)
              {
               counter++;
               if(counter >= thisHighLow && ZZ[i] < last_zig && last_zig !=0 && ZZ[i] < low)
                 {
                  return(ZZ[i]);
                 }
               last_zig = ZZ[i];
              }
           }
        }
     }
   return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_signal_bands(int buffer, int bar_index)
  {
   CopyBuffer(MA_handle_1, 0, 0, bar_index+1, BBMidle);
   CopyBuffer(MA_handle_1, 1, 0, bar_index+1, BBUp);
   CopyBuffer(MA_handle_1, 2, 0, bar_index+1, BBLow);
   ArraySetAsSeries(BBUp, true);
   ArraySetAsSeries(BBLow, true);
   ArraySetAsSeries(BBMidle, true);
   if(buffer == 1)
     {
      return (BBUp[bar_index]);
     }
   if(buffer == 2)
     {
      return (BBMidle[bar_index]);
     }
   if(buffer == 3)
     {
      return (BBLow[bar_index]);
     }
   return (0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_ma_deviation(int bar_index)
  {
   CopyBuffer(MA_handle_1, 0, 0, bar_index+1, BBMidle);
   CopyBuffer(MA_handle_1, 1, 0, bar_index+1, BBUp);
   CopyBuffer(MA_handle_1, 2, 0, bar_index+1, BBLow);
   ArraySetAsSeries(BBUp, true);
   ArraySetAsSeries(BBLow, true);
   ArraySetAsSeries(BBMidle, true);
   double width = BBUp[bar_index] - BBLow[bar_index];
   return (width);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_custom_rsi(int bar_index, int buffer)
  {
   CopyBuffer(CUSTOM_RSI_handle_1, buffer, 0, bar_index+1, CRSI1);
   ArraySetAsSeries(CRSI1, true);
   double width = CRSI1[bar_index];
   return (width);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string IndicatorPlus::get_standard_deviation_signal()
  {

   CopyBuffer(STD_handle_1, 0, 0, 4, StdDevBuffer);
   ArraySetAsSeries(StdDevBuffer, true);
   string decision = "";
   if(StdDevBuffer[1] > StdDevBuffer[2] && StdDevBuffer[2] > StdDevBuffer[3])
     {
      // std increasing
      decision = "up";
     }
   if(StdDevBuffer[1] < StdDevBuffer[2] && StdDevBuffer[2] < StdDevBuffer[3])
     {
      // std decreasing
      decision = "down";
     }
   if(decision == "")
     {
      decision = "flat";
     }
   return (decision);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_standard_deviation_price(int bar_index)
  {
   CopyBuffer(STD_handle_1, 0, 0,  bar_index+1, StdDevBuffer);
   ArraySetAsSeries(StdDevBuffer, true);
   double normalize = NormalizeDouble(StdDevBuffer[ bar_index], 8);
   return (normalize);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_rsi(int bar_index)
  {
   CopyBuffer(RSI_handle_1, 0, 0,  bar_index+1, RSI);
   ArraySetAsSeries(RSI, true);
   return (NormalizeDouble(RSI[bar_index], 2));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double IndicatorPlus::get_ema_spread(int bar_index)
  {
   double ema1 = 0;
   double ema2 = 0;
   CopyBuffer(EMA_handle_1, 0, 0,  bar_index+1, EMA_1);
   CopyBuffer(EMA_handle_2, 0, 0,  bar_index+1, EMA_2);
   ArraySetAsSeries(EMA_1, true);
   ArraySetAsSeries(EMA_2, true);
   ema1 = EMA_1[bar_index];
   ema2 = EMA_2[bar_index];
//Spread is the percentage spread difference between EMA1 (Slow) and EMA2 (Fast)
   return (NormalizeDouble(((ema1 / ema2) - 1) * 100, 2));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string IndicatorPlus::get_ema_cross_signal()
  {
   double ema1a = 0;
   double ema2a = 0;
   double ema1b = 0;
   double ema2b = 0;
   CopyBuffer(EMA_handle_1, 0, 0, 5, EMA_1);
   CopyBuffer(EMA_handle_2, 0, 0, 5, EMA_2);
   ArraySetAsSeries(EMA_1, true);
   ArraySetAsSeries(EMA_2, true);

   ema1a = EMA_1[0];
   ema2a = EMA_2[0];
   ema1b = EMA_1[1];
   ema2b = EMA_2[1];

// cross up
   if(ema1a > ema2a && ema1b <= ema2b)
     {
      return("CROSSUP");
     }
// cross down
   if(ema1a < ema2a && ema1b >= ema2b)
     {
      return("CROSSDOWN");
     }
   return("NONE");
  }
