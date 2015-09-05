{******************************************************************************}
{*  TFMREG - Programmers registry editor.                                     *}
{*  Copyright Toby Allen - Toflidium Software 2001                            *}
{*                                                                            *}
{******************************************************************************}
{*                                                                            *}
{* 12/3/02                                                                    *}
{* 1.  Added code to properly deal with CaseSensitive and WholeKey Flags.     *}
{* 2.                                                                         *}
{*                                                                            *}
{*                                                                            *}
{******************************************************************************}
unit tfmRegClasses;

interface
Uses Registry, Classes, Windows, forms, sysutils, dialogs,strUtils,
    {TOFLIDIUM}
    tfmCommonReg;
type
    TGuidType = (gtUNK,gtCLSID, gtTYPLIB, gtINF, gtCompCats, gtImpCats);

    TGuidInfo = Record
        GuidString  : String;
        GuidType    : TGuidType;
    end;

    TKeyFoundEvent = Procedure(Sender : TObject; Path : String) of object;

    TRegSearch = Class(TComponent)
    private
    FReg :          TRegistry;
    FSearchKeys:    Boolean;
    FStartKey:      String;
    FSearchValue:   String;
    FHKEYS:         THives;
    FFound:         TRegPath;
    FKeyFound:      TKeyFoundEvent;
    FCaseSensitive:   Boolean;
    FSearchValueName: Boolean;
    FSearchValueData: Boolean;
    FIsCancelled :  Boolean;
    FWholeKey:      Boolean;
    FSearchKEy:     TKeyFoundEvent;
    procedure SetHKEYS(const Value: THives);
    procedure SetSearchKeys(const Value: Boolean);
    procedure SetSearchValue(const Value: String);
    procedure SetStartKey(const Value: String);
    procedure QueryKey(     QueryString, TopSection: string;
                            Ahkey: HKEY;
                            bMatchWhole: Boolean;
                            const QueryList: TStrings);
    function ReturnAsString(    Value: String): String;
    function SearchDataValues(   List: TStrings;
                                QueryValue: String; GetData : Boolean): Boolean;
//    function SearchValues(Values : TStrings; QueryValue: String): Boolean;

    procedure DoFound(Path : String);
    procedure SetSearchValueData(const Value: Boolean);
    procedure SetSearchValueName(const Value: Boolean);

    Public

        {Function GetFirst : Boolean;
        Function GetNext  : Boolean;    }
        Procedure GetAll(aStrings : TStrings);
        Procedure Cancel;
        Constructor Create(AOwner: TComponent); override;
        Destructor Destroy; override;
    Published
        Property HKEYS : THives read FHKEYS write SetHKEYS;
        Property OnKeyFound : TKeyFoundEvent read FKeyFound write FKeyFound;
        Property OnSearchKey : TKeyFoundEvent read FSearchKEy write FSearchKey;
        Property SearchValue : String read FSearchValue write SetSearchValue;
        Property StartKey : String read FStartKey write SetStartKey;
        Property SearchValueName : Boolean read FSearchValueName write SetSearchValueName Stored True;
        Property SearchValueData : Boolean  read FSearchValueData write SetSearchValueData;
        Property SearchKeyNames: Boolean read FSearchKeys write SetSearchKeys Stored True;
        Property Found : TRegPath read FFound;
        Property CaseSensitive : Boolean read FCaseSensitive write FCaseSensitive;
        Property MatchWholeKey : Boolean read FWholeKey Write FWholeKey;
    end;

implementation

{ TRegSearch }

constructor TRegSearch.Create(AOwner: TComponent);
begin
    inherited;
    FReg := TRegistry.Create;
    FHKEYS := THives.Create;
end;

destructor TRegSearch.Destroy;
begin
    FReg.Free;
    FHKEYS.free;
    inherited;

end;

procedure TRegSearch.GetAll(aStrings: TStrings);
VAR
    index : Integer;
begin
    FIsCancelled := False;
  {  QueryKey(FSearchValue,FStartKey,HKEY_CLASSES_ROOT  ,true,astrings);
    QueryKey(FSearchValue,FStartKey,HKEY_LOCAL_MACHINE   ,true,astrings);
    QueryKey(FSearchValue,FStartKey,HKEY_CURRENT_USER    ,true,astrings); }

    for index := 0 to hivecount -1 do
    begin
        if FHKEYS.ShowHive[RegistryHives[Index]] then
            queryKey (FSearchValue,FStartKey, RegistryHives[Index], TRUE,aStrings);
    end;


end;





{function TRegSearch.GetFirst: Boolean;

begin


end;

function TRegSearch.GetNext: Boolean;
begin

end; }

procedure TRegSearch.SetHKEYS(const Value: THives);
begin
  FHKEYS := Value;
end;

procedure TRegSearch.SetSearchKeys(const Value: Boolean);
begin
  FSearchKeys := Value;
end;

procedure TRegSearch.SetSearchValue(const Value: String);
begin
  FSearchValue := Value;
end;



procedure TRegSearch.SetStartKey(const Value: String);
begin
  FStartKey := Value;
end;

procedure TRegSearch.QueryKey(QueryString, TopSection: string;Ahkey: HKEY; bMatchWhole: Boolean;
  const QueryList: TStrings);
var slValues, slKeys : TStringlist;
i, itemindex : integer;
    SingleKey : TStringList;
begin
    Application.ProcessMessages;
    With FReg do
    begin
        RootKey := Ahkey;
        if OpenKey(TopSection, false) then
        begin
            if assigned(fsearchkey) then
                fsearchkey(self,StringFromHKey(Ahkey) + TopSection);

            slValues := TStringList.Create;
            slKeys := TStringlist.create;
            SingleKey := TStringlist.create;
            try
                GetKeyNames(slKEys);

                GetValueNames(slValues);
                {Search Value Data}
                if SearchDataValues(slValues,QueryString, True) then
                begin
                    Querylist.Add(StringFromHKey(Ahkey) + TopSection);
                    DoFound(IncludeTrailingPathDelimiter( StringFromHKey(Ahkey) + TopSection));
                    Application.ProcessMessages;
                end;
                Closekey;
                if slKEys.Count > 0 then
                begin

                    {Search Subkeys}
                    for itemindex := 0 to slKeys.Count -1 do
                    begin
                        SingleKey.Clear;
                        singlekey.Add(slkeys[itemindex]);
                        if SearchDataValues(singlekey,querystring,false) then
                        begin
                          Querylist.Add(StringFromHKey(Ahkey)+TopSection + '\' + slkeys[itemindex]);
                            DoFound(IncludeTrailingPathDelimiter(StringFromHKey(Ahkey)+TopSection + '\' + slkeys[itemindex]));
                          Application.ProcessMessages;
                        end;
                    end;

                    {Search Value Names}
                    if SearchDataValues(slValues,querystring, False) then
                    begin
                      Querylist.Add(StringFromHKey(Ahkey)+ TopSection);
                        DoFound(IncludeTrailingPathDelimiter(StringFromHKey(Ahkey) + TopSection));
                      Application.ProcessMessages;
                    end;

                    for i := 0 to slKEys.count -1 do
                    begin
                        if FIsCancelled then
                            exit;
                        if not (slkeys[i] = '') then
                            QueryKey(QueryString,TopSEction + '\' + slKEys[i],AHKEY,bMatchWhole,Querylist);
                    end;
              end;


            finally
              slkeys.free;
              slvalues.free;
              SingleKey.Free;
            end;
        end;
    end;

end;

function TRegSearch.ReturnAsString(Value: String): String;
var
    RegType : TRegDataType;

begin
  With FReg do
  begin
  RegType :=  GetDataType(value);

  Case Regtype of
    rdString :  Result := ReadString(value);
    rdInteger: Result := inttostr(Readinteger(value));
    rdExpandString : Result := ReadString(value);
    rdBinary : Result := 'Binary';
    {begin
      try
        binlength :=  ReadBinaryData(value, buffer, SizeOf(buffer));
        Result :=  GetStringFromByteArray(buffer,binlength);
      except
        Result := '';
      end;

    end; }
  else
    Result := 'NotString';
  end;
  end;
end;

function TRegSearch.SearchDataValues(List: TStrings; QueryValue : String; GetData : Boolean): Boolean;
var i : Integer;
valuestr : String;
begin
    Result := false;
    For i := 0 to List.Count -1 do
    begin
     if GetData then
        valuestr := ReturnAsString(List[i])
     else
        ValueStr := List[i];
     //if lowercase(valuestr) = LowerCase(QueryValue) then
        if FCaseSensitive then
        begin
            if (FWholeKey) then
            begin
                if ValueStr = queryValue then
                begin
                    Result := True;
                    break;
                end;
            end
            else If AnsiContainsStr(Valuestr,queryValue  ) then
            begin
                Result := True;
                Break;
            end;
        end
        else
        begin
           if FWholeKey then
           begin
              if AnsiCompareText(valuestr,queryvalue) = 0 then
              begin
                 Result := True;
                 break;
              end
           end
           else if AnsicontainsText(valuestr,queryvalue ) then
           begin
             Result := true;
             break;
           end;
        end;
    end;
end;

(*function TRegSearch.SearchValues(Values: TStrings;
  QueryValue: String): Boolean;
begin
       { slValues.CaseSensitive := FCaseSensitive;
        itemindex := slValues.IndexOf(QueryString);
        if itemindex > -1 then
        begin
          Querylist.Add(StringFromHKey(Ahkey)+ TopSection);
            DoFound(StringFromHKey(Ahkey) + TopSection);
          Application.ProcessMessages;
        end; }
    if FCaseSensitive then
    begin

    end
    else
    begin

    end;
end; *)


procedure TRegSearch.DoFound(Path: String);
begin
    if assigned(fKeyFound) then
        FKeyFound(self,Path);
end;

procedure TRegSearch.Cancel;
begin
    FIsCancelled := True;
end;

procedure TRegSearch.SetSearchValueData(const Value: Boolean);
begin
  FSearchValueData := Value;
end;

procedure TRegSearch.SetSearchValueName(const Value: Boolean);
begin
  FSearchValueName := Value;
end;



end.
