{******************************************************************************}
{*  TFMREG - Programmers registry editor.                                     *}
{*  Copyright Toby Allen - Toflidium Software 2002                            *}
{*                                                                            *}
{******************************************************************************}
{*                                                                            *}
{* 19/02/2002 Toby                                                            *}
{* 1.  Added recursive procedures to enable export of sub keys.               *}
{* 2.  Tidied up one or two things to bring closer to regedit export.         *}
{*                                                                            *}
{* 4/03/02                                                                    *}
{* 1. Added code to allow cancelling of export, also provide events onfinish  *}
{*    and OnCancelled                                                         *}
{******************************************************************************}
unit RegExport;

interface
uses Classes, Registry, SysUtils, tfmCommonReg, ComCtrls, forms, tfmregappconst, WINDOWS;
type

    TExportType = (etBranch, etWindow, etFull);

    TBaseRegExport = Class
    private
        FFilename:      String;
        FExportType:    TExportType;
        FExportFile :   TStringlist;
        FExportKeys :   TStrings;
        FReg:           TExtRegistry;
        FExportSubKeys: Boolean;
        FCancelled :    Boolean;
    FOnCancelled: TNotifyEvent;
    FOnFinished: TNotifyEvent;
    FInvalidTypes: Boolean;
    FInvalidMessage: TStrings;
        procedure SetExportKeys(const Value: TStrings);
    procedure SetOnCancelled(const Value: TNotifyEvent);
    procedure SetOnFinished(const Value: TNotifyEvent);
    procedure SetInvalidMessage(const Value: TStrings);

    protected
        procedure    AddExportKey(Key : TRegPath);
        procedure    ExportKey(Key : TRegPath; DoSubKeys : Boolean);
        function     GetKeyString(  ValueName, ValueData : String;
                                    ValueType : TRegDataType): String;
    Public
        Constructor Create;
        Destructor Destroy; override;
        procedure Cancel;
        Function ExportReg : Boolean;
        property InvalidTypes : Boolean read FInvalidTypes;
        Property InvalidMessage : TStrings read FInvalidMessage write SetInvalidMessage;
        Property Filename : String read FFilename write FFilename;
        Property ExportType : TExportType read FExportType write FExportType;
        Property ExportKeys : TStrings read FExportKeys write SetExportKeys;
        Property ExportSubKeys : Boolean read FExportSubKeys write FExportSubKeys  default true;
        property OnFinished : TNotifyEvent read FOnFinished write SetOnFinished;
        property OnCancelled : TNotifyEvent read FOnCancelled write SetOnCancelled;
    end;




const
//    REGFILE_IDENTIFIER  = 'Windows Registry Editor Version 5.00';
    REGFILE_IDENTIFIER = 'REGEDIT4';
    KEYOPEN_BRACKET     = '[';
    KEYCLOSE_BRACKET    = ']';
implementation
uses utilityfunctions;
{ TBaseRegExport }

procedure TBaseRegExport.AddExportKey(Key: TRegPath);
var
    ValueNames  : TStringList;
    Index :      Integer;
    ValueData   : String;
    ValueName   : String;
    ValueType   : TRegDataType;
    ValuetoAdd  : String;
    binCount    : Integer;
    RealDataType    : Integer;
begin

    With fReg do
    begin
        Closekey;
        if RootKey <> key.RegHKey then
            RootKey := key.RegHKey;

        if OpenKey(key.RegSection ,false) then
        begin
            ValueNames := TStringList.Create;
            try
                FExportFile.Add(KEYOPEN_BRACKET + RemoveFinalDelimiter( key.FullPath,'\') + KEYCLOSE_BRACKET );
                GetValueNames(valuenames);

                if ValueNames.Count > 0 then
                begin
                    for  index := 0 to ValueNames.count -1 do
                    begin
                        ValueName := ValueNames[index];
                        ValueType := GetDataType(Valuename);
                        freg.Ext_GetDataType(Valuename,RealDataType );
                        {Use @ for name of default value, when exporting.}
                        if ValueName = '' then
                            ValueName := '@'
                        else
                            ValueName :=  '"' + ValueName + '"';

                        {Ensure that all \ are doubled.}
                        ValueData := ReadValueAsString(ValueNames[index],True );
                        ValueData := StringReplace(ValueData,'\','\\',[rfReplaceAll]);
                        ValueData := StringReplace(ValueData,'"','\"',[rfReplaceAll]);

                        {If value is binary, seperate bytes by commas and add final comma
                        at end.}
                        if (ValueType = rdBinary)
                        or (ValueType = rdexpandstring)then
                        begin
                            ValueData := StringReplace(ValueData,' ',',',[rfReplaceAll]);// + ',';
                            valuetoadd := ValueName + '=' + ValueData;
                            binCount := 78;

                            while bincount <= length(valuetoadd) do
                            begin
                                if valuetoadd[bincount] <> ',' then
                                begin
                                    repeat
                                        inc(bincount);
                                    until valuetoadd[bincount] = ',';
                                end;
                                valuetoadd := copy(valuetoadd,1,bincount)  + '\' +  #10 + '  '  + copy(valuetoadd,bincount + 1,maxint);
                                inc(bincount,79);
                            end

                        end
                        else if (ValueType = rdUnknown) then
                        begin
                            FInvalidTypes := True;
                            FInvalidMessage.Add('[' + Key.FullPath + ']');
                            FInvalidMessage.Add( ValueName + ' - Type ' + freg.DataTypetoDisplayString(RealDatatype) + ' not supported'  );
                            Valuetoadd := '';
                        end
                        else
                            valuetoadd := ValueName + '=' + ValueData;


                        if valuetoadd <> '' then
                        FExportFile.Add(valuetoadd);

                    end;

                end;
                {Add a blank line between each section.}
                fexportFile.add('');
            finally

                ValueNames.free;
            end;
        end;

    end;
end;

procedure TBaseRegExport.Cancel;
begin
    FCancelled := True;
end;

constructor TBaseRegExport.Create;
begin
    inherited;
    FExportFile   := TStringList.Create;
    FExportKeys     := TStringList.Create;
    fReg     := TExtRegistry.Create;
    FInvalidMessage := TStringList.Create;
    FInvalidTypes := false;
end;

destructor TBaseRegExport.Destroy;
begin
    FExportFile.free;
    FExportKeys.free;
    fReg.Free;
    FInvalidMessage.free;
    inherited;

end;

procedure TBaseRegExport.ExportKey(Key: TRegPath; DoSubKeys: Boolean);
var
    subKeys : TStringlist;
    index : integer;
    REg : TExtRegistry;
    RegPath : TRegPath;
begin
    application.processMessages;
    if fCancelled then
        exit;
    subkeys := TStringList.Create;
    try
        Reg := TExtRegistry.Create;
        try
            AddExportKey(Key);
            if DoSubKeys then
            begin
                Reg.RootKey := key.RegHKey;
                if REg.OpenKey(Key.RegSection,false) then
                reg.GetKeyNames(Subkeys);

                for index := 0 to subkeys.count -1 do
                begin
                    RegPath := GetRegSections(StringFromHKey(key.reghkey) + '\' + key.regsection + subkeys[index] + '\');
                    ExportKey(RegPath,DoSubkeys);
                end;
            end;

        finally
            REg.free;
        end;

    finally
        subkeys.free;
    end;


end;

function TBaseRegExport.ExportReg: Boolean;
var
    index : Integer;
    RegP:   TRegPath;
    SubKeys : TStringlist;
begin
        { TODO -oToby -c Features: Place commas between bytes for bin value, add comma at end.
        Remove final \ from key name.  Recurse through children. }
    Result := True;
    subkeys := TStringList.Create;
    try
    for index := 0 to FExportKeys.Count -1 do
    begin

        RegP := GetRegSections(FExportKeys[index]);
        ExportKey(regp, FExportSubKeys );
        if fCancelled then
            break;
    end;
    FExportFile.Insert(0,REGFILE_IDENTIFIER);
    FExportFile.insert(1,'');
    FExportFile.SaveToFile(FFilename);

    if InvalidTypes then
    begin
        Result := False;
        FInvalidMessage.Insert(0,MSG_REG_INVALIDTYPES_FOUND);
    end;

    finally
        SubKeys.Free;
    end;
    if FCancelled then
    begin
        if assigned(FOnCancelled) then
            FOnCancelled(Self);
    end
    else if assigned(FOnFinished) then
        fOnFinished(Self);


    fCancelled := False;
end;

function TBaseRegExport.GetKeyString(   ValueName, ValueData: String;
                                        ValueType: TRegDataType): String;
begin

end;

procedure TBaseRegExport.SetExportKeys(const Value: TStrings);
begin
  FExportKeys.Assign(Value);
end;

procedure TBaseRegExport.SetInvalidMessage(const Value: TStrings);
begin
  FInvalidMessage.Assign( Value);
end;

procedure TBaseRegExport.SetOnCancelled(const Value: TNotifyEvent);
begin
  FOnCancelled := Value;
end;

procedure TBaseRegExport.SetOnFinished(const Value: TNotifyEvent);
begin
  FOnFinished := Value;
end;

end.
