//+------------------------------------------------------------------+
//|                                                       RahulA.mq4 |
//|                                      Copyright 2018, Rohit Nanda |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Rohit Nanda"
#property version   "4.0"
#property strict

#property indicator_chart_window
#property indicator_buffers 256


enum MAMODE
{
   SMA,
   EMA,
   SMMA,
   LWMA,
   HedgeableMeanLine,
   JMA,
   NMA,
   SimpleMAMA,
   ExponentialMAMA,
   SmoothedMAMA,
   LWMAMAMA,
   AdditionalMAMA
};

input int      IndNumber           = 0;

input bool     UseArray1           = true;
input ENUM_TIMEFRAMES UATimeFrame1 = PERIOD_CURRENT;
input MAMODE   UAMAMode1           = SMA;
input int      UAMAPeriod1         = 100;
input ENUM_APPLIED_PRICE UAPriceType1 = PRICE_HIGH;
input int      UAMAPeriod21        = 100;
input int      UAHedgePhase1       = 0;
input int      UAHedgeBarCount1    = 30000;
input color    UAColor1            = clrRed;


input bool     UseArray2           = true;
input ENUM_TIMEFRAMES UATimeFrame2 = PERIOD_CURRENT;
input MAMODE   UAMAMode2           = SMA;
input int      UAMAPeriod2         = 100;
input ENUM_APPLIED_PRICE UAPriceType2 = PRICE_LOW;
input int      UAMAPeriod22        = 100;
input int      UAHedgePhase2       = 0;
input int      UAHedgeBarCount2    = 30000;
input color    UAColor2            = clrGreen;


input bool     UseArray3           = true;
input ENUM_TIMEFRAMES UATimeFrame3 = PERIOD_CURRENT;
input MAMODE   UAMAMode3           = SMA;
input int      UAMAPeriod3         = 100;
input ENUM_APPLIED_PRICE UAPriceType3 = PRICE_OPEN;
input int      UAMAPeriod23        = 100;
input int      UAHedgePhase3       = 0;
input int      UAHedgeBarCount3    = 30000;
input color    UAColor3            = clrBlue;

input bool     UseArray4           = true;
input ENUM_TIMEFRAMES UATimeFrame4 = PERIOD_CURRENT;
input MAMODE   UAMAMode4           = SMA;
input int      UAMAPeriod4         = 100;
input ENUM_APPLIED_PRICE UAPriceType4 = PRICE_CLOSE;
input int      UAMAPeriod24        = 100;
input int      UAHedgePhase4       = 0;
input int      UAHedgeBarCount4    = 30000;
input color    UAColor4            = clrLimeGreen;

input bool     UseArray5           = true;
input ENUM_TIMEFRAMES UATimeFrame5 = PERIOD_CURRENT;
input MAMODE   UAMAMode5           = SMA;
input int      UAMAPeriod5         = 200;
input ENUM_APPLIED_PRICE UAPriceType5 = PRICE_CLOSE;
input int      UAMAPeriod25        = 100;
input int      UAHedgePhase5       = 0;
input int      UAHedgeBarCount5    = 30000;
input color    UAColor5            = clrBrown;

input bool     UseArray6           = true;
input ENUM_TIMEFRAMES UATimeFrame6 = PERIOD_CURRENT;
input MAMODE   UAMAMode6           = EMA;
input int      UAMAPeriod6         = 100;
input ENUM_APPLIED_PRICE UAPriceType6 = PRICE_CLOSE;
input int      UAMAPeriod26        = 100;
input int      UAHedgePhase6       = 0;
input int      UAHedgeBarCount6    = 30000;
input color    UAColor6            = clrYellow;

input bool     UseArray7           = true;
input ENUM_TIMEFRAMES UATimeFrame7 = PERIOD_CURRENT;
input MAMODE   UAMAMode7           = AdditionalMAMA;
input int      UAMAPeriod7         = 100;
input ENUM_APPLIED_PRICE UAPriceType7 = PRICE_CLOSE;
input int      UAMAPeriod27        = 100;
input int      UAHedgePhase7       = 0;
input int      UAHedgeBarCount7    = 30000;
input color    UAColor7            = clrBeige;

input bool     UseArray8           = true;
input ENUM_TIMEFRAMES UATimeFrame8 = PERIOD_CURRENT;
input MAMODE   UAMAMode8           = NMA;
input int      UAMAPeriod8         = 100;
input ENUM_APPLIED_PRICE UAPriceType8 = PRICE_CLOSE;
input int      UAMAPeriod28        = 100;
input int      UAHedgePhase8       = 0;
input int      UAHedgeBarCount8    = 30000;
input color    UAColor8            = clrBeige;

input bool     UseArray9           = true;
input ENUM_TIMEFRAMES UATimeFrame9 = PERIOD_CURRENT;
input MAMODE   UAMAMode9           = EMA;
input int      UAMAPeriod9         = 100;
input ENUM_APPLIED_PRICE UAPriceType9 = PRICE_CLOSE;
input int      UAMAPeriod29        = 100;
input int      UAHedgePhase9       = 0;
input int      UAHedgeBarCount9    = 30000;
input color    UAColor9            = clrBeige;

input bool     UseArray10          = true;
input ENUM_TIMEFRAMES UATimeFrame10= PERIOD_CURRENT;
input MAMODE   UAMAMode10          = SMA;
input int      UAMAPeriod10        = 105;
input ENUM_APPLIED_PRICE UAPriceType10 = PRICE_HIGH;
input int      UAMAPeriod210       = 100;
input int      UAHedgePhase10      = 0;
input int      UAHedgeBarCount10   = 30000;
input color    UAColor10           = clrIndigo;

input bool     UseArray11           = true;
input ENUM_TIMEFRAMES UATimeFrame11 = PERIOD_CURRENT;
input MAMODE   UAMAMode11           = SMA;
input int      UAMAPeriod11         = 110;
input ENUM_APPLIED_PRICE UAPriceType11 = PRICE_HIGH;
input int      UAMAPeriod211        = 100;
input int      UAHedgePhase11       = 0;
input int      UAHedgeBarCount11    = 30000;
input color    UAColor11            = clrHotPink;


input bool     UseArray12           = true;
input ENUM_TIMEFRAMES UATimeFrame12 = PERIOD_CURRENT;
input MAMODE   UAMAMode12           = SMA;
input int      UAMAPeriod12         = 120;
input ENUM_APPLIED_PRICE UAPriceType12 = PRICE_HIGH;
input int      UAMAPeriod212        = 100;
input int      UAHedgePhase12       = 0;
input int      UAHedgeBarCount12    = 30000;
input color    UAColor12            = clrGreenYellow;

input bool     UseArray13           = true;
input ENUM_TIMEFRAMES UATimeFrame13 = PERIOD_CURRENT;
input MAMODE   UAMAMode13           = SMA;
input int      UAMAPeriod13         = 130;
input ENUM_APPLIED_PRICE UAPriceType13 = PRICE_HIGH;
input int      UAMAPeriod213        = 100;
input int      UAHedgePhase13       = 0;
input int      UAHedgeBarCount13    = 30000;
input color    UAColor13            = clrFloralWhite;

input bool     UseArray14           = true;
input ENUM_TIMEFRAMES UATimeFrame14 = PERIOD_CURRENT;
input MAMODE   UAMAMode14           = SMA;
input int      UAMAPeriod14         = 140;
input ENUM_APPLIED_PRICE UAPriceType14 = PRICE_HIGH;
input int      UAMAPeriod214        = 100;
input int      UAHedgePhase14       = 0;
input int      UAHedgeBarCount14    = 30000;
input color    UAColor14            = clrDarkGoldenrod;

input bool     UseArray15           = true;
input ENUM_TIMEFRAMES UATimeFrame15 = PERIOD_CURRENT;
input MAMODE   UAMAMode15           = SMA;
input int      UAMAPeriod15         = 150;
input ENUM_APPLIED_PRICE UAPriceType15 = PRICE_HIGH;
input int      UAMAPeriod215        = 100;
input int      UAHedgePhase15       = 0;
input int      UAHedgeBarCount15    = 30000;
input color    UAColor15            = clrCyan;

input bool     UseArray16           = true;
input ENUM_TIMEFRAMES UATimeFrame16 = PERIOD_CURRENT;
input MAMODE   UAMAMode16           = SMA;
input int      UAMAPeriod16         = 160;
input ENUM_APPLIED_PRICE UAPriceType16 = PRICE_HIGH;
input int      UAMAPeriod216        = 100;
input int      UAHedgePhase16       = 0;
input int      UAHedgeBarCount16    = 30000;
input color    UAColor16            = clrRed;

input bool     UseArray17           = true;
input ENUM_TIMEFRAMES UATimeFrame17 = PERIOD_CURRENT;
input MAMODE   UAMAMode17           = SMA;
input int      UAMAPeriod17         = 170;
input ENUM_APPLIED_PRICE UAPriceType17 = PRICE_HIGH;
input int      UAMAPeriod217        = 180;
input int      UAHedgePhase17       = 0;
input int      UAHedgeBarCount17    = 30000;
input color    UAColor17            = clrBlueViolet;

input bool     UseArray18           = true;
input ENUM_TIMEFRAMES UATimeFrame18 = PERIOD_CURRENT;
input MAMODE   UAMAMode18           = SMA;
input int      UAMAPeriod18         = 100;
input ENUM_APPLIED_PRICE UAPriceType18 = PRICE_HIGH;
input int      UAMAPeriod218        = 100;
input int      UAHedgePhase18       = 0;
input int      UAHedgeBarCount18    = 30000;
input color    UAColor18            = clrRoyalBlue;

input bool     UseArray19           = true;
input ENUM_TIMEFRAMES UATimeFrame19 = PERIOD_CURRENT;
input MAMODE   UAMAMode19           = SMA;
input int      UAMAPeriod19         = 190;
input ENUM_APPLIED_PRICE UAPriceType19 = PRICE_HIGH;
input int      UAMAPeriod219        = 100;
input int      UAHedgePhase19       = 0;
input int      UAHedgeBarCount19    = 30000;
input color    UAColor19            = clrChocolate;

input bool     UseArray20           = true;
input ENUM_TIMEFRAMES UATimeFrame20 = PERIOD_CURRENT;
input MAMODE   UAMAMode20           = SMA;
input int      UAMAPeriod20         = 200;
input ENUM_APPLIED_PRICE UAPriceType20 = PRICE_HIGH;
input int      UAMAPeriod220        = 100;
input int      UAHedgePhase20       = 0;
input int      UAHedgeBarCount20    = 30000;
input color    UAColor20            = clrCyan;

input string   UAMAMAFileName      = "UA MAMA CSV.csv";

input string   OffsetMASepB      = "";
input string   OffsetMASep       = "------ Offset MA ------";
input bool     DrawOffsetMA1      = true;
input int      OffsetGridLevel1   = 2;
input double   LowerGridOffsetPips1 = 15;
input color    OffsetLineColor1   = clrHotPink;
input bool     DrawOffsetMA2      = true;
input int      OffsetGridLevel2   = 4;
input double   LowerGridOffsetPips2 = 15;
input color    OffsetLineColor2   = clrLimeGreen;
input bool     DrawOffsetMA3      = true;
input int      OffsetGridLevel3   = 6;
input double   LowerGridOffsetPips3 = 15;
input color    OffsetLineColor3   = clrBlue;

input string   GridSepB          = "";
input string   GridSep           = "--------- Grid --------";
input bool     DrawGrid          = true;
input int      HGridWeeks        = 20000; // Period over which to calc High/Low of gird
input int      HGridPips         = 0; // Size of grid in Pips
input color    HLine             = clrDarkGreen;        // Color of grid = Was DimGray
input color    HLine2            = clrDarkGreen;     // Every 100 pips, change grid color to this.
input int      GridTime          = 10000;          // Number of periods (days or weeks) to draw time grid
input ENUM_TIMEFRAMES TimeGrid   = PERIOD_CURRENT;   // Grid period in minutes
input int      ColorHour         = 0;         // For hour grids, draw color line at this hour (broker time)
input color    TimeLine          = CLR_NONE;     // Color of grid
input color    TimeLine2         = CLR_NONE;  // Color of special bars

input int      BarCount          = 10000;

int calculationIndex = 0;

#define SUBTIMEFRAME    1
#define SUBMAMODE       2
#define SUBMAPERIOD     3
#define SUBMAPRICETYPE  4
#define SUBMAPERIOD1    5
#define SUBMAHEDGEPHASE 6
#define SUBMAHEDGEBARCOUNT 7
#define SUBMAVARCOUNT 7

#define USERARRAYGR     0
#define OTHERARRAYGR    1

#define HIGHARRAY          0
#define LOWARRAY           1
#define MAHIGHOFFSETARRAY  2
#define MALOWOFFSETARRAY   3

#define MAOFFSETCOUNT      3
bool    DrawOffsetMA[MAOFFSETCOUNT];
int     OffsetGridLevel[MAOFFSETCOUNT];
double  LowerGridOffsetPips[MAOFFSETCOUNT];
color   OffsetLineColor[MAOFFSETCOUNT];

double         TPoint;
double         GridArray[];
int            MaxBars;
double         HGridPipsCur;


bool Init              = true;

string IndPrefix       = "ST";
class ArrayStruct
{
   public:
      int    MAIndexNo;
      int    MAArrayNo;
      double Array[];
      double ArrayMA[];
      int    SubMACount;
      
      bool UseArray;
      ENUM_TIMEFRAMES TimeFrame;
      MAMODE MAMode;
      int MAPeriod;
      ENUM_APPLIED_PRICE PriceType;
      int MAPeriod1;
      int HedgePhase;
      int HedgeBarCount;
      int  cIndex;
      int  LineColor;
      int  LineCount;
      
      ArrayStruct* NextArrayStruct;
      
      ArrayStruct( int inMAIndexNo, int inMAArrayNo, bool setIndCal )
      {
         MAIndexNo = inMAIndexNo;
         MAArrayNo = inMAArrayNo;
         UseArray       = false;
         TimeFrame      = PERIOD_CURRENT;
         MAMode         = SMA;
         MAPeriod       = 100;
         PriceType      = PRICE_CLOSE;
         MAPeriod1      = 100;
         HedgePhase     = 0;
         HedgeBarCount  = 30000;
         SubMACount     = 0;
         LineCount = 0;
         
         
         //ArraySetAsSeries( Array, false );
         if ( setIndCal )
         {
            cIndex = SetCalculationIndex( Array );      
         }
      }
      
      void Reset( double value )
      {
         SetIndexEmptyValue( cIndex, value );
      }
};

ArrayStruct*   UAArrayStructList = NULL;
ArrayStruct* GetArrayStructFromList( ArrayStruct* &inArrayStructList, int MAIndexNo, int MAArrayNo, bool setIndCal = false )
{
   ArrayStruct* arrayStructList = inArrayStructList;
   ArrayStruct* lastArrayStructList = arrayStructList;
   
   // Check if order already exits
   while ( arrayStructList != NULL )
   {
      if (( arrayStructList.MAIndexNo == MAIndexNo ) && ( arrayStructList.MAArrayNo == MAArrayNo ))
      {
         //Print( "Existing struct at ", IntegerToString( MAIndexNo ), " ", IntegerToString( MAArrayNo ), " already exists." );
         return arrayStructList;
      }
      lastArrayStructList = arrayStructList;
      arrayStructList = arrayStructList.NextArrayStruct;
   }
   
   if ( arrayStructList == NULL )
   {
      arrayStructList = new ArrayStruct( MAIndexNo, MAArrayNo, setIndCal );
      //Print( "Creating new struct at ", IntegerToString( MAIndexNo ), " ", IntegerToString( MAArrayNo ));
      if ( inArrayStructList == NULL )
         inArrayStructList = arrayStructList;
      else
         lastArrayStructList.NextArrayStruct = arrayStructList;
   }
   
   return arrayStructList;
}

int SetCalculationIndex( double& Array[] )
{
   SetIndexBuffer( calculationIndex, Array, INDICATOR_CALCULATIONS );
   SetIndexEmptyValue( calculationIndex, 0.0 );
   calculationIndex++;
   return calculationIndex;
}
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   if (( Digits == 5 || Digits == 3 ) && ( MarketInfo( Symbol(), MODE_PROFITCALCMODE ) == 0 ))
      TPoint = Point * 10;
   else
      TPoint = Point;
   
   ArrayStruct* arrayStruct;
   calculationIndex = 0;
   IndPrefix       = "ST" + IntegerToString( IndNumber );
   
   if ( UseArray1 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray1;
      arrayStruct.TimeFrame      = UATimeFrame1;
      arrayStruct.MAMode         = UAMAMode1;
      arrayStruct.MAPeriod       = UAMAPeriod1;
      arrayStruct.PriceType      = UAPriceType1;
      arrayStruct.MAPeriod1      = UAMAPeriod21;
      arrayStruct.HedgePhase     = UAHedgePhase1;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount1; 
      arrayStruct.LineColor      = UAColor1; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }

   if ( UseArray2 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray2;
      arrayStruct.TimeFrame      = UATimeFrame2;
      arrayStruct.MAMode         = UAMAMode2;
      arrayStruct.MAPeriod       = UAMAPeriod2;
      arrayStruct.PriceType      = UAPriceType2;
      arrayStruct.MAPeriod1      = UAMAPeriod22;
      arrayStruct.HedgePhase     = UAHedgePhase2;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount2;
      arrayStruct.LineColor      = UAColor2; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
      
   if ( UseArray3 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray3;
      arrayStruct.TimeFrame      = UATimeFrame3;
      arrayStruct.MAMode         = UAMAMode3;
      arrayStruct.MAPeriod       = UAMAPeriod3;
      arrayStruct.PriceType      = UAPriceType3;
      arrayStruct.MAPeriod1      = UAMAPeriod23;
      arrayStruct.HedgePhase     = UAHedgePhase3;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount3;
      arrayStruct.LineColor      = UAColor3; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_DASHDOT, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
      
   if ( UseArray4 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray4;
      arrayStruct.TimeFrame      = UATimeFrame4;
      arrayStruct.MAMode         = UAMAMode4;
      arrayStruct.MAPeriod       = UAMAPeriod4;
      arrayStruct.PriceType      = UAPriceType4;
      arrayStruct.MAPeriod1      = UAMAPeriod24;
      arrayStruct.HedgePhase     = UAHedgePhase4;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount4;
      arrayStruct.LineColor      = UAColor4; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_DASHDOT, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
      
   if ( UseArray5 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, 4, USERARRAYGR );
      arrayStruct.UseArray       = UseArray5;
      arrayStruct.TimeFrame      = UATimeFrame5;
      arrayStruct.MAMode         = UAMAMode5;
      arrayStruct.MAPeriod       = UAMAPeriod5;
      arrayStruct.PriceType      = UAPriceType5;
      arrayStruct.MAPeriod1      = UAMAPeriod25;
      arrayStruct.HedgePhase     = UAHedgePhase5;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount5;
      arrayStruct.LineColor      = UAColor5; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_DASHDOT, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
      
   if ( UseArray6 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray6;
      arrayStruct.TimeFrame      = UATimeFrame6;
      arrayStruct.MAMode         = UAMAMode6;
      arrayStruct.MAPeriod       = UAMAPeriod6;
      arrayStruct.PriceType      = UAPriceType6;
      arrayStruct.MAPeriod1      = UAMAPeriod26;
      arrayStruct.HedgePhase     = UAHedgePhase6;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount6;
      arrayStruct.LineColor      = UAColor6; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_DASHDOT, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
      
   if ( UseArray7 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray7;
      arrayStruct.TimeFrame      = UATimeFrame7;
      arrayStruct.MAMode         = UAMAMode7;
      arrayStruct.MAPeriod       = UAMAPeriod7;
      arrayStruct.PriceType      = UAPriceType7;
      arrayStruct.MAPeriod1      = UAMAPeriod27;
      arrayStruct.HedgePhase     = UAHedgePhase7;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount7;
      arrayStruct.LineColor      = UAColor7; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_DASHDOT, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray8 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray8;
      arrayStruct.TimeFrame      = UATimeFrame8;
      arrayStruct.MAMode         = UAMAMode8;
      arrayStruct.MAPeriod       = UAMAPeriod8;
      arrayStruct.PriceType      = UAPriceType8;
      arrayStruct.MAPeriod1      = UAMAPeriod28;
      arrayStruct.HedgePhase     = UAHedgePhase8;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount8;
      arrayStruct.LineColor      = UAColor8; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_DASHDOT, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray9 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray9;
      arrayStruct.TimeFrame      = UATimeFrame9;
      arrayStruct.MAMode         = UAMAMode9;
      arrayStruct.MAPeriod       = UAMAPeriod9;
      arrayStruct.PriceType      = UAPriceType9;
      arrayStruct.MAPeriod1      = UAMAPeriod29;
      arrayStruct.HedgePhase     = UAHedgePhase9;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount9;
      arrayStruct.LineColor      = UAColor9; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_DASHDOT, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray10 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray10;
      arrayStruct.TimeFrame      = UATimeFrame10;
      arrayStruct.MAMode         = UAMAMode10;
      arrayStruct.MAPeriod       = UAMAPeriod10;
      arrayStruct.PriceType      = UAPriceType10;
      arrayStruct.MAPeriod1      = UAMAPeriod210;
      arrayStruct.HedgePhase     = UAHedgePhase10;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount10; 
      arrayStruct.LineColor      = UAColor10; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray11 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray11;
      arrayStruct.TimeFrame      = UATimeFrame11;
      arrayStruct.MAMode         = UAMAMode11;
      arrayStruct.MAPeriod       = UAMAPeriod11;
      arrayStruct.PriceType      = UAPriceType11;
      arrayStruct.MAPeriod1      = UAMAPeriod211;
      arrayStruct.HedgePhase     = UAHedgePhase11;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount11; 
      arrayStruct.LineColor      = UAColor11; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   
   if ( UseArray12 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray12;
      arrayStruct.TimeFrame      = UATimeFrame12;
      arrayStruct.MAMode         = UAMAMode12;
      arrayStruct.MAPeriod       = UAMAPeriod12;
      arrayStruct.PriceType      = UAPriceType12;
      arrayStruct.MAPeriod1      = UAMAPeriod212;
      arrayStruct.HedgePhase     = UAHedgePhase12;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount12; 
      arrayStruct.LineColor      = UAColor12; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray13 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray13;
      arrayStruct.TimeFrame      = UATimeFrame13;
      arrayStruct.MAMode         = UAMAMode13;
      arrayStruct.MAPeriod       = UAMAPeriod13;
      arrayStruct.PriceType      = UAPriceType13;
      arrayStruct.MAPeriod1      = UAMAPeriod213;
      arrayStruct.HedgePhase     = UAHedgePhase13;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount13; 
      arrayStruct.LineColor      = UAColor13; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray14 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray14;
      arrayStruct.TimeFrame      = UATimeFrame14;
      arrayStruct.MAMode         = UAMAMode14;
      arrayStruct.MAPeriod       = UAMAPeriod14;
      arrayStruct.PriceType      = UAPriceType14;
      arrayStruct.MAPeriod1      = UAMAPeriod214;
      arrayStruct.HedgePhase     = UAHedgePhase14;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount14; 
      arrayStruct.LineColor      = UAColor14; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray15 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray15;
      arrayStruct.TimeFrame      = UATimeFrame15;
      arrayStruct.MAMode         = UAMAMode15;
      arrayStruct.MAPeriod       = UAMAPeriod15;
      arrayStruct.PriceType      = UAPriceType15;
      arrayStruct.MAPeriod1      = UAMAPeriod215;
      arrayStruct.HedgePhase     = UAHedgePhase15;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount15; 
      arrayStruct.LineColor      = UAColor15; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray16 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray16;
      arrayStruct.TimeFrame      = UATimeFrame16;
      arrayStruct.MAMode         = UAMAMode16;
      arrayStruct.MAPeriod       = UAMAPeriod16;
      arrayStruct.PriceType      = UAPriceType16;
      arrayStruct.MAPeriod1      = UAMAPeriod216;
      arrayStruct.HedgePhase     = UAHedgePhase16;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount16; 
      arrayStruct.LineColor      = UAColor16; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray17 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray17;
      arrayStruct.TimeFrame      = UATimeFrame17;
      arrayStruct.MAMode         = UAMAMode17;
      arrayStruct.MAPeriod       = UAMAPeriod17;
      arrayStruct.PriceType      = UAPriceType17;
      arrayStruct.MAPeriod1      = UAMAPeriod217;
      arrayStruct.HedgePhase     = UAHedgePhase17;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount17; 
      arrayStruct.LineColor      = UAColor17; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray18 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray18;
      arrayStruct.TimeFrame      = UATimeFrame18;
      arrayStruct.MAMode         = UAMAMode18;
      arrayStruct.MAPeriod       = UAMAPeriod18;
      arrayStruct.PriceType      = UAPriceType18;
      arrayStruct.MAPeriod1      = UAMAPeriod218;
      arrayStruct.HedgePhase     = UAHedgePhase18;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount18; 
      arrayStruct.LineColor      = UAColor18; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray19 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray19;
      arrayStruct.TimeFrame      = UATimeFrame19;
      arrayStruct.MAMode         = UAMAMode19;
      arrayStruct.MAPeriod       = UAMAPeriod19;
      arrayStruct.PriceType      = UAPriceType19;
      arrayStruct.MAPeriod1      = UAMAPeriod219;
      arrayStruct.HedgePhase     = UAHedgePhase19;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount19; 
      arrayStruct.LineColor      = UAColor19; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   if ( UseArray20 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, calculationIndex, USERARRAYGR );
      arrayStruct.UseArray       = UseArray20;
      arrayStruct.TimeFrame      = UATimeFrame20;
      arrayStruct.MAMode         = UAMAMode20;
      arrayStruct.MAPeriod       = UAMAPeriod20;
      arrayStruct.PriceType      = UAPriceType20;
      arrayStruct.MAPeriod1      = UAMAPeriod220;
      arrayStruct.HedgePhase     = UAHedgePhase20;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount20; 
      arrayStruct.LineColor      = UAColor20; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( calculationIndex, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( calculationIndex, 0.0 );
      SetIndexStyle( calculationIndex, DRAW_LINE, STYLE_SOLID, 2, arrayStruct.LineColor );
      calculationIndex++;
   }
   
   
   arrayStruct = UAArrayStructList;
   while( arrayStruct != NULL )
   {
      if (( arrayStruct.UseArray ) && ( arrayStruct.MAArrayNo == USERARRAYGR ))
      {
         switch( arrayStruct.MAMode )
         {
            case SimpleMAMA: // MA OF SIMPLE MA
            case ExponentialMAMA: // MA OF EXPNENTIAL MA
            case SmoothedMAMA: // MA OF SMOOTHED MA
            case LWMAMAMA: // MA OF LWMA
               GetArrayStructFromList( UAArrayStructList, arrayStruct.MAIndexNo, OTHERARRAYGR, true );
               break;
            case AdditionalMAMA:
            break;
         }
      }
      arrayStruct = arrayStruct.NextArrayStruct;
   }

   // Read Additional MAMA file
   if ( UAMAMAFileName != "" )
   {
      ReadMAMAFile( UAMAMAFileName, UAArrayStructList );
   } 
   
   
   GetArrayStructFromList( UAArrayStructList, HIGHARRAY, OTHERARRAYGR, true );
   GetArrayStructFromList( UAArrayStructList, LOWARRAY, OTHERARRAYGR, true );
      
   DrawOffsetMA[0]      = DrawOffsetMA1;
   OffsetGridLevel[0]   = OffsetGridLevel1;
   LowerGridOffsetPips[0] = LowerGridOffsetPips1;
   OffsetLineColor[0]   = OffsetLineColor1; 
   DrawOffsetMA[1]      = DrawOffsetMA2;
   OffsetGridLevel[1]   = OffsetGridLevel2;
   LowerGridOffsetPips[1] = LowerGridOffsetPips2;
   OffsetLineColor[1]   = OffsetLineColor2; 
   DrawOffsetMA[2]      = DrawOffsetMA3;
   OffsetGridLevel[2]   = OffsetGridLevel3;
   LowerGridOffsetPips[2] = LowerGridOffsetPips3;
   OffsetLineColor[2]    = OffsetLineColor3;
   int highOffsetCount = MAHIGHOFFSETARRAY;
   int lowOffsetCount = MALOWOFFSETARRAY;
   for ( int maIndex = 0; maIndex < MAOFFSETCOUNT; maIndex++ )
   {
      if ( DrawOffsetMA[maIndex] )
      {
         GetArrayStructFromList( UAArrayStructList, highOffsetCount, OTHERARRAYGR, true );
         GetArrayStructFromList( UAArrayStructList, lowOffsetCount, OTHERARRAYGR, true );
         highOffsetCount = highOffsetCount + 2;
         lowOffsetCount = lowOffsetCount + 2;
      }
   }
   
   //--------------------------------------------------------------------------
   Init = true;
   return( INIT_SUCCEEDED );
}

void OnDeinit( const int reason )
{
   ArrayStruct* arrayStruct = UAArrayStructList;
   ArrayStruct* nextArrayStruct = NULL;
   while( arrayStruct != NULL )
   {
      nextArrayStruct = arrayStruct.NextArrayStruct;
      delete arrayStruct;
      arrayStruct = nextArrayStruct;
   }
   
   ClearChart();
}

void ClearChart()
{
   ObjectsDeleteAll( 0, IndPrefix );
   Comment( "" );
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
   if ( Init )
   {
      if ( HGridPips == 0 )
      {
         if (( TPoint <= 0.0001 ) || ( MarketInfo( Symbol(), MODE_PROFITCALCMODE ) == 0 ))
            HGridPipsCur = 10;
         else if ( TPoint <= 0.001 )
            HGridPipsCur = 100;
         else //if ( TPoint <= 0.01 )
         {
            if ( rates_total == 0 )
               return ( rates_total );
               
            if( Close[0] < 100 )
               HGridPipsCur = 1 / TPoint;
            else if ( Close[0] < 5000 )
               HGridPipsCur = 10 / TPoint;
            else
               HGridPipsCur = 100 / TPoint;
         }
      }  
      else
         HGridPipsCur = HGridPips;
         
      Comment( "Grid Step: " + DoubleToStr( HGridPipsCur, 1 ));
      Init = False;
   }
   
   
   int limit = rates_total - prev_calculated;
      
   if ( BarCount != -1 )
      if ( limit >= BarCount )
      {
         limit = BarCount - 1;
         MaxBars = limit;
      }
      
   if ( prev_calculated <= 0 )
   {
      for ( int maIndex = 0; maIndex < MAOFFSETCOUNT; maIndex++ )
      {
         OffsetMAHighLineCount[maIndex] = 0;
         OffsetMALowLineCount[maIndex] = 0;
      }
      MaxBars = limit;
      ClearChart();
   }
   
   bool newBar;
   if ( limit > 2)
   {
      for ( int barNo = limit - 1; barNo > 0; barNo-- )
      {
         for ( int maIndex = 0; maIndex < MAOFFSETCOUNT; maIndex++ )
            Calculate( maIndex, barNo, true );
      } 
   }
   else
   {
      newBar = NewBar( 0 );
      for ( int maIndex = 0; maIndex < MAOFFSETCOUNT; maIndex++ )
      {
         Calculate( maIndex, 0, newBar );
      }
   }
   
   return(rates_total);
}
//+------------------------------------------------------------------+
void Calculate( int maIndex, int barNo, bool newBar )
{

   ArrayStruct* arrayStruct = UAArrayStructList;
   while( arrayStruct != NULL )
   {
      if (( arrayStruct.UseArray ) && ( arrayStruct.MAArrayNo == 0 ))
      {
         //Print( arrayStruct.MAIndexNo, " ", barNo, " ", ArraySize( arrayStruct.Array ));
         arrayStruct.Array[barNo] = CalculateMA( barNo, 
                                                 arrayStruct.MAIndexNo,
                                                 UAArrayStructList,
                                                 arrayStruct );
         //if ( arrayStruct.MAIndexNo == 7 )
         //   Print( arrayStruct.MAIndexNo, " ", barNo, " ",   arrayStruct.Array[barNo] );                                              
      }
      arrayStruct = arrayStruct.NextArrayStruct;
   }
   
   if ( newBar )
   {
      DrawGridFunc( barNo, newBar );
      GetHighLowArray( barNo );
   }

   if ( DrawOffsetMA[maIndex] )   
      DrawOffsetMADouble( maIndex, barNo, newBar );
}

double CalculateMA( int barNo, int ind, ArrayStruct* UAOrOMA, ArrayStruct* arrayStructBaseMA )
{
   switch( arrayStructBaseMA.MAMode )
   {
      case SMA:
         return NormalizeDouble( iMA( Symbol(), arrayStructBaseMA.TimeFrame, arrayStructBaseMA.MAPeriod, 0, MODE_SMA, arrayStructBaseMA.PriceType, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] )), Digits );
         break;
      case EMA:
         return NormalizeDouble( iMA( Symbol(), arrayStructBaseMA.TimeFrame, arrayStructBaseMA.MAPeriod, 0, MODE_EMA, arrayStructBaseMA.PriceType, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] )), Digits );
         break;
      case SMMA:
         return NormalizeDouble( iMA( Symbol(), arrayStructBaseMA.TimeFrame, arrayStructBaseMA.MAPeriod, 0, MODE_SMMA, arrayStructBaseMA.PriceType, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] )), Digits );
         break;
      case LWMA:
         return NormalizeDouble( iMA( Symbol(), arrayStructBaseMA.TimeFrame, arrayStructBaseMA.MAPeriod, 0, MODE_LWMA, arrayStructBaseMA.PriceType, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] )), Digits );
         break;
      case HedgeableMeanLine:
         return iCustom( Symbol(), arrayStructBaseMA.TimeFrame, "hedgable meanline", arrayStructBaseMA.MAPeriod, arrayStructBaseMA.PriceType, arrayStructBaseMA.HedgePhase, arrayStructBaseMA.HedgeBarCount, 0, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] ));
         break;
      case JMA:
         return iCustom( Symbol(), arrayStructBaseMA.TimeFrame, "JMA", arrayStructBaseMA.MAPeriod, arrayStructBaseMA.PriceType, arrayStructBaseMA.HedgePhase, arrayStructBaseMA.HedgeBarCount, 0, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] ));
         break;
      case NMA:
         return iCustom( Symbol(), arrayStructBaseMA.TimeFrame, "NMA", arrayStructBaseMA.MAPeriod, BarCount, 0, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] ));
         break;
      case SimpleMAMA: // MA OF SIMPLE MA
         {
            //Print( ind, " ", UAOrOMA.MAIndexNo, " ", arrayStructBaseMA.SubMACount, " ", barNo, " ", ArraySize( arrayStructBaseMA.ArrayMA ));
            arrayStructBaseMA.ArrayMA[barNo] = iMA( Symbol(), arrayStructBaseMA.TimeFrame, arrayStructBaseMA.MAPeriod, 0, MODE_SMA, arrayStructBaseMA.PriceType, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] ));
            return NormalizeDouble( iMAOnArray( arrayStructBaseMA.ArrayMA, 0, arrayStructBaseMA.MAPeriod1, 0, MODE_SMA, barNo ), Digits );
         }
         break;
      case ExponentialMAMA: // MA OF EXPNENTIAL MA
         {
            //Print( ind, " ", UAOrOMA.MAIndexNo, " ", arrayStructBaseMA.SubMACount, " ", barNo, " ", ArraySize( arrayStructBaseMA.ArrayMA ));
            arrayStructBaseMA.ArrayMA[barNo] = iMA( Symbol(), arrayStructBaseMA.TimeFrame, arrayStructBaseMA.MAPeriod, 0, MODE_EMA, arrayStructBaseMA.PriceType, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] ));
            return NormalizeDouble( iMAOnArray( arrayStructBaseMA.ArrayMA, 0, arrayStructBaseMA.MAPeriod1, 0, MODE_SMA, barNo ), Digits );
         }
         break;
      case SmoothedMAMA: // MA OF SMOOTHED MA
         {
            arrayStructBaseMA.ArrayMA[barNo] = iMA( Symbol(), arrayStructBaseMA.TimeFrame, arrayStructBaseMA.MAPeriod, 0, MODE_SMMA, arrayStructBaseMA.PriceType, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] ));
            return NormalizeDouble( iMAOnArray( arrayStructBaseMA.ArrayMA, 0, arrayStructBaseMA.MAPeriod1, 0, MODE_SMA, barNo ), Digits );
         }
         break;
      case LWMAMAMA: // MA OF LWMA
         {
            arrayStructBaseMA.ArrayMA[barNo] = iMA( Symbol(), arrayStructBaseMA.TimeFrame, arrayStructBaseMA.MAPeriod, 0, MODE_LWMA, arrayStructBaseMA.PriceType, iBarShift( NULL, arrayStructBaseMA.TimeFrame, Time[barNo] ));
            return NormalizeDouble( iMAOnArray( arrayStructBaseMA.ArrayMA, 0, arrayStructBaseMA.MAPeriod1, 0, MODE_SMA, barNo ), Digits );
         }
         break;
      case AdditionalMAMA:
         {
            double totalVal = 0;
            for ( int subMA = OTHERARRAYGR; subMA <= arrayStructBaseMA.SubMACount; subMA++ )
            {
               totalVal += CalculateMA( barNo, ind, UAOrOMA, GetArrayStructFromList( UAOrOMA, ind, subMA ));
            }
            if ( arrayStructBaseMA.SubMACount > 0 )
               return NormalizeDouble( totalVal / arrayStructBaseMA.SubMACount, Digits );
            else
               return 0;
         }
         break;
   }
   
   return 0;
}

MAMODE GetMAModeFromStr( string inStr )
{
   if ( inStr == "SMA" )
      return SMA;
   else if ( inStr == "EMA" )
      return EMA;
   else if ( inStr == "SMMA" )
      return SMMA;
   else if ( inStr == "LWMA" )
      return LWMA;
   else if ( inStr == "HedgeableMeanLine" )
      return HedgeableMeanLine;
   else if ( inStr == "JMA" )
      return JMA;
   else if ( inStr == "SimpleMAMA" )
      return SimpleMAMA;
   else if ( inStr == "ExponentialMAMA" )
      return ExponentialMAMA;
   else if ( inStr == "SmoothedMAMA" )
      return SmoothedMAMA;
   else if ( inStr == "LWMAMAMA" )
      return LWMAMAMA;
      
   return -1;
}

ENUM_APPLIED_PRICE GetPriceTypeFromStr( string inStr )
{
   if ( inStr == "PRICE_CLOSE" )
      return PRICE_CLOSE;
   else if ( inStr == "PRICE_OPEN" )
      return PRICE_OPEN;
   else if ( inStr == "PRICE_HIGH" )
      return PRICE_HIGH;
   else if ( inStr == "PRICE_LOW" )
      return PRICE_LOW;
   else if ( inStr == "PRICE_MEDIAN" )
      return PRICE_MEDIAN;
   else if ( inStr == "PRICE_TYPICAL" )
      return PRICE_TYPICAL;
   else if ( inStr == "PRICE_WEIGHTED" )
      return PRICE_WEIGHTED;      
   return -1;
}

ENUM_TIMEFRAMES GetTimeframeFromString( string inStr )
{
   if ( inStr == "PERIOD_CURRENT" )
      return PERIOD_CURRENT;
   if ( inStr == "PERIOD_M1" )
      return PERIOD_M1;
   if ( inStr == "PERIOD_M5" )
      return PERIOD_M5;
   if ( inStr == "PERIOD_M15" )
      return PERIOD_M15;
   if ( inStr == "PERIOD_M30" )
      return PERIOD_M30;
   if ( inStr == "PERIOD_H1" )
      return PERIOD_H1;
   if ( inStr == "PERIOD_H4" )
      return PERIOD_H4;
   if ( inStr == "PERIOD_D1" )
      return PERIOD_D1;
   if ( inStr == "PERIOD_W1" )
      return PERIOD_W1;
   if ( inStr == "PERIOD_MN1" )
      return PERIOD_MN1;
      
   return PERIOD_CURRENT;
}

datetime LastTime;
bool NewBar( int barNo ) 
{
	datetime curTime = iTime( NULL, 0, barNo );
	   
	if ( curTime != LastTime ) {
	   //Print( barNo, " ", TimeToStr( LastTime, TIME_DATE | TIME_SECONDS ), " ", TimeToStr( iTime( NULL, TimeFrame, barNo ))); 
		LastTime = curTime;
		return (true);
	} else	
	   return (false);
}


void AddToGridIndex( double price )
{
   price = NormalizeDouble( price, Digits );
   int gridSize = ArraySize( GridArray );

   if ( gridSize == 0 )
   {
      ArrayResize( GridArray, 1 );
      GridArray[0] = price;
   }
   else
   {
      if ( GridArray[0] > price ) // Add at start
      {
         gridSize++;
         ArrayResize( GridArray, gridSize );
         for ( int i = gridSize - 1; i > 0; i-- )
            GridArray[i] = GridArray[i - 1];
         GridArray[0] = price; 
      }
      else if ( GridArray[gridSize - 1] < price ) // Add at start
      {
         gridSize++;
         ArrayResize( GridArray, gridSize );
         GridArray[gridSize - 1] = price; 
      }
      else 
      {
         for ( int i = 0; i < gridSize - 1; i++ )
         {
            if ( GridArray[i] == price ) // price already present
               return; 
            else if (( GridArray[i] < price ) && ( GridArray[i + 1] > price )) // Insert in middle
            {
               gridSize++;
               ArrayResize( GridArray, gridSize );
               for ( int j = gridSize - 1; j > i; j-- )
                  GridArray[j] = GridArray[j - 1];
               GridArray[i + 1] = price; 
               
               //for ( int k = 0; k < gridSize - 1; k++ )
               //   Print( k, " ", GridArray[k], " ", price );
               break;
            }
         }
      }
   }
}

void GetHighLowArray( int barNo )
{
   // Find Highest and Lowest MA line
   double highValue = 0;
   double lowValue = DBL_MAX;
   ArrayStruct* arrayStruct = UAArrayStructList;
   
   while ( arrayStruct != NULL )
   {
      if (( arrayStruct.UseArray ) && ( arrayStruct.MAArrayNo == 0 ))
      {
         if ( arrayStruct.Array[barNo] > highValue )
         {
            highValue = arrayStruct.Array[barNo];
         }
         if ( arrayStruct.Array[barNo] < lowValue )
         {
            lowValue = arrayStruct.Array[barNo];
         }
      }
      arrayStruct = arrayStruct.NextArrayStruct;
   }
   ArrayStruct* HighArrayStruct = GetArrayStructFromList( UAArrayStructList, HIGHARRAY, OTHERARRAYGR );
   ArrayStruct* LowArrayStruct = GetArrayStructFromList( UAArrayStructList, LOWARRAY, OTHERARRAYGR );
   if ( HighArrayStruct == NULL )
      Print( "HighArrayStruct is NULL" );
      
   HighArrayStruct.Array[barNo] = NormalizeDouble( highValue, Digits );
   LowArrayStruct.Array[barNo] = NormalizeDouble( lowValue, Digits );
}

void DrawGridFunc( int barNo, bool newBar )
{
   if (( !DrawGrid ) || ( !newBar ))
      return;
      
   int gridSize = ArraySize( GridArray );
   
   if (( gridSize > 0 ) &&
       (( iHigh( NULL, 0, barNo ) < GridArray[ArraySize( GridArray ) - 1] *0.9 ) &&
        ( iLow( NULL, 0, barNo ) > GridArray[0] * 1.1 )))
      return;
      
   if ( true /*lastTime == 0 || CurTime() - lastTime > 5*/ ) 
   {
      //firstTime = false;
      //lastTime = CurTime();
         
      int weeklyBar = HGridWeeks;
      if ( HGridWeeks > iBars( NULL, PERIOD_W1 ))
         weeklyBar = iBars( NULL, PERIOD_W1 ) - 1;
      if ( HGridPipsCur > 0 ) 
      {
         double weekH = iHigh( NULL, PERIOD_W1, weeklyBar );
         double weekL = iLow( NULL, PERIOD_W1, weeklyBar );

         for ( int i = 0; i <= weeklyBar; i++ ) 
         {
            weekH = MathMax( weekH, iHigh( NULL, PERIOD_W1, i ) );
            weekL = MathMin( weekL, iLow( NULL, PERIOD_W1, i ) );
         }

         if ( weekH < iHigh( NULL, 0, 1 ) * 0.7)
            weekH = iHigh( NULL, 0, 1 ) * 1.3;
          if ( weekL > iLow( NULL, 0, 1 ) * 1.3)
            weekL = iLow( NULL, 0, 1 ) * 0.7;
            
         double pipRange = HGridPipsCur * TPoint;

         double topPips = (weekH + pipRange) - MathMod( weekH, pipRange );
         double botPips = weekL - pipRange - MathMod( weekL, pipRange );
         //Print( topPips, " ", ArrayRange( GridArray, 0 ) );
         for ( double p = botPips; p <= topPips; p += pipRange ) 
         {
            string gridname = IndPrefix + "XGrid" + DoubleToStr( p, Digits );
            ObjectCreate( gridname, OBJ_HLINE, 0, 0, p );
            p = NormalizeDouble( p, Digits );
            double pp = p / TPoint;
           
            //Print( lineIndex, " ", ArraySize( GridArray ), " ", p );
            AddToGridIndex( p );
             
            int pInt = ( int ) MathRound( pp );
            int mod = 100;
            if ( Symbol() == "GOLD" )
               mod = 1000;
               
            if ( (pInt % mod) == 0 )
               ObjectSet( gridname, OBJPROP_COLOR, HLine2 );
            else
               ObjectSet( gridname, OBJPROP_COLOR, HLine );
            ObjectSet( gridname, OBJPROP_STYLE, STYLE_DASHDOTDOT );
            ObjectSet( gridname, OBJPROP_PRICE1, p );
            ObjectSet( gridname, OBJPROP_BACK, true );
         }
      }
   }
   
   datetime start;
   if ( TimeGrid == PERIOD_W1 ) 
   {
      int weekCount = GridTime - 1;
      int bar=0;
      while ( weekCount >= 0 && bar < Bars ) 
      {
         if ( TimeDayOfWeek( Time[bar] ) == 1 && TimeHour( Time[bar] ) == 0  ) 
         {
            start = Time[bar];
            string gridname = IndPrefix + "XGrid" + DoubleToStr( start, 0 );
            ObjectCreate( gridname, OBJ_VLINE, 0, start, 0 );
            ObjectSet( gridname, OBJPROP_RAY, true );
            if ( TimeHour( start ) == ColorHour && TimeMinute( start ) == 0 ) 
               ObjectSet( gridname, OBJPROP_COLOR, TimeLine2 );
            else
               ObjectSet( gridname, OBJPROP_COLOR, TimeLine );
            ObjectSet( gridname, OBJPROP_STYLE, STYLE_DASHDOTDOT );
            ObjectSet( gridname, OBJPROP_TIME1, start );
            ObjectSet( gridname, OBJPROP_BACK, true );
            weekCount--;
         }
         bar++;
      }
   }
   
   if ( TimeGrid > 0 ) 
   {
      start = Time[0];
      int skip = TimeGrid * 60;
      
      start = start - (start % skip) + skip;
      
      int thisDay = TimeDay( start );
      int dayCount = GridTime - 1;
      
      while ( dayCount >= 0 )
      {
         string gridname = IndPrefix + "XGrid" + DoubleToStr( start, 0 );
         ObjectCreate( gridname, OBJ_VLINE, 0, start, 0 );
         if ( TimeHour( start ) == ColorHour && TimeMinute( start ) == 0 ) 
            ObjectSet( gridname, OBJPROP_COLOR, TimeLine2 );
         else
            ObjectSet( gridname, OBJPROP_COLOR, TimeLine );
         ObjectSet( gridname, OBJPROP_STYLE, STYLE_DASHDOTDOT );
         ObjectSet( gridname, OBJPROP_TIME1, start );
         ObjectSet( gridname, OBJPROP_BACK, false );
         
         start = start - skip;
         if ( TimeDay( start ) != thisDay ) {
            dayCount--;
            thisDay = TimeDay( start );
         }
      }
   }
}

void DrawIndicator( string prefix, int barNo, double lPrice, double rPrice, color clr, int width = 2, ENUM_LINE_STYLE lineStyle = STYLE_SOLID )
{
   string name = prefix + IntegerToString( Bars - barNo );
   bool existing = ObjectFind( name ) >= 0;

   if ( !existing )
   {
      ObjectCreate( name, OBJ_TREND, 0, 0, 0, 0 ); 
      
      ObjectSet( name, OBJPROP_RAY, false );      
      ObjectSet( name, OBJPROP_COLOR, clr );
      ObjectSet( name, OBJPROP_STYLE, lineStyle );
      ObjectSet( name, OBJPROP_WIDTH, width );
      ObjectSet( name, OBJPROP_TIME1, Time[barNo + 1] );
      ObjectSet( name, OBJPROP_TIME2, Time[barNo] );
      //Print( "new ind " + name + " " + barNo );
   }
         
   ObjectSet( name, OBJPROP_PRICE1, lPrice );
   ObjectSet( name, OBJPROP_PRICE2, rPrice );
}


void DrawTrendLine( string prefix, int& index, int fromBarNo, int toBarNo, double fromPrice, double toPrice, color clr, int width = 2, ENUM_LINE_STYLE lineStyle = STYLE_SOLID, bool reuse = false )
{
   if (( fromPrice == 0) || ( toPrice == 0 ))
      return;
        
   string name;
   name = prefix + IntegerToString( index );
   //if ( StringFind( prefix, "OSetLine" ) > 0 )
   //   Print( lPrice, " ", rPrice );
   bool existing = ObjectFind( name ) >= 0;
   if ( existing )
   {
      if ((( ObjectGet( name, OBJPROP_TIME1 ) == Time[fromBarNo] ) &&
           ( ObjectGet( name, OBJPROP_TIME2 ) == Time[toBarNo] )) ||
          ( reuse &&
           ( ObjectGet( name, OBJPROP_PRICE1 ) == fromPrice ) && // for oc lines
           ( ObjectGet( name, OBJPROP_PRICE2 ) == toPrice )))
         existing = true;
      else
         existing = false;
   }
   
   if ( !existing )       
   {
      index++;
      name = prefix + IntegerToString( index );
      ObjectCreate( name, OBJ_TREND, 0, 0, 0, 0 );
      ObjectSet( name, OBJPROP_RAY, false );      
      ObjectSet( name, OBJPROP_COLOR, clr );
      ObjectSet( name, OBJPROP_STYLE, lineStyle );
      ObjectSet( name, OBJPROP_WIDTH, width );
   }
   ObjectSet( name, OBJPROP_PRICE1, fromPrice );
   ObjectSet( name, OBJPROP_PRICE2, toPrice );
   if ( !reuse )
      ObjectSet( name, OBJPROP_TIME1, Time[fromBarNo] );
   ObjectSet( name, OBJPROP_TIME2, Time[toBarNo] );
}
 

int OffsetMAHighLineCount[MAOFFSETCOUNT];
int OffsetMALowLineCount[MAOFFSETCOUNT];
void DrawOffsetMADouble( int maIndex, int barNo, bool newBar  )
{
   if (( MaxBars - barNo ) < 512 )
      return;

   ArrayStruct* MAHighArrayStruct = GetArrayStructFromList( UAArrayStructList, MAHIGHOFFSETARRAY + 2 * maIndex, OTHERARRAYGR );
   ArrayStruct* MALowArrayStruct = GetArrayStructFromList( UAArrayStructList, MALOWOFFSETARRAY + 2 * maIndex, OTHERARRAYGR );
   ArrayStruct* HighArrayStruct = GetArrayStructFromList( UAArrayStructList, HIGHARRAY, OTHERARRAYGR );
   ArrayStruct* LowArrayStruct = GetArrayStructFromList( UAArrayStructList, LOWARRAY, OTHERARRAYGR );
    
   int gridArraySize = ArraySize( GridArray );  
   int gridIndex;
   double oldLevel;
   bool found;  
   
   // Draw High MA
   found = false;
   oldLevel = MAHighArrayStruct.Array[barNo + 1];
   double tempHighMA = MathCeil( HighArrayStruct.Array[barNo + 1] / HGridPipsCur / TPoint ) * HGridPipsCur * TPoint;
   for ( gridIndex = gridArraySize - 2; gridIndex > 0 ; gridIndex-- )
   {
      //Print( GridArray[gridIndex], " ", tempHighMA, " ",  HighArrayStruct.Array[barNo + 1]);
      if (( GridArray[gridIndex] <= tempHighMA ) && 
          ( GridArray[gridIndex + 1] >= tempHighMA ))
      {
         found = true;
         break;
      }
   }

   //if (( ArraySize(HighArrayStruct.Array) > 1 ) && ( gridIndex <= ( gridArraySize - 1 )))
   //   Print( " High ", Time[barNo + 1], " ", found, " ", gridIndex, " ", GridArray[gridIndex], " ", HighArrayStruct.Array[barNo + 1]);
   if ( !found )
   {
      MAHighArrayStruct.Array[barNo] =  MAHighArrayStruct.Array[barNo + 1];
       //Print( " High 0 ", Time[barNo + 1], " ", found, " ", gridIndex, " ", HighArrayStruct.Array[barNo + 1]);
   }
   else
   {      
      while (( gridIndex <= ( gridArraySize - 1 )) &&
             ((( GridArray[gridIndex] - HighArrayStruct.Array[barNo + 1] ) < LowerGridOffsetPips[maIndex] * TPoint ) ||
              (( GridArray[gridIndex] - HighArrayStruct.Array[barNo + 1] ) < ( OffsetGridLevel[maIndex] - 1 ) * HGridPipsCur * TPoint )))
         gridIndex++;
      if (( gridIndex <= ( gridArraySize - 1 )) && 
          ( oldLevel != GridArray[gridIndex] ))
      {
         //Print( " High 1 ", Time[barNo + 1], " ", found, " ", gridIndex, " ", GridArray[gridIndex], " ", HighArrayStruct.Array[barNo + 1]);

         MAHighArrayStruct.Array[barNo] = GridArray[gridIndex];
      }
      else
      {
         MAHighArrayStruct.Array[barNo] =  MAHighArrayStruct.Array[barNo + 1];
         //Print( " High 2 ", Time[barNo + 1], " ", found, " ", gridIndex, " ", GridArray[gridIndex], " ", HighArrayStruct.Array[barNo + 1]);
      }
   }

   // Draw Low MA
   found = false;
   oldLevel = MALowArrayStruct.Array[barNo + 1];
   double tempLowMA = MathFloor( LowArrayStruct.Array[barNo + 1] / HGridPipsCur / TPoint ) * HGridPipsCur * TPoint;
   for ( gridIndex = gridArraySize - 2; gridIndex > 0 ; gridIndex-- )
   {
      //Print( GridArray[gridIndex], " ", tempLowMA, " ",  HighArrayStruct.Array[barNo + 1]);
      if (( GridArray[gridIndex] >= tempLowMA ) && 
          ( GridArray[gridIndex - 1] <= tempLowMA ))
      {
         found = true;
         break;
      }
   }
      
   if ( !found )
   {
      MALowArrayStruct.Array[barNo] = MALowArrayStruct.Array[barNo + 1];
      //Print( "Not found Low ", gridIndex, " ", barNo, " ", LowArrayStruct.Array[barNo], " ", arrayStruct.Array[barNo] );
   }
   else
   {   
      while (( gridIndex >= 0 ) && 
             ((( LowArrayStruct.Array[barNo + 1] - GridArray[gridIndex] ) < LowerGridOffsetPips[maIndex] * TPoint ) ||
              (( LowArrayStruct.Array[barNo + 1] - GridArray[gridIndex] ) < ( OffsetGridLevel[maIndex] - 1 ) * HGridPipsCur * TPoint )))
         gridIndex--;
      if (( gridIndex >= 0 )  && 
          ( oldLevel != GridArray[gridIndex] ))
      {
         //Print( "New Low switch", barNo, " ", gridIndex, " ", Low[barNo + 1], " ",GridArray[gridIndex], " ", oldLevel, " ", TimeToStr( Time[barNo], TIME_DATE | TIME_SECONDS ));      
      
         MALowArrayStruct.Array[barNo] = GridArray[gridIndex];
      }
      else
      {
         //Print( "New Low no switch", barNo, " ", gridIndex, " ", LowArrayStruct.Array[barNo ], " ",arrayStruct.Array[barNo + 1], " ",arrayStruct.Array[barNo], " ", TimeToStr( Time[barNo], TIME_DATE | TIME_SECONDS ));      
         MALowArrayStruct.Array[barNo] =  MALowArrayStruct.Array[barNo + 1];
      }
   }

   //if ( newBar )
   {
      //Print( "Draw ", lowerBarNo, " ", 
      //                ( arrayStruct.CrossOver ? Bars - arrayStruct.LastCrossBarNo : barNo + 1), " ", barNo, " ",
      //                ( arrayStruct.CrossOver ? arrayStruct.LastCrossY : arrayStruct.Array[barNo + 1] ), " ",
      DrawTrendLine( IndPrefix + "X" + IntegerToString( maIndex ) + "OSetHighLine", OffsetMAHighLineCount[maIndex], barNo + 1, barNo, 
                     MAHighArrayStruct.Array[barNo + 1], 
                     MAHighArrayStruct.Array[barNo], OffsetLineColor[maIndex], 3, STYLE_SOLID, !newBar );
      //Print( maIndex, " ", OffsetMALowLineCount[maIndex], " ", barNo + 1, " ", barNo, " ", MALowArrayStruct.Array[barNo + 1], " ", MALowArrayStruct.Array[barNo], " ", LowArrayStruct.Array[barNo] );
      DrawTrendLine( IndPrefix + "X" + IntegerToString( maIndex ) + "OSetLowLine", OffsetMALowLineCount[maIndex], barNo + 1, barNo, 
                     MALowArrayStruct.Array[barNo + 1], 
                     MALowArrayStruct.Array[barNo], OffsetLineColor[maIndex], 3, STYLE_SOLID, !newBar );
   }
}

int ReadMAMAFile( string fileName, ArrayStruct* UAOrMAStructList )
{

   int fh = FileOpen( fileName, FILE_CSV | FILE_BIN | FILE_SHARE_READ);
   //Print( "File Opening " + fh );
   string readText;
   ArrayStruct* arrayStruct;
   ArrayStruct* arrayStructBaseMA;
   int indIndex = 0;
   bool headerLine = true;
   int subMACount = OTHERARRAYGR;
   if ( fh != INVALID_HANDLE ) 
   {
      while ( !FileIsEnding( fh ))
      {
         readText = FileReadString( fh );
         if ( headerLine )
         {
            headerLine = false;
            continue;
         }
         
         string splitStr[];
         StringSplit( readText, ',', splitStr );
         arrayStruct = NULL;
         arrayStructBaseMA = NULL;
         subMACount = OTHERARRAYGR;
         for ( int i = 0; i < ArraySize( splitStr ); i++ )
         {
            //Print( "word No ", i, " ", splitStr[i] + ", ind No / index ", indIndex, ", subMA count ", subMACount );
            if ( i == 0 ) // Indicator Index
            {
               indIndex = StrToInteger( splitStr[0] ) - 1;
               arrayStructBaseMA = GetArrayStructFromList( UAOrMAStructList, indIndex, USERARRAYGR );
               //Print( indIndex, " ", arrayStructBaseMA.MAMode, " ", readText );
               if ( arrayStructBaseMA.MAMode != AdditionalMAMA )
               {
                  //Alert( "Indicator " + IntegerToString( indIndex + 1) + " is not set to AdditionaMAMA type" );
                  break;
               }
            }
            else if ( i == ( SUBTIMEFRAME + subMACount * SUBMAVARCOUNT )) // Indicator Index
            {
               ENUM_TIMEFRAMES timeframe =  GetTimeframeFromString( splitStr[i] );
               {
                  arrayStruct = GetArrayStructFromList( UAOrMAStructList, indIndex, subMACount + 1, true );
                  arrayStruct.TimeFrame = timeframe;  
               }
               /*else
               {
                  Alert( "AdditionaMAMA Indicator " + IntegerToString( indIndex + 1) + 
                         ", sub MA value MAMODE " + splitStr[i] + " is invalid" );
                  return( INIT_FAILED );
               }*/
            }
            else if ( i == ( SUBMAMODE + subMACount * SUBMAVARCOUNT )) // Indicator Index
            {
               MAMODE mAMode = GetMAModeFromStr( splitStr[i] );
               if (( mAMode >= SMA ) && ( mAMode <= LWMAMAMA ))
               {
                  if ( arrayStruct != NULL )
                  {
                     arrayStruct.MAMode = mAMode;
                     
                     if ( arrayStruct.MAMode >= SimpleMAMA )
                        SetCalculationIndex( arrayStruct.ArrayMA );
                  }
               }
               else
               {
                  Alert( "AdditionaMAMA Indicator " + IntegerToString( indIndex + 1) + 
                         ", sub MA value MAMODE " + splitStr[i] + " is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( SUBMAPERIOD + subMACount * SUBMAVARCOUNT )) // Indicator Index
            {
               int mAPeriod = StrToInteger( splitStr[i] );
               if ( mAPeriod > 0 )
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.MAPeriod =  mAPeriod;
               }
               else
               {
                  Alert( "AdditionaMAMA Indicator " + IntegerToString( indIndex + 1) + 
                         ", sub MA value MA Period is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( SUBMAPRICETYPE + subMACount * SUBMAVARCOUNT )) // Indicator Index
            {
               ENUM_APPLIED_PRICE priceType = GetPriceTypeFromStr( splitStr[i] );
               if (( priceType >= PRICE_CLOSE ) && ( priceType <= PRICE_WEIGHTED ))
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.PriceType = priceType;
               }
               else
               {
                  Alert( "AdditionaMAMA Indicator " + IntegerToString( indIndex + 1) + 
                         ", sub MA value Price Type " + splitStr[i] + " is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( SUBMAPERIOD1 + subMACount * SUBMAVARCOUNT )) // Indicator Index
            {
               int mAPeriod1 = StrToInteger( splitStr[i] );
               if ( mAPeriod1 > 0 )
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.MAPeriod1 =  mAPeriod1;
               }
               else
               {
                 Alert( "AdditionaMAMA Indicator " + IntegerToString( indIndex + 1) + 
                         ", sub MA value MA Period1 is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( SUBMAHEDGEPHASE + subMACount * SUBMAVARCOUNT )) // Indicator Index
            {
               int hedgePhase = StrToInteger( splitStr[i] );
               if ( hedgePhase >= 0 )
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.HedgePhase =  hedgePhase;
               }
               else
               {
                  Alert( "AdditionaMAMA Indicator " + IntegerToString( indIndex + 1) + 
                         ", sub MA value HedgePhase is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( SUBMAHEDGEBARCOUNT + subMACount * SUBMAVARCOUNT )) // Indicator Index
            {
               int hedgeBarCount = StrToInteger( splitStr[i] );
               if ( hedgeBarCount > 0 )
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.HedgeBarCount =  hedgeBarCount;
               }
               else
               {
                  Alert( "AdditionaMAMA Indicator " + IntegerToString( indIndex + 1) + 
                         ", sub MA value HedgeBarCount is invalid" );
                  return( INIT_FAILED );
               }
               subMACount++;          
            }
            
         } // readline
         if ( arrayStructBaseMA != NULL )
            arrayStructBaseMA.SubMACount = subMACount;
            
      } // while, read line
      FileClose( fh );
   } // File opened
   else
   {
     Alert( "MAMA - unable to open file in Files folder " + fileName );
     return( INIT_FAILED );
   }
   
   return ( INIT_SUCCEEDED );
}