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
  PLineRect = class (TPersistent)
  private
    FTop: integer;
    FLeft: integer;
    FRight: integer;
    FBottom: integer;
  published
    property Left:integer read FLeft write FLeft;
    property Right:integer read FRight write FRight;
    property Top:integer read FTop write FTop;
    property Bottom:integer read FBottom write FBottom;
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
    FIndex: integer;
    FLineRect3: integer;
    FLineRect1: integer;
    FLineRect4: integer;
    FLineRect2: integer;
    FMinHeight: integer;
    FLineTop: integer;
    FDragHeight: integer;
    FLineRect: PLineRect;

  public
    constructor Create(Collection: TCollection);override;
    destructor destroy;               override;
  published
    property CellList:PCellList read FCellList write FCellList;
    property _Index:integer read FIndex write FIndex ;
    property   MinHeight :integer read FMinHeight write FMinHeight;
    property   DragHeight :integer read FDragHeight write FDragHeight;
    // todo : dup with linerect
    property   LineTop :integer read FLineTop write FLineTop;
    // LineRect
    property LineRect : PLineRect read FLineRect write FLineRect;
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
    destructor destroy;               override;
  published
    //property id : string read FName write FName;
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
  FLineRect := PLineRect.create();
end;

destructor PLine.destroy;
begin
  FCellList.Free;
  FLineRect.Free;
  inherited ;
end;

destructor PPage.destroy;
begin
  FLineList.Free ;
  inherited;
end;

initialization
  RegisterClass(PLine);
  RegisterClass(PCell);
end.
