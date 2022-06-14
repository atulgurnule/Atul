<%@ Page Title="" Language="C#" MasterPageFile="~/WebShop.Master" AutoEventWireup="true" CodeBehind="AddBooking.aspx.cs" Inherits="WebShop.AddBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Google Font: Source Sans Pro -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
    <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
    <!-- Google Font: Source Sans Pro -->
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700" rel="stylesheet">
    <link rel="stylesheet" href="../../plugins/sweetalert2-theme-bootstrap-4/bootstrap-4.min.css">
    <link rel="stylesheet" href="../../plugins/toastr/toastr.min.css">

    <%-- <script src="../scripts/jquery-1.3.2.min.js" type="text/javascript"></script>--%>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
    <%-- <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>--%>
    <!-- Font Awesome -->

    <!-- DataTables -->
    <link rel="stylesheet" href="../../plugins/datatables-bs4/css/dataTables.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-responsive/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="../../plugins/datatables-buttons/css/buttons.bootstrap4.min.css">
    <link rel="stylesheet" href="../plugins/daterangepicker/daterangepicker.css">

    <script language="javascript">
      var ctrl
      function openChild(control, form) {
        ctrl = control
        frm = form + ".aspx?param1=" + document.getElementById("t_scbp").value.toString();
        var left = (screen.width - 800) / 2;
        var top = (screen.height - 400) / 4;
        childWindow = open(frm, 'pagename', 'resizable=no,width=800,height=400,left=' + left + ',top=' + top);
      }
      function setValue(myVal) {
        document.getElementById(ctrl).value = myVal;
        $(document).ready(function () {
          document.getElementById(ctrl).onchange();

        });
      }

    </script>
    <!-- Theme style -->
    <script type="text/javascript">
      var userid = '';
      var UserName = '';
      $(document).ready(function () {

        const urlParams = new URLSearchParams(window.location.search);
        const bkno = urlParams.get('t_bkno');
        userid = '<%= Session["t_usid"] %>';
        debugger
        if (bkno != null) {
          $("#t_bkno_id").html(bkno);
          Bind_Booking_head(bkno);
          Bind_BookingDetails(bkno);

        }
        $("#t_amnt").prop("disabled", true);
      });
    </script>
    <script type="text/javascript">
      function GetItemdesc() {

        var t_itemcode = $("#t_item").val();

        $.ajax({
          url: "AddBooking.aspx/GetItemDescription",
          data: '{t_item :"' + t_itemcode + '"}',
          type: "POST",
          contentType: "application/json;charset=UTF-8",
          dataType: "json",
          success: function (response) {

            if (response.d.length === 0) {
              $("#t_item_desc").html("");
              $("#t_item").val("");

            }
            else {
              $("#t_item_desc").html(response.d[0].t_dsca);
              $("#t_item_desc").css('display', 'block');

            }
          },
          error: function (errormessage) {
            alert(errormessage.responseText);
          }
        });
        return false;

      }
   </script>

    <script type="text/javascript">
      function GetCustDesc() {
        userid = '<%= Session["t_usid"] %>';

        var t_scbpcode = $("#t_scbp").val();
        if (t_scbpcode != '') {
          $.ajax({
            url: "AddBooking.aspx/GetCustInfo",
            data: '{t_scbp :"' + t_scbpcode + '"}',
            type: "POST",
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            success: function (response) {

              if (response.d.length === 0) {
                $("#t_scbp_desc").html("");
                $("#t_scbp").val("");
                $("#t_mono").val("");
              }
              else {
                $("#t_scbp_desc").html(response.d[0].t_desc);
                $("#t_mono").val(response.d[0].t_phne);
                $("#t_mono").prop("disabled", true);
                $("#t_scbp_desc").css('display', 'block');

                //document.getElementById("t_item_desc").innerHTML = response.d[0].t_dsca;

              }
            },
            error: function (errormessage) {
              alert(errormessage.responseText);
            }
          });
          return false;
        }

      }
   </script>
    <script type="text/javascript">
      function CalculateAmount() {

        var qty = parseFloat(document.getElementById("t_qoor").value);
        var price = parseFloat(document.getElementById("t_pric").value);
        if (qty < 1) {
          toastr.error("Please enter value more than 0.");
          document.getElementById("t_qoor").value = "";
        }
        else if (price < 1) {
          toastr.error("Please enter value more than 0.");
          document.getElementById("t_pric").value = "";
        }
        else {
          var t_oamt = (qty * price);
          $("#t_oamt").val(t_oamt);
          $("#t_oamt").prop("disabled", true);
        }
      }
    </script>
    <script type="text/javascript">
      function Bind_Booking_head(t_bkno) {
        userid = '<%= Session["t_usid"] %>';
        $.ajax({
          type: "POST",
          url: "AddBooking.aspx/GetBookingHeader",
          data: '{t_bkno: "' + t_bkno + '"}',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function (response) {

            if (response.d != '') {
              debugger
              var bkno = (response.d);

              document.getElementById("t_date").value = bkno[0].t_date;
              //document.getElementById("t_prbp").value = bkno[0].t_prbp;
              document.getElementById("t_srep").value = bkno[0].t_srep;
              document.getElementById("t_scbp").value = bkno[0].t_scbp;
              document.getElementById("t_tdlg").value = bkno[0].t_tdlg;
              document.getElementById("t_amnt").value = bkno[0].t_amnt;
              document.getElementById("t_advc").value = bkno[0].t_advc;
              $('#t_srep').focus();
              $("#t_amnt").prop("disabled", true);
              GetCustDesc(userid);
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
      function SaveBookingHeader(flag, pono) {

        userid = '<%= Session["t_usid"] %>';
        var res = validateHeader();
        if (res == false) {
          return false;
        }
        if (flag == 'UH') {
          pono = 0;
        }

        var t_date = document.getElementById("t_date").value;
        var t_prbp = userid;
        var t_srep = document.getElementById("t_srep").value;
        var t_scbp = document.getElementById("t_scbp").value;
        var t_tdlg = document.getElementById("t_tdlg").value;
        //var t_oamt = document.getElementById("t_oamt").value;
        var t_advc = document.getElementById("t_advc").value;

        var bkno_id = $("#t_bkno_id").html();


        if (bkno_id != '') {

          Swal.fire({
            title: 'Do you want to Save?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Save',
            denyButtonText: `Don't save`,
          }).then((result) => {

            if (result.isConfirmed) {
              //var flag = 'I';
              $.ajax(
                  {
                    type: "POST",
                    url: "AddBooking.aspx/saveHeader",
                    data: '{t_bkno: "' + bkno_id + '",t_date: "' + t_date + '",t_prbp: "' + t_prbp + '",t_srep: "' + t_srep + '",t_scbp: "' + t_scbp + '",t_tdlg: "' + t_tdlg + '",t_advc:"' + t_advc + '",t_flag:"' + flag + '",t_pono_code:"' + pono + '"}',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: GetHeaderData,
                    failure: function (response) {
                      alert(response.d);
                    }
                  });
              Swal.fire('Record is Saved!', '', 'success')
            } else if (result.isDenied) {
              Swal.fire('Record not is Saved', '', 'info')
            }
          })
        }
        else {
          toastr.error('Booking id does not found,Please add items in below tab');
        }
      }

      function validateHeader() {

        var isValid = true;

        if ($('#t_prbp').val() == "") {
          $('#t_prbp').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_prbp').css('border-color', 'lightgrey');
        }
        if ($('#t_srep').val() == "") {
          $('#t_srep').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_srep').css('border-color', 'lightgrey');
        }
        if ($('#t_scbp').val() == "") {
          $('#t_scbp').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_scbp').css('border-color', 'lightgrey');
        }

        if ($('#t_date').val() == "") {
          $('#t_date').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_date').css('border-color', 'lightgrey');
        }


        if ($('#t_tdlg').val() == "") {
          $('#t_tdlg').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_tdlg').css('border-color', 'lightgrey');
        }
        if ($('#t_advc').val() == "") {
          $('#t_advc').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_advc').css('border-color', 'lightgrey');
        }

        return isValid;
      }
      function GetHeaderData(response) {

        var t_bkno = response.d[0].toString();
        $('#t_bkno_id').html(t_bkno);

        if (response.d[2].toString() != '') {
          document.getElementById("t_amnt").value = response.d[2].toString();
          $("#t_amnt").prop("disabled", true);
        }

        $('#t_prbp').focus();
        //$("#btnAdd").attr("onclick", "AddInput('I',0)");
        //$("#btnAdd").attr("value", "Add");

        if (response.d[1].toString().trim() != 'success') {
          toastr.error(response.d[1].toString());
        }
        else {
          Bind_Booking_head(t_bkno);
          toastr.success('Booking header added successfully');

        }

      }
    </script>
    <script type="text/javascript">
      function AddInput(flag, pono) {

        userid = '<%= Session["t_usid"] %>';
        var res = validate();
        if (res == false) {
          return false;
        }
        if (flag == 'I') {
          pono = 0;
        }

        var t_date = document.getElementById("t_date").value;
        var t_prbp = userid;
        var t_srep = document.getElementById("t_srep").value;
        var t_scbp = document.getElementById("t_scbp").value;
        var t_tdlg = document.getElementById("t_tdlg").value;
        var t_oamt = document.getElementById("t_oamt").value;
        var t_advc = document.getElementById("t_advc").value;

        var item = document.getElementById("t_item").value;
        var qty = document.getElementById("t_qoor").value;
        var price = document.getElementById("t_pric").value;
        //var t_amnt = document.getElementById("t_amnt").value;

        //var t_oamt = (qty * price);
        var t_qtno = document.getElementById("t_qtno").value;
        var bkno_id = $("#t_bkno_id").html();
        if (price != 0) {
          //var flag = 'I';
          $.ajax(
              {
                type: "POST",
                url: "AddBooking.aspx/saveBooking",
                data: '{t_bkno: "' + bkno_id + '",t_date: "' + t_date + '",t_prbp: "' + t_prbp + '",t_srep: "' + t_srep + '",t_scbp: "' + t_scbp + '",t_tdlg: "' + t_tdlg + '",t_advc:"' + t_advc + '",t_item:"' + item.toString() + '",t_qoor:"' + qty.toString() + '",t_pric:"' + price.toString() + '",t_oamt:"' + t_oamt + '",t_qtno:"' + t_qtno + '",t_flag:"' + flag + '",t_pono_code:"' + pono + '"}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: GetLineData,
                failure: function (response) {
                  alert(response.d);
                }
              });
        }
        else {
          toastr.error("You can not add 0 amount,Please enter quantity and rate.");
        }
      }

      function validate() {

        var isValid = true;
        if ($('#t_prbp').val() == "") {
          $('#t_prbp').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_prbp').css('border-color', 'lightgrey');
        }
        if ($('#t_srep').val() == "") {
          $('#t_srep').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_srep').css('border-color', 'lightgrey');
        }
        if ($('#t_scbp').val() == "") {
          $('#t_scbp').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_scbp').css('border-color', 'lightgrey');
        }

        if ($('#t_tdlg').val() == "") {
          $('#t_tdlg').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_tdlg').css('border-color', 'lightgrey');
        }
        if ($('#t_advc').val() == "") {
          $('#t_advc').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_advc').css('border-color', 'lightgrey');
        }
        if ($('#t_item').val() == "") {
          $('#t_item').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_item').css('border-color', 'lightgrey');
        }
        if ($('#t_qoor').val() == "") {
          $('#t_qoor').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_qoor').css('border-color', 'lightgrey');
        }
        if ($('#t_pric').val() == "") {
          $('#t_pric').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_pric').css('border-color', 'lightgrey');
        }
        if ($('#t_oamt').val() == "") {
          $('#t_oamt').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_oamt').css('border-color', 'lightgrey');
        }
        if ($('#t_qtno').val() == "") {
          $('#t_qtno').css('border-color', 'Red');
          isValid = false;
        }
        else {
          $('#t_qtno').css('border-color', 'lightgrey');
        }
        return isValid;
      }

      function GetLineData(response) {

        var t_bkno = response.d[0].toString();
        $('#t_bkno_id').html(t_bkno);

        if (response.d[2].toString() != '') {
          document.getElementById("t_amnt").value = response.d[2].toString();
          $("#t_amnt").prop("disabled", true);
        }
        document.getElementById("t_item").value = "";
        document.getElementById("t_qoor").value = 0;
        document.getElementById("t_pric").value = 0;
        document.getElementById("t_oamt").value = 0;
        document.getElementById("t_qtno").value = '';

        $('#t_item').focus();
        $("#btnAdd").attr("onclick", "AddInput('I',0)");
        $("#btnAdd").attr("value", "Add");

        if (response.d[1].toString().trim() != 'success') {
          toastr.error(response.d[1].toString());
        }
        else {
          toastr.success('Booking added successfully');
          Bind_Booking_head(t_bkno);
          Bind_BookingDetails(t_bkno);
          $('#bookingdetModal').modal('hide');

        }

      }

      function Bind_BookingDetails(t_bkno) {

        if (t_bkno != '') {
          $.ajax({

            type: "POST",
            url: "AddBooking.aspx/BindBookingDetails",
            data: '{t_bkno:"' + t_bkno + '"}',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            processData: false,
            success: function (data) {


              var datatableVariable = $('#tblbookingdetails').DataTable({

                "footerCallback": function (row, data, start, end, display) {
                  var api = this.api(), data;
                  // converting to interger to find total
                  var intVal = function (i) {
                    return typeof i === 'string' ?
                        i.replace(/[\$,]/g, '') * 1 :
                        typeof i === 'number' ?
                      i : 0;
                  };
                  var CollTotal = api
                      .column(5)
                      .data()
                      .reduce(function (a, b) {
                        return intVal(a) + intVal(b);
                      }, 0);

                  // Update footer by showing the total with the reference of the column index 
                  $(api.column(0).footer()).html('Total');
                  $(api.column(1).footer()).html('');
                  $(api.column(2).footer()).html('');
                  $(api.column(3).footer()).html('');
                  $(api.column(4).footer()).html('');
                  $(api.column(5).footer()).html((CollTotal).toFixed(2));
                  $(api.column(6).footer()).html('');
                  $(api.column(7).footer()).html('');
                  $(api.column(8).footer()).html('');
                },

                "responsive": true, "lengthChange": false, "autoWidth": true,
                "buttons": ["excel", "pdf", "print"],
                "bDestroy": true,
                data: data.d,
                columns: [
                    { "data": "t_pono", "title": "Sr No." },
                    { "data": "t_item", "title": "Item" },
                    { "data": "t_itemdsca", "title": "Item Description" },
                    { "data": "t_qoor", "title": "Quantity" },
                    { "data": "t_pric", "title": "Price" },
                    { "data": "t_oamt", "title": "Amount", className: "text-right" },
                    { "data": "t_qtno", "title": "Qtn Number" },
                    //{ "data": "BookStatus", "title": "Booking Status" },
                    {
                      data: null, "title": "Booking Status", render: function (data, type, row, meta) {
                        var bookingStatus = "";
                        debugger
                        if (row.BookStatus == 'Logged') {

                          bookingStatus = "Logged";
                          return '<div' + bookingStatus + '" class="badge bg-warning">' + bookingStatus + '</div>';
                        }
                        else if (row.BookStatus == 'Booked') {
                          bookingStatus = "Booked";
                          return '<div' + bookingStatus + '" class="badge bg-success">' + bookingStatus + '</div>';
                        }
                      }
                    },

                    { 'data': null, title: 'Edit', wrap: true, "render": function (item) { return '<div class="btn-group"><button type="button" data-toggle="modal" data-target="#exampleModal" onclick="Bind_Booking_Lines(' + "'" + item.t_bkno + "'" + ',' + item.t_pono + ')" value="0" class="btn btn-success btn-sm"> <i class="nav-icon fas fa-edit"></i></button></div>' } },
                    {
                      'data': null, title: 'Delete', wrap: true, "render": function (item) {
                        if (item.BookStatus == 'Logged') {

                          return '<div class="btn-group"><button type="button" value="0" class="btn btn-default btn-sm" id="btndel1" disabled> <i class="far fa-trash-alt"></i></button></div>'
                        }
                        else if (item.BookStatus == 'Booked') {

                          return '<div class="btn-group"><button type="button" onclick="delete_row(' + "'" + item.t_bkno + "'" + ',' + item.t_pono + ')" value="0" class="btn btn-danger btn-sm" id="btndel1"> <i class="far fa-trash-alt"></i></button></div>'
                        }

                      }
                    }

                ]

              }).buttons().container().appendTo('#tblbookingdetails_wrapper .col-md-6:eq(0)');
            }
          });
        }

      }


      function Bind_Booking_Lines(t_bkno, t_pono) {

        $.ajax({
          type: "POST",
          url: "AddBooking.aspx/GetBookingDetails",
          data: '{t_bkno: "' + t_bkno + '",t_pono: "' + t_pono + '"}',
          contentType: "application/json; charset=utf-8",
          dataType: "json",
          success: function (response) {

            if (response.d != '') {

              var bkno = (response.d);
              // $('#t_dorn_id').html(dorn.t_dorn);
              document.getElementById("t_item").value = bkno[0].t_item;
              document.getElementById("t_qoor").value = bkno[0].t_qoor;
              document.getElementById("t_pric").value = bkno[0].t_pric;
              document.getElementById("t_oamt").value = bkno[0].t_oamt;
              document.getElementById("t_qtno").value = bkno[0].t_qtno;
              //$("#t_item_desc").html(bkno[0].t_itemdsca);
              GetItemdesc();
              //$("#t_item_desc").css('display', 'block');
              //document.getElementById("t_qtno").value = bkno[0].t_qtno;
              $("#t_oamt").prop("disabled", true);
              $('#t_item').focus();
              $("#btnAdd").attr("onclick", "AddInput('U'," + t_pono + ")");
              $("#btnAdd").attr("value", "Update");
              $('#bookingdetModal').modal('show');


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

      function delete_row(t_bkno, t_pono) {

        //const urlParams = new URLSearchParams(window.location.search);
        //t_tano = urlParams.get('t_tano');
        //var t_stat = document.getElementById('t_stat').value;
        Swal.fire({
          title: 'Do you want to delete the record?',
          showDenyButton: true,
          showCancelButton: true,
          confirmButtonText: 'Delete',
          denyButtonText: `Don't delete`,
        }).then((result) => {
          /* Read more about isConfirmed, isDenied below */
          if (result.isConfirmed) {
            $.ajax(
                {
                  type: "POST",
                  url: "AddBooking.aspx/deleteBookingDetails",
                  data: '{t_bkno: "' + t_bkno + '",t_pono: "' + t_pono + '"}',
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (response) {
                    if (response.d[0].toString() === "success") {

                      toastr.success('Record deleted successfully.');
                      $("#btnupdate").prop("disabled", true);
                      Bind_BookingDetails(t_bkno);
                    }

                    else {
                      toastr.warning(response.d[0].toString());

                    }

                    if (response.d[2].toString() != '') {
                      document.getElementById("t_amnt").value = response.d[2].toString();
                      $("#t_amnt").prop("disabled", true);
                    }

                  },
                  failure: function (response) {
                    alert(response.d);
                  }
                })
            Swal.fire('Deleted!', '', 'success')
          } else if (result.isDenied) {
            Swal.fire('Records are not deleted', '', 'info')
          }
        })
      }

    </script>

    <script type="text/javascript">
      function clearTextBox() {

        $("#t_item").val('');
        $("#t_qoor").val('');
        $("#t_pric").val('');
        $("#t_oamt").val('');
        $("#t_qtno").val('');
        $("#t_item_desc").html('');
        $("#t_oamt").prop("disabled", true);

      }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ct1" runat="server">
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Booking Form</h1>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item"><a href="BookingList.aspx">Home</a></li>
                        <li class="breadcrumb-item active">Booking</li>
                    </ol>
                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </section>
    <section class="content">

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-book"></i>&nbsp;Add Booking</h3>

                        <div class="card-tools">
                            <h3 class="card-title"><span class="badge badge-warning">Booking No. :</span>&nbsp;
                             <span class="float-right username">
                                 <label id="t_bkno_id"></label>
                             </span>
                            </h3>
                            &nbsp;
                            <button type="button" class="btn btn-default btn-sm" data-card-widget="collapse">
                                <i class="fas fa-minus"></i>
                            </button>
                            <button type="button" class="btn btn-success btn-sm" onclick="SaveBookingHeader('UH', 0);">
                                <i class="fas fa-save"></i>
                            </button>


                        </div>
                    </div>


                    <div class="card-body">
                        <div class="row">
                            <%-- <div class="col-md-3">
                                <div class="form-group">
                                    <label>Showroom Code</label>
                                    <input type="text" class="form-control" placeholder="Enter Showroom Code" id="t_prbp">
                                </div>
                            </div>--%>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Booking Sales Person Name</label>
                                    <input type="text" class="form-control" placeholder="Enter Booking Sales Person Name" id="t_srep">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <label>Customer Name</label>
                                <div class="input-group">

                                    <div class="custom-file">
                                        <input type="text" class="form-control" placeholder="Enter Customer Name" id="t_scbp" onchange="GetCustDesc();">
                                    </div>
                                    <div class="input-group-append">
                                        <button type="button" id="btnbindcustomer" class="btn btn-warning" onclick="openChild('t_scbp','HelpPages/tdtst1500m000')"><i class="fa fa-search"></i></button>
                                    </div>
                                </div>
                                <label id="t_scbp_desc" style="display: none;"></label>
                                <%--<label id="t_item_desc"></label>--%>
                            </div>


                            <div class="col-md-3">
                                <label>Mobile Number</label>
                                <input type="number" class="form-control" placeholder="Enter Mobile No" id="t_mono" disabled>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Booking Date</label>
                                    <%-- <input type="text" class="form-control" placeholder="Enter Booking Date" id="t_date">--%>
                                    <div class="input-group date" id="reservationdate" data-target-input="nearest">
                                        <input type="text" class="form-control datetimepicker-input" data-target="#reservationdate" id="t_date">
                                        <div class="input-group-append" data-target="#reservationdate" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Tentative Date of Login</label>
                                    <%--<input type="text" class="form-control" placeholder="Enter Tentative Date of Login" id="t_tdlg">--%>
                                    <div class="input-group date" id="reservationdate1" data-target-input="nearest">
                                        <input type="text" class="form-control datetimepicker-input" data-target="#reservationdate1" id="t_tdlg">
                                        <div class="input-group-append" data-target="#reservationdate1" data-toggle="datetimepicker">
                                            <div class="input-group-text"><i class="fa fa-calendar"></i></div>
                                        </div>

                                    </div>
                                </div>
                            </div>

                            <div class="col-md-3">
                                <label>Advance Received :</label>
                                <input type="number" class="form-control" placeholder="Advance Received" id="t_advc">
                            </div>
                            <div class="col-md-3">

                                <label>Total Amount :</label>
                                <input type="text" class="form-control" placeholder="Total Amount" id="t_amnt">
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="modal fade" id="bookingdetModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg card card-secondary" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h3 class="modal-title">
                                    <i class="fas fa-book"></i>&nbsp;Booking Details

                                </h3>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                                <div class="modal-tools">
                                </div>
                            </div>
                            <div class="modal-body">
                                <div class="row">

                                    <div class="col-sm-6">
                                        <label>Item</label>
                                        <div class="input-group">
                                            <div class="custom-file">
                                                <input type="text" class="form-control" placeholder="Enter Item" id="t_item" onchange="GetItemdesc();">
                                            </div>
                                            <div class="input-group-append">
                                                <button type="button" id="btnbinditem" class="btn btn-warning" onclick="openChild('t_item','HelpPages/tdtst1505m000')"><i class="fa fa-search"></i></button>
                                            </div>
                                        </div>
                                        <label id="t_item_desc" style="display: none;"></label>
                                    </div>


                                    <div class="col-sm-6">
                                        <label>Quantity</label>
                                        <input type="number" class="form-control" placeholder="Enter Quantity" id="t_qoor" onkeyup="CalculateAmount();">
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Rate</label>
                                            <input type="number" class="form-control" placeholder="Enter Rate" id="t_pric" onkeyup="CalculateAmount();">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Amount</label>
                                            <input type="number" class="form-control" placeholder="Enter Amount" id="t_oamt">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label>Qtn Number</label>
                                            <input type="text" class="form-control" placeholder="Enter Qtn Number" id="t_qtno">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-warning waves-effect" onclick="AddInput('I', 0)" id="btnAdd" value="Add" />
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">
                            <i class="fas fa-book"></i>&nbsp;Booking  Details
                          
                        </h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-warning btn-sm" data-toggle="modal" data-target="#bookingdetModal" onclick="clearTextBox()">
                                <i class="fas fa-book" style="font-size: 20px;"></i>&nbsp;&nbsp;Add Booking  
                            </button>

                        </div>
                    </div>
                    <div class="card-body table-responsive p-0">
                        <table id="tblbookingdetails" class="table table-bordered table-striped ">
                            <tfoot align="right">
                                <tr>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                    <th></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </section>
    <script src="../plugins/daterangepicker/daterangepicker.js"></script>

    <script>
      $(function () {
        bsCustomFileInput.init();
      });
    </script>

    <%-- <script src="plugins/daterangepicker/daterangepicker.js"></script>--%>
    <script src="plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
    <!-- jQuery -->

    <!-- Page specific script -->

    <%-- <script src="../../plugins/jquery/jquery.min.js"></script>--%>
    <!-- Bootstrap 4 -->
    <script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Select2 -->

    <!-- Bootstrap4 Duallistbox -->
    <script src="../../plugins/bootstrap4-duallistbox/jquery.bootstrap-duallistbox.min.js"></script>
    <!-- InputMask -->
    <script src="../../plugins/moment/moment.min.js"></script>
    <script src="../../plugins/inputmask/jquery.inputmask.min.js"></script>
    <!-- date-range-picker -->
    <script src="../../plugins/daterangepicker/daterangepicker.js"></script>
    <!-- bootstrap color picker -->
    <script src="../../plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.min.js"></script>
    <!-- Tempusdominus Bootstrap 4 -->
    <script src="../../plugins/tempusdominus-bootstrap-4/js/tempusdominus-bootstrap-4.min.js"></script>
    <!-- Bootstrap Switch -->
    <script src="../../plugins/bootstrap-switch/js/bootstrap-switch.min.js"></script>
    <!-- BS-Stepper -->
    <script src="../../plugins/bs-stepper/js/bs-stepper.min.js"></script>
    <!-- dropzonejs -->
    <script src="../../plugins/dropzone/min/dropzone.min.js"></script>
    <!-- AdminLTE App -->
    <script src="../../dist/js/adminlte.min.js"></script>
    <!-- AdminLTE for demo purposes -->
    <%--<script src="../../dist/js/demo.js"></script>--%>
    <script src="../../plugins/sweetalert2/sweetalert2.min.js"></script>
    <!-- Toastr -->
    <script src="../../plugins/toastr/toastr.min.js"></script>

    <script src="../../plugins/datatables/jquery.dataTables.min.js"></script>
    <script src="../../plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script src="../../plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
    <script src="../../plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>
    <script src="../../plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
    <script src="../../plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
    <script src="../../plugins/jszip/jszip.min.js"></script>
    <script src="../../plugins/pdfmake/pdfmake.min.js"></script>
    <script src="../../plugins/pdfmake/vfs_fonts.js"></script>
    <script src="../../plugins/datatables-buttons/js/buttons.html5.min.js"></script>
    <script src="../../plugins/datatables-buttons/js/buttons.print.min.js"></script>
    <script src="../../plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
    <script>
      $(function () {
        //$('.summernote').summernote();
        //Initialize Select2 Elements
        //$('.select2').select2()

        ////Initialize Select2 Elements
        //$('.select2bs4').select2({
        //    theme: 'bootstrap4'
        //})

        //Date picker
        $('#reservationdate').datetimepicker({
          //format: 'L'
          format: "DD-MM-YYYY"
        });
        $('#reservationdate1').datetimepicker({
          //format: 'L'
          format: "DD-MM-YYYY"
        });
        //Date and time picker
        $('#reservationdatetime').datetimepicker({ icons: { time: 'far fa-clock' } });
      })
    </script>
</asp:Content>
