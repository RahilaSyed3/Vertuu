table 60000 "Dynamo Order Status"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
        }
        field(2; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}