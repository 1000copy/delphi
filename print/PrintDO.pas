unit PrintDO;


interface

uses classes;
type
  PCell = class(TCollectionItem)
  private
    FName: string;
    FI:Integer;
  public
  published
    property id : string read FName write FName;
    property i : integer read FI write FI;
  end;
  PCellList = class(TCollection)
  private
    FName: string;
  public
  published
    property id : string read FName write FName;
  end;
//   NLine 的构造函数非常关键，必须覆盖 Create(Collection: TCollection);override，如果是Create;就无法被omnixml在构建此对象的时候调用 。
  PLine = class(TCollectionItem)
  private
    FName: string;
    FCellList: PCellList;
  public
    constructor Create(Collection: TCollection);override;
  published
    property id : string read FName write FName;
    property CellList:PCellList read FCellList write FCellList;
  end;
  PLineList = class(TCollection)
  private
    FName: string;
  public
  published
    property id : string read FName write FName;
  end;

  PPage = class(TPersistent)
  private
    FName: string;
    FLineList: PLineList;
    FReportScale: Integer;
    FPageWidth: Integer;
    FPageHeight: Integer;
    FLeftMargin: Integer;
    FTopMargin: Integer;
    FRightMargin: Integer;
    FBottomMargin: Integer;
    FNewTable: Boolean;
    FDataLine: integer;
    FTablePerPage: integer;

  public
    constructor Create;

  published
    property id : string read FName write FName;
    property ReportScale : Integer read FReportScale write FReportScale;
    property PageWidth:  Integer read FPageWidth write FPageWidth ;
    property PageHeight:  Integer read FPageHeight write FPageHeight ;
    property LeftMargin:  Integer read FLeftMargin write FLeftMargin ;
    property TopMargin:  Integer read FTopMargin write FTopMargin ;
    property RightMargin:  Integer read FRightMargin write FRightMargin ;
    property BottomMargin:  Integer read FBottomMargin write FBottomMargin ;
    property NewTable:  Boolean read FNewTable write FNewTable;
    property DataLine: integer read FDataLine write FDataLine;
    property TablePerPage: integer read FTablePerPage write FTablePerPage;
    property LineList: PLineList read FLineList write FLineList;
  end;

{
      WriteInteger(FReportScale);
      WriteInteger(FPageWidth);
      WriteInteger(FPageHeight);
      WriteInteger(FLeftMargin);
      WriteInteger(FTopMargin);
      WriteInteger(FRightMargin);
      WriteInteger(FBottomMargin);
      WriteInteger(FLeftMargin1);
      WriteInteger(FTopMargin1);
      WriteInteger(FRightMargin1);
      WriteInteger(FBottomMargin1);
      WriteBoolean(FNewTable);
      WriteInteger(FDataLine);
      WriteInteger(FTablePerPage);
      WriteInteger(FLineList.Count);}
implementation

{ NPage }


constructor PPage.Create;
begin
 inherited;
 FLineList := PLineList.Create(PLine);
end;


{ NLine }

constructor PLine.Create(Collection: TCollection);
begin
  inherited;
  FCellList := PCellList.Create(PCell);
end;

initialization
  RegisterClass(PLine);
  RegisterClass(PCell);
end.
