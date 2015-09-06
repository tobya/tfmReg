unit FavoritesCollection;

interface

uses Classes, RegFavorites;

type
    TFavoritesCollectionItem = class (TCollectionItem)
     private
        FRegFavorite    : TRegFavoritesFile;
        procedure SetRegFavorite(const Value: TRegFavoritesFile);
     public
      procedure Assign (aSource : TPersistent); override;
     published
        property RegFavorite : TRegFavoritesFile read FRegFavorite write SetRegFavorite;
     end;

     _COLLECTION_ITEM_ = TFavoritesCollectionItem;

     {$INCLUDE TemplateCollectionInterface}

     TFavoritesCollection = _COLLECTION_;

implementation

uses SysUtils;

{$INCLUDE TemplateCollectionImplementation}

procedure TFavoritesCollectionItem.Assign (aSource : TPersistent);
begin
 if aSource is TFavoritesCollectionItem then
 begin
        RegFavorite.assign((aSource as TFavoritesCollectionItem).regfavorite);
 end
 else inherited;
end;

procedure TFavoritesCollectionItem.SetRegFavorite(const Value: TRegFavoritesFile);
begin
  FRegFavorite := Value;
end;

end.
