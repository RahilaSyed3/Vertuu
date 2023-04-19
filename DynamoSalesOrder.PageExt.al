pageextension 60002 "Dynamo Sales Order" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("Dynamo Order Status"; Rec."Dynamo Order Status")
            {
                ApplicationArea = All;
                ToolTip = 'Sales Order Status';
            }
        }
        addafter(Control1902018507)
        {
            part(CustomerNotes; "Dynamo Customer Notes Subpage")
            {
                Caption = 'Customer Notes';
                SubPageLink = CustomerNo = field("Sell-to Customer No.");
                ApplicationArea = All;
                UpdatePropagation = SubPart;
            }
        }
    }

    actions
    {
        addafter("Print Confirmation")
        {
            action(PrintSimple)
            {
                ApplicationArea = All;
                Caption = 'Print Simple Confirmation';
                ToolTip = 'Prints the Sales Order without images';
                Image = PrintReport;
                PromotedIsBig = true;
                Promoted = true;
                PromotedCategory = Category11;

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                begin
                    SalesHeader.Reset();
                    SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
                    SalesHeader.SetRange("No.", rec."No.");
                    Report.RunModal(Report::"Dynamo Sales - Order Simple", true, true, SalesHeader);
                end;
            }
        }
    }
}