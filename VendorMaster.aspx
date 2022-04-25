<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VendorMaster.aspx.cs" Inherits="StoreApp.VendorMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>
     <script type="text/javascript">
        $(document).ready(function () {
            
            Bind_Vendor_Details();
        });

    </script>

    <script type="text/javascript">
        function clearTextBox() {
            $("#txtvendorid").val('');
            $("#txtvendorname").val('');
           
            $("#btnAdd").attr("onclick", "AddInput('I')");
            $("#btnAdd").attr("value", "Add");

        }
   </script>
    <script type="text/javascript">
        function Bind_Vendor_Details() {
            
            $.ajax({

                type: "POST",
                url: "VendorMaster.aspx/BindVendor_Master",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    
                    var html = '';
                    $.each(response.d, function (key, item) {
                        html += '<tr>';
                        html += '<td>' + item.Vendor_id + '</td>';
                        html += '<td>' + item.Vendor_name + '</td>';
                        html += '<td><a href="#" onclick="return getbyID(' + item.Vendor_id + ')">Edit</a> | <a href="#" onclick="delete_row(' + item.Vendor_id + ')">Delete</a></td>';
                        html += '</tr>';
                    });
                    $('.tbody').html(html);

                }
            });
        };

        function BindVendorWise() {
            debugger
             var txtvendor = document.getElementById("txtvendor").value;
            if(txtvendor != "") {
                $.ajax({

                    type: "POST",
                    url: "VendorMaster.aspx/BindVendor_Wise",
                    data: "{'Vendor_name': '" + txtvendor + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        var html = '';
                        $.each(response.d, function (key, item) {
                            html += '<tr>';
                            html += '<td>' + item.Vendor_id + '</td>';
                            html += '<td>' + item.Vendor_name + '</td>';
                            html += '<td><a href="#" onclick="return getbyID(' + item.Vendor_id + ')">Edit</a> | <a href="#" onclick="delete_row(' + item.Vendor_id + ')">Delete</a></td>';
                            html += '</tr>';
                        });
                        $('.tbody').html(html);

                    }
                });
            }
        };
   </script>
    <script type="text/javascript">
        function delete_row(Vendor_id) {
            $.ajax(
                {
                    type: "POST",
                    url: "VendorMaster.aspx/deleteVendorMaster",
                    data: "{'Vendor_id': '" + Vendor_id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //success: GetLineData_Delete,
                    success: function (response) {
                        Bind_Vendor_Details();
                        alert('Record deleted successfully');
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });

        }  
   </script>

    <script type="text/javascript">

        function getbyID(Vendor_id) {
            $.ajax({
                type: "POST",
                url: "VendorMaster.aspx/GetVendorMaster",

                data: "{'Vendor_id': " + Vendor_id + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        document.getElementById("txtvendorid").value = response.d[0].Vendor_id;
                        document.getElementById("txtvendorname").value = response.d[0].Vendor_name;
                       
                        $('#txtvendorname').focus();
                        $("#btnAdd").attr("onclick", "AddInput('U')");
                        $("#btnAdd").attr("value", "Update");
                    }
                    else {
                        //$('#lblt_ofbp').html('no datafound');
                    }
                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
    </script>
    <script type="text/javascript">
        function AddInput(t_flag) {

            var res = validate();
            if (res == false) {
                return false;
            }
            var Vendor_id = $("#txtvendorid").val();

            $.ajax(
                {
                    type: "POST",
                    url: "VendorMaster.aspx/savevendorMaster",
                    data: '{Vendor_id: "' + Vendor_id + '",Vendor_name: "' + document.getElementById('txtvendorname').value + '",t_flag:"' + t_flag + '"}',
                    //,t_cwoc: "' + document.getElementById('t_cwoc').value + '",t_mcrt: "' + document.getElementById('t_mcrt').value + '",t_mccp: "' + document.getElementById('t_mccp').value + '",t_mdcp: "' + document.getElementById('t_mdcp').value + '"
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    ////success: GetLineData,
                    success: function (response) {

                        if (response.d.toString() === "success") {

                            clearTextBox();

                            $('#txtvendorname').focus();
                            $("#btnAdd").attr("onclick", "AddInput('I')");
                            $("#btnAdd").attr("value", "Add");
                            //Bind_Input1_Lines(t_tano);
                            Bind_Vendor_Details();
                            alert('Record added successfully');
                        }
                        else {
                            alert(response.d.toString());

                        }
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
        }

        function validate() {

            var isValid = true;
            if ($('#txtvendorname').val() == "") {
                $('#txtvendorname').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#txtvendorname').css('border-color', 'lightgrey');
            }

            return isValid;
        }
    </script>
    <div class="container">
        <h2>Vendor Master</h2>
       
        <input type="hidden" class="form-control" id="txtvendorid" placeholder="Enter Vendor Id" name="vendor">
            <div class="form-group">
                <label for="email">Vendor Name:</label>
                <input type="text" class="form-control" id="txtvendorname" placeholder="Enter Vendor Name" name="Item">
            </div>
           
            <input type="button" class="btn btn-warning" onclick="AddInput('I')" id="btnAdd" value="Save" />
            <button type="button" class="btn btn-secondary" onclick="clearTextBox();">New</button>
        </div>
    
    <div class="container">
        <h2>Vendor Details</h2>
       <div class="form-group">
            <label for="item" id="lblitem">Enter Vendor Name</label>
            <input type="text" class="form-control" id="txtvendor" placeholder="Enter Vendor" name="vendor" onchange="BindVendorWise();"/ >
        </div>
        <table class="table table-responsive" id="tbldept">
          <thead>
                <tr>
                    <th>Vendor Id</th>
                    <th>Vendor Name</th>
                    
                </tr>
            </thead>
            <tbody class="tbody">
            </tbody>
        </table>
    </div>

</asp:Content>
