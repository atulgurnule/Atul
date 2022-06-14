using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;


public partial class CS : System.Web.UI.Page
{
    static string consString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
    protected void Upload(object sender, EventArgs e)
    {
        //Upload and save the file
        string excelPath = Server.MapPath("~/Files/") + Path.GetFileName(FileUpload1.PostedFile.FileName);
        FileUpload1.SaveAs(excelPath);

        string conString = string.Empty;
        string storedProc = string.Empty;
        string extension = Path.GetExtension(FileUpload1.PostedFile.FileName);
        switch (extension)
        {
            case ".xls": //Excel 97-03
                //storedProc = "spx_ImportFromExcel03";
                conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                break;
            case ".xlsx": //Excel 07 or higher
                //storedProc = "spx_ImportFromExcel07";
                conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                break;

        }
        conString = string.Format(conString, excelPath);
        using (OleDbConnection excel_con = new OleDbConnection(conString))
        {

            excel_con.Open();
            string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
            DataTable dtExcelData = new DataTable();

            //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.
            //dtExcelData.Columns.AddRange(new DataColumn[5] { new DataColumn("t_orno", typeof(string)),
            //        new DataColumn("t_btno", typeof(string)),
            //        new DataColumn("t_btdt", typeof(string)),
            //         new DataColumn("t_Refcntd", typeof(int)),
            //          new DataColumn("t_Refcntu", typeof(int)),
            //         });
            dtExcelData.Columns.AddRange(new DataColumn[2] { new DataColumn("t_orno", typeof(string)),
                    new DataColumn("t_btno", typeof(string)),
             });

            using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
            {
                oda.Fill(dtExcelData);
            }
            excel_con.Close();
           


                    ///////////////////////////////////Insert in Database/////////////////////////////////////////////////
            using (SqlConnection con = new SqlConnection(consString))
            {
                
                storedProc = "test..[spx_ImportFromExcel]";
                //DateTime TodayDate = Convert.ToDateTime(dtTodayDate.Rows[0]["TodayDate"]);
               
                //string batchDate = DateTime.Now.ToString("yyyy-MM-dd");
                //string CurrentDate = batchDate.ToString("yyyy-MM-dd");
                if (dtExcelData.Rows.Count > 0)
                {
                    //Build the Text file data.
                    for (int AddNewCount = 0; AddNewCount < dtExcelData.Rows.Count; AddNewCount++)
                    {

                        //////////////// For Already Exist Check///////////////////////////
                        SqlConnection conn = new SqlConnection();
                        conn.ConnectionString = consString;
                        conn.Open();
                        string strsql;
                        strsql = "test..[SWGetImportSalDetails]";

                        SqlCommand cmd1 = new SqlCommand(strsql, conn);
                        cmd1.CommandType = CommandType.StoredProcedure;
                        cmd1.Parameters.Add(new SqlParameter("@t_orno", dtExcelData.Rows[AddNewCount]["t_orno"]));
                        cmd1.Parameters.Add(new SqlParameter("@t_btno", dtExcelData.Rows[AddNewCount]["t_btno"]));
                        var da = new SqlDataAdapter(cmd1);
                        DataTable dtExist = new DataTable();
                        dtExist.Rows.Clear();
                        da.Fill(dtExist);
                        conn.Close();
                        //////////////// For Already Exist Close/////////////////////////////////////////////////////////////
                        if (dtExist.Rows.Count > 0)
                        {
                            ////Build the Text file data.
                            //for (int checkExist = 0; checkExist < dtExcelData.Rows.Count; checkExist++)
                            //{

                            //}
                            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('This record is already inserted')+","Sales Order No:"+ dtExcelData.Rows[AddNewCount]["t_orno"],true);
                            string message = "This record is already inserted..." + "Sales Order No:" + dtExcelData.Rows[AddNewCount]["t_orno"];
                            //'"and Batch No.:" + dtExcelData.Rows[AddNewCount]["t_btno"]";
                            System.Text.StringBuilder sb = new System.Text.StringBuilder();
                            sb.Append("alert('");
                            sb.Append(message);
                            sb.Append("');");
                            ClientScript.RegisterOnSubmitStatement(this.GetType(), "alert", sb.ToString());


                        }
                        else
                        {

                            using (SqlCommand cmd = new SqlCommand(storedProc, con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@t_orno", dtExcelData.Rows[AddNewCount]["t_orno"]);
                                cmd.Parameters.AddWithValue("@t_btno", dtExcelData.Rows[AddNewCount]["t_btno"]);
                                //cmd.Parameters.AddWithValue("@t_btdt", batchDate);
                                cmd.Parameters.AddWithValue("@t_Refcntd", 0);
                                cmd.Parameters.AddWithValue("@t_Refcntu", 0);

                                cmd.Connection = con;
                                con.Open();
                                cmd.ExecuteNonQuery();
                                con.Close();

                            }
                        }

                    }
                    ///////////////////////////////////End in Database/////////////////////////////////////////////////

                    //using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                    //{
                    //    sqlBulkCopy.DestinationTableName = "fp10..ttdswc110100";


                    //Set the database table name


                    //[OPTIONAL]: Map the Excel columns with that of the database table
                    //sqlBulkCopy.ColumnMappings.Add("t_orno", "t_orno");
                    //sqlBulkCopy.ColumnMappings.Add("t_btno", "t_btno");
                    //sqlBulkCopy.ColumnMappings.Add(dtExcelData.Rows[0]["t_btdt"] == DBNull.Value ?  batchDate : dtExcelData.Rows[0]["t_btdt"].ToString().Trim(), "t_btdt");
                    //sqlBulkCopy.ColumnMappings.Add(dtExcelData.Rows[0]["t_Refcntd"] == DBNull.Value ? "0" : dtExcelData.Rows[0]["t_Refcntd"].ToString(), "t_Refcntd");
                    //sqlBulkCopy.ColumnMappings.Add(dtExcelData.Rows[0]["t_Refcntu"] == DBNull.Value ? "0" : dtExcelData.Rows[0]["t_Refcntu"].ToString(), "t_Refcntu");
                    //foreach (DataRow row in dtExcelData.Rows)
                    //{
                    //    object value = row["t_btdt"];
                    //    if (value == DBNull.Value)
                    //    {
                    //        sqlBulkCopy.ColumnMappings.Add(batchDate ,"t_btdt");
                    //    }
                    //    else
                    //    {
                    //        sqlBulkCopy.ColumnMappings.Add("t_btdt", "t_btdt");
                    //    }
                    //do something else

                    //string t_btdt = dtExcelData.Rows[0]["t_btdt"].ToString();
                    //string t_Refcntd = dtExcelData.Rows[0]["t_Refcntd"].ToString();
                    //string t_Refcntu = dtExcelData.Rows[0]["t_Refcntu"].ToString();
                    //if (t_btdt == "")
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add(batchDate, "t_btdt");
                    //}
                    //else
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add("t_btdt", "t_btdt");
                    //}
                    //if (t_Refcntd == "")
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add(0, "t_btdt");
                    //}
                    //else
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add("t_Refcntd", "t_Refcntd");
                    //}
                    //object value1 = row["t_Refcntd"];
                    //if (value1 == DBNull.Value)
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add(0,"t_Refcntd");
                    //}
                    //else
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add("t_Refcntd", "t_Refcntd");
                    //}
                    //object value2 = row["t_Refcntu"];
                    //if (value2 == DBNull.Value)
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add( 0,"t_Refcntu");
                    //}
                    //else
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add("t_Refcntu", "t_Refcntu");
                    //}
                    //if (t_Refcntu == "")
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add(0, "t_btdt");
                    //}
                    //else
                    //{
                    //    sqlBulkCopy.ColumnMappings.Add("t_Refcntu", "t_Refcntu");
                    //}
                    //con.Open();
                    //    sqlBulkCopy.WriteToServer(dtExcelData);
                    //    con.Close();

                    //using (SqlCommand cmd = new SqlCommand(storedProc, con))
                    //{
                    //    cmd.CommandType = CommandType.StoredProcedure;
                    //    //cmd.Parameters.AddWithValue("@t_btdt", batchDate);
                    //    cmd.Parameters.AddWithValue("@t_Refcntd", 0);
                    //    cmd.Parameters.AddWithValue("@t_Refcntu", 0);

                    //    cmd.Connection = con;
                    //    con.Open();
                    //    cmd.ExecuteNonQuery();
                    //    con.Close();
                    //}

                    //}
                    //}
                }
            }
        }

        BindSalesDetails1();
    }

    [WebMethod]
    public static List<ExcelSalOrd> BindSalesDetails1()
    {
        try
        {
            SqlConnection con = new SqlConnection(consString);
            var salList = new List<ExcelSalOrd>();
            con.Open();

            SqlCommand cmd = new SqlCommand("test..[SWImportGetSalBind]", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Add(new SqlParameter("@SalOrdNo", SalOrdNo));
            SqlDataReader rdr = cmd.ExecuteReader();


            while (rdr.Read())
            {
                salList.Add(new ExcelSalOrd
                {
                    t_orno = rdr["t_orno"].ToString(),
                    t_btno = rdr["t_btno"].ToString(),
                    t_btdt= Convert.ToDateTime(rdr["t_btdt"].ToString())

                });
            }
            con.Close();

            //con.Close();
            return salList;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public int SubmitDetails(HttpPostedFileBase postedFile)
    {

        //string responseMsg = string.Empty;
        //bool InsertData;
        string filePath = string.Empty;
        try
        {
            if (postedFile != null)
            {
                string path = Server.MapPath("~/Files/");
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                filePath = path + Path.GetFileName(postedFile.FileName);
                string extension = Path.GetExtension(postedFile.FileName);
                postedFile.SaveAs(filePath);

                string conString = string.Empty;
                switch (extension)
                {
                    case ".xls": //Excel 97-03
                        conString = ConfigurationManager.ConnectionStrings["Excel03ConString"].ConnectionString;
                        break;
                    case ".xlsx": //Excel 07 or higher
                        conString = ConfigurationManager.ConnectionStrings["Excel07+ConString"].ConnectionString;
                        break;

                }
                conString = string.Format(conString, filePath);
                using (OleDbConnection excel_con = new OleDbConnection(conString))
                {

                    //public static string path = @"C:\src\RedirectApplication\RedirectApplication\301s.xlsx";
                    //    public static string connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=Excel 12.0;";
                    excel_con.Open();
                    string sheet1 = excel_con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null).Rows[0]["TABLE_NAME"].ToString();
                    DataTable dtExcelData = new DataTable();

                    //[OPTIONAL]: It is recommended as otherwise the data will be considered as String by default.
                    dtExcelData.Columns.AddRange(new DataColumn[3] { new DataColumn("Id", typeof(int)),
                new DataColumn("Name", typeof(string)),
                new DataColumn("Salary",typeof(decimal)) });

                    using (OleDbDataAdapter oda = new OleDbDataAdapter("SELECT * FROM [" + sheet1 + "]", excel_con))
                    {
                        oda.Fill(dtExcelData);
                    }
                    excel_con.Close();


                    string consString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
                    using (SqlConnection con = new SqlConnection(consString))
                    {
                        using (SqlBulkCopy sqlBulkCopy = new SqlBulkCopy(con))
                        {
                            //Set the database table name
                            sqlBulkCopy.DestinationTableName = "dbo.tblPersons";

                            //[OPTIONAL]: Map the Excel columns with that of the database table
                            sqlBulkCopy.ColumnMappings.Add("Id", "PersonId");
                            sqlBulkCopy.ColumnMappings.Add("Name", "Name");
                            sqlBulkCopy.ColumnMappings.Add("Salary", "Salary");
                            con.Open();
                            sqlBulkCopy.WriteToServer(dtExcelData);
                            con.Close();
                        }
                    }

                }
            }

            }
        catch (Exception ex)
        {
            ex.ToString();
        }
        return 0;
    

    }
}