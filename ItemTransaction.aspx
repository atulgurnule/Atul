<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ItemTransaction.aspx.cs" Inherits="StoreApp.ItemTransaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            debugger
            Bind_Item_Transaction();
            GetItemDetails();
            GetDeptDetails();
            GetVendorDetails();

            $("#rdoissue").click(function () {

                $("input[type=radio][name=radiopurchase]").prop('checked', false);

            });

            $("#rdopur").click(function () {

                $("input[type=radio][name=radioissue]").prop('checked', false);
            });

        });

    </script>



    <script type="text/javascript">
        function clearTextBox() {
            $("#txttranId").val('');
            $("#txtqty").val('');
            $("#lblbalQty").html('');
            $('#lblText').css('display', 'none');
            $("#btnAdd").attr("onclick", "AddInput('I')");
            $("#btnAdd").attr("value", "Add");

            GetItemDetails();
            GetDeptDetails();
            GetVendorDetails();

        }
   </script>

    <script type="text/javascript">
        function Bind_Item_Transaction() {

            $.ajax({

                type: "POST",
                url: "ItemTransaction.aspx/BindItems_Transaction",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var html = '';
                    $.each(response.d, function (key, item) {
                        html += '<tr>';
                        html += '<td>' + item.Transaction_id + '</td>';
                        html += '<td>' + item.Item_Name + '</td>';
                        html += '<td>' + item.Transaction_date + '</td>';
                        html += '<td>' + item.Department_name + '</td>';
                        html += '<td>' + item.Vendor_name + '</td>';
                        html += '<td>' + item.Quantity + '</td>';
                        html += '<td><a href="#" onclick="return getbyID(' + item.Transaction_id + ')">Edit</a> | <a href="#" onclick="delete_row(' + item.Transaction_id + ')">Delete</a></td>';
                        html += '</tr>';
                    });
                    $('.tbody').html(html);

                }
            });
        };
   </script>

    <script type="text/javascript">
        function BindItemWise() {
            var Item_Name = document.getElementById("txtItemname").value;
            debugger
            if (Item_Name !== "") {
 
            $.ajax({

                type: "POST",
                url: "ItemTransaction.aspx/BindItemnameWise",
                data: "{'Item_Name': '" + Item_Name + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {

                    var html = '';
                    $.each(response.d, function (key, item) {
                        html += '<tr>';
                        html += '<td>' + item.Transaction_id + '</td>';
                        html += '<td>' + item.Item_Name + '</td>';
                        html += '<td>' + item.Transaction_date + '</td>';
                        html += '<td>' + item.Department_name + '</td>';
                        html += '<td>' + item.Vendor_name + '</td>';
                        html += '<td>' + item.Quantity + '</td>';
                        html += '<td><a href="#" onclick="return getbyID(' + item.Transaction_id + ')">Edit</a> | <a href="#" onclick="delete_row(' + item.Transaction_id + ')">Delete</a></td>';
                        html += '</tr>';
                    });
                    $('.tbody').html(html);

                }
                });

            }
        };
   </script>

    <script type="text/javascript">
        function delete_row(Transaction_id) {
            $.ajax(
                {
                    type: "POST",
                    url: "ItemTransaction.aspx/deleteItemTransaction",
                    data: "{'Item_Id': '" + Transaction_id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //success: GetLineData_Delete,
                    success: function (response) {
                        Bind_Item_Transaction();
                        alert('Record deleted successfully');
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });

        }

   </script>

    <script type="text/javascript">

        function getbyID(Transaction_id) {

            $.ajax({
                type: "POST",
                url: "ItemTransaction.aspx/GetItemTrasaction",

                data: "{'Transaction_id': '" + Transaction_id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    debugger
                    if (response.d != '') {
                        document.getElementById("txttranId").value = response.d[0].Transaction_id;
                        document.getElementById("ddlItem").value = response.d[0].Item_id;
                        document.getElementById("ddlDept").value = response.d[0].Department_Id;
                        document.getElementById("ddlVendor").value = response.d[0].Vendor_id;
                        document.getElementById("txtqty").value = response.d[0].Quantity;

                        $('#ddlItem').focus();
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

        function GetItemBalQty() {
            var Item_Id = document.getElementById("ddlItem").value;
            debugger
            if (Item_Id != 0) {
                $.ajax({
                    type: "POST",
                    url: "ItemTransaction.aspx/GetItemBalQty",
                    data: "{'Item_Id': '" + Item_Id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {

                        if (response.d != '') {
                            $('#lblbalQty').html(response.d[0].Balance_Quantity);
                            $("#lblText").css('display', 'block');
                            $("#lblbalQty").css('display', 'block');

                            $('#ddlItem').focus();

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
            else {
                debugger
                $("#lblText").css('display', 'none');
                $("#lblbalQty").css('display', 'none');
            }
        }

    </script>
    <script type="text/javascript">
        function AddInput(t_flag) {
            debugger
            var Transtype = '';
            var quantity = "";
            let availbalqty = $("#lblbalQty").html();

            let transqty = document.getElementById('txtqty').value;

            if (document.getElementById('rdoissue').checked == true) {
                Transtype = 1;
                //quantity = availbalqty - transqty;
                if (availbalqty == 0 && document.getElementById('rdoissue').checked == true) {
                    alert("Items unavailability in inventory stock, You can't issue item to department");
                }
                else if (transqty == 0 || transqty=='' || transqty < 0) {
                    alert("You have entered 0 quantity, You can't issue item to department");
                }
                else if (parseFloat(availbalqty) < parseFloat(transqty)) {
                    alert("Available quantity is less than transaction quantity.");
                }
                else {
                    var res = validate();
                    if (res == false) {
                        return false;
                    }
                    var txttranId = $("#txttranId").val();
                    $.ajax(
                        {
                            type: "POST",
                            url: "ItemTransaction.aspx/saveItemTransaction",
                            data: '{Transaction_id: "' + txttranId + '",Item_Id: "' + document.getElementById('ddlItem').value + '",Department_Id: "' + document.getElementById('ddlDept').value + '",Vendor_id : "' + document.getElementById('ddlVendor').value + '",Quantity: "' + document.getElementById('txtqty').value + '",Transtype:"' + Transtype + '",t_flag:"' + t_flag + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            ////success: GetLineData,
                            success: function (response) {
                                debugger
                                if (response.d.toString() === "success") {

                                    clearTextBox();

                                    $('#ddlItem').focus();
                                    $("#btnAdd").attr("onclick", "AddInput('I')");
                                    $("#btnAdd").attr("value", "Add");
                                    Bind_Item_Transaction();

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
            }


            if (document.getElementById('rdopur').checked == true) {
                Transtype = 2;
                let transqty = document.getElementById('txtqty').value;
                if (transqty == 0 || transqty=='' || transqty < 0) {
                    alert("You have entered 0 quantity, You can't purchase item to departmesnt");
                }
                else {
                    //quantity = availbalqty + transqty;
                    var res = validate();
                    if (res == false) {
                        return false;
                    }
                    var txttranId = $("#txttranId").val();

                    $.ajax(
                        {
                            type: "POST",
                            url: "ItemTransaction.aspx/saveItemTransaction",
                            data: '{Transaction_id: "' + txttranId + '",Item_Id: "' + document.getElementById('ddlItem').value + '",Department_Id: "' + document.getElementById('ddlDept').value + '",Vendor_id : "' + document.getElementById('ddlVendor').value + '",Quantity: "' + document.getElementById('txtqty').value + '",Transtype:"' + Transtype + '",t_flag:"' + t_flag + '"}',
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            ////success: GetLineData,
                            success: function (response) {
                                debugger
                                if (response.d.toString() === "success") {

                                    clearTextBox();

                                    $('#ddlItem').focus();
                                    $("#btnAdd").attr("onclick", "AddInput('I')");
                                    $("#btnAdd").attr("value", "Add");
                                    Bind_Item_Transaction();

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
            }

        }

        function validate() {

            var isValid = true;
            if ($('#txtqty').val() == "") {
                $('#txtqty').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#txtqty').css('border-color', 'lightgrey');
            }

            //if ($('#ddlItem').val() == "") {
            if ($("#ddlItem option:selected").text() == "--Select--") {
                $('#ddlItem').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#ddlItem').css('border-color', 'lightgrey');
            }

            //if ($('#ddlItem').val() == "") {
            if ($("#ddlDept option:selected").text() == "--Select--") {
                $('#ddlDept').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#ddlDept').css('border-color', 'lightgrey');
            }

            if ($("#ddlVendor option:selected").text() == "--Select--") {
                $('#ddlVendor').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#ddlVendor').css('border-color', 'lightgrey');
            }
            return isValid;
        }


    </script>

    <script type="text/javascript">
        function GetItemDetails() {
            //Add Item
            debugger
            $.ajax({
                type: "POST",
                url: "ItemTransaction.aspx/GetItem",
                //data: '{t_cbrn :"' + t_cbrn + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response != null) {

                        $("#ddlItem").empty();
                        //$("#t_prod").append($("<option></option>").val("0").html("Select Shift"));

                        var ddlItem = $("#ddlItem");
                        ddlItem.empty().append('<option selected="selected" value="0">--Select--</option>');
                        $.each(response.d, function () {
                            ddlItem.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }

                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function GetDeptDetails() {
            //Add Item
            $.ajax({
                type: "POST",
                url: "ItemTransaction.aspx/GetDept",
                //data: '{t_cbrn :"' + t_cbrn + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response != null) {

                        $("#ddlDept").empty();
                        //$("#t_prod").append($("<option></option>").val("0").html("Select Shift"));

                        var ddlDept = $("#ddlDept");
                        ddlDept.empty().append('<option selected="selected" value="0">--Select--</option>');
                        $.each(response.d, function () {
                            ddlDept.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }

                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }

        function GetVendorDetails() {
            //Add Item
            $.ajax({
                type: "POST",
                url: "ItemTransaction.aspx/GetVendor",
                //data: '{t_cbrn :"' + t_cbrn + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response != null) {

                        $("#ddlVendor").empty();
                        //$("#t_prod").append($("<option></option>").val("0").html("Select Shift"));

                        var ddlVendor = $("#ddlVendor");
                        ddlVendor.empty().append('<option selected="selected" value="0">--Select--</option>');
                        $.each(response.d, function () {
                            ddlVendor.append($("<option></option>").val(this['Value']).html(this['Text']));
                        });
                    }

                },
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
    </script>

    <div class="container">
        .
        <h2>Item Transaction</h2>
        <input type="hidden" class="form-control" id="txttranId" placeholder="Trasaction id" name="tranId">
        <div class="form-group">
            <label class="radio-inline">
                <input type="radio" name="radioissue" checked id="rdoissue">Issue
            </label>
            <label class="radio-inline">
                <input type="radio" name="radiopurchase" id="rdopur">Purchase
            </label>
        </div>

        <div class="form-group">
            <label for="item">Select Item</label>
            <select class="form-control" onclick="GetItemBalQty();" id="ddlItem">
            </select>

        </div>
        <div class="form-group">
            <label for="item" id="lblText" style="display: none;">Balance Quantity</label>
            <label for="item" id="lblbalQty" style="display: none;"></label>
        </div>

        <div class="form-group">
            <label for="item">Select Department</label>
            <select class="form-control" id="ddlDept">
            </select>
        </div>
        <div class="form-group">
            <label for="item">Select Vendor</label>
            <select class="form-control" id="ddlVendor">
            </select>
        </div>
        <div class="form-group">
            <label for="Qty">Quantity:</label>
            <input type="number" class="form-control" id="txtqty" placeholder="Enter Quantity" name="Qty">
        </div>
        <input type="button" class="btn btn-warning" onclick="AddInput('I')" id="btnAdd" value="Save" />
        <input type="button" class="btn btn-default" onclick="clearTextBox();" value="New" />


        <%--        <button type="button" class="btn btn-secondary" onclick="clearTextBox();">New</button>--%>
    </div>
    <div class="container">

        <h3>Item Transaction Details</h3>
        <div class="form-group">
            <label for="item" id="lblitem">Enter Item</label>
            <input type="text" class="form-control" id="txtItemname" placeholder="Enter Item Name" name="item" onchange="BindItemWise();"/ >
        </div>


        <table class="table table-responsive">
            <thead>
                <tr>
                    <th>Transaction Id</th>
                    <th>Item Name</th>
                    <th>Transaction Date</th>
                    <th>Department Name</th>
                    <th>Vendor Name</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody class="tbody">
            </tbody>
        </table>
    </div>
</asp:Content>
