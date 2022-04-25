using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Data;

namespace StoreApp
{
    public partial class VendorMaster : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        private static string message = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<Vendor_mast> BindVendor_Master()
        {
          
            try
            {
                List<Vendor_mast> lst = new List<Vendor_mast>();
              
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_VendorMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    //comm.Parameters.AddWithValue("@Department_Id", Department_Id);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();

                    while (sdr.Read())
                    {
                        lst.Add(new Vendor_mast
                        {
                            Vendor_id = sdr["Vendor_id"].ToString(),
                            Vendor_name = sdr["Vendor_name"].ToString()
                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@message"].Value.ToString();
                    return lst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [WebMethod]
        public static List<Vendor_mast> BindVendor_Wise(string Vendor_name)
        {

            try
            {
                List<Vendor_mast> lst = new List<Vendor_mast>();

                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_VendorMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "SLIKE");
                    comm.Parameters.AddWithValue("@Vendor_name", Vendor_name);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();

                    while (sdr.Read())
                    {
                        lst.Add(new Vendor_mast
                        {
                            Vendor_id = sdr["Vendor_id"].ToString(),
                            Vendor_name = sdr["Vendor_name"].ToString()
                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@message"].Value.ToString();
                    return lst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [WebMethod]
        public static List<Vendor_mast> GetVendorMaster(string Vendor_id)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ToString();

            try
            {
                List<Vendor_mast> lst = new List<Vendor_mast>();
                //using (SqlConnection con = new SqlConnection(constr))
                //{
                //    con.Open();
                //    SqlCommand comm = new SqlCommand("Store.dbo.[ST_VendorMaster]");
                //    comm.Parameters.AddWithValue("@t_flag", "S");
                //    comm.Parameters.Add(new SqlParameter("@Vendor_id", Vendor_id));
                //    comm.Parameters.Add("@message", SqlDbType.VarChar, 100);
                //    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                //    SqlDataReader sdr = comm.ExecuteReader();
                //    while (sdr.Read())
                //    {
                //        lst.Add(new Vendor_mast
                //        {
                //            Vendor_name = sdr["Vendor_name"].ToString()
                //        });
                //    }
                //    con.Close();
                //    message = (string)comm.Parameters["message"].Value.ToString();
                //    return lst;
                //}
                using (SqlConnection con = new SqlConnection(cs))
                {

                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_VendorMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "SID");
                    comm.Parameters.AddWithValue("@Vendor_id", Vendor_id);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();

                    while (sdr.Read())
                    {
                        lst.Add(new Vendor_mast
                        {
                            Vendor_id = sdr["Vendor_id"].ToString(),
                            Vendor_name = sdr["Vendor_name"].ToString()
                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@message"].Value.ToString();
                    return lst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        [System.Web.Services.WebMethod]
        public static string savevendorMaster(string Vendor_id, string Vendor_name, string t_flag)
        {

            string response = string.Empty;
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_VendorMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    if (Vendor_id == "")
                    {
                        comm.Parameters.AddWithValue("@Vendor_id", null);
                    }
                    else
                    {
                        comm.Parameters.AddWithValue("@Vendor_id", Vendor_id);
                    }
                    comm.Parameters.AddWithValue("@Vendor_name", Vendor_name);
                    comm.Parameters.AddWithValue("@t_flag", t_flag);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    comm.ExecuteNonQuery();
                    con.Close();
                    message = (string)comm.Parameters["@message"].Value.ToString();
                    response = message;
                    return response;
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }

        }

        [WebMethod]
        public static int deleteVendorMaster(string Vendor_id)
        {
            int i;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("Store.dbo.[ST_VendorMaster]", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@t_flag", "D");
                com.Parameters.Add("@message", SqlDbType.VarChar, 500);
                com.Parameters["@message"].Direction = ParameterDirection.Output;
                com.Parameters.AddWithValue("@Vendor_id", Vendor_id);
                i = com.ExecuteNonQuery();
                message = (string)com.Parameters["@message"].Value.ToString();
                con.Close();
            }
            return i;
        }
    }
    public class Vendor_mast
    {
        public string Vendor_id { get; set; }
        public string Vendor_name { get; set; }

    }
}