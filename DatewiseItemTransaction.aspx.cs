using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using CrystalDecisions.Reporting;
using CrystalDecisions.ReportSource;
using CrystalDecisions.CrystalReports.Engine;

namespace StoreApp
{
    public partial class DatewiseItemTransaction : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        ReportDocument rprt = new ReportDocument();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            
            ////CrystalReportViewer1.ReportSource = crystalReport;
            rprt.Load(Server.MapPath("~/CrystalReport/CrystalReport_ItemTransaction.rpt"));
            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand("ST_ItemReport", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //rprt.SetParameterValue("@fromdate", txtfromdate.Text);
            //rprt.SetParameterValue("@todate", txttodate.Text);
            cmd.Parameters.AddWithValue("@fromdate", txtfromdate.Text);
            cmd.Parameters.AddWithValue("@todate", txttodate.Text);
           
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            rprt.SetDataSource(dt);
          
            CrystalReportViewer1.ReportSource = rprt;
            CrystalReportViewer1.DataBind();
        }
       
    }


}