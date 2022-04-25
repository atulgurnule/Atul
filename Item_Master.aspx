<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Item_Master.aspx.cs" Inherits="StoreApp.Item_Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    
    <%--  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>--%>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            
            Bind_Item_Details();
        });

    </script>

    <script type="text/javascript">
        function clearTextBox() {
            $("#txtitemid").val('');
            $("#txtitem").val('');
            //$("#ddlcategory").val('');
            $("#txtbalqty").val('');
            $("#txtrate").val('');

            $("#btnAdd").attr("onclick", "AddInput('I')");
            $("#btnAdd").attr("value", "Add");

        }
   </script>
    
    <script type="text/javascript">
        function Bind_Item_Details() {
            
            $.ajax({

                type: "POST",
                url: "Item_Master.aspx/BindItems_Master",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    //var datatableVariable = $('#tblMachineDetails').DataTable({
                    //    "responsive": true, "lengthChange": false, "autoWidth": true,
                    //    "buttons": ["excel", "pdf", "print"],
                    //    "bDestroy": true,

                    //    //"lengthMenu": [[5, 25, 50, -1], [5, 25, 50, "All"]],
                    //    data: response.d,
                    //    columns: [

                    //        { "data": "t_mcno", "title": "Machine No." },
                    //        { "data": "t_dsca", "title": "Description" },
                    //        { "data": "t_cwoc", "title": "Work Center" },
                    //        { "data": "t_cwocdesc", "title": "Work Center Description" },
                    //        //{ "data": "t_mcrt", "title": "t_mcrt" },
                    //        //{ "data": "t_mccp", "title": "t_mccp" },
                    //        //{ "data": "t_mdcp", "title": "t_mdcp" },
                    //        { 'data': null, title: 'Edit', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="Bind_Machine_Lines(' + "'" + item.t_mcno + "'" + ')" value="0" class="btn btn-success btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },
                    //        //data-toggle="modal" data-target="#processModal"
                    //        { 'data': null, title: 'Delete', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_mcno + "'" + ')" value="0" class="btn btn-default btn-sm"> <i class="far fa-trash-alt"></i></button></div>' } },

                    //    ]
                    //}).buttons().container().appendTo('#tblMachineDetails_wrapper .col-md-6:eq(0)');
                    
                    var html = '';
                    $.each(response.d, function (key, item) {
                        html += '<tr>';
                        html += '<td>' + item.Item_Id + '</td>';
                        html += '<td>' + item.Item_Name + '</td>';
                        html += '<td>' + item.Category + '</td>';
                        html += '<td>' + item.Rate + '</td>';
                        html += '<td>' + item.Balance_Quantity + '</td>';
                        html += '<td><a href="#" onclick="return getbyID(' + item.Item_Id + ')">Edit</a> | <a href="#" onclick="delete_row(' + item.Item_Id + ')">Delete</a></td>';
                        html += '</tr>';
                    });
                    $('.tbody').html(html);

                }
            });
        };

         function BindItemWise() {
              var txtitemname = document.getElementById("txtitemname").value;
            $.ajax({

                type: "POST",
                url: "Item_Master.aspx/BindItems_Wise",
                data: "{'Item_Name': '" + txtitemname + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                   
                    var html = '';
                    $.each(response.d, function (key, item) {
                        html += '<tr>';
                        html += '<td>' + item.Item_Id + '</td>';
                        html += '<td>' + item.Item_Name + '</td>';
                        html += '<td>' + item.Category + '</td>';
                        html += '<td>' + item.Rate + '</td>';
                        html += '<td>' + item.Balance_Quantity + '</td>';
                        html += '<td><a href="#" onclick="return getbyID(' + item.Item_Id + ')">Edit</a> | <a href="#" onclick="delete_row(' + item.Item_Id + ')">Delete</a></td>';
                        html += '</tr>';
                    });
                    $('.tbody').html(html);

                }
            });
        };
   </script>
    <script type="text/javascript">
        function delete_row(Item_Id) {
            $.ajax(
                {
                    type: "POST",
                    url: "Item_Master.aspx/deleteItemMaster",
                    data: "{'Item_Id': '" + Item_Id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //success: GetLineData_Delete,
                    success: function (response) {
                        Bind_Item_Details();
                        alert('Record deleted successfully');
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
        }   
   </script>
   <script type="text/javascript">

        function getbyID(Item_Id) {
            $.ajax({
                type: "POST",
                url: "Item_Master.aspx/GetItemMaster",
                data: "{'Item_Id': '" + Item_Id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        document.getElementById("txtitemid").value = response.d[0].Item_Id;
                        document.getElementById("txtitem").value = response.d[0].Item_Name;
                        document.getElementById("ddlcategory").value = response.d[0].Category;
                        document.getElementById("txtrate").value = response.d[0].Rate;
                        document.getElementById("txtbalqty").value = response.d[0].Balance_Quantity;

                        $('#txtitem').focus();
                        $("#btnAdd").attr("onclick", "AddInput('U')");
                        $("#btnAdd").attr("value", "Update");
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
            var Item_Id = $("#txtitemid").val();

            $.ajax(
                {
                    type: "POST",
                    url: "Item_Master.aspx/saveItemMaster",
                    data: '{Item_Id: "' + Item_Id + '",Item_Name: "' + document.getElementById('txtitem').value + '",Category: "' + document.getElementById('ddlcategory').value + '",Rate: "' + document.getElementById('txtrate').value + '",Balance_Quantity: "' + document.getElementById('txtbalqty').value + '",t_flag:"' + t_flag + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response.d.toString() === "success") {

                            clearTextBox();
                             $('#txtitem').focus();
                            $("#btnAdd").attr("onclick", "AddInput('I')");
                            $("#btnAdd").attr("value", "Add");
                            //Bind_Input1_Lines(t_tano);
                            Bind_Item_Details();
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
            if ($('#txtitem').val() == "") {
                $('#txtitem').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#txtitem').css('border-color', 'lightgrey');
            }

            if ($('#txtrate').val() == "") {
                $('#txtrate').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#txtrate').css('border-color', 'lightgrey');
            }

            if ($('#txtbalqty').val() == "") {
                $('#txtbalqty').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#txtbalqty').css('border-color', 'lightgrey');
            }

             if ($('#ddlcategory option:selected').text() == "Select") {
                $('#ddlcategory').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#ddlcategory').css('border-color', 'lightgrey');
            }

            return isValid;
        }

    </script>

    <div class="container">
        <h2>Item Master</h2>
        <%-- <div class="form-horizontal">--%>
        <div class="form-group">
            
            <input type="hidden" class="form-control" id="txtitemid" placeholder="Enter Item Id" name="Item">
        </div>
        <div class="form-group">
            <label for="email">Item Name:</label>
            <input type="text" class="form-control" id="txtitem" placeholder="Enter Item Name" name="Item">
        </div>
        <div class="form-group">
            <label for="category">Category:</label>
            <select name="category" class="form-control" id="ddlcategory">
                <option value="0">Select</option>
                <option value="1">Electronics</option>
                <option value="2">Consumable</option>
                <option value="3">Furniture</option>
                <option value="4">Stationary</option>
            </select>
        </div>
        <div class="form-group">
            <label for="pwd">Rate:</label>
            <input type="number" class="form-control" id="txtrate" placeholder="Enter Balance Quantity" name="BalQty">
        </div>
        <div class="form-group">
            <label for="pwd">Balance Quantity:</label>
            <input type="number" class="form-control" id="txtbalqty" placeholder="Enter Balance Quantity" name="BalQty">
        </div>

        <input type="button" class="btn btn-warning" onclick="AddInput('I')" id="btnAdd" value="Save" />
        <button type="button" class="btn btn-secondary" onclick="clearTextBox();">New</button>
    </div>
    <%--</div>--%>
    <div class="container">
        <h3>Item Master Details</h3>
        <div class="form-group">
            <label for="item" id="lblitem">Enter Item Name</label>
            <input type="text" class="form-control" id="txtitemname" placeholder="Enter Item" name="item" onchange="BindItemWise();"/ >
        </div>
        <table class="table table-responsive" id="tblitem">
            <thead>
                <tr>
                    <th>Item Id</th>
                    <th>Item Name</th>
                    <th>Category</th>
                    <th>Rate</th>
                    <th>Balance_Quantity</th>
                </tr>
            </thead>
            <tbody class="tbody">
            </tbody>
        </table>
    </div>

    <%--<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>--%>
    <script src="Scripts/jquery-3.3.1.min.js"></script>

    <%-- <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>--%>
</asp:Content>
