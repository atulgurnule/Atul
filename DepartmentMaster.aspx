<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DepartmentMaster.aspx.cs" Inherits="StoreApp.DepartmentMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            
            Bind_Dept_Details();
        });

    </script>

    <script type="text/javascript">
        function clearTextBox() {
            $("#txtdeptid").val('');
            $("#txtdept").val('');
           
            $("#btnAdd").attr("onclick", "AddInput('I')");
            $("#btnAdd").attr("value", "Add");

        }
   </script>
    <script type="text/javascript">
        function Bind_Dept_Details() {
            
            $.ajax({

                type: "POST",
                url: "DepartmentMaster.aspx/BindDept_Master",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    
                    var html = '';
                    $.each(response.d, function (key, item) {
                        html += '<tr>';
                        html += '<td>' + item.Department_Id + '</td>';
                        html += '<td>' + item.Department_name + '</td>';
                        html += '<td><a href="#" onclick="return getbyID(' + item.Department_Id + ')">Edit</a> | <a href="#" onclick="delete_row(' + item.Department_Id + ')">Delete</a></td>';
                        html += '</tr>';
                    });
                    $('.tbody').html(html);

                }
            });
        };
   </script>
    <script type="text/javascript">
        function BindDeptWise() {
            var txtdepartment = document.getElementById("txtdeptname").value;
            if(txtdept != "") {
            $.ajax({

                type: "POST",
                url: "DepartmentMaster.aspx/BindDept_Wise",
                data: "{'Department_name': '" + txtdepartment + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    
                    var html = '';
                    $.each(response.d, function (key, item) {
                        html += '<tr>';
                        html += '<td>' + item.Department_Id + '</td>';
                        html += '<td>' + item.Department_name + '</td>';
                        html += '<td><a href="#" onclick="return getbyID(' + item.Department_Id + ')">Edit</a> | <a href="#" onclick="delete_row(' + item.Department_Id + ')">Delete</a></td>';
                        html += '</tr>';
                    });
                    $('.tbody').html(html);

                }
                });
            }
        }
   </script>

    <script type="text/javascript">
        function delete_row(Department_Id) {
            $.ajax(
                {
                    type: "POST",
                    url: "DepartmentMaster.aspx/deleteDeptMaster",
                    data: "{'Department_Id': '" + Department_Id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    //success: GetLineData_Delete,
                    success: function (response) {
                        Bind_Dept_Details();
                        alert('Record deleted successfully');
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });

        }  
   </script>

    <script type="text/javascript">

        function getbyID(Department_Id) {
            $.ajax({
                type: "POST",
                url: "DepartmentMaster.aspx/GetDeptMaster",

                data: "{'Department_Id': " + Department_Id + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d != '') {
                        document.getElementById("txtdeptid").value = response.d[0].Department_Id;
                        document.getElementById("txtdept").value = response.d[0].Department_name;
                       
                        $('#txtdept').focus();
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
            var Dept_Id = $("#txtdeptid").val();

            $.ajax(
                {
                    type: "POST",
                    url: "DepartmentMaster.aspx/saveDepartmentMaster",
                    data: '{Department_Id: "' + Dept_Id + '",Department_name: "' + document.getElementById('txtdept').value + '",t_flag:"' + t_flag + '"}',
                    //,t_cwoc: "' + document.getElementById('t_cwoc').value + '",t_mcrt: "' + document.getElementById('t_mcrt').value + '",t_mccp: "' + document.getElementById('t_mccp').value + '",t_mdcp: "' + document.getElementById('t_mdcp').value + '"
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    ////success: GetLineData,
                    success: function (response) {

                        if (response.d.toString() === "success") {

                            clearTextBox();

                            $('#txtdepts').focus();
                            $("#btnAdd").attr("onclick", "AddInput('I')");
                            $("#btnAdd").attr("value", "Add");
                            //Bind_Input1_Lines(t_tano);
                            Bind_Dept_Details();
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
            if ($('#txtdept').val() == "") {
                $('#txtdept').css('border-color', 'Red');
                isValid = false;
            }
            else {
                $('#txtdept').css('border-color', 'lightgrey');
            }

            return isValid;
        }
    </script>
    <div class="container">
        <h2>Department Master</h2>
        <div class="form-group">

            <input type="hidden" class="form-control" id="txtdeptid" placeholder="Enter Department Id" name="Item">
        </div>

        <div class="form-group">
            <label for="email">Department Name:</label>
            <input type="text" class="form-control" id="txtdept" placeholder="Enter Department Name" name="Item">
        </div>

        <input type="button" class="btn btn-warning" onclick="AddInput('I')" id="btnAdd" value="Save" />
        <button type="button" class="btn btn-secondary" onclick="clearTextBox();">New</button>

    </div>
    <div class="container">
        <h3>Department Details</h3>
        <div class="form-group">
            <label for="item" id="lblitem">Enter Department</label>
            <input type="text" class="form-control" id="txtdeptname" placeholder="Enter Department" name="item" onchange="BindDeptWise();"/ >
        </div>
        <%--  <p>The .table class adds basic styling (light padding and only horizontal dividers) to a table:</p>--%>
        <table class="table table-responsive" id="tbldept">
              <thead>
                <tr>
                    <th>Department Id</th>
                    <th>Department Name</th>
                    
                </tr>
            </thead>
            <tbody class="tbody">
            </tbody>
        </table>
    </div>
</asp:Content>
