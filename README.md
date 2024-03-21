
# MT5 RobotFrameWork
**Goal:** Build Automated Trading Strategies within MT5 quickly and effortlessly with ```mql5```. 

### What's inside?  

Includes a Crypto-Bridge child class for trading on Crypto Exchanges with [CB-API](https://github.com/TradingToolCrypto/TradingTool-Wiki/wiki/CB-API) . 
### Crypto Exchanges supported

Connects to Ascendex (Spot), Bitmex, Bybit (Futures), Binance (Spot+Futures), Kucoin (Spot), and FTX (Spot+Futures). 

# CBP FrameWork 
**CBP** stands for CryptoBridgePro (The crypto exchange bridge built for professional traders).  

This is the **Easy Crypto Trading Package** for MQL/MT5 that you've always dreamed about. [Let's take a look at what is inside](https://github.com/TradingToolCrypto/TradingTool-Wiki/wiki/CBP-Framework)
### Start building bots instantly
This **include** file makes life easier when making robots and other utilities.
![Screen Shot 2022-10-01 at 7 57 55 PM](https://user-images.githubusercontent.com/67847059/193410662-34c42881-bda1-4af3-b5d1-4a6b48d19719.png)



```c#
RobotFrameWork btc;
RobotFrameWork bnb;
RobotFrameWork eth;

CBPFrameWork crypto_bot_btc;
CBPFrameWork crypto_bot_bnb;
CBPFrameWork crypto_bot_eth;

btc.tradeBuy(0.1);// send market buy request to mt5 brokerage/backtester

bnb.tradeBid(1.25, bnb.symbolBid());// send buy limit request to mt5 brokerage/backtester

eth.tradeBuyStop(2.5,eth.symbolAsk());// send buy stop request to mt5 brokerage/backtester

// sends request to crypto exchange 
crypto_bot_eth.tradeBuyStop(2.5,eth.symbolAsk());
crypto_bot_bnb.tradeBid(2.5,bnb.symbolBid());
crypto_bot_btc.tradeBuy(2.5);

```

More order types are supported, but it is limited to the exchange offering the feature. 
```c#
  bool tradeBuyStopLimit(double volume, double trigger);
  bool tradeSellStopLimit(double volume, double trigger);
  bool tradeBuyStopLimit(double volume, double trigger, double orderprice);
  bool tradeSellStopLimit(double volume, double trigger, double orderprice);
```
Spend less time coding and more time focusing on your trading algorithms.  Add _two lines_ to get started.

```c++
#include <TradingToolCrypto\CBP\CBPFramework.mqh>  
CBPFrameWork cb;      // CryptoBridgePro child class
```

After adding the child class, you can access all the functions within **cb.** When you add the "." after **cb**, MetaEditor will use intellisense to list all the available functions from the CBP Framework. To view all the functions, please see the [mqh file](https://github.com/TradingToolCrypto/MT5-TradingToolCrypto/blob/master/MQL5/Include/TradingToolCrypto/CBP/CBPFrameWork.mqh). 

![function list](https://github.com/TradingToolCrypto/TradingTool-Wiki/blob/master/fqg75Eytxo.gif)
