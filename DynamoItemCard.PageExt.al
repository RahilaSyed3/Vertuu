pageextension 60000 "Dynamo Item Card" extends "Item Card"
{
    layout
    {
        addlast(Item)
        {
            field("Item Url"; Rec."Item Url")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the URL of Item';
            }
        }
    }
}