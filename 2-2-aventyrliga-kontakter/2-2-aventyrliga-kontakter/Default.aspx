<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="_2_2_aventyrliga_kontakter.Default" ViewStateMode="Disabled" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="Css/Style.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <h1>
                Kunder
            </h1>

        <asp:ValidationSummary ID="ValidationResults" runat="server" HeaderText="Ett fel har inträffat. Korrigera felet och försök igen."/>

         <asp:PlaceHolder ID="SuccessPlaceHolder" runat="server" Visible="false">
         <div id="BorderSuccesBox">
             <div id="SuccesBox">
                 <asp:Label ID="SuccessLabel" runat="server" ></asp:Label>
                 <a href="#" id="Esc">X</a>     
             </div>
         </div>
        </asp:PlaceHolder> 

            <asp:ListView ID="ContactListView" runat="server"
                ItemType="_2_2_aventyrliga_kontakter.Model.Contact"
                SelectMethod="GetContactsPageWise"
                DataKeyNames="ContactID" 
                InsertMethod="ContactListView_InsertItem"
                UpdateMethod="ContactListView_UpdateItem"
                DeleteMethod="DeleteContact"
                InsertItemPosition="FirstItem">
                <LayoutTemplate>
                    <table>
                        <tr>
                            <th>
                                Förnamn
                            </th>
                            <th>
                                Efternamn
                            </th>
                            <th>
                                Email
                            </th>
                        </tr>
                        <%-- Platshållare för nya rader --%>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                    </table>
                    <asp:DataPager ID="DataPager1" runat="server" PageSize="20">
                        <Fields>
                            <asp:NextPreviousPagerField ShowFirstPageButton="true" FirstPageText=" << Första Sidan"
                                ShowNextPageButton="false" ShowPreviousPageButton="false" />
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField ShowLastPageButton="true" LastPageText="Sista Sidan >>"
                                ShowNextPageButton="false" ShowPreviousPageButton="false" />
                        </Fields>
                    </asp:DataPager>
                </LayoutTemplate>
                <ItemTemplate>
                    <%-- Mall för nya rader. --%>
                    <tr>
                        <td>
                            <asp:Label ID="FirstNameLabel" runat="server" Text='<%#: Item.FirstName %>' />
                        </td>
                        <td>
                            <asp:Label ID="LastNameLabel" runat="server" Text='<%#: Item.LastName %>' />
                        </td>
                        <td>
                            <asp:Label ID="EmailLabel" runat="server" Text='<%#: Item.EmailAddress %>' />
                        </td>
                        <td class="command">
                            <%-- "Kommandknappar" för att ta bort och redigera kontaktuppgifter --%>
                            <asp:LinkButton ID="EditLinkButton" runat="server" CommandName="Edit" Text="Redigera" CausesValidation="false" />
                            <asp:LinkButton ID="DeleteLinkButton" runat="server" CommandName="Delete" Text="Ta bort" CausesValidation="false" 
                                OnClientClick='<%# String.Format("return confirm(\"Är du säker att du vill ta bort {0} {1}?\")", Item.FirstName, Item.LastName) %>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <%-- Detta visas då kunduppgifter saknas i databasen. --%>
                    <p>
                        Kunduppgifter saknas.
                    </p>
                </EmptyDataTemplate>
                
                 <InsertItemTemplate>
                    <%-- Mall för rad i tabellen för att lägga till nya kontaktuppgifter --%>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstName" runat="server" Text='<%# BindItem.FirstName %>' MaxLength="50" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ErrorMessage="Fältet får inte vara tomt!"
                                ControlToValidate="FirstName"
                                Display="None"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastName" runat="server" Text='<%# BindItem.LastName %>' MaxLength="50" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ErrorMessage="Fältet får inte vara tomt!"
                                ControlToValidate="LastName"
                                Display="None"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddress" runat="server" Text='<%# BindItem.EmailAddress %>' MaxLength="50" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                ErrorMessage="Fältet får inte vara tomt!"
                                ControlToValidate="EmailAddress"
                                Display="None"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                ErrorMessage="Emailaddressen är inte giltig!"
                                ControlToValidate="EmailAddress"
                                Display="None"
                                ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"
                                ></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <%-- "Kommandknappar" för att lägga till en ny kontaktuppgift och rensa texfälten --%>
                            <asp:LinkButton ID="LinkButton3" runat="server" CommandName="Insert" Text="Lägg till" />
                            <asp:LinkButton ID="LinkButton4" runat="server" CommandName="Cancel" Text="Rensa" CausesValidation="false" />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <EditItemTemplate>
                    <%-- Mall för rad i tabellen för att redigera kontaktuppgifter. --%>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstName1" runat="server" Text='<%# BindItem.FirstName %>' />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                                ErrorMessage="Fältet får inte vara tomt!"
                                ControlToValidate="FirstName1"
                                Display="None"
                                ValidationGroup="Validations"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastName1" runat="server" Text='<%# BindItem.LastName %>' />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                ErrorMessage="Fältet får inte vara tomt!"
                                ControlToValidate="LastName1"
                                Display="None"
                                ValidationGroup="Validations"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddress1" runat="server" Text='<%# BindItem.EmailAddress %>' />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server"
                                ErrorMessage="Fältet får inte vara tomt!"
                                ControlToValidate="EmailAddress1"
                                Display="None"
                                ValidationGroup="Validations"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                ErrorMessage="Mailaddressen är inte giltig!"
                                ControlToValidate="EmailAddress1"
                                Display="None"
                                ValidationExpression="^([\w\.\-]+)@([\w\-]+)((\.(\w){2,3})+)$"
                                ValidationGroup="Validations"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <%-- "Kommandknappar" för att uppdatera en kunduppgift och avbryta --%>
                            <asp:LinkButton ID="LinkButton5" runat="server" CommandName="Update" Text="Spara" />
                            <asp:LinkButton ID="LinkButton6" runat="server" CommandName="Cancel" Text="Avbryt" CausesValidation="false" />
                        </td>
                    </tr>
                </EditItemTemplate>
            </asp:ListView>
    </div>
    </form>
    <script src='<%= ResolveClientUrl("/Script/Script.js") %>' type="text/javascript"></script>
</body>
</html>
