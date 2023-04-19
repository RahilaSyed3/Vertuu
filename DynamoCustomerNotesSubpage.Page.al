page 60002 "Dynamo Customer Notes Subpage"
{
    PageType = Listpart;
    SourceTable = "Customer Notes";
    InsertAllowed = false;
    DeleteAllowed = false;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(Notes)
            {
                field(CustomerNote; Rec.NoteFlowField)
                {
                    ApplicationArea = All;
                    ToolTip = 'Notes';
                    DrillDownPageId = "Dynamo Customer Note";

                }
            }
        }
    }
}