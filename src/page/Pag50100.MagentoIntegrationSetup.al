page 50100 "Magento Integration Setup"
{

    PageType = Card;
    SourceTable = "Magento Integration Setup";
    Caption = 'Magento Integration Setup';
    UsageCategory = Administration;
    ApplicationArea = All;
    AdditionalSearchTerms = 'Web Service';

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Username; Username)
                {
                    ApplicationArea = All;
                }
                field(Password; Password)
                {
                    ApplicationArea = All;
                }
                field(Url; Url)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;
    end;

}
