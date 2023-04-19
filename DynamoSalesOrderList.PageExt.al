pageextension 60001 "Dynamo Sales Order List" extends "Sales Order List"
{
    layout
    {
        addbefore("External Document No.")
        {
            field("Dynamo Order Status"; Rec."Dynamo Order Status")
            {
                ApplicationArea = All;
                ToolTip = 'Order Status';
            }
        }
        addafter(Control1902018507)
        {
            part(CustomerNotes; "Dynamo Customer Notes Subpage")
            {
                Caption = 'Customer Notes';
                ApplicationArea = All;
                UpdatePropagation = SubPart;
                SubPageLink = CustomerNo = field("Sell-to Customer No.");
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
                PromotedCategory = Category8;

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

    // trigger OnAfterGetRecord()
    // var
    //     Customer: Record Customer;
    // begin
    //     if Customer.Get(Rec."Sell-to Customer No.") then begin
    //         CurrPage.CustomerNotes.Page.setCustomerRecordId(Customer.RecordId());
    //         CurrPage.CustomerNotes.Page.Update();
    //     end;
    // end;
}