File.Delete("data\\allload\\file.xml", false, false, false, nil);
File.Delete("data\\allload\\file11.xml", false, false, false, nil);
Crypto.BlowfishDecrypt("data\\allload\\data.allload", "data\\allload\\file.xml", "N/A");
StatusDlg.Show(MB_ICONNONE, false);
XML.Load("data\\allload\\file.xml");
codelk = RichText.GetText("code-l1nk", false);
codesp = Crypto.BlowfishEncryptString(codelk, "N/A", 0);
XML.SetValue("allload/xfile/root", codesp, false);
XML.Save("data\\temp\\-temp.xml");
Crypto.BlowfishEncrypt("data\\temp\\-temp.xml", "data\\temp\\-temp.rzr", "N/A");
File.Delete("data\\temp\\-temp.xml", false, false, false, nil);
xname = Dialog.Input("STE", "nombre del archivo:", "", MB_ICONQUESTION);
FTP.Connect("ftp.N/A", "uN/A", "N/A", "", true);
err = Application.GetLastError();
if err ~= FTP.OK then
    Dialog.Message("Error", _tblErrorMessages[err]);
    else
    Dialog.TimedMessage("CONEXIÓN", "Conexión Realizada Exitosamente", 2500, MB_ICONINFORMATION);
end
FTP.ChangeDir("/public_html/N/A");
FTP.MakeDir(xname);
FTP.Upload("data\\temp\\-temp.rzr", xname.."/-temp.allload", nil);
File.Delete("data\\temp\\-temp.rzr", false, false, false, nil);
-- Test for error
error = Application.GetLastError();
if (error ~= 0) then
	Dialog.Message("Error", _tblErrorMessages[error], MB_OK, MB_ICONEXCLAMATION);
end
codelink = Crypto.BlowfishEncryptString(xname, "N/A", 0);
Input.SetText("xcode", codelink);
StatusDlg.Hide();
File.Delete("data\\temp\\test.rzr", false, false, false, nil);
-- display the name, size and date for every folder in the current directory
-- in an AutoPlay Media Studio listbox object named "DirList"
-- (note: the listbox object must already exist on the current page)

-- empty the listbox
ListBox.DeleteItem("ListBox1", LB_ALLITEMS);

tbFolders = FTP.ListFolders();

-- add each item to the listbox in this format:
-- <name> (<size>) (<date>)
for i = 1, tbFolders.Count do
    local name = tbFolders[i].Name;
    local size = tbFolders[i].Size;
    local date = tbFolders[i].Date;

    ListBox.AddItem("ListBox1", name.."("..size.." bytes) ("..date..")", "");
end