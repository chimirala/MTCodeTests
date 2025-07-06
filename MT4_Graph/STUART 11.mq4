//+------------------------------------------------------------------+
//|                                                       RahulA.mq4 |
//|                                      Copyright 2018, Rohit Nanda |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, Rohit Nanda"
#property version   "3.1"
#property strict

#property indicator_chart_window
#property indicator_buffers 256
#property indicator_plots   8


enum MAMODE
{
   SMA,
   EMA,
   SMMA,
   LWMA,
   HedgeableMeanLine,
   JMA,
   SimpleMAMA,
   ExponentialMAMA,
   SmoothedMAMA,
   LWMAMAMA,
   AdditionalMAMA
};

enum OCTextLocationE
{
   OnCandle,            // On Candle
   OnStuart             // On Stuart Line
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

input ENUM_TIMEFRAMES lowerTF      = PERIOD_M1;
input int      IndNumber           = 0;
input bool     UseArray1           = true;
input ENUM_TIMEFRAMES UATimeFrame1 = PERIOD_CURRENT;
input MAMODE   UAMAMode1           = SMA;
input int      UAMAPeriod1         = 100;
input ENUM_APPLIED_PRICE UAPriceType1 = PRICE_HIGH;
input int      UAMAPeriod11        = 100;
input int      UAHedgePhase1       = 0;
input int      UAHedgeBarCount1    = 30000;


input bool     UseArray2         = true;
input ENUM_TIMEFRAMES UATimeFrame2 = PERIOD_CURRENT;
input MAMODE   UAMAMode2           = SMA;
input int      UAMAPeriod2         = 100;
input ENUM_APPLIED_PRICE UAPriceType2 = PRICE_LOW;
input int      UAMAPeriod21        = 100;
input int      UAHedgePhase2       = 0;
input int      UAHedgeBarCount2    = 30000;

input bool     UseArray3         = true;
input ENUM_TIMEFRAMES UATimeFrame3 = PERIOD_CURRENT;
input MAMODE   UAMAMode3           = SMA;
input int      UAMAPeriod3         = 100;
input ENUM_APPLIED_PRICE UAPriceType3 = PRICE_OPEN;
input int      UAMAPeriod31        = 100;
input int      UAHedgePhase3       = 0;
input int      UAHedgeBarCount3    = 30000;

input bool     UseArray4         = false;
input ENUM_TIMEFRAMES UATimeFrame4 = PERIOD_CURRENT;
input MAMODE   UAMAMode4           = SMA;
input int      UAMAPeriod4         = 100;
input ENUM_APPLIED_PRICE UAPriceType4 = PRICE_CLOSE;
input int      UAMAPeriod41        = 100;
input int      UAHedgePhase4       = 0;
input int      UAHedgeBarCount4    = 30000;

input bool     UseArray5         = false;
input ENUM_TIMEFRAMES UATimeFrame5 = PERIOD_CURRENT;
input MAMODE   UAMAMode5           = SMA;
input int      UAMAPeriod5         = 200;
input ENUM_APPLIED_PRICE UAPriceType5 = PRICE_CLOSE;
input int      UAMAPeriod51        = 100;
input int      UAHedgePhase5       = 0;
input int      UAHedgeBarCount5    = 30000;

input bool     UseArray6         = false;
input ENUM_TIMEFRAMES UATimeFrame6 = PERIOD_CURRENT;
input MAMODE   UAMAMode6           = EMA;
input int      UAMAPeriod6         = 100;
input ENUM_APPLIED_PRICE UAPriceType6 = PRICE_CLOSE;
input int      UAMAPeriod61        = 100;
input int      UAHedgePhase6       = 0;
input int      UAHedgeBarCount6    = 30000;

input bool     UseArray7         = false;
input ENUM_TIMEFRAMES UATimeFrame7 = PERIOD_CURRENT;
input MAMODE   UAMAMode7           = AdditionalMAMA;
input int      UAMAPeriod7         = 100;
input ENUM_APPLIED_PRICE UAPriceType7 = PRICE_CLOSE;
input int      UAMAPeriod71        = 100;
input int      UAHedgePhase7       = 0;
input int      UAHedgeBarCount7    = 30000;

input string   UAMAMAFileName      = "UA MAMA CSV.csv";

input bool     DrawOMALines        = true;

input bool     UseOMAArray1        = true;
input ENUM_TIMEFRAMES OMATimeFrame1 = PERIOD_CURRENT;
input MAMODE   OMAMAMode1          = EMA;
input int      OMAMAPeriod1        = 150;
input ENUM_APPLIED_PRICE OMAPriceType1 = PRICE_CLOSE;
input int      OMAMAPeriod11       = 100;
input int      OMAHedgePhase1      = 0;
input int      OMAHedgeBarCount1   = 30000;
input int      OMALineColor1       = clrGreen;

input bool     UseOMAArray2        = true;
input ENUM_TIMEFRAMES OMATimeFrame2 = PERIOD_CURRENT;
input MAMODE   OMAMAMode2          = SMA;
input int      OMAMAPeriod2        = 150;
input ENUM_APPLIED_PRICE OMAPriceType2 = PRICE_CLOSE;
input int      OMAMAPeriod21       = 100;
input int      OMAHedgePhase2      = 0;
input int      OMAHedgeBarCount2   = 30000;
input int      OMALineColor2       = clrWhite;

input bool     UseOMAArray3        = false;
input ENUM_TIMEFRAMES OMATimeFrame3 = PERIOD_CURRENT;
input MAMODE   OMAMAMode3          = SMA;
input int      OMAMAPeriod3        = 100;
input ENUM_APPLIED_PRICE OMAPriceType3 = PRICE_CLOSE;
input int      OMAMAPeriod31       = 100;
input int      OMAHedgePhase3      = 0;
input int      OMAHedgeBarCount3   = 30000;
input int      OMALineColor3       = clrBlue;

input bool     UseOMAArray4        = false;
input ENUM_TIMEFRAMES OMATimeFrame4 = PERIOD_CURRENT;
input MAMODE   OMAMAMode4          = SMA;
input int      OMAMAPeriod4        = 100;
input ENUM_APPLIED_PRICE OMAPriceType4 = PRICE_CLOSE;
input int      OMAMAPeriod41       = 100;
input int      OMAHedgePhase4      = 0;
input int      OMAHedgeBarCount4   = 30000;
input int      OMALineColor4       = clrCyan;

input bool     UseOMAArray5        = false;
input ENUM_TIMEFRAMES OMATimeFrame5 = PERIOD_CURRENT;
input MAMODE   OMAMAMode5          = SMA;
input int      OMAMAPeriod5        = 100;
input ENUM_APPLIED_PRICE OMAPriceType5 = PRICE_CLOSE;
input int      OMAMAPeriod51       = 100;
input int      OMAHedgePhase5      = 0;
input int      OMAHedgeBarCount5   = 30000;
input int      OMALineColor5       = clrPurple;

input bool     UseOMAArray6        = false;
input ENUM_TIMEFRAMES OMATimeFrame6 = PERIOD_CURRENT;
input MAMODE   OMAMAMode6          = SMA;
input int      OMAMAPeriod61       = 100;
input ENUM_APPLIED_PRICE OMAPriceType6 = PRICE_CLOSE;
input int      OMAMAPeriod6        = 100;
input int      OMAHedgePhase6      = 0;
input int      OMAHedgeBarCount6   = 30000;
input int      OMALineColor6       = clrPurple;

input bool     UseOMAArray7        = false;
input ENUM_TIMEFRAMES OMATimeFrame7 = PERIOD_CURRENT;
input MAMODE   OMAMAMode7          = SMA;
input int      OMAMAPeriod7        = 100;
input ENUM_APPLIED_PRICE OMAPriceType7 = PRICE_CLOSE;
input int      OMAMAPeriod71       = 100;
input int      OMAHedgePhase7      = 0;
input int      OMAHedgeBarCount7   = 30000;
input int      OMALineColor7       = clrPurple;

input bool     UseOMAArray8        = false;
input ENUM_TIMEFRAMES OMATimeFrame8 = PERIOD_CURRENT;
input MAMODE   OMAMAMode8          = SMA;
input int      OMAMAPeriod8        = 100;
input ENUM_APPLIED_PRICE OMAPriceType8 = PRICE_CLOSE;
input int      OMAMAPeriod81       = 100;
input int      OMAHedgePhase8      = 0;
input int      OMAHedgeBarCount8   = 30000;
input int      OMALineColor8       = clrPurple;

input bool     UseOMAArray9        = false;
input ENUM_TIMEFRAMES OMATimeFrame9 = PERIOD_CURRENT;
input MAMODE   OMAMAMode9          = SMA;
input int      OMAMAPeriod9        = 100;
input ENUM_APPLIED_PRICE OMAPriceType9 = PRICE_CLOSE;
input int      OMAMAPeriod91       = 100;
input int      OMAHedgePhase9      = 0;
input int      OMAHedgeBarCount9   = 30000;
input int      OMALineColor9       = clrPurple;

input bool     UseOMAArray10       = true;
input ENUM_TIMEFRAMES OMATimeFrame10 = PERIOD_CURRENT;
input MAMODE   OMAMAMode10         = AdditionalMAMA;
input int      OMAMAPeriod10       = 100;
input ENUM_APPLIED_PRICE OMAPriceType10 = PRICE_CLOSE;
input int      OMAMAPeriod101      = 100;
input int      OMAHedgePhase10     = 0;
input int      OMAHedgeBarCount10  = 30000;
input int      OMALineColor10      = clrPurple;

input string   OMAFileName         = "OMA CSV.csv";
input string   OMAMAMAFileName     = "OMA MAMA CSV.csv";

input string   StuartSepB        = "";
input string   StuartSep         = "-------- Stuart -------";
input bool     DrawStuart        = true;
input CrossPriceTypeE StuartCrossPriceType = ClosePrice;

input string   OffsetMASepB      = "";
input string   OffsetMASep       = "------ Offset MA ------";
input DrawOffsetMAE DrawOffsetMA = Single;
input CrossPriceTypeE MAOffsetCrossPriceType = ClosePrice;
input int      OffsetGridLevel   = 2;
input double   LowerGridOffsetPips = 15;
input color    OffsetLineColor   = clrHotPink;
//input color    OffsetLowerLineColor   = clrLimeGreen;

input string   OverCupSep        = "------ OverCupSep ------ ";
input bool     DrawOverCup       = true;
input color    OverCupStuartLineColor  = clrBlue;
input color    OverCupMAOffsetLineColor  = clrRed;
input color    OverCupSignalColor = clrYellow;
input OCTextLocationE OCTextLocation = OnCandle; // OverCup Text Location

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

int calculationIndex = 8;

#define SUBTIMEFRAME    1
#define SUBMAMODE       2
#define SUBMAPERIOD     3
#define SUBMAPRICETYPE  4
#define SUBMAPERIOD1    5
#define SUBMAHEDGEPHASE 6
#define SUBMAHEDGEBARCOUNT 7
#define SUBMAVARCOUNT 7

#define OMAUSEARRAY     1
#define OMATIMEFRAME    2
#define OMAMAMODE       3
#define OMAMAPERIOD     4
#define OMAMAPRICETYPE  5
#define OMAMAPERIOD1    6
#define OMAMAHEDGEPHASE 7
#define OMAMAHEDGEBARCOUNT 8
#define OMAMAVARCOUNT   8

#define STUARTARRAY     7

#define USERARRAYGR     0
#define OTHERARRAYGR    1

#define HIGHARRAY          0
#define LOWARRAY           1
#define MAHIGHOFFSETARRAY  2
#define MALOWOFFSETARRAY   3

#define        STUARTOC       0
#define        MAHIGHOFFSETOC 1
#define        MALOWOFFSETOC  2


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
      int LastCrossBarNo;
      double LastCrossY;
      bool CrossedOver[3];
      bool CrossOver;
      bool BuySell;
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
         LastCrossBarNo = EMPTY;
         LastCrossY = -1;
         CrossedOver[0] = false;
         CrossedOver[1] = false;
         CrossedOver[2] = false;
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
ArrayStruct*   OMAArrayStructList = NULL;


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
   
   /*if ( arrayStructList == NULL )
   {
      arrayStructList = new ArrayStruct( MAIndexNo, MAArrayNo );
      //Print( "Creating new struct at ", IntegerToString( MAIndexNo ), " ", IntegerToString( MAArrayNo ));
         if ( UAArrayStructList == NULL )
         UAArrayStructList = arrayStructList;
      else
         lastArrayStructList.NextArrayStruct = arrayStructList;
   }*/
   return arrayStructList;
}

int SetCalculationIndex( double& Array[] )
{
   calculationIndex++;
   SetIndexBuffer( calculationIndex, Array, INDICATOR_CALCULATIONS );
   SetIndexEmptyValue( calculationIndex, 0.0 );
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
   calculationIndex = 7;
   IndPrefix       = "ST" + IntegerToString( IndNumber );
   
   if ( UseArray1 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, 0, USERARRAYGR );
      arrayStruct.UseArray       = UseArray1;
      arrayStruct.TimeFrame      = UATimeFrame1;
      arrayStruct.MAMode         = UAMAMode1;
      arrayStruct.MAPeriod       = UAMAPeriod1;
      arrayStruct.PriceType      = UAPriceType1;
      arrayStruct.MAPeriod1      = UAMAPeriod11;
      arrayStruct.HedgePhase     = UAHedgePhase1;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount1; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );

      SetIndexBuffer( 1, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( 1, 0.0 );
      SetIndexStyle( 1, DRAW_LINE, STYLE_SOLID, 3, clrRed );
   }

   if ( UseArray2 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, 1, USERARRAYGR );
      arrayStruct.UseArray       = UseArray2;
      arrayStruct.TimeFrame      = UATimeFrame2;
      arrayStruct.MAMode         = UAMAMode2;
      arrayStruct.MAPeriod       = UAMAPeriod2;
      arrayStruct.PriceType      = UAPriceType2;
      arrayStruct.MAPeriod1      = UAMAPeriod21;
      arrayStruct.HedgePhase     = UAHedgePhase2;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount2;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( 2, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( 2, 0.0 );
      SetIndexStyle( 2, DRAW_LINE, STYLE_SOLID, 3, clrGreen );
   }
      
   if ( UseArray3 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, 2, USERARRAYGR );
      arrayStruct.UseArray       = UseArray3;
      arrayStruct.TimeFrame      = UATimeFrame3;
      arrayStruct.MAMode         = UAMAMode3;
      arrayStruct.MAPeriod       = UAMAPeriod3;
      arrayStruct.PriceType      = UAPriceType3;
      arrayStruct.MAPeriod1      = UAMAPeriod31;
      arrayStruct.HedgePhase     = UAHedgePhase3;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount3;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( 3, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( 3, 0.0 );
      SetIndexStyle( 3, DRAW_LINE, STYLE_DASHDOT, 2, clrLime );
   }
      
   if ( UseArray4 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, 3, USERARRAYGR );
      arrayStruct.UseArray       = UseArray4;
      arrayStruct.TimeFrame      = UATimeFrame4;
      arrayStruct.MAMode         = UAMAMode4;
      arrayStruct.MAPeriod       = UAMAPeriod4;
      arrayStruct.PriceType      = UAPriceType4;
      arrayStruct.MAPeriod1      = UAMAPeriod41;
      arrayStruct.HedgePhase     = UAHedgePhase4;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount4;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( 4, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( 4, 0.0 );
      SetIndexStyle( 4, DRAW_LINE, STYLE_DASHDOT, 2, clrBlue );
   }
      
   if ( UseArray5 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, 4, USERARRAYGR );
      arrayStruct.UseArray       = UseArray5;
      arrayStruct.TimeFrame      = UATimeFrame5;
      arrayStruct.MAMode         = UAMAMode5;
      arrayStruct.MAPeriod       = UAMAPeriod5;
      arrayStruct.PriceType      = UAPriceType5;
      arrayStruct.MAPeriod1      = UAMAPeriod51;
      arrayStruct.HedgePhase     = UAHedgePhase5;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount5;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( 5, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( 5, 0.0 );
      SetIndexStyle( 5, DRAW_LINE, STYLE_DASHDOT, 2, clrBrown );
   }
      
   if ( UseArray6 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, 5, USERARRAYGR );
      arrayStruct.UseArray       = UseArray6;
      arrayStruct.TimeFrame      = UATimeFrame6;
      arrayStruct.MAMode         = UAMAMode6;
      arrayStruct.MAPeriod       = UAMAPeriod6;
      arrayStruct.PriceType      = UAPriceType6;
      arrayStruct.MAPeriod1      = UAMAPeriod61;
      arrayStruct.HedgePhase     = UAHedgePhase6;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount6;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( 6, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( 6, 0.0 );
      SetIndexStyle( 6, DRAW_LINE, STYLE_DASHDOT, 2, clrWhite );
   }
      
   if ( UseArray7 )
   {
      arrayStruct = GetArrayStructFromList( UAArrayStructList, 6, USERARRAYGR );
      arrayStruct.UseArray       = UseArray7;
      arrayStruct.TimeFrame      = UATimeFrame7;
      arrayStruct.MAMode         = UAMAMode7;
      arrayStruct.MAPeriod       = UAMAPeriod7;
      arrayStruct.PriceType      = UAPriceType7;
      arrayStruct.MAPeriod1      = UAMAPeriod71;
      arrayStruct.HedgePhase     = UAHedgePhase7;
      arrayStruct.HedgeBarCount  = UAHedgeBarCount7;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      SetIndexBuffer( 7, arrayStruct.Array, INDICATOR_DATA );
      SetIndexEmptyValue( 7, 0.0 );
      SetIndexStyle( 7, DRAW_LINE, STYLE_DASHDOT, 2, clrPink );
   }

   arrayStruct = GetArrayStructFromList( UAArrayStructList, STUARTARRAY, USERARRAYGR, true );
   arrayStruct.UseArray       = false;
   //SetCalculationIndex( arrayStruct.ArrayMA );
   //SetIndexBuffer( 8, arrayStruct.Array, INDICATOR_DATA );
   //SetIndexEmptyValue( 8, 0.0 );
   //SetIndexStyle( 8, DRAW_LINE, STYLE_SOLID, 3, clrWhite );
   
   
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
   GetArrayStructFromList( UAArrayStructList, MAHIGHOFFSETARRAY, OTHERARRAYGR, true );
   GetArrayStructFromList( UAArrayStructList, MALOWOFFSETARRAY, OTHERARRAYGR, true );
    
   
   //--------------------------------------------------------------------------
      
   if ( UseOMAArray1 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 0, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray1;
      arrayStruct.TimeFrame      = OMATimeFrame1;
      arrayStruct.MAMode         = OMAMAMode1;
      arrayStruct.MAPeriod       = OMAMAPeriod1;
      arrayStruct.PriceType      = OMAPriceType1;
      arrayStruct.MAPeriod1      = OMAMAPeriod11;
      arrayStruct.HedgePhase     = OMAHedgePhase1;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount1;
      arrayStruct.LineColor      = OMALineColor1;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
      
   if ( UseOMAArray2 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 1, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray2;
      arrayStruct.TimeFrame      = OMATimeFrame2;
      arrayStruct.MAMode         = OMAMAMode2;
      arrayStruct.MAPeriod       = OMAMAPeriod2;
      arrayStruct.PriceType      = OMAPriceType2;
      arrayStruct.MAPeriod1      = OMAMAPeriod21;
      arrayStruct.HedgePhase     = OMAHedgePhase2;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount2;
      arrayStruct.LineColor      = OMALineColor2;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
      
   if ( UseOMAArray3 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 2, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray3;
      arrayStruct.TimeFrame      = OMATimeFrame3;
      arrayStruct.MAMode         = OMAMAMode3;
      arrayStruct.MAPeriod       = OMAMAPeriod3;
      arrayStruct.PriceType      = OMAPriceType3;
      arrayStruct.MAPeriod1      = OMAMAPeriod31;
      arrayStruct.HedgePhase     = OMAHedgePhase3;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount3;
      arrayStruct.LineColor      = OMALineColor3;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
      
   if ( UseOMAArray4 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 3, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray4;
      arrayStruct.TimeFrame      = OMATimeFrame4;
      arrayStruct.MAMode         = OMAMAMode4;
      arrayStruct.MAPeriod       = OMAMAPeriod4;
      arrayStruct.PriceType      = OMAPriceType4;
      arrayStruct.MAPeriod1      = OMAMAPeriod41;
      arrayStruct.HedgePhase     = OMAHedgePhase4;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount4;
      arrayStruct.LineColor      = OMALineColor4;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
      
   if ( UseOMAArray5 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 4, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray5;
      arrayStruct.TimeFrame      = OMATimeFrame5;
      arrayStruct.MAMode         = OMAMAMode5;
      arrayStruct.MAPeriod       = OMAMAPeriod5;
      arrayStruct.PriceType      = OMAPriceType5;
      arrayStruct.MAPeriod1      = OMAMAPeriod51;
      arrayStruct.HedgePhase     = OMAHedgePhase5;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount5;
      arrayStruct.LineColor      = OMALineColor5;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
      
   if ( UseOMAArray6 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 5, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray6;
      arrayStruct.TimeFrame      = OMATimeFrame6;
      arrayStruct.MAMode         = OMAMAMode6;
      arrayStruct.MAPeriod       = OMAMAPeriod6;
      arrayStruct.PriceType      = OMAPriceType6;
      arrayStruct.MAPeriod1      = OMAMAPeriod61;
      arrayStruct.HedgePhase     = OMAHedgePhase6;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount6;
      arrayStruct.LineColor      = OMALineColor6;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
      
   if ( UseOMAArray7 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 6, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray7;
      arrayStruct.TimeFrame      = OMATimeFrame7;
      arrayStruct.MAMode         = OMAMAMode7;
      arrayStruct.MAPeriod       = OMAMAPeriod7;
      arrayStruct.PriceType      = OMAPriceType7;
      arrayStruct.MAPeriod1      = OMAMAPeriod71;
      arrayStruct.HedgePhase     = OMAHedgePhase7;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount7;
      arrayStruct.LineColor      = OMALineColor7; 
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
      
   if ( UseOMAArray8 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 7, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray8;
      arrayStruct.TimeFrame      = OMATimeFrame8;
      arrayStruct.MAMode         = OMAMAMode8;
      arrayStruct.MAPeriod       = OMAMAPeriod8;
      arrayStruct.PriceType      = OMAPriceType8;
      arrayStruct.MAPeriod1      = OMAMAPeriod81;
      arrayStruct.HedgePhase     = OMAHedgePhase8;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount8;
      arrayStruct.LineColor      = OMALineColor8;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
      
      }
      
   if ( UseOMAArray9 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 8, USERARRAYGR, true );
      arrayStruct.UseArray       = UseOMAArray9;
      arrayStruct.TimeFrame      = OMATimeFrame9;
      arrayStruct.MAMode         = OMAMAMode9;
      arrayStruct.MAPeriod       = OMAMAPeriod9;
      arrayStruct.PriceType      = OMAPriceType9;
      arrayStruct.MAPeriod1      = OMAMAPeriod91;
      arrayStruct.HedgePhase     = OMAHedgePhase9;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount9;
      arrayStruct.LineColor      = OMALineColor9;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
      
   if ( UseOMAArray10 )
   {
      arrayStruct = GetArrayStructFromList( OMAArrayStructList, 9, USERARRAYGR, true);
      arrayStruct.UseArray       = UseOMAArray10;
      arrayStruct.TimeFrame      = OMATimeFrame10;
      arrayStruct.MAMode         = OMAMAMode10;
      arrayStruct.MAPeriod       = OMAMAPeriod10;
      arrayStruct.PriceType      = OMAPriceType10;
      arrayStruct.MAPeriod1      = OMAMAPeriod101;
      arrayStruct.HedgePhase     = OMAHedgePhase10;
      arrayStruct.HedgeBarCount  = OMAHedgeBarCount10;
      arrayStruct.LineColor      = OMALineColor10;
      if ( arrayStruct.MAMode >= SimpleMAMA )
         SetCalculationIndex( arrayStruct.ArrayMA );
   }
   
   arrayStruct = OMAArrayStructList;
   while ( arrayStruct != NULL )
   {
      if (( arrayStruct.UseArray ) && ( arrayStruct.MAArrayNo == 0 ))
      {
         switch( arrayStruct.MAMode )
         {
            case SimpleMAMA: // MA OF SIMPLE MA
            case ExponentialMAMA: // MA OF EXPNENTIAL MA
            case SmoothedMAMA: // MA OF SMOOTHED MA
            case LWMAMAMA: // MA OF LWMA
               GetArrayStructFromList( OMAArrayStructList, arrayStruct.MAIndexNo, OTHERARRAYGR, true );
               break;
            case AdditionalMAMA:
            break;
         }
      }
      arrayStruct = arrayStruct.NextArrayStruct;
   }
   
   // Read OMA file
   if ( OMAFileName != "" )
   {
      ReadOMAFile( OMAFileName, OMAArrayStructList );
   }
   
   if ( OMAMAMAFileName != "" )
   {
      ReadMAMAFile( OMAMAMAFileName, OMAArrayStructList );
   }
      
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
   
   arrayStruct = OMAArrayStructList;
   nextArrayStruct = NULL;
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
      OverCupLineCountS = 0;
      OverCupLineCountMA = 0;
      OverCupMALineCount = 0;
      OffsetMAHighLineCount = 0;
      OffsetMALowLineCount = 0;
      MaxBars = limit;
      ClearChart();
   }
   
   bool newBar;
   if ( limit > 1 )
   {
      for ( int barNo = limit - 2; barNo > 0; barNo-- )
      {
         Calculate( barNo, false, newBar );
      } 
   }
   else
   {
      Calculate( 0, true, newBar );
      DrawStuartFirstArray( 0, 0, newBar );
      if ( DrawOffsetMA == Single )
         DrawOffsetMASingle( 0, 0, newBar );
      else if ( DrawOffsetMA == Double )
         DrawOffsetMADouble( 0, 0, newBar );
   }
   
   return(rates_total);
}
//+------------------------------------------------------------------+
void Calculate( int barNo, bool zeroBar, bool& newBar )
{
   newBar = NewBar( barNo );

   ArrayStruct* arrayStruct = UAArrayStructList;
   while( arrayStruct != NULL )
   {
      if (( arrayStruct.UseArray ) && ( arrayStruct.MAArrayNo == 0 ))
      {
         arrayStruct.Array[barNo] = CalculateMA( barNo, 
                                                 arrayStruct.MAIndexNo,
                                                 UAArrayStructList,
                                                 arrayStruct );
      }
      arrayStruct = arrayStruct.NextArrayStruct;
   }

   arrayStruct = OMAArrayStructList;
   while( arrayStruct != NULL )
   {
      if (( arrayStruct.UseArray ) && ( arrayStruct.MAArrayNo == USERARRAYGR ))
      {
         arrayStruct.Array[barNo] = CalculateMA( barNo, 
                                                 arrayStruct.MAIndexNo,
                                                 OMAArrayStructList,
                                                 arrayStruct );                           
         if ( DrawOMALines )
            DrawIndicator( IndPrefix + "OMALine" + IntegerToString( arrayStruct.MAIndexNo ), barNo, arrayStruct.Array[barNo + 1], arrayStruct.Array[barNo], arrayStruct.LineColor, 1, STYLE_SOLID );
      }
      arrayStruct = arrayStruct.NextArrayStruct;
   }
   
   if ( newBar )
   {
      DrawGridFunc( barNo, newBar );
      GetHighLowArray( barNo );
   }
   
   if ( !zeroBar )
   {
      if (( StuartCrossPriceType == TouchPrice ) ||
          ( MAOffsetCrossPriceType == TouchPrice ))
      {
         int startBar = iBarShift( NULL, lowerTF, Time[barNo] );
         int endBar = iBarShift( NULL, lowerTF, Time[barNo - 1] );
         for ( int lowerBarNo = startBar; lowerBarNo > endBar; lowerBarNo-- )
         {
            if ( lowerBarNo < 0 )
               break;
               
            if ( StuartCrossPriceType == TouchPrice )
               DrawStuartFirstArray( barNo, lowerBarNo, ( lowerBarNo - 1 ) == endBar );
            if ( MAOffsetCrossPriceType == TouchPrice )
            {
               if ( DrawOffsetMA == Single )
                  DrawOffsetMASingle( barNo, lowerBarNo, ( lowerBarNo - 1 ) == endBar );
               else if ( DrawOffsetMA == Double )
                  DrawOffsetMADouble( barNo, lowerBarNo, ( lowerBarNo - 1 ) == endBar );
            }
         }
      }
      if ( newBar )
      {
         if ( StuartCrossPriceType == ClosePrice )
            DrawStuartFirstArray( barNo, -1, true );
         if ( MAOffsetCrossPriceType == ClosePrice )
         {
            if ( DrawOffsetMA == Single )
               DrawOffsetMASingle( barNo, -1, true );
            else if ( DrawOffsetMA == Double )
               DrawOffsetMADouble( barNo, -1, true );
         }
      }
   }
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

bool GetPriceCrossOver( CrossPriceTypeE CrossPriceType, bool HighLow, int barNo, int lowerBarNo, double& value[], double offset = 0 )
{
   switch ( CrossPriceType )
   {
      case ClosePrice:  
         if ( HighLow )
            return ( Close[barNo] > value[barNo] ) && 
                   ( Close[barNo + 1] <= value[barNo + 1]);
         else
            return ( Close[barNo] < value[barNo] ) && 
                   ( Close[barNo + 1] >= value[barNo + 1] );
         break;
      case TouchPrice: 
         if ( HighLow )
         {
            bool cond = iHigh( NULL, lowerTF, lowerBarNo ) >= value[barNo];
            //if ( cond )
            //   Print( "Switch over to low ", Time[barNo], " ", barNo, " ", lowerBarNo );
            return ( cond );
         }
         else
         {
            bool cond = iLow( NULL, lowerTF, lowerBarNo ) <= value[barNo];
            //if ( cond )
            //   Print( "Switch over to high ", Time[barNo], " ", barNo, " ", lowerBarNo );
            return ( cond );
         }
         break;
   }
   return false;
}

#define NOLEVEL   0
#define HIGHLEVEL 1
#define LOWLEVEL  2
void DoCross( ArrayStruct* highArrayStruct, ArrayStruct* lowArrayStruct, CrossPriceTypeE CrossPriceType, int barNo, int lowerBarNo, int& curLevel, int& prevLevel )
{
   if (( prevLevel != HIGHLEVEL ) && GetPriceCrossOver( CrossPriceType, false, barNo, lowerBarNo, lowArrayStruct.Array ))
   {
      //Print( "MA Switch over to high ", Time[barNo], " ", barNo, " ", lowerBarNo );
      curLevel = HIGHLEVEL;
   }
   else if (( prevLevel != LOWLEVEL ) && GetPriceCrossOver( CrossPriceType, true, barNo, lowerBarNo, highArrayStruct.Array ))
   {
      //Print( "MA Switch over to low ", Time[barNo], " ", barNo, " ", lowerBarNo );
      curLevel = LOWLEVEL;
   }
   else
      curLevel = prevLevel; 
}



int StuartPrevLevel = NOLEVEL;
int StuartLineCount = 0;
void DrawStuartFirstArray( int barNo, int lowerBarNo, bool newBar )
{
   if ( !DrawStuart )
      return;  
   ArrayStruct* arrayStruct = GetArrayStructFromList( UAArrayStructList, STUARTARRAY, USERARRAYGR );
   arrayStruct.Array[barNo] = arrayStruct.Array[barNo + 1];
   
   ArrayStruct* HighArrayStruct = GetArrayStructFromList( UAArrayStructList, HIGHARRAY, OTHERARRAYGR );
   ArrayStruct* LowArrayStruct = GetArrayStructFromList( UAArrayStructList, LOWARRAY, OTHERARRAYGR );
       
  
   int curLevel = StuartPrevLevel;
   DoCross( HighArrayStruct, LowArrayStruct, StuartCrossPriceType, barNo, lowerBarNo, curLevel, StuartPrevLevel );
   
   arrayStruct.CrossOver  = false;
   
   if ( curLevel == HIGHLEVEL )
   {
      arrayStruct.Array[barNo] = HighArrayStruct.Array[barNo];
      if ( curLevel != StuartPrevLevel )
      {
         //Print( "High ", Bars - arrayStruct.LastCrossBarNo );
         if ( arrayStruct.LastCrossBarNo < ( Bars - ( barNo + 1 )))
            arrayStruct.LastCrossBarNo = Bars - ( barNo + 1 );
         else
            arrayStruct.LastCrossBarNo = Bars - barNo;
            
         arrayStruct.LastCrossY = LowArrayStruct.Array[Bars - arrayStruct.LastCrossBarNo];
         arrayStruct.CrossOver  = true;
         arrayStruct.BuySell        = false;
         ArrayStruct* arrayStructOMA = OMAArrayStructList;
         while( arrayStructOMA != NULL )
         {
            if (( arrayStructOMA.UseArray ) && ( arrayStructOMA.MAArrayNo == 0 ))
               arrayStructOMA.CrossedOver[STUARTOC] = false;
            arrayStructOMA = arrayStructOMA.NextArrayStruct;
         }
      }
   }
   else if ( curLevel == LOWLEVEL )
   {
      arrayStruct.Array[barNo] = LowArrayStruct.Array[barNo];
      if ( curLevel != StuartPrevLevel )
      {
         //Print( "Low ", Bars - arrayStruct.LastCrossBarNo );
         if ( arrayStruct.LastCrossBarNo < ( Bars - ( barNo + 1 )))
            arrayStruct.LastCrossBarNo = Bars - ( barNo + 1 );
         else
            arrayStruct.LastCrossBarNo = Bars - barNo;
         arrayStruct.LastCrossY = HighArrayStruct.Array[Bars - arrayStruct.LastCrossBarNo];
         arrayStruct.BuySell        = true;
         arrayStruct.CrossOver  = true;
         ArrayStruct* arrayStructOMA = OMAArrayStructList;
         while( arrayStructOMA != NULL )
         {
            if (( arrayStructOMA.UseArray ) && ( arrayStructOMA.MAArrayNo == 0 ))
               arrayStructOMA.CrossedOver[STUARTOC] = false;
            arrayStructOMA = arrayStructOMA.NextArrayStruct;
         }
      }
   }

   //Print( Time[0], " ", lastLowerBar, " ", ( arrayStruct.LastCrossBarNo != barNo ), " ", arrayStruct.CrossOver);
   if (( newBar && ( arrayStruct.LastCrossBarNo != ( Bars -  barNo ))) || arrayStruct.CrossOver )
   {
      /*Print( "Stuart Draw " + Time[barNo], " ", StuartLineCount, " ", StuartPrevLevel, " ", curLevel, " ",  
                     (arrayStruct.CrossOver ? Bars - arrayStruct.LastCrossBarNo : barNo + 1), " ", barNo, " ",
                     (arrayStruct.CrossOver ? arrayStruct.LastCrossY : arrayStruct.Array[barNo + 1]),  " ",
                     arrayStruct.Array[barNo], " ", arrayStruct.CrossOver);*/
      DrawTrendLine( IndPrefix + "X" + "Stuart", StuartLineCount, 
                     arrayStruct.CrossOver ? Bars - arrayStruct.LastCrossBarNo : barNo + 1, barNo, 
                     arrayStruct.CrossOver ? arrayStruct.LastCrossY : arrayStruct.Array[barNo + 1], 
                     arrayStruct.Array[barNo], clrWhite, 3, STYLE_SOLID );
   }
   DrawOverCupFunc( barNo, arrayStruct, STUARTOC );
   StuartPrevLevel = curLevel;
}
     
int OverCupLineCountS = 0;
int OverCupLineCountMA = 0;
int OverCupMALineCount = 0;
void DrawOverCupFunc( int barNo, ArrayStruct* arrayStruct, int caller )
{
   if (( !DrawOverCup ) || (( Bars - barNo ) < 3 ))
      return;

   if ( arrayStruct.CrossedOver[caller] )
      return;
      
   color offsetLinecolor;
   string lineName;
   string MALineName;
   string SignalName;
   string LabelName;
   // Draw overcup lines
   if ( caller == STUARTOC )
   {
      offsetLinecolor = OverCupStuartLineColor;
      lineName = IndPrefix + "X" + "OCupLineS";
      MALineName = IndPrefix + "X" + "OCupMALineS";
      SignalName = IndPrefix + "X" + "OCupSignalS";
      DrawTrendLine( lineName, OverCupLineCountS, 
                     arrayStruct.CrossOver ? Bars - arrayStruct.LastCrossBarNo : barNo + 1, barNo, 
                     arrayStruct.LastCrossY, arrayStruct.LastCrossY, offsetLinecolor, 1, STYLE_SOLID, !arrayStruct.CrossOver );
      if ( arrayStruct.BuySell )
         LabelName = "B";
      else
         LabelName = "S";
         
   }
   else
   {
      offsetLinecolor = OverCupMAOffsetLineColor;
      lineName = IndPrefix + "X" + "OCupLineMA";
      MALineName = IndPrefix + "X" + "OCupMALineMA";
      SignalName = IndPrefix + "X" + "OCupSignalMA";
      DrawTrendLine( lineName, OverCupLineCountMA,
                     arrayStruct.CrossOver ? Bars - arrayStruct.LastCrossBarNo : barNo + 1, barNo, 
                     arrayStruct.LastCrossY, arrayStruct.LastCrossY, offsetLinecolor, 1, STYLE_SOLID, !arrayStruct.CrossOver );
      if ( arrayStruct.BuySell )
         LabelName = "BO";
      else
         LabelName = "SO";
   }
   //Print( barNo, " ", caller, " ", arrayStruct.LastCrossY, " ", arrayStruct.CrossedOver, " ", arrayStruct.Array[barNo] );
   arrayStruct.CrossOver  = false;
   
   ArrayStruct* arrayStructOMA = OMAArrayStructList;
   while ( arrayStructOMA != NULL )
   {      
      if (( arrayStructOMA.UseArray ) && ( arrayStructOMA.MAArrayNo == USERARRAYGR ) && ( !arrayStructOMA.CrossedOver[caller] ))
      {
                 
         //if ( caller == 1 )
         //Print( "OCP ", barNo, " ", ind, " ", arrayStructMA.UseArray, " ", arrayStructMA.CrossedOver[caller], " ",arrayStruct.LastCrossY, " ", TimeToStr( Time[barNo], TIME_DATE | TIME_SECONDS ));      
               
         if (( arrayStruct.BuySell &&
              ( arrayStruct.LastCrossY >= arrayStructOMA.Array[barNo + 1] ) &&
              ( arrayStruct.LastCrossY <= arrayStructOMA.Array[barNo] )) || 
             (( !arrayStruct.BuySell ) &&
              ( arrayStruct.LastCrossY <= arrayStructOMA.Array[barNo + 1] ) &&
              ( arrayStruct.LastCrossY >= arrayStructOMA.Array[barNo] )))
         {
            arrayStructOMA.CrossedOver[caller] = true;
            
            //if ( ind >= MAXARRAYS )
            //   continue;
               
            DrawTrendLine( MALineName, OverCupMALineCount, barNo + 1, barNo, Close[barNo], Close[barNo], OverCupSignalColor, 1, true );
            
            string name = IndPrefix + SignalName + IntegerToString( OverCupMALineCount );
            if ( ObjectFind( name ) == -1 )
            {
               ObjectCreate( name, OBJ_TEXT, 0, 0, 0, 0 );
               ObjectSet( name, OBJPROP_COLOR, OverCupSignalColor );
               ObjectSetString( 0, name, OBJPROP_FONT, "Arial" ); 
               ObjectSetInteger( 0, name, OBJPROP_FONTSIZE, 8 ); 
            }
            int indTag = arrayStructOMA.MAIndexNo + 1;//(( caller == STUARTOC ) && ( ind == STUART )) || (( caller == MAOFFSETOC ) && ( ind == OTHERARRAYS )) ? 0 : ind + 1;
            ObjectSetString( 0, name, OBJPROP_TEXT, IntegerToString( OCCount ) + "-" + LabelName + IntegerToString( indTag ));
            OCCount++;
            if ( arrayStruct.BuySell )
            {
               ObjectSet( name, OBJPROP_ANCHOR, ANCHOR_LEFT_LOWER  );
            }
            else
            {
               ObjectSet( name, OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER );
            }
            //Print( barNo, " ", ( LabelName + IntegerToString( indTag )), " ", name, " ", OverCupMALineCount );
            if ( OCTextLocation == OnCandle )
               ObjectSet( name, OBJPROP_PRICE1, Close[barNo] );
            else
               ObjectSet( name, OBJPROP_PRICE1, arrayStruct.LastCrossY );
            ObjectSet( name, OBJPROP_TIME1, Time[barNo] );
         }
      }
      arrayStructOMA = arrayStructOMA.NextArrayStruct;
   }
}

void DoOffsetMASingle( ArrayStruct* arrayStruct, int barNo, int lowerBarNo, int curLevel )
{
   ArrayStruct* HighArrayStruct = GetArrayStructFromList( UAArrayStructList, HIGHARRAY, OTHERARRAYGR );
   ArrayStruct* LowArrayStruct = GetArrayStructFromList( UAArrayStructList, LOWARRAY, OTHERARRAYGR );
   
   int gridArraySize = ArraySize( GridArray );
   int gridIndex;
   double oldPrice = arrayStruct.Array[barNo + 1];
   bool found;
   arrayStruct.CrossOver  = false;
   if ( curLevel == HIGHLEVEL )
   {
      found = false;
      if ( curLevel != OMAPrevLevel )
      {
         arrayStruct.CrossOver  = true;
         if (( arrayStruct.LastCrossBarNo ) < ( Bars - ( barNo + 1 )))
            arrayStruct.LastCrossBarNo = Bars - ( barNo + 1 );
         else
            arrayStruct.LastCrossBarNo = Bars - barNo;
         arrayStruct.BuySell    = true;   
         for ( gridIndex = 0; gridIndex < gridArraySize; gridIndex++ )
         {
             //Print( "Not found H ", gridIndex, " ", GridArray[gridIndex], " ",  HighArrayStruct.Array[barNo + 1], " ",
             //( HighArrayStruct.Array[barNo + 1] <= GridArray[gridIndex] ));
            if ( HighArrayStruct.Array[barNo + 1] <= GridArray[gridIndex] )
            {
               found = true;
               OCCount = 1;
               break;
            }
         }
      }
      else
      {
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
      }

      //Print( " High ", Time[barNo + 1], " ", found, " ", OffsetSideChange, " ", gridIndex, " ", HighArrayStruct.Array[barNo + 1]);
      if ( !found )
      {
         arrayStruct.CrossOver  = false;
         arrayStruct.Array[barNo] =  arrayStruct.Array[barNo + 1];
         //Print( "Not found High ", Time[barNo + 1], " ", gridIndex, " ", arrayStruct.Array[barNo], " ", GridArray[0], " ", GridArray[gridArraySize - 1] );
      }
      else
      {      
         while (( gridIndex <= ( gridArraySize - 1 )) &&
                ((( GridArray[gridIndex] - HighArrayStruct.Array[barNo + 1] ) < LowerGridOffsetPips * TPoint ) ||
                 (( GridArray[gridIndex] - HighArrayStruct.Array[barNo + 1] ) < ( OffsetGridLevel - 1 ) * HGridPipsCur * TPoint )))
            gridIndex++;
         if (( gridIndex <= ( gridArraySize - 1 )) && 
             ( oldPrice != GridArray[gridIndex] )/* &&
             ( High[barNo + 1] < GridArray[gridIndex] )*/)
         {
            //Print( "New High switch ", barNo, " ", lowerBarNo, " ", Time[barNo + 1], " ", gridIndex, " ", High[barNo + 1], " ", GridArray[gridIndex], " ", oldPrice);      
            if (arrayStruct.CrossOver)
            {
               if (( arrayStruct.CrossOver ) && ( arrayStruct.LastCrossBarNo == ( Bars - barNo )))
                  arrayStruct.LastCrossY = arrayStruct.Array[Bars - arrayStruct.LastCrossBarNo];
               else
                  arrayStruct.LastCrossY = arrayStruct.Array[barNo + 1];
            }
            arrayStruct.Array[barNo] = GridArray[gridIndex];
         }
         else
         {
            arrayStruct.CrossOver  = false;
            arrayStruct.Array[barNo] =  arrayStruct.Array[barNo + 1];
            //Print( "New High no switch ", barNo, " ", lowerBarNo, " ", Time[barNo + 1], " ", gridIndex, " ", gridArraySize, " ", HighArrayStruct.Array[barNo ], " ",arrayStruct.Array[barNo + 1], " ",arrayStruct.Array[barNo], " ", TimeToStr( Time[barNo + 1], TIME_DATE | TIME_SECONDS ));      
         }
      }
   }
   else
   {
      found = false;
      if ( curLevel != OMAPrevLevel  )
      {
         arrayStruct.CrossOver  = true;
         if ( arrayStruct.LastCrossBarNo < ( Bars - ( barNo + 1 )))
            arrayStruct.LastCrossBarNo = Bars - ( barNo + 1 );
         else
            arrayStruct.LastCrossBarNo = Bars - barNo;
         arrayStruct.BuySell = false;   
         
         for ( gridIndex = gridArraySize - 1; gridIndex >= 0 ; gridIndex-- )
         {
            //Print( gridIndex, " ", GridArray[gridIndex], " ", LowArrayStruct.Array[barNo + 1], " ",
            //      ( GridArray[gridIndex] <= LowArrayStruct.Array[barNo + 1] ));
            if ( GridArray[gridIndex] <= LowArrayStruct.Array[barNo + 1] )
            {
               found = true;
               OCCount = 1;
               break;
            }
         }
      }
      else
      {
         oldPrice = LowArrayStruct.Array[barNo + 1];
         double tempLowMA = MathFloor( HighArrayStruct.Array[barNo + 1] / HGridPipsCur / TPoint ) * HGridPipsCur * TPoint;
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
      }
      
      if ( !found )
      {
         arrayStruct.CrossOver  = false;
         DrawTrendLine( IndPrefix + "X" + "OSetLine", OffsetLineCount, barNo + 1, barNo, arrayStruct.Array[barNo], arrayStruct.Array[barNo], OffsetLineColor );
         //Print( "Not found Low ", gridIndex, " ", barNo, " ", LowArrayStruct.Array[barNo], " ", arrayStruct.Array[barNo] );
      }
      else
      {   
         while (( gridIndex >= 0 ) && 
                ((( LowArrayStruct.Array[barNo + 1] - GridArray[gridIndex] ) < LowerGridOffsetPips * TPoint ) ||
                 (( LowArrayStruct.Array[barNo + 1] - GridArray[gridIndex] ) < ( OffsetGridLevel - 1 ) * HGridPipsCur * TPoint )))
            gridIndex--;
         if (( gridIndex >= 0 )  && 
             ( oldPrice != GridArray[gridIndex] )/* &&
             ( Low[barNo + 1] > GridArray[gridIndex] )*/)
         {
            //Print( "New Low switch", barNo, " ", lowerBarNo, " ", gridIndex, " ", Low[barNo + 1], " ",GridArray[gridIndex], " ", oldPrice, " ", TimeToStr( Time[barNo], TIME_DATE | TIME_SECONDS ));      
            if (arrayStruct.CrossOver)
            {
               if (( arrayStruct.CrossOver ) && ( arrayStruct.LastCrossBarNo == ( Bars - barNo )))
                  arrayStruct.LastCrossY = arrayStruct.Array[Bars - arrayStruct.LastCrossBarNo];
               else
                  arrayStruct.LastCrossY = arrayStruct.Array[barNo + 1];
            }
            arrayStruct.Array[barNo] = GridArray[gridIndex];
         }
         else
         {
            //Print( "New Low no switch", barNo, " ", lowerBarNo, " ", gridIndex, " ", LowArrayStruct.Array[barNo ], " ",arrayStruct.Array[barNo + 1], " ",arrayStruct.Array[barNo], " ", TimeToStr( Time[barNo], TIME_DATE | TIME_SECONDS ));      
            arrayStruct.CrossOver  = false;
            arrayStruct.Array[barNo] =  arrayStruct.Array[barNo + 1];
         }
      }
   }
}


int OffsetLineCount = 0;
int OMAPrevLevel = -1;
int OCCount = 0;
void DrawOffsetMASingle( int barNo, int lowerBarNo, bool newBar )
{
   if (( MaxBars - barNo ) < 512 )
      return;
   
   ArrayStruct* arrayStruct = GetArrayStructFromList( UAArrayStructList, MAHIGHOFFSETARRAY, OTHERARRAYGR );
   int curLevel = OMAPrevLevel;

   DoOffsetMASingle( arrayStruct, barNo, lowerBarNo, curLevel );
   DoCross( arrayStruct, arrayStruct, MAOffsetCrossPriceType, barNo, lowerBarNo, curLevel, OMAPrevLevel );
   if ( curLevel != OMAPrevLevel )
      DoOffsetMASingle( arrayStruct, barNo, lowerBarNo, curLevel );

  
   if (( newBar && ( arrayStruct.LastCrossBarNo != ( Bars - barNo ))) || arrayStruct.CrossOver )
   {
      Print( "Draw ", Time[barNo], " ", lowerBarNo, " ", OffsetLineCount, " ", arrayStruct.CrossOver, " ", arrayStruct.LastCrossBarNo, " ", arrayStruct.LastCrossY, " ",
                      ( arrayStruct.CrossOver ? Bars - arrayStruct.LastCrossBarNo : barNo + 1), " ", barNo, " ",
                      ( arrayStruct.CrossOver ? arrayStruct.LastCrossY : arrayStruct.Array[barNo + 1] ), " ",
                        arrayStruct.Array[barNo] );
      DrawTrendLine( IndPrefix + "X" + "OSetLine", OffsetLineCount, 
                     arrayStruct.CrossOver ? Bars - arrayStruct.LastCrossBarNo : barNo + 1, barNo, 
                     arrayStruct.CrossOver ? arrayStruct.LastCrossY : arrayStruct.Array[barNo + 1], 
                     arrayStruct.Array[barNo], OffsetLineColor, 3, STYLE_SOLID );
   }
    
   if ( curLevel != OMAPrevLevel )
   {
      ArrayStruct* arrayStructOMA = OMAArrayStructList;
      while( arrayStructOMA != NULL )
      {
         if (( arrayStructOMA.UseArray ) && ( arrayStructOMA.MAArrayNo == 0 ))
            arrayStructOMA.CrossedOver[MAHIGHOFFSETOC] = false;
         arrayStructOMA = arrayStructOMA.NextArrayStruct;
      }
   }                 
   DrawOverCupFunc( barNo, arrayStruct, MAHIGHOFFSETOC );
   OMAPrevLevel = curLevel;
   //Print(arrayStruct.Array[barNo]);
}


int OffsetMAHighLineCount = 0;
int OffsetMALowLineCount = 0;
void DrawOffsetMADouble( int barNo, int lowerBarNo, bool newBar  )
{
   if (( MaxBars - barNo ) < 512 )
      return;

   ArrayStruct* MAHighArrayStruct = GetArrayStructFromList( UAArrayStructList, MAHIGHOFFSETARRAY, OTHERARRAYGR );
   ArrayStruct* MALowArrayStruct = GetArrayStructFromList( UAArrayStructList, MALOWOFFSETARRAY, OTHERARRAYGR );
   ArrayStruct* HighArrayStruct = GetArrayStructFromList( UAArrayStructList, HIGHARRAY, OTHERARRAYGR );
   ArrayStruct* LowArrayStruct = GetArrayStructFromList( UAArrayStructList, LOWARRAY, OTHERARRAYGR );
   int curLevel = OMAPrevLevel;
    
   int gridArraySize = ArraySize( GridArray );  
   int gridIndex;
   double oldLevel;
   bool found;  
   
   // Draw High MA
   found = false;
   oldLevel = MAHighArrayStruct.Array[barNo + 1];
   MAHighArrayStruct.CrossOver  = false;
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
             ((( GridArray[gridIndex] - HighArrayStruct.Array[barNo + 1] ) < LowerGridOffsetPips * TPoint ) ||
              (( GridArray[gridIndex] - HighArrayStruct.Array[barNo + 1] ) < ( OffsetGridLevel - 1 ) * HGridPipsCur * TPoint )))
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
   MAHighArrayStruct.CrossOver  = false;
   oldLevel = MALowArrayStruct.Array[barNo + 1];
   double tempLowMA = MathFloor( HighArrayStruct.Array[barNo + 1] / HGridPipsCur / TPoint ) * HGridPipsCur * TPoint;
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
             ((( LowArrayStruct.Array[barNo + 1] - GridArray[gridIndex] ) < LowerGridOffsetPips * TPoint ) ||
              (( LowArrayStruct.Array[barNo + 1] - GridArray[gridIndex] ) < ( OffsetGridLevel - 1 ) * HGridPipsCur * TPoint )))
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

   DoCross( MAHighArrayStruct, MALowArrayStruct, MAOffsetCrossPriceType, barNo, lowerBarNo, curLevel, OMAPrevLevel );
   
   if ( curLevel != OMAPrevLevel )
   { 
      //Print( curLevel );
      if (( MALowArrayStruct.BuySell ||
          (( !MAHighArrayStruct.BuySell ) && ( !MALowArrayStruct.BuySell ))) && ( curLevel == HIGHLEVEL ))
      {
         MAHighArrayStruct.CrossOver = true;
         MAHighArrayStruct.LastCrossBarNo = Bars - barNo;
         MAHighArrayStruct.LastCrossY = MAHighArrayStruct.Array[barNo];
         MAHighArrayStruct.BuySell        = true;
         MALowArrayStruct.BuySell         = false;
         
         ArrayStruct* arrayStructOMA = OMAArrayStructList;
         while( arrayStructOMA != NULL )
         {
            if (( arrayStructOMA.UseArray ) && ( arrayStructOMA.MAArrayNo == 0 ))
               arrayStructOMA.CrossedOver[MAHIGHOFFSETOC] = false;
            arrayStructOMA = arrayStructOMA.NextArrayStruct;
         }
      }
      if (( MAHighArrayStruct.BuySell  ||
          (( !MAHighArrayStruct.BuySell ) && ( !MALowArrayStruct.BuySell ))) && ( curLevel == LOWLEVEL ))
      {
         MALowArrayStruct.CrossOver = true;
         MALowArrayStruct.LastCrossBarNo = Bars - barNo;
         MALowArrayStruct.LastCrossY = MALowArrayStruct.Array[barNo];
         MAHighArrayStruct.BuySell       = false;
         MALowArrayStruct.BuySell        = true;
         
         ArrayStruct* arrayStructOMA = OMAArrayStructList;
         while( arrayStructOMA != NULL )
         {
            if (( arrayStructOMA.UseArray ) && ( arrayStructOMA.MAArrayNo == 0 ))
               arrayStructOMA.CrossedOver[MALOWOFFSETOC] = false;
            arrayStructOMA = arrayStructOMA.NextArrayStruct;
         }
      }
   }
   
   if (( newBar && (( MAHighArrayStruct.LastCrossBarNo != ( Bars - barNo )) || ( MALowArrayStruct.LastCrossBarNo != ( Bars - barNo )))) || 
         MAHighArrayStruct.CrossOver || MALowArrayStruct.CrossOver )
   {
      //Print( "Draw ", lowerBarNo, " ", 
      //                ( arrayStruct.CrossOver ? Bars - arrayStruct.LastCrossBarNo : barNo + 1), " ", barNo, " ",
      //                ( arrayStruct.CrossOver ? arrayStruct.LastCrossY : arrayStruct.Array[barNo + 1] ), " ",
      DrawTrendLine( IndPrefix + "X" + "OSetHighLine", OffsetMAHighLineCount, barNo + 1, barNo, 
                     MAHighArrayStruct.Array[barNo + 1], 
                     MAHighArrayStruct.Array[barNo], OffsetLineColor, 3, STYLE_SOLID );
      DrawTrendLine( IndPrefix + "X" + "OSetLowLine", OffsetMALowLineCount, barNo + 1, barNo, 
                     MALowArrayStruct.Array[barNo + 1], 
                     MALowArrayStruct.Array[barNo], OffsetLineColor, 3, STYLE_SOLID );
      if ( MAHighArrayStruct.CrossOver )
      {
         OffsetMAHighLineCount++;
         DrawTrendLine( IndPrefix + "X" + "OSetHighLine", OffsetMAHighLineCount, barNo, barNo, 
                     MAHighArrayStruct.Array[barNo + 1], 
                     MALowArrayStruct.Array[barNo], OffsetLineColor, 3, STYLE_SOLID );
         //Print( "Double Cross High ", barNo, " ", barNo, " ", MALowArrayStruct.Array[barNo + 1],  " ", MAHighArrayStruct.Array[barNo] );
      }
      if ( MALowArrayStruct.CrossOver )
      {
         OffsetMALowLineCount++;
         DrawTrendLine( IndPrefix + "X" + "OSetLowLine", OffsetMALowLineCount, barNo, barNo, 
                     MALowArrayStruct.Array[barNo + 1], 
                     MAHighArrayStruct.Array[barNo], OffsetLineColor, 3, STYLE_SOLID );
         //Print( "Double Cross Low ", barNo + 1, " ", barNo, " ", MAHighArrayStruct.Array[barNo + 1],  " ", MALowArrayStruct.Array[barNo] );
      }
   }
   
   if ( MAHighArrayStruct.BuySell )
      DrawOverCupFunc( barNo, MAHighArrayStruct, MAHIGHOFFSETOC );
   else if ( MALowArrayStruct.BuySell )
      DrawOverCupFunc( barNo, MALowArrayStruct, MALOWOFFSETOC );
   //Print(arrayStruct.Array[barNo]);
   OMAPrevLevel = curLevel;
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


int ReadOMAFile( string fileName, ArrayStruct* UAOrMAStructList )
{

   int fh = FileOpen( fileName, FILE_CSV | FILE_BIN | FILE_SHARE_READ);
   //Print( "File Opening " + fh );
   string readText;
   ArrayStruct* arrayStruct = NULL;
   bool headerLine = true;
   int MACount = 0;
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
         MACount = 0;
         for ( int i = 0; i < ArraySize( splitStr ); i++ )
         {
            if ( i == 0 ) // Indicator Index
            {
               MACount = StrToInteger( splitStr[0] ) - 1;
               arrayStruct = GetArrayStructFromList( UAOrMAStructList, MACount, USERARRAYGR, true );
            }
            else if ( i == ( OMAUSEARRAY )) // Indicator Index
            {
               if ( splitStr[i] == "true" )
               {
                  arrayStruct.UseArray = true;
               }
               else
               {
                  arrayStruct.UseArray = false;
               }
            }
            else if ( i == ( OMATIMEFRAME )) // Indicator Index
            {
               ENUM_TIMEFRAMES timeframe =  GetTimeframeFromString( splitStr[i] );
               {
                  arrayStruct.TimeFrame = timeframe;
               }
            }
            else if ( i == ( OMAMAMODE )) // Indicator Index
            {
               MAMODE mAMode = GetMAModeFromStr( splitStr[i] );
               if (( mAMode >= SMA ) && ( mAMode <= LWMAMAMA ))
               {
                  arrayStruct.MAMode = mAMode;
               }
               else
               {
                  Alert( "OMA Indicator " + IntegerToString( MACount + 1) + 
                         ", sub MA value MAMODE " + splitStr[i] + " is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( OMAMAPERIOD )) // Indicator Index
            {
               int mAPeriod = StrToInteger( splitStr[i] );
               if ( mAPeriod > 0 )
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.MAPeriod =  mAPeriod;
               }
               else
               {
                  Alert( "OMA Indicator " + IntegerToString( MACount + 1) + 
                         ", sub MA value MA Period is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( OMAMAPRICETYPE )) // Indicator Index
            {
               ENUM_APPLIED_PRICE priceType = GetPriceTypeFromStr( splitStr[i] );
               if (( priceType >= PRICE_CLOSE ) && ( priceType <= PRICE_WEIGHTED ))
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.PriceType = priceType;
               }
               else
               {
                  Alert( "OMA Indicator " + IntegerToString( MACount + 1) + 
                         ", sub MA value Price Type " + splitStr[i] + " is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( OMAMAPERIOD1 )) // Indicator Index
            {
               int mAPeriod1 = StrToInteger( splitStr[i] );
               if ( mAPeriod1 > 0 )
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.MAPeriod1 =  mAPeriod1;
               }
               else
               {
                 Alert( "OMA Indicator " + IntegerToString( MACount + 1) + 
                         ", sub MA value MA Period1 is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( OMAMAHEDGEPHASE )) // Indicator Index
            {
               int hedgePhase = StrToInteger( splitStr[i] );
               if ( hedgePhase >= 0 )
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.HedgePhase =  hedgePhase;
               }
               else
               {
                  Alert( "OMA Indicator " + IntegerToString( MACount + 1) + 
                         ", sub MA value HedgePhase is invalid" );
                  return( INIT_FAILED );
               }
            }
            else if ( i == ( OMAMAHEDGEBARCOUNT )) // Indicator Index
            {
               int hedgeBarCount = StrToInteger( splitStr[i] );
               if ( hedgeBarCount > 0 )
               {
                  if ( arrayStruct != NULL )
                     arrayStruct.HedgeBarCount =  hedgeBarCount;
               }
               else
               {
                  Alert( "OMA Indicator " + IntegerToString( MACount + 1) + 
                         ", sub MA value HedgeBarCount is invalid" );
                  return( INIT_FAILED );
               }      
            }
            //Print( i, " ", indIndex, " ", subMACount );
         } // readline
         
         if ( arrayStruct != NULL )
            if ( arrayStruct.MAMode >= SimpleMAMA )
               SetCalculationIndex( arrayStruct.ArrayMA );
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