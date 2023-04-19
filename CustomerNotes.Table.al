table 60002 "Customer Notes"
{
    Caption = 'Customer Notes';


    fields
    {
        field(1; ID; Integer)
        {
        }
        field(2; CustomerNo; Code[20])
        {
            Caption = 'Customer No.';
        }
        field(3; Note; Text[2048])
        {
            Caption = 'Note';
        }
        field(4; NoteFlowField; Text[2048])
        {
            Caption = 'Note';
            FieldClass = FlowField;
            CalcFormula = lookup("Customer Notes".Note where(ID = field(ID)));
        }
    }

    keys
    {
        key(Key1; ID)
        {
            Clustered = true;
        }
    }

}