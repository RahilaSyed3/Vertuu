page 60003 "Dynamo Customer Note"
{
    PageType = Card;
    SourceTable = "Customer Notes";
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                ShowCaption = false;
                field(Note; Rec.Note)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Note';
                    ToolTip = 'Note';
                }
            }
        }
    }
}