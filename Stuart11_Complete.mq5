//+------------------------------------------------------------------+
//|                                              Stuart11_Complete.mq5 |
//|                                      Copyright 2025, BNS |
//|                    Complete MQL5 conversion of STUART 11.mq4 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, BNS"
#property version   "1.00"
#property description "Complete Stuart11 Multi-MA Grid System - MQL5 Version"

#property indicator_chart_window
#property indicator_buffers 64
#property indicator_plots   8

// Enums
enum MAMODE
{
   SMA,
   EMA,
   SMMA,
   LWMA,
   SimpleMAMA,
   ExponentialMAMA,
   SmoothedMAMA,
   LWMAMAMA,
   AdditionalMAMA
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

// Critical Constants
#define USERARRAYGR     0
#define OTHERARRAYGR    1
#define STUARTARRAY     8

#define HIGHARRAY          0
#define LOWARRAY           1
#define MAHIGHOFFSETARRAY  2
#define MALOWOFFSETARRAY   3

#define STUARTOC       0
#define MAHIGHOFFSETOC 1
#define MALOWOFFSETOC  2

#define NOLEVEL   0
#define HIGHLEVEL 1
#define LOWLEVEL  2

// Input Parameters
input ENUM_TIMEFRAMES lowerTF      = PERIOD_M1;
input int      IndNumber           = 0;

input group "=== User Arrays (UA) ==="
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

input group "=== Signal Parameters ==="
input bool     DrawStuart          = true;
input CrossPriceTypeE StuartCrossPriceType = ClosePrice;
input DrawOffsetMAE DrawOffsetMA   = Double;  // Changed to Double
input CrossPriceTypeE MAOffsetCrossPriceType = ClosePrice;
input int      OffsetGridLevel     = 2;
input double   LowerGridOffsetPips = 15;
input color    OffsetLineColor     = clrHotPink;

input bool     DrawOverCup         = true;
input color    OverCupStuartLineColor  = clrBlue;
input color    OverCupMAOffsetLineColor = clrRed;
input color    OverCupSignalColor  = clrYellow;
input OCTextLocationE OCTextLocation = OnCandle;

input group "=== Grid Parameters ==="
input bool     DrawGrid            = true;
input int      HGridWeeks          = 20000;
input int      HGridPips           = 500;
input color    HLine               = clrDarkGreen;
input color    HLine2              = clrLimeGreen;
input int      GridTime            = 10000;
input ENUM_TIMEFRAMES TimeGrid     = PERIOD_CURRENT;
input int      ColorHour           = 0;
input color    TimeLine            = CLR_NONE;
input color    TimeLine2           = CLR_NONE;

input group "=== Colors ==="
input color    MA1_Color           = clrRed;
input color    MA2_Color           = clrGreen;
input color    MA3_Color           = clrBlue;
input color    MA4_Color           = clrYellow;
input color    MA5_Color           = clrAntiqueWhite;
input color    MA6_Color           = clrCyan;
input color    MA7_Color           = clrOrange;
input color    MA8_Color           = clrWhite;

input int      BarCount            = 10000;

// ArrayStruct Class
class CArrayStruct
{
public:
   int               MAIndexNo;
   int               MAArrayNo;
   double            Array[];
   double            ArrayMA[];
   
   // Configuration
   bool              UseArray;
   ENUM_TIMEFRAMES   TimeFrame;
   MAMODE            MAMode;
   int               MAPeriod;
   ENUM_APPLIED_PRICE PriceType;
   int               MAPeriod1;
   int               HedgePhase;
   int               HedgeBarCount;
   
   // Signal tracking
   int               LastCrossBarNo;
   double            LastCrossY;
   bool              CrossedOver[3];
   bool              CrossOver;
   bool              BuySell;
   int               cIndex;
   int               LineColor;
   int               LineCount;
   
   // MQL5 handles
   int               ma_handle;
   int               ma_handle_secondary;
   
   CArrayStruct     *NextArrayStruct;
   
   CArrayStruct()
   {
      MAIndexNo = 0;
      MAArrayNo = 0;
      UseArray = false;
      TimeFrame = PERIOD_CURRENT;
      MAMode = SMA;
      MAPeriod = 100;
      PriceType = PRICE_CLOSE;
      MAPeriod1 = 100;
      HedgePhase = 0;
      HedgeBarCount = 30000;
      LastCrossBarNo = 0;
      LastCrossY = 0.0;
      CrossOver = false;
      BuySell = false;
      cIndex = 0;
      LineColor = clrWhite;
      LineCount = 0;
      ma_handle = INVALID_HANDLE;
      ma_handle_secondary = INVALID_HANDLE;
      NextArrayStruct = NULL;
      
      for(int i = 0; i < 3; i++)
         CrossedOver[i] = false;
         
      ArrayResize(Array, 0);
      ArrayResize(ArrayMA, 0);
   }
   
   ~CArrayStruct()
   {
      if(ma_handle != INVALID_HANDLE)
         IndicatorRelease(ma_handle);
      if(ma_handle_secondary != INVALID_HANDLE)
         IndicatorRelease(ma_handle_secondary);
   }
};

// Global Variables
double TPoint;
double GridArray[];
int MaxBars;
double HGridPipsCur;
bool Init = true;
string IndPrefix;
int calculationIndex = 8;

// Array Structure Lists
CArrayStruct *UAArrayStructList = NULL;
CArrayStruct *OMAArrayStructList = NULL;

// Indicator Buffers
double MA_Buffer1[];
double MA_Buffer2[];
double MA_Buffer3[];
double MA_Buffer4[];
double MA_Buffer5[];
double MA_Buffer6[];
double MA_Buffer7[];
double MA_Buffer8[];

// Internal calculation buffers
double HighArray[];
double LowArray[];
double MAHighOffsetArray[];
double MALowOffsetArray[];

// State tracking
int StuartPrevLevel = NOLEVEL;
int OMAPrevLevel = NOLEVEL;
int StuartLineCount = 0;
int OffsetLineCount = 0;
int OCCount = 0;
datetime lastBarTime = 0;
bool newBar = false;

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   Print("=== STUART11_COMPLETE.MQ5 INITIALIZING ===");
   
   if((SymbolInfoInteger(Symbol(), SYMBOL_DIGITS) == 5 || SymbolInfoInteger(Symbol(), SYMBOL_DIGITS) == 3))
      TPoint = SymbolInfoDouble(Symbol(), SYMBOL_POINT) * 10;
   else
      TPoint = SymbolInfoDouble(Symbol(), SYMBOL_POINT);
   
   IndPrefix = "ST" + IntegerToString(IndNumber);
   
   Print("TPoint=", TPoint, ", IndPrefix=", IndPrefix);
   
   // Set up indicator buffers
   SetIndexBuffer(0, MA_Buffer1, INDICATOR_DATA);
   SetIndexBuffer(1, MA_Buffer2, INDICATOR_DATA);
   SetIndexBuffer(2, MA_Buffer3, INDICATOR_DATA);
   SetIndexBuffer(3, MA_Buffer4, INDICATOR_DATA);
   SetIndexBuffer(4, MA_Buffer5, INDICATOR_DATA);
   SetIndexBuffer(5, MA_Buffer6, INDICATOR_DATA);
   SetIndexBuffer(6, MA_Buffer7, INDICATOR_DATA);
   SetIndexBuffer(7, MA_Buffer8, INDICATOR_DATA);
   
   // Set up calculation buffers
   SetIndexBuffer(8, HighArray, INDICATOR_CALCULATIONS);
   SetIndexBuffer(9, LowArray, INDICATOR_CALCULATIONS);
   SetIndexBuffer(10, MAHighOffsetArray, INDICATOR_CALCULATIONS);
   SetIndexBuffer(11, MALowOffsetArray, INDICATOR_CALCULATIONS);
   
   // Initialize User Arrays
   InitializeUserArrays();
   
   // Set plot properties
   SetupPlots();
   
   // Initialize grid array
   ArrayResize(GridArray, 0);
   
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Initialize User Arrays                                           |
//+------------------------------------------------------------------+
void InitializeUserArrays()
{
   if(UseArray1) CreateArrayStruct(UAArrayStructList, 0, USERARRAYGR, UseArray1, UATimeFrame1, UAMAMode1, UAMAPeriod1, UAPriceType1);
   if(UseArray2) CreateArrayStruct(UAArrayStructList, 1, USERARRAYGR, UseArray2, UATimeFrame2, UAMAMode2, UAMAPeriod2, UAPriceType2);
   if(UseArray3) CreateArrayStruct(UAArrayStructList, 2, USERARRAYGR, UseArray3, UATimeFrame3, UAMAMode3, UAMAPeriod3, UAPriceType3);
   if(UseArray4) CreateArrayStruct(UAArrayStructList, 3, USERARRAYGR, UseArray4, UATimeFrame4, UAMAMode4, UAMAPeriod4, UAPriceType4);
   if(UseArray5) CreateArrayStruct(UAArrayStructList, 4, USERARRAYGR, UseArray5, UATimeFrame5, UAMAMode5, UAMAPeriod5, UAPriceType5);
   if(UseArray6) CreateArrayStruct(UAArrayStructList, 5, USERARRAYGR, UseArray6, UATimeFrame6, UAMAMode6, UAMAPeriod6, UAPriceType6);
   if(UseArray7) CreateArrayStruct(UAArrayStructList, 6, USERARRAYGR, UseArray7, UATimeFrame7, UAMAMode7, UAMAPeriod7, UAPriceType7);
   if(UseArray8) CreateArrayStruct(UAArrayStructList, 7, USERARRAYGR, UseArray8, UATimeFrame8, UAMAMode8, UAMAPeriod8, UAPriceType8);
   
   // Create High/Low arrays
   CreateArrayStruct(UAArrayStructList, HIGHARRAY, OTHERARRAYGR, true, PERIOD_CURRENT, SMA, 1, PRICE_HIGH);
   CreateArrayStruct(UAArrayStructList, LOWARRAY, OTHERARRAYGR, true, PERIOD_CURRENT, SMA, 1, PRICE_LOW);
   CreateArrayStruct(UAArrayStructList, MAHIGHOFFSETARRAY, OTHERARRAYGR, true, PERIOD_CURRENT, SMA, 1, PRICE_HIGH);
   CreateArrayStruct(UAArrayStructList, MALOWOFFSETARRAY, OTHERARRAYGR, true, PERIOD_CURRENT, SMA, 1, PRICE_LOW);
   
   // Create Stuart array for state tracking
   CreateArrayStruct(UAArrayStructList, STUARTARRAY, USERARRAYGR, true, PERIOD_CURRENT, SMA, 1, PRICE_CLOSE);
}

//+------------------------------------------------------------------+
//| Create Array Structure                                           |
//+------------------------------------------------------------------+
void CreateArrayStruct(CArrayStruct* &list, int indexNo, int arrayNo, bool useArray, 
                       ENUM_TIMEFRAMES timeFrame, MAMODE maMode, int maPeriod, 
                       ENUM_APPLIED_PRICE priceType)
{
   CArrayStruct *newStruct = new CArrayStruct();
   newStruct.MAIndexNo = indexNo;
   newStruct.MAArrayNo = arrayNo;
   newStruct.UseArray = useArray;
   newStruct.TimeFrame = timeFrame;
   newStruct.MAMode = maMode;
   newStruct.MAPeriod = maPeriod;
   newStruct.PriceType = priceType;
   
   // Create MA handles for basic MA types
   if(maMode <= LWMA)
   {
      ENUM_MA_METHOD method = MODE_SMA;
      switch(maMode)
      {
         case SMA:  method = MODE_SMA; break;
         case EMA:  method = MODE_EMA; break;
         case SMMA: method = MODE_SMMA; break;
         case LWMA: method = MODE_LWMA; break;
      }
      newStruct.ma_handle = iMA(Symbol(), timeFrame, maPeriod, 0, method, priceType);
      
      if(newStruct.ma_handle == INVALID_HANDLE)
      {
         Print("ERROR: Failed to create MA handle for Index=", indexNo, ", Error=", GetLastError());
      }
      else
      {
         Print("SUCCESS: Created MA handle for Index=", indexNo, ", Handle=", newStruct.ma_handle, ", Method=", EnumToString(method), ", Period=", maPeriod, ", Price=", EnumToString(priceType));
      }
      
      // For MAMA types, create secondary handle (MA of MA)
      if(maMode >= SimpleMAMA)
      {
         newStruct.ma_handle_secondary = iMA(Symbol(), timeFrame, maPeriod, 0, method, PRICE_CLOSE);
      }
   }
   
   // Assign buffer index
   newStruct.cIndex = SetCalculationIndex();
   
   // Add to linked list
   newStruct.NextArrayStruct = list;
   list = newStruct;
   
   Print("Created ArrayStruct: Index=", indexNo, ", ArrayNo=", arrayNo, ", Mode=", EnumToString(maMode), ", UseArray=", useArray);
}

//+------------------------------------------------------------------+
//| Set calculation index                                            |
//+------------------------------------------------------------------+
int SetCalculationIndex()
{
   calculationIndex++;
   return calculationIndex;
}

//+------------------------------------------------------------------+
//| Get Array Struct from List                                      |
//+------------------------------------------------------------------+
CArrayStruct* GetArrayStructFromList(CArrayStruct* list, int indexNo, int arrayNo)
{
   CArrayStruct* current = list;
   while(current != NULL)
   {
      if(current.MAIndexNo == indexNo && current.MAArrayNo == arrayNo)
         return current;
      current = current.NextArrayStruct;
   }
   return NULL;
}

//+------------------------------------------------------------------+
//| Setup plot properties                                            |
//+------------------------------------------------------------------+
void SetupPlots()
{
   SetupPlot(0, UseArray1, "MA1 (High)", MA1_Color, 3);
   SetupPlot(1, UseArray2, "MA2 (Low)", MA2_Color, 3);
   SetupPlot(2, UseArray3, "MA3 (Close)", MA3_Color, 3);
   SetupPlot(3, UseArray4, "MA4 (High150)", MA4_Color, 2);
   SetupPlot(4, UseArray5, "MA5 (Low150)", MA5_Color, 2);
   SetupPlot(5, UseArray6, "MA6 (EMA150)", MA6_Color, 2);
   SetupPlot(6, UseArray7, "MA7 (EMAHigh)", MA7_Color, 2);
   SetupPlot(7, UseArray8, "MA8 (EMALow)", MA8_Color, 2);
   
   for(int i = 0; i < 8; i++)
      PlotIndexSetDouble(i, PLOT_EMPTY_VALUE, 0.0);
}

//+------------------------------------------------------------------+
//| Setup individual plot                                            |
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
      InitializeGridStep(rates_total, close);
      Init = false;
   }
   
   int limit = rates_total - prev_calculated;
   if(prev_calculated > 0)
      limit++;
   
   if(limit > BarCount && BarCount > 0)
      limit = BarCount;
   
   // Check for new bar
   if(rates_total > 0 && time[rates_total-1] != lastBarTime)
   {
      newBar = true;
      lastBarTime = time[rates_total-1];
   }
   else
      newBar = false;
   
   // Main calculation loop
   for(int i = 0; i < limit; i++)
   {
      int barNo = rates_total - 1 - i;
      Calculate(barNo, rates_total, time, open, high, low, close);
   }
   
   return(rates_total);
}

//+------------------------------------------------------------------+
//| Initialize grid step                                             |
//+------------------------------------------------------------------+
void InitializeGridStep(int rates_total, const double &close[])
{
   if(HGridPips == 0)
   {
      if(TPoint <= 0.0001)
         HGridPipsCur = 10;
      else if(TPoint <= 0.001)
         HGridPipsCur = 100;
      else
      {
         if(rates_total == 0) return;
         
         if(close[rates_total-1] < 100)
            HGridPipsCur = (int)(10 / TPoint);
         else if(close[rates_total-1] < 5000)
            HGridPipsCur = (int)(100 / TPoint);
         else
            HGridPipsCur = (int)(1000 / TPoint);
      }
   }
   else
      HGridPipsCur = HGridPips;
      
   // Ensure multiple of 10
   int remainder = HGridPipsCur - (HGridPipsCur / 10) * 10;
   if(remainder != 0)
      HGridPipsCur = ((HGridPipsCur / 10) + 1) * 10;
      
   Comment("Grid Step: " + DoubleToString(HGridPipsCur, 1));
}

//+------------------------------------------------------------------+
//| Main calculation function                                        |
//+------------------------------------------------------------------+
void Calculate(int barNo, int rates_total, const datetime &time[], 
               const double &open[], const double &high[], 
               const double &low[], const double &close[])
{
    // Calculate all User Array MAs
    CalculateUserArrayMAs(barNo, rates_total);

    // Update High/Low arrays
    UpdateHighLowArrays(barNo);

    // Draw grid on new bars
    if(newBar && DrawGrid && barNo == rates_total - 1)
    {
        DrawGridFunc();
    }

    // Process offset MA calculations
    if(DrawOffsetMA != None)
    {
        ProcessOffsetMAs(barNo);
    }

    // Generate Stuart signals
    if(DrawStuart)
    {
        // CORRECTION: Ensure rates_total is passed to the function
        DrawStuartFirstArray(barNo, rates_total, close, high, low);
    }
}

//+------------------------------------------------------------------+
//| Calculate User Array MAs                                         |
//+------------------------------------------------------------------+
void CalculateUserArrayMAs(int barNo, int rates_total)
{
   static bool firstCall = true;
   if(firstCall && barNo == rates_total - 1)
   {
      Print("CalculateUserArrayMAs called for bar ", barNo, ", UseArray1=", UseArray1, ", UseArray2=", UseArray2, ", UseArray3=", UseArray3);
      firstCall = false;
   }
   
   // Calculate proper shift from current bar
   int shift = rates_total - 1 - barNo;
   
   // Calculate MA1-MA8
   if(UseArray1) 
   {
      MA_Buffer1[barNo] = CalculateMA(0, shift);
   }
   if(UseArray2) 
   {
      MA_Buffer2[barNo] = CalculateMA(1, shift);
   }
   if(UseArray3) 
   {
      MA_Buffer3[barNo] = CalculateMA(2, shift);
   }
   if(UseArray4) MA_Buffer4[barNo] = CalculateMA(3, shift);
   if(UseArray5) MA_Buffer5[barNo] = CalculateMA(4, shift);
   if(UseArray6) MA_Buffer6[barNo] = CalculateMA(5, shift);
   if(UseArray7) MA_Buffer7[barNo] = CalculateMA(6, shift);
   if(UseArray8) MA_Buffer8[barNo] = CalculateMA(7, shift);
}

//+------------------------------------------------------------------+
//| Calculate MA value for specific array                            |
//+------------------------------------------------------------------+
double CalculateMA(int arrayIndex, int shift)
{
   CArrayStruct* arrayStruct = GetArrayStructFromList(UAArrayStructList, arrayIndex, USERARRAYGR);
   if(arrayStruct == NULL || !arrayStruct.UseArray)
      return 0.0;
   
   if(arrayStruct.ma_handle != INVALID_HANDLE)
   {
      double ma_values[];
      ArraySetAsSeries(ma_values, true);
      
      // Copy enough data - need at least MA period + shift
      int copyCount = MathMax(arrayStruct.MAPeriod + shift + 10, 200);
      int copied = CopyBuffer(arrayStruct.ma_handle, 0, 0, copyCount, ma_values);
      
      if(copied > shift && copied > arrayStruct.MAPeriod)
      {
         if(ma_values[shift] != EMPTY_VALUE && ma_values[shift] > 0 && ma_values[shift] < 1e+100)
         {
            return ma_values[shift];
         }
      }
   }
   
   return 0.0;
}

//+------------------------------------------------------------------+
//| Update High/Low Arrays                                           |
//+------------------------------------------------------------------+
void UpdateHighLowArrays(int barNo)
{
   double maxMA = 0, minMA = 0;
   bool first = true;
   
   // Find max and min of all active MAs
   if(UseArray1 && MA_Buffer1[barNo] > 0)
   {
      if(first) { maxMA = minMA = MA_Buffer1[barNo]; first = false; }
      else { if(MA_Buffer1[barNo] > maxMA) maxMA = MA_Buffer1[barNo]; if(MA_Buffer1[barNo] < minMA) minMA = MA_Buffer1[barNo]; }
   }
   if(UseArray2 && MA_Buffer2[barNo] > 0)
   {
      if(first) { maxMA = minMA = MA_Buffer2[barNo]; first = false; }
      else { if(MA_Buffer2[barNo] > maxMA) maxMA = MA_Buffer2[barNo]; if(MA_Buffer2[barNo] < minMA) minMA = MA_Buffer2[barNo]; }
   }
   if(UseArray3 && MA_Buffer3[barNo] > 0)
   {
      if(first) { maxMA = minMA = MA_Buffer3[barNo]; first = false; }
      else { if(MA_Buffer3[barNo] > maxMA) maxMA = MA_Buffer3[barNo]; if(MA_Buffer3[barNo] < minMA) minMA = MA_Buffer3[barNo]; }
   }
   if(UseArray4 && MA_Buffer4[barNo] > 0)
   {
      if(first) { maxMA = minMA = MA_Buffer4[barNo]; first = false; }
      else { if(MA_Buffer4[barNo] > maxMA) maxMA = MA_Buffer4[barNo]; if(MA_Buffer4[barNo] < minMA) minMA = MA_Buffer4[barNo]; }
   }
   if(UseArray5 && MA_Buffer5[barNo] > 0)
   {
      if(first) { maxMA = minMA = MA_Buffer5[barNo]; first = false; }
      else { if(MA_Buffer5[barNo] > maxMA) maxMA = MA_Buffer5[barNo]; if(MA_Buffer5[barNo] < minMA) minMA = MA_Buffer5[barNo]; }
   }
   if(UseArray6 && MA_Buffer6[barNo] > 0)
   {
      if(first) { maxMA = minMA = MA_Buffer6[barNo]; first = false; }
      else { if(MA_Buffer6[barNo] > maxMA) maxMA = MA_Buffer6[barNo]; if(MA_Buffer6[barNo] < minMA) minMA = MA_Buffer6[barNo]; }
   }
   if(UseArray7 && MA_Buffer7[barNo] > 0)
   {
      if(first) { maxMA = minMA = MA_Buffer7[barNo]; first = false; }
      else { if(MA_Buffer7[barNo] > maxMA) maxMA = MA_Buffer7[barNo]; if(MA_Buffer7[barNo] < minMA) minMA = MA_Buffer7[barNo]; }
   }
   if(UseArray8 && MA_Buffer8[barNo] > 0)
   {
      if(first) { maxMA = minMA = MA_Buffer8[barNo]; first = false; }
      else { if(MA_Buffer8[barNo] > maxMA) maxMA = MA_Buffer8[barNo]; if(MA_Buffer8[barNo] < minMA) minMA = MA_Buffer8[barNo]; }
   }
   
   HighArray[barNo] = maxMA;
   LowArray[barNo] = minMA;
}

//+------------------------------------------------------------------+
//| Process Offset MAs                                               |
//+------------------------------------------------------------------+
void ProcessOffsetMAs(int barNo)
{
   if(DrawOffsetMA == Single)
   {
      DoOffsetMASingle(barNo, HIGHLEVEL);
      DoOffsetMASingle(barNo, LOWLEVEL);
   }
   else if(DrawOffsetMA == Double)
   {
      DrawOffsetMADouble(barNo);
   }
}

//+------------------------------------------------------------------+
//| DrawOffsetMADouble - Double offset calculation                   |
//+------------------------------------------------------------------+
void DrawOffsetMADouble(int barNo)
{
   // Get high/low arrays
   CArrayStruct* HighArrayStruct = GetArrayStructFromList(UAArrayStructList, HIGHARRAY, OTHERARRAYGR);
   CArrayStruct* LowArrayStruct = GetArrayStructFromList(UAArrayStructList, LOWARRAY, OTHERARRAYGR);
   
   if(HighArrayStruct == NULL || LowArrayStruct == NULL) return;
   
   // Calculate upper and lower offset levels
   double upperOffset = HighArray[barNo] + (OffsetGridLevel * LowerGridOffsetPips * TPoint);
   double lowerOffset = LowArray[barNo] - (OffsetGridLevel * LowerGridOffsetPips * TPoint);
   
   // Store in offset arrays
   MAHighOffsetArray[barNo] = upperOffset;
   MALowOffsetArray[barNo] = lowerOffset;
   
   // Draw offset lines
   DrawOffsetLine(barNo, upperOffset, "Upper");
   DrawOffsetLine(barNo, lowerOffset, "Lower");
   
   // Generate offset signals
   GenerateOffsetSignals(barNo, upperOffset, lowerOffset);
}

//+------------------------------------------------------------------+
//| DoOffsetMASingle - Core offset calculation                       |
//+------------------------------------------------------------------+
void DoOffsetMASingle(int barNo, int level)
{
   // Get high/low arrays
   CArrayStruct* HighArrayStruct = GetArrayStructFromList(UAArrayStructList, HIGHARRAY, OTHERARRAYGR);
   CArrayStruct* LowArrayStruct = GetArrayStructFromList(UAArrayStructList, LOWARRAY, OTHERARRAYGR);
   
   if(HighArrayStruct == NULL || LowArrayStruct == NULL) return;
   
   // Get appropriate offset array
   CArrayStruct* arrayStruct;
   if(level == HIGHLEVEL)
      arrayStruct = GetArrayStructFromList(UAArrayStructList, MAHIGHOFFSETARRAY, OTHERARRAYGR);
   else
      arrayStruct = GetArrayStructFromList(UAArrayStructList, MALOWOFFSETARRAY, OTHERARRAYGR);
      
   if(arrayStruct == NULL) return;
   
   // Ensure arrays are sized correctly
   if(ArraySize(arrayStruct.Array) <= barNo)
      ArrayResize(arrayStruct.Array, barNo + 1);
   
   int gridArraySize = ArraySize(GridArray);
   double oldPrice = 0;
   if(barNo > 0 && ArraySize(arrayStruct.Array) > barNo)
      oldPrice = arrayStruct.Array[barNo];
   
   arrayStruct.CrossOver = false;
   bool found = false;
   int gridIndex = 0;
   
   if(level == HIGHLEVEL)
   {
      // High level logic
      if(OMAPrevLevel != HIGHLEVEL)
      {
         arrayStruct.CrossOver = true;
         arrayStruct.BuySell = true;
         arrayStruct.LastCrossBarNo = barNo;
         
         // Find appropriate grid level
         for(gridIndex = 0; gridIndex < gridArraySize; gridIndex++)
         {
            if(HighArray[barNo] <= GridArray[gridIndex])
            {
               found = true;
               break;
            }
         }
      }
      
      if(found)
      {
         // Apply offset rules
         while((gridIndex < gridArraySize) &&
               (((GridArray[gridIndex] - HighArray[barNo]) < LowerGridOffsetPips * TPoint) ||
                ((GridArray[gridIndex] - HighArray[barNo]) < (OffsetGridLevel - 1) * HGridPipsCur * TPoint)))
            gridIndex++;
            
         if((gridIndex < gridArraySize) && (oldPrice != GridArray[gridIndex]))
         {
            arrayStruct.Array[barNo] = GridArray[gridIndex];
            MAHighOffsetArray[barNo] = GridArray[gridIndex];
         }
         else
         {
            arrayStruct.CrossOver = false;
            if(barNo > 0)
               arrayStruct.Array[barNo] = arrayStruct.Array[barNo - 1];
         }
      }
   }
   else
   {
      // Low level logic
      if(OMAPrevLevel != LOWLEVEL)
      {
         arrayStruct.CrossOver = true;
         arrayStruct.BuySell = false;
         arrayStruct.LastCrossBarNo = barNo;
         
         // Find appropriate grid level
         for(gridIndex = gridArraySize - 1; gridIndex >= 0; gridIndex--)
         {
            if(GridArray[gridIndex] <= LowArray[barNo])
            {
               found = true;
               break;
            }
         }
      }
      
      if(found)
      {
         // Apply offset rules
         while((gridIndex >= 0) &&
               (((LowArray[barNo] - GridArray[gridIndex]) < LowerGridOffsetPips * TPoint) ||
                ((LowArray[barNo] - GridArray[gridIndex]) < (OffsetGridLevel - 1) * HGridPipsCur * TPoint)))
            gridIndex--;
            
         if((gridIndex >= 0) && (oldPrice != GridArray[gridIndex]))
         {
            arrayStruct.Array[barNo] = GridArray[gridIndex];
            MALowOffsetArray[barNo] = GridArray[gridIndex];
         }
         else
         {
            arrayStruct.CrossOver = false;
            if(barNo > 0)
               arrayStruct.Array[barNo] = arrayStruct.Array[barNo - 1];
         }
      }
   }
   
   OMAPrevLevel = level;
}

//+------------------------------------------------------------------+
//| Draw Offset Line (Corrected)                                     |
//+------------------------------------------------------------------+
void DrawOffsetLine(int barNo, double price, string type)
{
    // --- CORRECTION: The object name is now fixed and does NOT include the bar number. ---
    // This ensures we are always working with the same two objects.
    string lineName = IndPrefix + "_Offset_" + type; 

    // Only draw/update the line when calculating for the most recent bar to be efficient.
    if(barNo != Bars(_Symbol, _Period) - 1)
       return;
       
    // If the object doesn't exist, create it.
    if(ObjectFind(0, lineName) < 0)
    {
        ObjectCreate(0, lineName, OBJ_HLINE, 0, 0, price);
        ObjectSetInteger(0, lineName, OBJPROP_COLOR, OffsetLineColor);
        ObjectSetInteger(0, lineName, OBJPROP_STYLE, STYLE_DASH);
        ObjectSetInteger(0, lineName, OBJPROP_WIDTH, 2);
        ObjectSetInteger(0, lineName, OBJPROP_SELECTABLE, false); // Make it non-selectable
        ObjectSetInteger(0, lineName, OBJPROP_BACK, false);
    }
    // If it already exists, just move it to the new price level.
    else
    {
        ObjectSetDouble(0, lineName, OBJPROP_PRICE, 0, price);
    }
}

//+------------------------------------------------------------------+
//| Generate Offset Signals                                          |
//+------------------------------------------------------------------+
void GenerateOffsetSignals(int barNo, double upperOffset, double lowerOffset)
{
   if(barNo == 0) return;
   
   double currentPrice = SymbolInfoDouble(Symbol(), SYMBOL_BID);
   
   // Check for offset level breaks
   if(currentPrice > upperOffset)
   {
      CreateOffsetSignal(barNo, true, upperOffset, "Upper");
   }
   else if(currentPrice < lowerOffset)
   {
      CreateOffsetSignal(barNo, false, lowerOffset, "Lower");
   }
}

//+------------------------------------------------------------------+
//| Create Offset Signal                                             |
//+------------------------------------------------------------------+
void CreateOffsetSignal(int barNo, bool isBuy, double price, string type)
{
   if(!DrawOverCup) return;
   
   string signalName = IndPrefix + "_Offset" + type + "Signal_" + IntegerToString(barNo);
   datetime signalTime = iTime(Symbol(), PERIOD_CURRENT, barNo);
   
   if(ObjectFind(0, signalName) < 0)
   {
      ObjectCreate(0, signalName, OBJ_ARROW, 0, signalTime, price);
      ObjectSetInteger(0, signalName, OBJPROP_ARROWCODE, isBuy ? 233 : 234);
      ObjectSetInteger(0, signalName, OBJPROP_COLOR, isBuy ? clrLime : clrRed);
      ObjectSetInteger(0, signalName, OBJPROP_WIDTH, 3);
   }
}

//+------------------------------------------------------------------+
//|         CORRECTED AND OPTIMIZED STUART LINE LOGIC (MQL5)         |
//+------------------------------------------------------------------+

/**
 * Main function to calculate and draw the Stuart Line.
 * This is a state machine that draws a continuous, stepped line.
 */
void DrawStuartFirstArray(int barNo, const int rates_total, const double &close[], const double &high[], const double &low[])
{
    if (!DrawStuart || barNo < 1) return;

    // Get the struct that holds the state for the Stuart Line itself
    CArrayStruct* stuartStruct = GetArrayStructFromList(UAArrayStructList, STUARTARRAY, USERARRAYGR);
    if(stuartStruct == NULL) return;

    // --- THIS IS THE CRITICAL FIX ---
    // Resize the dynamic array if it's smaller than the total number of bars.
    if(ArraySize(stuartStruct.Array) < rates_total)
    {
        ArrayResize(stuartStruct.Array, rates_total);
    }
    // --- END OF FIX ---

    // Carry over the previous value initially. Correct MQL5 indexing is barNo - 1.
    stuartStruct.Array[barNo] = stuartStruct.Array[barNo - 1];

    // Determine the current crossover level
    int curLevel = StuartPrevLevel;
    DoCross(barNo, curLevel, StuartPrevLevel, close, high, low);

    stuartStruct.CrossOver = false;

    // --- State Change Logic ---
    if (curLevel != StuartPrevLevel) // A crossover just happened!
    {
        stuartStruct.CrossOver = true;
        stuartStruct.LastCrossBarNo = barNo; // Store the bar index of the cross

        if (curLevel == HIGHLEVEL) // Switched to tracking the High band
        {
            stuartStruct.LastCrossY = LowArray[barNo]; 
            stuartStruct.BuySell = true; 
        }
        else // Switched to tracking the Low band
        {
            stuartStruct.LastCrossY = HighArray[barNo];
            stuartStruct.BuySell = false;
        }
    }

    // Update the Stuart Line's value for the current bar
    if (curLevel == HIGHLEVEL)
    {
        stuartStruct.Array[barNo] = HighArray[barNo];
    }
    else if (curLevel == LOWLEVEL)
    {
        stuartStruct.Array[barNo] = LowArray[barNo];
    }

    // --- Drawing Logic ---
    datetime time1 = iTime(_Symbol, _Period, barNo - 1);
    datetime time2 = iTime(_Symbol, _Period, barNo);

    double price1 = stuartStruct.CrossOver ? stuartStruct.LastCrossY : stuartStruct.Array[barNo - 1];
    double price2 = stuartStruct.Array[barNo];

    if(price1 > 0 && price2 > 0)
        DrawTrendLine(IndPrefix + "XStuart", StuartLineCount, time1, time2, price1, price2, clrWhite, 3);

    StuartPrevLevel = curLevel;
}


/**
 * Helper function to determine the state (HIGHLEVEL or LOWLEVEL).
 */
void DoCross(int barNo, int &curLevel, int prevLevel, const double &close[], const double &high[], const double &low[])
{
    // Check if price crossed below the low MA band, switching our state to HIGHLEVEL tracking
    if ((prevLevel != HIGHLEVEL) && GetPriceCrossOver(false, barNo, LowArray, high, low, close))
    {
        curLevel = HIGHLEVEL;
    }
    // Check if price crossed above the high MA band, switching our state to LOWLEVEL tracking
    else if ((prevLevel != LOWLEVEL) && GetPriceCrossOver(true, barNo, HighArray, high, low, close))
    {
        curLevel = LOWLEVEL;
    }
    else
    {
        curLevel = prevLevel; // No change in state
    }
}


/**
 * Helper function to detect the price crossover condition using OnCalculate() data.
 * This is much faster than using i-Series functions like iClose().
 */
bool GetPriceCrossOver(bool isHighCross, int barNo, const double &value[], const double &high[], const double &low[], const double &close[])
{
    if (barNo < 1) return false;

    switch (StuartCrossPriceType)
    {
        case ClosePrice:
            if (isHighCross) // Did we cross ABOVE the high band?
                return (close[barNo] > value[barNo] && close[barNo - 1] <= value[barNo - 1]);
            else // Did we cross BELOW the low band?
                return (close[barNo] < value[barNo] && close[barNo - 1] >= value[barNo - 1]);
            break;

        case TouchPrice:
             if (isHighCross) // Did we TOUCH or exceed the high band?
                return (high[barNo] >= value[barNo]);
            else // Did we TOUCH or go below the low band?
                return (low[barNo] <= value[barNo]);
            break;
    }
    return false;
}


/**
 * General purpose function to draw or update a trendline object on the chart.
 */
void DrawTrendLine(string prefix, int &index, datetime time1, datetime time2, double price1, double price2, color clr, int width, ENUM_LINE_STYLE style = STYLE_SOLID)
{
    if (price1 <= 0 || price2 <= 0) return;

    string name = prefix + IntegerToString(index);

    // If the object doesn't exist OR if we are starting a new segment...
    if (ObjectFind(0, name) < 0 || ObjectGetInteger(0, name, OBJPROP_TIME, 1) != time1)
    {
        index++; 
        name = prefix + IntegerToString(index);
        
        if(ObjectFind(0, name) < 0)
        {
             ObjectCreate(0, name, OBJ_TREND, 0, time1, price1, time2, price2);
        }
        else 
        {
             ObjectSetInteger(0, name, OBJPROP_TIME, 0, time1);
             ObjectSetDouble(0, name, OBJPROP_PRICE, 0, price1);
        }
    }
    
    // Always update the properties of the CURRENT segment name
    ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
    ObjectSetInteger(0, name, OBJPROP_STYLE, style);
    ObjectSetInteger(0, name, OBJPROP_WIDTH, width);
    ObjectSetInteger(0, name, OBJPROP_RAY_RIGHT, false);
    ObjectSetInteger(0, name, OBJPROP_BACK, false);
    
    // --- THE CORRECT FIX: Use the 'modifier' (0 or 1) to specify the anchor point ---
    ObjectSetDouble(0, name, OBJPROP_PRICE, 0, price1);  // Price for the 1st point
    ObjectSetDouble(0, name, OBJPROP_PRICE, 1, price2);  // Price for the 2nd point
    ObjectSetInteger(0, name, OBJPROP_TIME, 0, time1);   // Time for the 1st point
    ObjectSetInteger(0, name, OBJPROP_TIME, 1, time2);   // Time for the 2nd point
}

//+------------------------------------------------------------------+
//| Draw Grid Function                                               |
//+------------------------------------------------------------------+
void DrawGridFunc()
{
   if(!DrawGrid) return;
   
   double currentPrice = SymbolInfoDouble(Symbol(), SYMBOL_BID);
   double gridStep = HGridPipsCur * TPoint;
   
   // Build grid array based on HGridWeeks range
   ArrayResize(GridArray, 0);
   
   // Calculate weekly range
   int weeklyBars = HGridWeeks * 7 * 24 * 60 / PeriodSeconds();  // Convert weeks to bars
   double weeklyHigh = currentPrice;
   double weeklyLow = currentPrice;
   
   for(int i = 0; i < weeklyBars && i < Bars(Symbol(), PERIOD_CURRENT); i++)
   {
      double high = iHigh(Symbol(), PERIOD_CURRENT, i);
      double low = iLow(Symbol(), PERIOD_CURRENT, i);
      if(high > weeklyHigh) weeklyHigh = high;
      if(low < weeklyLow) weeklyLow = low;
   }
   
   // Create grid from weekly low to weekly high
   double startPrice = MathFloor(weeklyLow / gridStep) * gridStep;
   double endPrice = MathCeil(weeklyHigh / gridStep) * gridStep;
   
   for(double price = startPrice; price <= endPrice; price += gridStep)
   {
      ArrayResize(GridArray, ArraySize(GridArray) + 1);
      GridArray[ArraySize(GridArray) - 1] = price;
   }
   
   // Sort grid array
   ArraySort(GridArray);
   
   // Draw grid lines
   for(int i = 0; i < ArraySize(GridArray); i++)
   {
      string gridName = IndPrefix + "_Grid_" + IntegerToString(i);
      
      if(ObjectFind(0, gridName) < 0)
      {
         ObjectCreate(0, gridName, OBJ_HLINE, 0, 0, GridArray[i]);
         int gridRemainder = i - (i / 10) * 10;
         ObjectSetInteger(0, gridName, OBJPROP_COLOR, (gridRemainder == 0) ? HLine2 : HLine);
         ObjectSetInteger(0, gridName, OBJPROP_STYLE, STYLE_DOT);
         ObjectSetInteger(0, gridName, OBJPROP_WIDTH, (gridRemainder == 0) ? 2 : 1);
      }
   }
   
   Print("Grid created with ", ArraySize(GridArray), " levels from ", weeklyLow, " to ", weeklyHigh);
}

//+------------------------------------------------------------------+
//| Cleanup function                                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   // Clean up array structures
   CleanupArrayStructList(UAArrayStructList);
   CleanupArrayStructList(OMAArrayStructList);
   
   // Clean up objects with pattern matching
   CleanupObjectsByPattern();
   
   Comment("");
   Print("Stuart11 indicator removed - all objects cleaned up");
}

//+------------------------------------------------------------------+
//| Cleanup Objects by Pattern                                       |
//+------------------------------------------------------------------+
void CleanupObjectsByPattern()
{
   int totalObjects = ObjectsTotal(0);
   string objectsToDelete[];
   int deleteCount = 0;
   
   // First pass: identify objects to delete
   for(int i = totalObjects - 1; i >= 0; i--)
   {
      string objName = ObjectName(0, i);
      
      // Check if object name matches our patterns
      if(StringFind(objName, IndPrefix + "_Grid_") == 0 ||
         StringFind(objName, IndPrefix + "_Offset") == 0 ||
         StringFind(objName, IndPrefix + "_Stuart_") == 0 ||
         StringFind(objName, IndPrefix + "_Signal_") == 0)
      {
         ArrayResize(objectsToDelete, deleteCount + 1);
         objectsToDelete[deleteCount] = objName;
         deleteCount++;
      }
   }
   
   // Second pass: delete identified objects
   for(int i = 0; i < deleteCount; i++)
   {
      if(ObjectDelete(0, objectsToDelete[i]))
      {
         Print("Deleted object: ", objectsToDelete[i]);
      }
   }
   
   Print("Cleanup completed: ", deleteCount, " objects deleted");
}

//+------------------------------------------------------------------+
//| Cleanup Array Struct List                                       |
//+------------------------------------------------------------------+
void CleanupArrayStructList(CArrayStruct* &list)
{
   while(list != NULL)
   {
      CArrayStruct* temp = list;
      list = list.NextArrayStruct;
      delete temp;
   }
}