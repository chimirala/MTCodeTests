//+------------------------------------------------------------------+
//|                                               Stuart11_Simplified.mq5 |
//|                                      Copyright 2025, BNS |
//|                     Simplified MQL5 version - Basic MA types only |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, BNS"
#property version   "5.1"
#property description "Simplified Multi-MA System with Grid (SMA, EMA, SMMA, LWMA only)"

#property indicator_chart_window
#property indicator_buffers 8
#property indicator_plots   8

enum MAMODE
{
   SMA,
   EMA,
   SMMA,
   LWMA
};

enum OCTextLocationE
{
   OnCandle,
   OnStuart
};

enum CrossPriceTypeE
{
   ClosePrice,
   TouchPrice
};

enum DrawOffsetMAE
{
   Single,
   Double,
   None
};

// Input parameters for 8 MA arrays
input ENUM_TIMEFRAMES lowerTF      = PERIOD_M1;
input int      IndNumber           = 0;

input bool     UseArray1           = true;
input ENUM_TIMEFRAMES UATimeFrame1 = PERIOD_CURRENT;
input MAMODE   UAMAMode1           = SMA;
input int      UAMAPeriod1         = 100;
input ENUM_APPLIED_PRICE UAPriceType1 = PRICE_HIGH;

input bool     UseArray2           = true;
input ENUM_TIMEFRAMES UATimeFrame2 = PERIOD_CURRENT;
input MAMODE   UAMAMode2           = SMA;
input int      UAMAPeriod2         = 100;
input ENUM_APPLIED_PRICE UAPriceType2 = PRICE_LOW;

input bool     UseArray3           = true;
input ENUM_TIMEFRAMES UATimeFrame3 = PERIOD_CURRENT;
input MAMODE   UAMAMode3           = SMA;
input int      UAMAPeriod3         = 100;
input ENUM_APPLIED_PRICE UAPriceType3 = PRICE_CLOSE;

input bool     UseArray4           = true;
input ENUM_TIMEFRAMES UATimeFrame4 = PERIOD_CURRENT;
input MAMODE   UAMAMode4           = SMA;
input int      UAMAPeriod4         = 150;
input ENUM_APPLIED_PRICE UAPriceType4 = PRICE_HIGH;

input bool     UseArray5           = true;
input ENUM_TIMEFRAMES UATimeFrame5 = PERIOD_CURRENT;
input MAMODE   UAMAMode5           = SMA;
input int      UAMAPeriod5         = 150;
input ENUM_APPLIED_PRICE UAPriceType5 = PRICE_LOW;

input bool     UseArray6           = true;
input ENUM_TIMEFRAMES UATimeFrame6 = PERIOD_CURRENT;
input MAMODE   UAMAMode6           = EMA;
input int      UAMAPeriod6         = 150;
input ENUM_APPLIED_PRICE UAPriceType6 = PRICE_CLOSE;

input bool     UseArray7           = true;
input ENUM_TIMEFRAMES UATimeFrame7 = PERIOD_CURRENT;
input MAMODE   UAMAMode7           = EMA;
input int      UAMAPeriod7         = 100;
input ENUM_APPLIED_PRICE UAPriceType7 = PRICE_HIGH;

input bool     UseArray8           = true;
input ENUM_TIMEFRAMES UATimeFrame8 = PERIOD_CURRENT;
input MAMODE   UAMAMode8           = EMA;
input int      UAMAPeriod8         = 100;
input ENUM_APPLIED_PRICE UAPriceType8 = PRICE_LOW;

// Signal generation parameters
input bool     DrawStuart          = true;
input CrossPriceTypeE StuartCrossPriceType = ClosePrice;
input bool     DrawOffsetMA        = true;     // Draw offset MA lines
input CrossPriceTypeE MAOffsetCrossPriceType = ClosePrice;
input int      OffsetGridLevel     = 2;
input double   LowerGridOffsetPips = 15;
input color    OffsetLineColor     = clrHotPink;

input group "=== MA Colors ==="
input color    MA1_Color           = clrRed;
input color    MA2_Color           = clrGreen;
input color    MA3_Color           = clrBlue;
input color    MA4_Color           = clrYellow;
input color    MA5_Color           = clrMagenta;
input color    MA6_Color           = clrCyan;
input color    MA7_Color           = clrOrange;
input color    MA8_Color           = clrWhite;

input bool     DrawOverCup         = true;
input color    OverCupStuartLineColor  = clrBlue;
input color    OverCupMAOffsetLineColor = clrRed;
input color    OverCupSignalColor  = clrYellow;
input OCTextLocationE OCTextLocation = OnCandle;

// Grid parameters
input group "=== Price Grid Parameters ==="
input bool     DrawGrid            = true;              // Enable/disable horizontal price grid
input int      HGridPips           = 0;                 // Grid step in pips (0=auto calculate)
input color    HLine               = clrDarkGreen;      // Regular grid line color
input color    HLine2              = clrLimeGreen;      // Every 10th grid line color

input group "=== Time Grid Parameters (Not Implemented) ==="
input int      GridTime            = 10000;             // Time grid periods (not used)
input ENUM_TIMEFRAMES TimeGrid     = PERIOD_CURRENT;    // Time grid timeframe (not used)
input int      ColorHour           = 0;                 // Special hour marking (not used)
input color    TimeLine            = CLR_NONE;          // Time grid color (not used)
input color    TimeLine2           = CLR_NONE;          // Special time color (not used)

input group "=== Other Parameters ==="
input int      HGridWeeks          = 20000;             // Historical calculation period (not used for grid)

input int      BarCount            = 10000;

// Indicator buffers
double MA_Buffer1[];
double MA_Buffer2[];
double MA_Buffer3[];
double MA_Buffer4[];
double MA_Buffer5[];
double MA_Buffer6[];
double MA_Buffer7[];
double MA_Buffer8[];

// Global variables
double TPoint;
int HGridPipsCur;
bool Init = true;
string IndPrefix;

struct ArrayStruct
{
   bool UseArray;
   ENUM_TIMEFRAMES TimeFrame;
   MAMODE MAMode;
   int MAPeriod;
   ENUM_APPLIED_PRICE PriceType;
   int ma_handle;
   bool BuySell;
   bool CrossOver;
   int LastCrossBarNo;
   double LastCrossY;
   bool CrossedOver[3];
};

ArrayStruct arrayStructs[8];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   if((SymbolInfoInteger(Symbol(), SYMBOL_DIGITS) == 5 || SymbolInfoInteger(Symbol(), SYMBOL_DIGITS) == 3))
      TPoint = SymbolInfoDouble(Symbol(), SYMBOL_POINT) * 10;
   else
      TPoint = SymbolInfoDouble(Symbol(), SYMBOL_POINT);
   
   IndPrefix = "ST" + IntegerToString(IndNumber);
   
   // Initialize array structures
   InitArrayStruct(0, UseArray1, UATimeFrame1, UAMAMode1, UAMAPeriod1, UAPriceType1);
   InitArrayStruct(1, UseArray2, UATimeFrame2, UAMAMode2, UAMAPeriod2, UAPriceType2);
   InitArrayStruct(2, UseArray3, UATimeFrame3, UAMAMode3, UAMAPeriod3, UAPriceType3);
   InitArrayStruct(3, UseArray4, UATimeFrame4, UAMAMode4, UAMAPeriod4, UAPriceType4);
   InitArrayStruct(4, UseArray5, UATimeFrame5, UAMAMode5, UAMAPeriod5, UAPriceType5);
   InitArrayStruct(5, UseArray6, UATimeFrame6, UAMAMode6, UAMAPeriod6, UAPriceType6);
   InitArrayStruct(6, UseArray7, UATimeFrame7, UAMAMode7, UAMAPeriod7, UAPriceType7);
   InitArrayStruct(7, UseArray8, UATimeFrame8, UAMAMode8, UAMAPeriod8, UAPriceType8);
   
   // Set up indicator buffers
   SetIndexBuffer(0, MA_Buffer1, INDICATOR_DATA);
   SetIndexBuffer(1, MA_Buffer2, INDICATOR_DATA);
   SetIndexBuffer(2, MA_Buffer3, INDICATOR_DATA);
   SetIndexBuffer(3, MA_Buffer4, INDICATOR_DATA);
   SetIndexBuffer(4, MA_Buffer5, INDICATOR_DATA);
   SetIndexBuffer(5, MA_Buffer6, INDICATOR_DATA);
   SetIndexBuffer(6, MA_Buffer7, INDICATOR_DATA);
   SetIndexBuffer(7, MA_Buffer8, INDICATOR_DATA);
   
   // Set plot properties
   SetupPlot(0, UseArray1, "MA1", MA1_Color, 3);
   SetupPlot(1, UseArray2, "MA2", MA2_Color, 3);
   SetupPlot(2, UseArray3, "MA3", MA3_Color, 3);
   SetupPlot(3, UseArray4, "MA4", MA4_Color, 2);
   SetupPlot(4, UseArray5, "MA5", MA5_Color, 2);
   SetupPlot(5, UseArray6, "MA6", MA6_Color, 2);
   SetupPlot(6, UseArray7, "MA7", MA7_Color, 2);
   SetupPlot(7, UseArray8, "MA8", MA8_Color, 2);
   
   // Set empty values
   for(int i = 0; i < 8; i++)
      PlotIndexSetDouble(i, PLOT_EMPTY_VALUE, 0.0);
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Setup plot properties                                            |
//+------------------------------------------------------------------+
void SetupPlot(int index, bool useArray, string label, color clr, int width)
{
   if(useArray)
   {
      PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_LINE);
      PlotIndexSetInteger(index, PLOT_LINE_STYLE, STYLE_SOLID);
      PlotIndexSetInteger(index, PLOT_LINE_WIDTH, width);
      PlotIndexSetInteger(index, PLOT_LINE_COLOR, clr);
      PlotIndexSetString(index, PLOT_LABEL, label);
   }
   else
   {
      PlotIndexSetInteger(index, PLOT_DRAW_TYPE, DRAW_NONE);
   }
}

//+------------------------------------------------------------------+
//| Initialize array structure                                        |
//+------------------------------------------------------------------+
void InitArrayStruct(int index, bool useArray, ENUM_TIMEFRAMES timeFrame, MAMODE maMode, 
                     int maPeriod, ENUM_APPLIED_PRICE priceType)
{
   if(index < 0 || index >= 8) return;
   
   arrayStructs[index].UseArray = useArray;
   arrayStructs[index].TimeFrame = timeFrame;
   arrayStructs[index].MAMode = maMode;
   arrayStructs[index].MAPeriod = maPeriod;
   arrayStructs[index].PriceType = priceType;
   arrayStructs[index].BuySell = false;
   arrayStructs[index].CrossOver = false;
   arrayStructs[index].LastCrossBarNo = 0;
   arrayStructs[index].LastCrossY = 0.0;
   
   // Initialize CrossedOver array
   for(int i = 0; i < 3; i++)
      arrayStructs[index].CrossedOver[i] = false;
   
   if(useArray)
   {
      ENUM_MA_METHOD method = MODE_SMA;
      switch(maMode)
      {
         case SMA:  method = MODE_SMA; break;
         case EMA:  method = MODE_EMA; break;
         case SMMA: method = MODE_SMMA; break;
         case LWMA: method = MODE_LWMA; break;
      }
      
      arrayStructs[index].ma_handle = iMA(Symbol(), timeFrame, maPeriod, 0, method, priceType);
      
      if(arrayStructs[index].ma_handle == INVALID_HANDLE)
      {
         Print("Error creating MA handle for array ", index, ", Error: ", GetLastError());
      }
      else
      {
         Print("MA handle created successfully for array ", index, ", handle: ", arrayStructs[index].ma_handle);
      }
   }
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
   if(Init)
   {
      if(HGridPips == 0)
      {
         if(TPoint <= 0.0001)
            HGridPipsCur = 10;
         else if(TPoint <= 0.001)
            HGridPipsCur = 100;
         else
         {
            if(rates_total == 0)
               return(rates_total);
               
            if(close[rates_total-1] < 100)
               HGridPipsCur = (int)(10 / TPoint);  // Force multiples of 10
            else if(close[rates_total-1] < 5000)
               HGridPipsCur = (int)(100 / TPoint); // Force multiples of 10
            else
               HGridPipsCur = (int)(1000 / TPoint); // Force multiples of 10
         }
      }
      else
         HGridPipsCur = HGridPips;
         
      // Ensure HGridPipsCur is multiple of 10
      if(HGridPipsCur % 10 != 0)
         HGridPipsCur = ((HGridPipsCur / 10) + 1) * 10;
         
      Comment("Grid Step: " + DoubleToString(HGridPipsCur, 1));
      Init = false;
   }
   
   int limit = rates_total - prev_calculated;
   if(prev_calculated > 0)
      limit++;
   
   if(limit > BarCount && BarCount > 0)
      limit = BarCount;
   
   // Calculate MA values
   for(int i = 0; i < limit; i++)
   {
      int bar_index = rates_total - 1 - i;
      
      if(UseArray1)
      {
         MA_Buffer1[bar_index] = CalculateMA(0, i);
         if(i == 0) Print("MA1[", bar_index, "] = ", MA_Buffer1[bar_index]);
      }
      if(UseArray2)
      {
         MA_Buffer2[bar_index] = CalculateMA(1, i);
         if(i == 0) Print("MA2[", bar_index, "] = ", MA_Buffer2[bar_index]);
      }
      if(UseArray3)
      {
         MA_Buffer3[bar_index] = CalculateMA(2, i);
         if(i == 0) Print("MA3[", bar_index, "] = ", MA_Buffer3[bar_index]);
      }
      if(UseArray4)
         MA_Buffer4[bar_index] = CalculateMA(3, i);
      if(UseArray5)
         MA_Buffer5[bar_index] = CalculateMA(4, i);
      if(UseArray6)
         MA_Buffer6[bar_index] = CalculateMA(5, i);
      if(UseArray7)
         MA_Buffer7[bar_index] = CalculateMA(6, i);
      if(UseArray8)
         MA_Buffer8[bar_index] = CalculateMA(7, i);
   }
   
   // Generate signals if enabled
   if(DrawStuart || DrawOverCup)
   {
      GenerateSignals(rates_total, prev_calculated, time, open, high, low, close);
   }
   
   // Draw grid if enabled
   if(DrawGrid)
   {
      DrawGrid();
   }
   
   // Draw offset MA lines if enabled
   if(DrawOffsetMA)
   {
      DrawOffsetMALines();
   }
   
   // Update MA colors if needed
   UpdateMAColors();
   
   return(rates_total);
}

//+------------------------------------------------------------------+
//| Calculate MA value for specific array                            |
//+------------------------------------------------------------------+
double CalculateMA(int arrayIndex, int shift)
{
   if(arrayIndex < 0 || arrayIndex >= 8 || !arrayStructs[arrayIndex].UseArray)
      return 0.0;
   
   if(arrayStructs[arrayIndex].ma_handle != INVALID_HANDLE)
   {
      double ma_values[];
      ArraySetAsSeries(ma_values, true);
      int copied = CopyBuffer(arrayStructs[arrayIndex].ma_handle, 0, shift, 1, ma_values);
      if(copied > 0)
      {
         if(shift == 0 && arrayIndex == 0) Print("MA Handle valid, copied: ", copied, ", value: ", ma_values[0]);
         return ma_values[0];
      }
      else
      {
         if(shift == 0 && arrayIndex == 0) Print("Failed to copy buffer, error: ", GetLastError());
      }
   }
   else
   {
      if(shift == 0 && arrayIndex == 0) Print("Invalid MA handle for array ", arrayIndex);
   }
   
   return 0.0;
}

//+------------------------------------------------------------------+
//| Generate trading signals                                         |
//+------------------------------------------------------------------+
void GenerateSignals(int rates_total, int prev_calculated, const datetime &time[], 
                     const double &open[], const double &high[], 
                     const double &low[], const double &close[])
{
   // Simple crossover signal generation
   for(int i = 1; i < rates_total - 1; i++)
   {
      // Check crossovers between MA1 and MA2 (if both enabled)
      if(UseArray1 && UseArray2 && MA_Buffer1[i] > 0 && MA_Buffer2[i] > 0)
      {
         // Bullish crossover: MA1 crosses above MA2
         if(MA_Buffer1[i] > MA_Buffer2[i] && MA_Buffer1[i+1] <= MA_Buffer2[i+1])
         {
            CreateSignal(i, true, time[i], MA_Buffer1[i]);
         }
         // Bearish crossover: MA1 crosses below MA2
         else if(MA_Buffer1[i] < MA_Buffer2[i] && MA_Buffer1[i+1] >= MA_Buffer2[i+1])
         {
            CreateSignal(i, false, time[i], MA_Buffer1[i]);
         }
      }
   }
}

//+------------------------------------------------------------------+
//| Create visual signal                                             |
//+------------------------------------------------------------------+
void CreateSignal(int barIndex, bool isBuy, datetime signalTime, double price)
{
   if(!DrawOverCup) return;
   
   string signalName = IndPrefix + "_Signal_" + IntegerToString(barIndex);
   
   if(ObjectFind(0, signalName) < 0)
   {
      ObjectCreate(0, signalName, OBJ_ARROW, 0, signalTime, price);
      ObjectSetInteger(0, signalName, OBJPROP_ARROWCODE, isBuy ? 233 : 234);
      ObjectSetInteger(0, signalName, OBJPROP_COLOR, isBuy ? clrLime : clrRed);
      ObjectSetInteger(0, signalName, OBJPROP_WIDTH, 3);
   }
}

//+------------------------------------------------------------------+
//| Update MA colors                                                 |
//+------------------------------------------------------------------+
void UpdateMAColors()
{
   static color lastMA1Color = CLR_NONE;
   static color lastMA2Color = CLR_NONE;
   static color lastMA3Color = CLR_NONE;
   static color lastMA4Color = CLR_NONE;
   static color lastMA5Color = CLR_NONE;
   static color lastMA6Color = CLR_NONE;
   static color lastMA7Color = CLR_NONE;
   static color lastMA8Color = CLR_NONE;
   
   if(UseArray1 && lastMA1Color != MA1_Color)
   {
      PlotIndexSetInteger(0, PLOT_LINE_COLOR, MA1_Color);
      lastMA1Color = MA1_Color;
   }
   if(UseArray2 && lastMA2Color != MA2_Color)
   {
      PlotIndexSetInteger(1, PLOT_LINE_COLOR, MA2_Color);
      lastMA2Color = MA2_Color;
   }
   if(UseArray3 && lastMA3Color != MA3_Color)
   {
      PlotIndexSetInteger(2, PLOT_LINE_COLOR, MA3_Color);
      lastMA3Color = MA3_Color;
   }
   if(UseArray4 && lastMA4Color != MA4_Color)
   {
      PlotIndexSetInteger(3, PLOT_LINE_COLOR, MA4_Color);
      lastMA4Color = MA4_Color;
   }
   if(UseArray5 && lastMA5Color != MA5_Color)
   {
      PlotIndexSetInteger(4, PLOT_LINE_COLOR, MA5_Color);
      lastMA5Color = MA5_Color;
   }
   if(UseArray6 && lastMA6Color != MA6_Color)
   {
      PlotIndexSetInteger(5, PLOT_LINE_COLOR, MA6_Color);
      lastMA6Color = MA6_Color;
   }
   if(UseArray7 && lastMA7Color != MA7_Color)
   {
      PlotIndexSetInteger(6, PLOT_LINE_COLOR, MA7_Color);
      lastMA7Color = MA7_Color;
   }
   if(UseArray8 && lastMA8Color != MA8_Color)
   {
      PlotIndexSetInteger(7, PLOT_LINE_COLOR, MA8_Color);
      lastMA8Color = MA8_Color;
   }
}

//+------------------------------------------------------------------+
//| Draw grid if enabled                                             |
//+------------------------------------------------------------------+
void DrawGrid()
{
   static bool gridDrawn = false;
   static color lastHLine = CLR_NONE;
   static color lastHLine2 = CLR_NONE;
   
   // Check if colors changed, redraw if needed
   if(lastHLine != HLine || lastHLine2 != HLine2)
   {
      // Delete existing grid lines
      for(int i = -50; i <= 50; i++)
      {
         string gridName = IndPrefix + "_Grid_" + IntegerToString(i);
         ObjectDelete(0, gridName);
      }
      gridDrawn = false;
      lastHLine = HLine;
      lastHLine2 = HLine2;
   }
   
   if(gridDrawn) return;
   
   // Basic grid implementation
   double currentPrice = SymbolInfoDouble(Symbol(), SYMBOL_BID);
   double gridStep = HGridPipsCur * TPoint;
   
   if(gridStep > 0)
   {
      // Draw grid lines around current price
      for(int i = -50; i <= 50; i++)
      {
         double gridPrice = currentPrice + (i * gridStep);
         string gridName = IndPrefix + "_Grid_" + IntegerToString(i);
         
         ObjectCreate(0, gridName, OBJ_HLINE, 0, 0, gridPrice);
         // Every 10th line uses HLine2 color with thicker width
         if(i % 10 == 0)
         {
            ObjectSetInteger(0, gridName, OBJPROP_COLOR, HLine2);
            ObjectSetInteger(0, gridName, OBJPROP_WIDTH, 2);
         }
         else
         {
            ObjectSetInteger(0, gridName, OBJPROP_COLOR, HLine);
            ObjectSetInteger(0, gridName, OBJPROP_WIDTH, 1);
         }
         ObjectSetInteger(0, gridName, OBJPROP_STYLE, STYLE_DOT);
      }
      
      gridDrawn = true;
      Print("Grid drawn with ", 101, " lines, step: ", gridStep, " (", HGridPipsCur, " pips) around price: ", currentPrice);
   }
}

//+------------------------------------------------------------------+
//| Draw offset MA lines                                             |
//+------------------------------------------------------------------+
void DrawOffsetMALines()
{
   static bool offsetLinesDrawn = false;
   if(offsetLinesDrawn) return;
   
   // Calculate offset values
   double offsetDistance = LowerGridOffsetPips * TPoint;
   
   // Get all current MA values for offset calculation
   double maValues[];
   ArrayResize(maValues, 0);
   
   if(UseArray1 && ArraySize(MA_Buffer1) > 0 && MA_Buffer1[0] > 0)
   {
      ArrayResize(maValues, ArraySize(maValues) + 1);
      maValues[ArraySize(maValues) - 1] = MA_Buffer1[0];
   }
   if(UseArray2 && ArraySize(MA_Buffer2) > 0 && MA_Buffer2[0] > 0)
   {
      ArrayResize(maValues, ArraySize(maValues) + 1);
      maValues[ArraySize(maValues) - 1] = MA_Buffer2[0];
   }
   if(UseArray3 && ArraySize(MA_Buffer3) > 0 && MA_Buffer3[0] > 0)
   {
      ArrayResize(maValues, ArraySize(maValues) + 1);
      maValues[ArraySize(maValues) - 1] = MA_Buffer3[0];
   }
   if(UseArray4 && ArraySize(MA_Buffer4) > 0 && MA_Buffer4[0] > 0)
   {
      ArrayResize(maValues, ArraySize(maValues) + 1);
      maValues[ArraySize(maValues) - 1] = MA_Buffer4[0];
   }
   if(UseArray5 && ArraySize(MA_Buffer5) > 0 && MA_Buffer5[0] > 0)
   {
      ArrayResize(maValues, ArraySize(maValues) + 1);
      maValues[ArraySize(maValues) - 1] = MA_Buffer5[0];
   }
   if(UseArray6 && ArraySize(MA_Buffer6) > 0 && MA_Buffer6[0] > 0)
   {
      ArrayResize(maValues, ArraySize(maValues) + 1);
      maValues[ArraySize(maValues) - 1] = MA_Buffer6[0];
   }
   if(UseArray7 && ArraySize(MA_Buffer7) > 0 && MA_Buffer7[0] > 0)
   {
      ArrayResize(maValues, ArraySize(maValues) + 1);
      maValues[ArraySize(maValues) - 1] = MA_Buffer7[0];
   }
   if(UseArray8 && ArraySize(MA_Buffer8) > 0 && MA_Buffer8[0] > 0)
   {
      ArrayResize(maValues, ArraySize(maValues) + 1);
      maValues[ArraySize(maValues) - 1] = MA_Buffer8[0];
   }
   
   if(ArraySize(maValues) >= 2)
   {
      // Find max and min of all MA values
      double maxMA = maValues[0];
      double minMA = maValues[0];
      
      for(int i = 1; i < ArraySize(maValues); i++)
      {
         if(maValues[i] > maxMA) maxMA = maValues[i];
         if(maValues[i] < minMA) minMA = maValues[i];
      }
      
      // Draw upper offset line
      double upperOffset = maxMA + (OffsetGridLevel * offsetDistance);
      string upperLineName = IndPrefix + "_OffsetUpper";
      if(ObjectFind(0, upperLineName) < 0)
      {
         ObjectCreate(0, upperLineName, OBJ_HLINE, 0, 0, upperOffset);
         ObjectSetInteger(0, upperLineName, OBJPROP_COLOR, OffsetLineColor);
         ObjectSetInteger(0, upperLineName, OBJPROP_STYLE, STYLE_DASH);
         ObjectSetInteger(0, upperLineName, OBJPROP_WIDTH, 2);
      }
      
      // Draw lower offset line
      double lowerOffset = minMA - (OffsetGridLevel * offsetDistance);
      string lowerLineName = IndPrefix + "_OffsetLower";
      if(ObjectFind(0, lowerLineName) < 0)
      {
         ObjectCreate(0, lowerLineName, OBJ_HLINE, 0, 0, lowerOffset);
         ObjectSetInteger(0, lowerLineName, OBJPROP_COLOR, OffsetLineColor);
         ObjectSetInteger(0, lowerLineName, OBJPROP_STYLE, STYLE_DASH);
         ObjectSetInteger(0, lowerLineName, OBJPROP_WIDTH, 2);
      }
      
      offsetLinesDrawn = true;
      Print("Offset MA lines drawn using ", ArraySize(maValues), " MAs - Upper=", upperOffset, ", Lower=", lowerOffset, " (Max MA=", maxMA, ", Min MA=", minMA, ")");
   }
}

//+------------------------------------------------------------------+
//| Cleanup function                                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   for(int i = 0; i < 8; i++)
   {
      if(arrayStructs[i].ma_handle != INVALID_HANDLE)
         IndicatorRelease(arrayStructs[i].ma_handle);
   }
   
   // Clean up objects
   ObjectsDeleteAll(0, IndPrefix);
   Comment("");
}

//+------------------------------------------------------------------+
//| Get buffer value for external access                            |
//+------------------------------------------------------------------+
double GetBufferValue(int bufferIndex, int shift)
{
   if(bufferIndex < 0 || bufferIndex >= 8 || shift < 0)
      return 0.0;
   
   switch(bufferIndex)
   {
      case 0: return MA_Buffer1[shift];
      case 1: return MA_Buffer2[shift];
      case 2: return MA_Buffer3[shift];
      case 3: return MA_Buffer4[shift];
      case 4: return MA_Buffer5[shift];
      case 5: return MA_Buffer6[shift];
      case 6: return MA_Buffer7[shift];
      case 7: return MA_Buffer8[shift];
   }
   return 0.0;
}