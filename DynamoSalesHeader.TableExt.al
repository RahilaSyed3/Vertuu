tableextension 60001 "Dynamo Sales Header" extends "Sales Header"
{
    fields
    {
        field(60000; "Dynamo Order Status"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dynamo Order Status".Code;
            Caption = 'Order Status';

            trigger OnLookup()
            var
                DynamoOrderStatus: Record "Dynamo Order Status";
            begin
                if DynamoOrderStatus.FindSet() then;

                if Page.RunModal(Page::"Dynamo Order Status", DynamoOrderStatus) = ACtion::LookupOK then
                    "Dynamo Order Status" := DynamoOrderStatus.Code;

                Validate("Dynamo Order Status");
            end;


            trigger OnValidate()
            var
                DynamoSetup: Record "Dynamo Setup";
                EmailMessage: Codeunit "Email Message";
                Email: Codeunit Email;
                EmailNotification: Notification;
                EmailBody: Text;
                Recipients: List of [Text];
            begin
                if DynamoSetup.Get() then
                    if DynamoSetup."Update Users Via Email" then begin
                        if getAssignedUserEmail() <> '' then
                            Recipients.Add(getAssignedUserEmail());
                        if getSalesPersonEmail() <> '' then
                            Recipients.Add(getSalesPersonEmail());

                        EmailBody := '';

                        EmailMessage.Create(Recipients, rec."No." + ' Status Updated to ' + rec."Dynamo Order Status", EmailBody, false);
                        if Email.Send(EmailMessage) then begin
                            EmailNotification.Message('Email Sent to ' + rec."Salesperson Code" + ' And ' + rec."Assigned User ID");
                            EmailNotification.Scope := EmailNotification.Scope::LocalScope;
                            EmailNotification.Send();
                        end;
                    end;
            end;
        }

        field(60001; CustomerRecordId; RecordId)
        {
            DataClassification = CustomerContent;
        }
    }

    local procedure getAssignedUserEmail(): Text
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.Get(Rec."Assigned User ID") then
            exit(UserSetup."E-Mail")
        else
            exit('');
    end;

    local procedure getSalesPersonEmail(): Text
    var
        SalespersonPurchaser: Record "Salesperson/Purchaser";
    begin
        if SalespersonPurchaser.Get(Rec."Salesperson Code") then
            exit(SalespersonPurchaser."E-Mail")
        else
            exit('');
    end;

    trigger OnAfterModify()
    var
        Customer: Record Customer;
    begin
        If Customer.Get("Sell-to Customer No.") then begin
            CustomerRecordId := Customer.RecordId;
            Rec.Modify();
        end;
    end;
}