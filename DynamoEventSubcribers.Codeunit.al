codeunit 60000 "Dynamo Event Subcribers"
{

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterOnInsert', '', false, false)]
    local procedure SetOrderStatus(var SalesHeader: Record "Sales Header")
    begin
        if SalesHeader."Document Type" = SalesHeader."Document Type"::Order then
            SalesHeader."Dynamo Order Status" := 'NEW';
    end;

    [EventSubscriber(ObjectType::Table, Database::"Record Link", 'OnAfterInsertEvent', '', false, false)]
    local procedure LinksOnAfterInsertEvent(var Rec: Record "Record Link")
    var
        CustomerNotes: Record "Customer Notes";
        BinaryReader: Codeunit DotNet_BinaryReader;
        Stream: Codeunit DotNet_Stream;
        Istream: InStream;
        Note: Text;
        Data: List of [Text];
    begin
        if Rec.Type = Rec.Type::Note then
            if Format(rec."Record ID").Contains('Customer:') then begin
                Data := Format(Rec."Record ID").Split(':');
                CustomerNotes.Init();
                CustomerNotes.Validate(ID, Rec."Link ID");
                CustomerNotes.Validate(CustomerNo, Data.Get(2));
                Rec.CalcFields(Note);
                Rec.Note.CreateInStream(Istream);
                Stream.FromInStream(Istream);
                BinaryReader.BinaryReader(Stream);
                Note := BinaryReader.ReadString();
                CustomerNotes.Validate(Note, Note);
                CustomerNotes.Insert();
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Record Link", 'OnAfterModifyEvent', '', false, false)]
    local procedure LinksOnAfterModifyEvent(var Rec: Record "Record Link")
    var
        CustomerNotes: Record "Customer Notes";
        BinaryReader: Codeunit DotNet_BinaryReader;
        Stream: Codeunit DotNet_Stream;
        Istream: InStream;
        Note: Text;
    begin
        if Rec.Type = Rec.Type::Note then
            if Format(rec."Record ID").Contains('Customer:') then
                if CustomerNotes.Get(Rec."Link ID") then begin
                    Rec.CalcFields(Note);
                    Rec.Note.CreateInStream(Istream);
                    Stream.FromInStream(Istream);
                    BinaryReader.BinaryReader(Stream);
                    Note := BinaryReader.ReadString();
                    CustomerNotes.Validate(Note, Note);
                    CustomerNotes.Modify();
                end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Record Link", 'OnAfterDeleteEvent', '', false, false)]
    local procedure LinksOnAfterDeleteEvent(var Rec: Record "Record Link")
    var
        CustomerNotes: Record "Customer Notes";
    begin
        if Rec.Type = Rec.Type::Note then
            if Format(rec."Record ID").Contains('Customer:') then
                if CustomerNotes.Get(Rec."Link ID") then
                    CustomerNotes.Delete();

    end;


}