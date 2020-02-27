table 50100 "Magento Integration Setup"
{
    Caption = 'Magento Integration Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
            end;
        }
        field(20; Username; Text[250])
        {
            Caption = 'Username';
            DataClassification = CustomerContent;
        }
        field(30; Password; Text[250])
        {
            Caption = 'Password';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }
        field(40; Url; Text[250])
        {
            Caption = 'Url';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }

    }
}
