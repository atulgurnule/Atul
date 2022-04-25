using System;
using System.Collections.Generic;

using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;

namespace StoreApp
{
    public partial class IssueReport : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        ReportDocument rprt = new ReportDocument();
        protected void Page_Load(object sender, EventArgs e)
        {
            //ReportDocument crystalReport = new ReportDocument();
            //crystalReport.Load(Server.MapPath("~/CrystalReport/IssueCrystalReport.rpt"));
            //ItemIssueDataSet dsCustomers = GetData("select count(itemtrans.Transaction_id) as Transaction_id,itemmast.Item_Name,FORMAT(itemtrans.Transaction_date,'dd/MM/yyyy') as Transaction_date,dept.Department_name,vend.Vendor_name,itemtrans.Quantity,case when Transtype = 1 then 'ISSUE' WHEN Transtype = 2 then'PURCHASE' END AS Transtype, CASE WHEN itemmast.Category = 1 THEN 'Electronics' WHEN itemmast.Category = 2 THEN 'Consumable' WHEN itemmast.Category = 3 THEN 'Furniture' WHEN itemmast.Category = 4 THEN 'Stationary' END AS Category from Store.dbo.Items_Transaction as itemtrans inner join Store.dbo.Item_master as itemmast on itemtrans.Item_Id = itemmast.Item_Id inner join Store.dbo.Department_mast as dept on itemtrans.Department_Id = dept.Department_Id inner join Store.dbo.Vendor_mast as vend on itemtrans.Vendor_id = vend.Vendor_id where itemtrans.Transtype = 1 group by itemtrans.Transaction_id, itemmast.Item_Name, itemtrans.Transaction_date, dept.Department_name, vend.Vendor_name, itemtrans.Quantity, itemtrans.Transtype, itemmast.Category Order By dept.Department_name, itemtrans.Transaction_date");
            //crystalReport.SetDataSource(dsCustomers);
            //CrystalReportViewer1.ReportSource = crystalReport;
            rprt.Load(Server.MapPath("~/CrystalReport/IssueCrystalReport.rpt"));
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand("select count(itemtrans.Transaction_id) as Transaction_id,itemmast.Item_Name,FORMAT(itemtrans.Transaction_date,'dd/MM/yyyy hh:mm:ss') as Transaction_date,dept.Department_name,vend.Vendor_name,itemtrans.Quantity,case when Transtype = 1 then 'ISSUE' WHEN Transtype = 2 then'PURCHASE' END AS Transtype, CASE WHEN itemmast.Category = 1 THEN 'Electronics' WHEN itemmast.Category = 2 THEN 'Consumable' WHEN itemmast.Category = 3 THEN 'Furniture' WHEN itemmast.Category = 4 THEN 'Stationary' END AS Category from Store.dbo.Items_Transaction as itemtrans inner join Store.dbo.Item_master as itemmast on itemtrans.Item_Id = itemmast.Item_Id inner join Store.dbo.Department_mast as dept on itemtrans.Department_Id = dept.Department_Id inner join Store.dbo.Vendor_mast as vend on itemtrans.Vendor_id = vend.Vendor_id where itemtrans.Transtype = 1 group by itemtrans.Transaction_id, itemmast.Item_Name, itemtrans.Transaction_date, dept.Department_name, vend.Vendor_name, itemtrans.Quantity, itemtrans.Transtype, itemmast.Category Order By dept.Department_name, itemtrans.Transaction_date", con);
            //cmd.CommandType = CommandType.StoredProcedure;
          
            //cmd.Parameters.AddWithValue("@fromdate", txtfromdate.Text);
            //cmd.Parameters.AddWithValue("@todate", txttodate.Text);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            rprt.SetDataSource(dt);

            CrystalReportViewer1.ReportSource = rprt;
            CrystalReportViewer1.DataBind();
        }

        //private ItemIssueDataSet GetData(string query)
        //{
        //    string conString = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        //    SqlCommand cmd = new SqlCommand(query);
        //    using (SqlConnection con = new SqlConnection(conString))
        //    {
        //        using (SqlDataAdapter sda = new SqlDataAdapter())
        //        {
        //            cmd.Connection = con;

        //            sda.SelectCommand = cmd;
        //            using (ItemIssueDataSet dsCustomers = new ItemIssueDataSet())
        //            {
        //                sda.Fill(dsCustomers, "DataTable1");
        //                return dsCustomers;
        //            }
        //        }
        //    }
        //}
    }

   

}