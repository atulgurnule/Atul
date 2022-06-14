$(document).ready(function () {

    //BindSalData();
    BindSalesDetails();
   

});
function BindSalesDetails() {
     

    var table = $('#tblSalImport').DataTable();
        table
            .clear()
            .draw();
        destroy: true,
            table.destroy();
        try {
            $.ajax({

                type: "POST",
                url: "UploadExcel.aspx/BindSalesDetails1",
                data: '{}',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    if (data.d.salList != "") {
                        
                        //var _dataSuccess = data.d.salList;
                        //var totalcnt = _dataSuccess.length;

                        for (var i = 0; i < data.d.length; i++) {

                            tr = $('<tr/>');
                            tr.append("<td >" + data.d[i].t_orno + "</td>");
                            tr.append("<td>" + data.d[i].t_btno + "</td>");
                            tr.append("<td>" + FormatJsonDate(data.d[i].t_btdt) + "</td>");
                          
                            $('.display1').append(tr);
     
                        }
                    }
                   

                }
            });

        }

        catch (Error) {
            log(Error);
        }
}
function FormatJsonDate(jsonDate) {
    var num = jsonDate.match(/\d+/g); //regex to extract numbers 
    var date = new Date(parseFloat(num)); //converting to date
    return (date.getDate() + "-" + (date.getMonth() + 1) + '-' + date.getFullYear());
}
function BindSalData() {
    //var table = $('#tblSalImport').DataTable();
    //table
    //    .clear()
    //    .draw();
    //destroy: false,
    //    table.destroy();
    //&& LoadN != ""
    $('#tblSalImport').DataTable({
        "responsive": true, "lengthChange": false, "autoWidth": false,
        "dom": 'Bfrtip',
        "buttons": ["excel", "pdf", "print"],
        //"processing": false,
        //"serverSide": false,
        //"filter": true,
        //"bsort": true,
        //"searching": true,
        //"tabIndex": -1,
        "ajax": {
            //"url": "/SalesOrderQRScan/BindLoadHeaderLiner?SalOrd=" + SalOrd ,

            "type": "POST",
            "datatype": "json",
            "url": "UploadExcel.aspx/BindSalesDetails1",
            //"data": {},
            "success": function (data) {
                var datatableVariable = $('#tblSalImport').DataTable({
                    data: data,
                    "columns": [
                        { "data": "t_orno", "name": "Sales Order No." },
                        { "data": "t_btno", "name": "Batch No." },
                        { "data": "t_btdt", "name": "Batch date" }

                    ]
                });
            },

        }
    }).buttons().container().appendTo('#tblSalImport_wrapper .col-md-6:eq(0)');
};
//function ValidateEmail(email) {
//    var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
//    return expr.test(email);
//};

$("#btnImport").click(function () {
    //$('input[type="checkbox"]').click(function () {

   
    $.ajax({
        type: "POST",
        url: "UploadExcel.aspx/SubmitDetails",
        data: '{}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        
        //async: false,
       
        success: function () {
           
        },
        failure: function () {

            alert("Error while inserting data");
        }


    });
});




