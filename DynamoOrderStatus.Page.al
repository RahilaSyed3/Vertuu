page 60001 "Dynamo Order Status"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Dynamo Order Status";
    Caption = 'Order Status';

    layout
    {
        area(Content)
        {
            repeater(Data)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Code';

                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';

                }
            }
        }
    }
}