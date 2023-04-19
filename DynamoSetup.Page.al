page 60000 "Dynamo Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Dynamo Setup";

    layout
    {
        area(Content)
        {
            group(Options)
            {
                Caption = 'Options';

                field("Update Users Via Email";
                Rec."Update Users Via Email")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Whether Email Notification is Sent to Assigned User or Sales Person';
                    Editable = false;
                }
                field("Copy Customer Notes to Orders"; Rec."Copy Customer Notes to Orders")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Whether to Copy Customer Notes to Orders';
                    Editable = true;
                }



            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(SetOrderStatus)
            {
                ApplicationArea = All;
                Caption = 'Set Order Status to Review';
                ToolTip = 'Set the Status to Review for All Orders Missing Status';
                Image = Process;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.SetRange("Dynamo Order Status", '');
                    if SalesHeader.FindSet() then
                        SalesHeader.ModifyAll("Dynamo Order Status", 'Review');
                end;
            }
            action(GenerateCustRecID)
            {
                ApplicationArea = All;
                Caption = 'Generate Customer Record IDs';
                ToolTip = 'Generate Customer Record IDs';
                Image = Process;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    if SalesHeader.FindSet() then
                        repeat
                            SalesHeader.Modify(true);
                        until SalesHeader.Next() = 0;
                end;
            }
        }
    }


    trigger OnOpenPage()
    begin
        if Not Rec.Get() then begin
            Rec.Init();
            Rec.Insert()
        end;
    end;
}