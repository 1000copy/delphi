unit PrintDO;


interface

uses classes;
type
  PCellList = class(TCollection)
  private
    FName: string;
  public
  published
    property id : string read FName write FName;
  end;
  PCellPosition = class(TCollectionItem)
  private
    FCellIndex: integer;
    FLineIndex: integer;
  published
    property LineIndex:integer read FLineIndex write FLineIndex;
    property CellIndex:integer read FCellIndex write FCellIndex;
  end;
  PCellPosition1 = class(TPersistent)
  private
    FCellIndex: integer;
    FLineIndex: integer;
  published
    property LineIndex:integer read FLineIndex write FLineIndex;
    property CellIndex:integer read FCellIndex write FCellIndex;
  end;
  PCellPositionList = class(TCollection)
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
  PCell = class(TCollectionItem)
  private
    FName: string;
    FI:Integer;
    FBottomLine: boolean;
    FLeftLine: boolean;
    FTopLine: boolean;
    FRightLine: boolean;
    Fbmpyn: boolean;
    FCellDispformat: Cardinal;
    FDiagonal: Cardinal;
    FTextColor: Cardinal;
    FRightLineWidth: integer;
    FVertAlign: integer;
    FTopLineWidth: integer;
    FLeftLineWidth: integer;
    FCellLeft: integer;
    FCellHeight: integer;
    FBottomLineWidth: integer;
    FHorzAlign: integer;
    FCellIndex: integer;
    FLeftMargin: integer;
    FCellWidth: integer;
    FRequiredCellHeight: integer;
    FCellRect: PLineRect;
    FTextRect: PLineRect;
    FCellText: String;
    FBackGroundColor: Cardinal;
    FOwnerCellPosition: PCellPosition1;
    FSlaveCells: PCellPositionList;
  public
    constructor Create(Collection: TCollection);override;
    destructor destroy;override;
  published
    property id : string read FName write FName;
    property i : integer read FI write FI;
    property LeftMargin : integer read FLeftMargin write FLeftMargin;
    property CellIndex : integer read FCellIndex write FCellIndex;
    property CellLeft : integer read FCellLeft write FCellLeft;
    property CellWidth : integer read FCellWidth write FCellWidth;
    property CellRect : PLineRect read FCellRect write FCellRect;
    property TextRect : PLineRect read FTextRect write FTextRect;
    property CellHeight : integer read FCellHeight write FCellHeight;
    property RequiredCellHeight : integer read FRequiredCellHeight write FRequiredCellHeight;
    property LeftLine : boolean read FLeftLine write FLeftLine;
    property LeftLineWidth : integer read FLeftLineWidth write FLeftLineWidth;
    property TopLine : boolean read FTopLine write FTopLine;
    property TopLineWidth : integer read FTopLineWidth write FTopLineWidth;
    property RightLine : boolean read FRightLine write FRightLine;
    property RightLineWidth : integer read FRightLineWidth write FRightLineWidth;
    property BottomLine : boolean read FBottomLine write FBottomLine;
    property BottomLineWidth : integer read FBottomLineWidth write FBottomLineWidth;
    property Diagonal : Cardinal read FDiagonal write FDiagonal;
    property TextColor : Cardinal read FTextColor write FTextColor;
    property HorzAlign : integer read FHorzAlign write FHorzAlign;
    property VertAlign : integer read FVertAlign write FVertAlign;
    property CellText : String read FCellText write FCellText;
    property CellDispformat : Cardinal read FCellDispformat write FCellDispformat;
    property bmpyn : boolean read Fbmpyn write Fbmpyn;
    property OwnerCellPosition : PCellPosition1 read FOwnerCellPosition write FOwnerCellPosition;
    property SlaveCells : PCellPositionList read FSlaveCells write FSlaveCells;
  end;

{ 


  
    If FileFlag = $AA57 Then
    Begin
      read(Fbmpyn, SizeOf(FbmpYn));
      If FbmpYn Then
        FBmp.LoadFromStream(stream);
    End;

    ReadTLogFont(FLogFont);

    ReadInteger(Count1);
    ReadInteger(Count2);

    If (Count1 < 0) Or (Count2 < 0) Then
      FOwnerCell := Nil
    Else
      FOwnerCell :=
        TReportCell(TReportLine(Self.ReportControl. FLineList[Count1]).FCells[Count2]);

    ReadInteger(Count3);

    For K := 0 To Count3 - 1 Do
    Begin
      ReadInteger(Count1);
      ReadInteger(Count2);
      FSlaveCells.Add(TReportCell(TReportLine(Self.ReportControl.FLineList[Count1]).FCells[Count2]));
    End;}


 
//   NLine 的构造函数非常关键，必须覆盖 Create(Collection: TCollection);override，如果是Create;就无法被omnixml在构建此对象的时候调用 。
  PLine = class(TCollectionItem)
  private
    FName: string;
    FCellList: PCellList;
    FIndex: integer;

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

{ PCell }

constructor PCell.Create(Collection: TCollection);
begin
  inherited;
  self.FSlaveCells := PCellPositionList.create(PCellPosition);
  self.FOwnerCellPosition :=  PCellPosition1.Create();
end;

destructor PCell.destroy;
begin
  self.FOwnerCellPosition.free;
  self.FSlaveCells.free ;
  inherited;
end;

initialization
  RegisterClass(PLine);
  RegisterClass(PCell);
  RegisterClass(PCellPosition)
end.
