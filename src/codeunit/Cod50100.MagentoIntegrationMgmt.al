codeunit 50100 "Magento Integration Mgmt."
{
    var
        MagentoIntegrationSetup: Record "Magento Integration Setup";
        TempBlobReq: Record TempBlob;
        TempBlobRes: Record TempBlob;
        FileManagement: Codeunit "File Management";
        MyxmlWriter: DotNet MyXmlWriter;
        MyXmlWriterSettings: DotNet MyXmlWriterSettings;
        MyReader: DotNet MyReader;
        MyXmlNamespaceMgr: DotNet MyXmlNamespaceMgr;
        MyXmlDocument: DotNet MyXmlDocument;
        MyXmlNode: DotNet MyXmlNode;
        MyTxtEncoding: DotNet MyTxtEncoding;
        SessionID: Text;
        MagentoSetupOK: Boolean;
        ReqBodyOutStream: OutStream;
        ResBodyOutStream: OutStream;
        RespBodyOutStream: InStream;
        MagentoValidationErrorTxt: Label 'Magento Integration Setup Validation Error. Please check Url, Username and Password.';

    trigger OnRun()
    begin
        Login();
    end;

    procedure Login()
    begin
        if not GetAndValidateMagentoIntegrationSetup() then
            Error(MagentoValidationErrorTxt);
        InitMagentoSession();
        InitializeWebRequest();

        MyxmlWriter.WriteStartElement('soapenv', 'Envelope', 'http://schemas.xmlsoap.org/soap/envelope/');
        MyxmlWriter.WriteAttributeString('xmlns', 'xsi', '', 'http://www.w3.org/2001/XMLSchema-instance');
        MyxmlWriter.WriteAttributeString('xmlns', 'xsd', '', 'http://www.w3.org/2001/XMLSchema');
        MyxmlWriter.WriteAttributeString('xmlns', 'urn', '', 'urn:Magento');
        MyxmlWriter.WriteStartElement('soapenv', 'Header', 'http://schemas.xmlsoap.org/soap/envelope/');
        MyxmlWriter.WriteStartElement('soapenv', 'Body', 'http://schemas.xmlsoap.org/soap/envelope/');
        MyxmlWriter.WriteStartElement('urn', 'login', 'urn:Magento');
        MyxmlWriter.WriteElementString('username', MagentoIntegrationSetup.Username);
        MyxmlWriter.WriteElementString('apiKey', MagentoIntegrationSetup.Password);
        MyxmlWriter.WriteEndElement(); //login
        MyxmlWriter.WriteEndElement(); //Body
        MyxmlWriter.WriteEndElement(); //Header
        MyxmlWriter.WriteEndElement(); //Envelope
    end;

    procedure GetMagentoOrder()
    var

    begin

    end;

    procedure ShipMagentoOrder()
    var

    begin

    end;

    procedure InvoiceMagentoOrder()
    var

    begin

    end;

    local procedure InitMagentoSession()

    begin
        SessionID := '';
    end;

    local procedure GetAndValidateMagentoIntegrationSetup(): Boolean

    begin
        if not MagentoSetupOK then begin
            if not MagentoIntegrationSetup.Get() then
                exit(false);
            if (MagentoIntegrationSetup.Url = '') or
            (MagentoIntegrationSetup.Username = '') or
            (MagentoIntegrationSetup.Password = '')
            then
                exit(false);
            MagentoSetupOK := true;
            exit(true);
        end;
        exit(true);
    end;

    local procedure InitializeWebRequest()
    begin
        Clear(MyxmlWriter);
        Clear(MyXmlWriterSettings);
        Clear(ReqBodyOutStream);
        Clear(RespBodyOutStream);
        Clear(ReqBodyOutStream);

        TempBlobReq.Reset();
        TempBlobReq.DeleteAll();
        TempBlobReq.Init();
        TempBlobReq.Blob.CreateOutStream(ReqBodyOutStream);

        MyXmlWriterSettings := MyXmlWriterSettings.XmlWriterSettings();
        MyXmlWriterSettings.Encoding := MyTxtEncoding.UTF8();
        MyXmlWriterSettings.Indent := true;

        MyxmlWriter := MyxmlWriter.Create(ReqBodyOutStream, MyXmlWriterSettings);
    end;

    local procedure FinalizeWebRequest(pAction: Text)

    begin
        GetAndValidateMagentoIntegrationSetup();
        MyxmlWriter.Close();
        MyXmlDocument := MyXmlDocument.XmlDocument();
        MyXmlDocument.Load(ReqBodyOutStream);
        if (MagentoIntegrationSetup."Enable Log") and (MagentoIntegrationSetup."Log Directory" <> '') then
            MyXmlDocument.Save(MagentoIntegrationSetup."Log Directory" + '\' + FileManagement.StripNotsupportChrInFileName(pAction + '_Req_' + Format(CurrentDateTime(), 0, 9) + '.xml'));
    end;
}

dotnet
{
    assembly(System.Xml)
    {
        type(System.Xml.XmlWriter; MyXmlWriter) { }
        type(System.Xml.XmlWriterSettings; MyXmlWriterSettings) { }
        type(System.Xml.XmlTextReader; MyReader) { }
        type(System.Xml.XmlNamespaceManager; MyXmlNamespaceMgr) { }
        type(System.Xml.XmlDocument; MyXmlDocument) { }
        type(System.Xml.XmlNode; MyXmlNode) { }
    }
    assembly(mscorlib)
    {
        type(System.Text.Encoding; MyTxtEncoding) { }
    }
}
