table 60001 "Dynamo Setup"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[10])
        {
            DataClassification = CustomerContent;

        }
        field(2; "Update Users Via Email"; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = false;

        }
        field(3; "Copy Customer Notes to Orders"; Boolean)
        {
            DataClassification = CustomerContent;
            InitValue = false;
            Editable = false;

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