table 50100 "Magento Integration Setup"
{
    Caption = 'Magento Integration Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
            Editable = false;
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
        field(50; "Enable Log"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(60; "Log Directory"; Text[250])
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                TestField("Enable Log");
                if "Log Directory".EndsWith('\') then
                    "Log Directory" := "Log Directory".TrimEnd('\');
            end;
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
