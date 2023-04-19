report 60005 "Update Customer Notes"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(CustomerDataItem; Customer)
        {
            trigger OnPreDataItem()
            var
                CustomerNotes: Record "Customer Notes";
            begin
                if CustomerNotes.FindSet() then;
                CustomerNotes.DeleteAll();
            end;

            trigger OnAfterGetRecord()
            var
                RecordLinks: Record "Record Link";
                CustomerNotes: Record "Customer Notes";
                BinaryReader: Codeunit DotNet_BinaryReader;
                Stream: Codeunit DotNet_Stream;
                Note: Text;
                Istream: InStream;
                Data: List of [Text];

            begin
                RecordLinks.SetRange("Record ID", CustomerDataItem.RecordId());
                if RecordLinks.FindSet() then
                    repeat
                        if RecordLinks.Type = RecordLinks.Type::Note then begin
                            Data := Format(RecordLinks."Record ID").Split(':');
                            RecordLinks.CalcFields(Note);
                            CustomerNotes.Init();
                            CustomerNotes.Validate(ID, RecordLinks."Link ID");
                            CustomerNotes.Validate(CustomerNo, Data.Get(2));
                            RecordLinks.Note.CreateInStream(Istream);
                            Stream.FromInStream(Istream);
                            BinaryReader.BinaryReader(Stream);
                            Note := BinaryReader.ReadString();
                            CustomerNotes.Validate(Note, Note);
                            CustomerNotes.Insert();
                        end;
                    Until RecordLinks.Next() = 0;
            end;
        }
    }
}