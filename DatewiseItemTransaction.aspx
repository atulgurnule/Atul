<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DatewiseItemTransaction.aspx.cs" Inherits="StoreApp.DatewiseItemTransaction" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.3500.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
  
    <div class="container">
        .
        <h2>Item Transaction</h2>
        <label>From Date</label>
        <asp:TextBox ID="txtfromdate" type="Date" runat="server"></asp:TextBox>

        <label>To Date</label>
        <asp:TextBox ID="txttodate" type="Date" runat="server"></asp:TextBox>
        <div class="card-footer">
            <asp:Button ID="btnView" runat="server" Text="View" OnClick="btnView_Click" />
        </div>
        <CR:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true" />
    </div>
   
</asp:Content>


