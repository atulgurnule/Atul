<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UploadExcel.aspx.cs" Inherits="CS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" src="dist/js/crudjscss/jquery-3.0.0.min.js"></script>
    <script type="text/javascript" src="dist/js/crudjscss/bootstrap.js"></script>
    <link href="dist/js/crudjscss/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback" />

    <link href="plugins/fontawesome-free/css/all.min.css" rel="stylesheet" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />
    <link rel="stylesheet" href="plugins/overlayScrollbars/css/OverlayScrollbars.min.css" />

    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

    <!-- Toastr -->
    <link rel="stylesheet" href="plugins/toastr/toastr.min.css" />
    <link rel="stylesheet" href="dist/css/adminlte.min.css" />
</head>
<body>
    <div class="wrapper">
        </br>
        </br>
        </br>
        <%-- <section class="content">
       <div class="container-fluid">--%>
        
                  

                    <%-- <form method="post" enctype="multipart/form-data">--%>
                    <%--  action="/UploadExcel.aspx" --%>
                    <%--<div class="card-body">

                            <div class="card-body">
                                <div class="form-group">
                                    <label for="exampleInputFile">File input</label>
                                    <div class="input-group">
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="exampleInputFile" />
                                            <label class="custom-file-label" for="exampleInputFile">Choose file</label>
                                        </div>
                                        <div class="input-group-append">
                                            <button type="button" id="btnImport">Import</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                    <%-- </form>--%>
               
           
        <form id="form1" runat="server">
        <section class="content">
      <div class="container-fluid">
        <div class="row">
          <!-- left column -->
          <div class="col-md-12">
            <!-- general form elements -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Upload excel file</h3>
              </div>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button Text="Upload" OnClick="Upload" runat="server" />
                </div>
               </div>
             </div>
           </div>
          </section>
          <section class="content" >
          <div class="container-fluid">
          <div class="row">
            <div class="col-12">

                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Sales Order Details</h3>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                        <table id="tblSalImport" class="display1 table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Sales Order No.</th>
                                    <th>Batch No.</th>
                                    <th>Batch Date.</th>
                                 </tr>
                            </thead>
                        </table>
                    </div>
                    <!-- /.card-body -->
                </div>
                <!-- /.card -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </div>
</section>

        </form>
  
  </div>

     <script type="text/javascript" src="formjs/UploadExcel.js"></script>


    <script type="text/javascript" src="plugins/datatables/jquery.dataTables.min.js"></script>
    <script type="text/javascript" src="plugins/datatables-bs4/js/dataTables.bootstrap4.min.js"></script>
    <script type="text/javascript" src="plugins/datatables-responsive/js/dataTables.responsive.min.js"></script>
    <script type="text/javascript" src="plugins/bs-custom-file-input/bs-custom-file-input.min.js"></script>
    <%--<script type="text/javascript" src="plugins/datatables-responsive/js/responsive.bootstrap4.min.js"></script>--%>
    <script type="text/javascript" src="plugins/datatables-buttons/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="plugins/datatables-buttons/js/buttons.bootstrap4.min.js"></script>
    <script type="text/javascript" src="plugins/jszip/jszip.min.js"></script>
    <script type="text/javascript" src="plugins/pdfmake/pdfmake.js"></script>

    <script type="text/javascript" src="plugins/pdfmake/vfs_fonts.js"></script>
    <script type="text/javascript" src="plugins/datatables-buttons/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="plugins/datatables-buttons/js/buttons.print.min.js"></script>
    <script type="text/javascript" src="plugins/datatables-buttons/js/buttons.colVis.min.js"></script>
   
    <script type="text/javascript">
        $(function () {
            bsCustomFileInput.init();
        });
    </script>
     <script type="text/javascript">
        $(function () {
            var table = $('#tblSalImport').DataTable();
            table
                .clear()
            //.draw();
            destroy: false,
                table.destroy();
            $("#tblSalImport").DataTable({
                "responsive": true, "lengthChange": false, "autoWidth": false,
                //"buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"],
                //"scrollY": "170px",
                //"sScrollX": "100%",
                //"processing": false,
                //"serverSide": false,
                //"filter": false,
                //"bsort": false,
                //"searching": false,
                "columns": [

                    null, //
                    null, //
                    null, //
                    
                ]
            }).buttons().container().appendTo('#tblSalImport_wrapper .col-md-6:eq(0)');
           
        });
    </script>

</body>
</html>
