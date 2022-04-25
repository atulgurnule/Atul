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
    public partial class ItemTransaction : System.Web.UI.Page
    {
        //static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        private static string message = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {

            }
        }
        [WebMethod]
        public static List<Items_Transaction> BindItems_Transaction()
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
               
                List<Items_Transaction> lst = new List<Items_Transaction>();
                using (SqlConnection con = new SqlConnection(constr))
                {


                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_ItemTransaction]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();

                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        lst.Add(new Items_Transaction
                        {
                            Transaction_id = sdr["Transaction_id"].ToString(),
                            Item_id = sdr["Item_id"].ToString(),
                            Item_Name = sdr["Item_Name"].ToString(),
                            Transaction_date = sdr["Transaction_date"].ToString(),
                            Department_Id = sdr["Department_Id"].ToString(),
                            Department_name = sdr["Department_name"].ToString(),
                            Vendor_id = sdr["Vendor_id"].ToString(),
                            Vendor_name = sdr["Vendor_name"].ToString(),
                            Quantity =sdr["Quantity"].ToString()
                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@message"].Value.ToString();
                    return lst;
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        [WebMethod]
        public static List<Items_Transaction> BindItemnameWise(string Item_Name)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {

                List<Items_Transaction> lst = new List<Items_Transaction>();
                using (SqlConnection con = new SqlConnection(constr))
                {


                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_ItemTransaction]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "SITEM");
                    comm.Parameters.AddWithValue("@Item_Name", Item_Name);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();

                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        lst.Add(new Items_Transaction
                        {
                            Transaction_id = sdr["Transaction_id"].ToString(),
                            Item_id = sdr["Item_id"].ToString(),
                            Item_Name = sdr["Item_Name"].ToString(),
                            Transaction_date = sdr["Transaction_date"].ToString(),
                            Department_Id = sdr["Department_Id"].ToString(),
                            Department_name = sdr["Department_name"].ToString(),
                            Vendor_id = sdr["Vendor_id"].ToString(),
                            Vendor_name = sdr["Vendor_name"].ToString(),
                            Quantity = sdr["Quantity"].ToString()
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
        public static List<Items_Master> GetItemBalQty(string Item_Id)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ToString();

            try
            {

                List<Items_Master> lst = new List<Items_Master>();
                using (SqlConnection con = new SqlConnection(constr))
                {

                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_ItemMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "SID");
                    comm.Parameters.Add(new SqlParameter("@Item_Id", Item_Id));
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();

                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        lst.Add(new Items_Master
                        {
                            Item_Id = Convert.ToInt32(sdr["Item_Id"].ToString()),
                            Balance_Quantity = sdr["Balance_Quantity"].ToString()

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
        public static List<Items_Transaction> GetItemTrasaction(string Transaction_id)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ToString();

            try
            {
              
                List<Items_Transaction> lst = new List<Items_Transaction>();
                using (SqlConnection con = new SqlConnection(constr))
                {


                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_ItemTransaction]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "SID");
                    comm.Parameters.Add(new SqlParameter("@Transaction_id", Transaction_id));
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();

                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        lst.Add(new Items_Transaction
                        {
                            Transaction_id = sdr["Transaction_id"].ToString(),
                            Item_id = sdr["Item_id"].ToString(),
                            Item_Name = sdr["Item_Name"].ToString(),
                            Transaction_date = sdr["Transaction_date"].ToString(),
                            Department_Id = sdr["Department_Id"].ToString(),
                            Department_name = sdr["Department_name"].ToString(),
                            Vendor_id = sdr["Vendor_id"].ToString(),
                            Vendor_name = sdr["Vendor_name"].ToString(),
                            Quantity = sdr["Quantity"].ToString()
                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@message"].Value.ToString();
                    return lst;
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        [System.Web.Services.WebMethod]
        public static string saveItemTransaction(string Transaction_id,string Item_Id, string Department_Id, string Vendor_id, string Quantity,string Transtype, string t_flag)
        {
          
            string response = string.Empty;
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_ItemTransaction]", con);

                    comm.CommandType = CommandType.StoredProcedure;
                    if (Transaction_id == "")
                    {
                        comm.Parameters.AddWithValue("@Transaction_id", null);
                    }
                    else
                    {
                        comm.Parameters.AddWithValue("@Transaction_id", Transaction_id);
                    }
                    comm.Parameters.AddWithValue("@Item_Id", Item_Id);
                    comm.Parameters.AddWithValue("@Department_Id", Department_Id);
                    comm.Parameters.AddWithValue("@Vendor_id", Vendor_id);
                    comm.Parameters.AddWithValue("@Quantity", Quantity);
                    comm.Parameters.AddWithValue("@Transtype", Transtype);
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
        public static int deleteItemTransaction(string Transaction_id)
        {
            int i;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("Store.dbo.[ST_ItemTransaction]", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@t_flag", "D");
                com.Parameters.Add("@message", SqlDbType.VarChar, 500);
                com.Parameters["@message"].Direction = ParameterDirection.Output;
                com.Parameters.AddWithValue("@Transaction_id", Transaction_id);
                i = com.ExecuteNonQuery();
                message = (string)com.Parameters["@message"].Value.ToString();
                con.Close();
            }

            return i;
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ListItem> GetItem()
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Store.dbo.[ST_ItemMaster]"))
                {
                   
                    cmd.Parameters.AddWithValue("@t_flag", "SI");
                    cmd.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    cmd.Parameters["@message"].Direction = ParameterDirection.Output;
                    List<ListItem> customers = new List<ListItem>();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            customers.Add(new ListItem
                            {
                                Value = sdr["Item_Id"].ToString(),
                                Text = sdr["Item_Name"].ToString()
                            });
                        }
                    }
                    message = (string)cmd.Parameters["@message"].Value.ToString();
                    con.Close();
                    return customers;
                }
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ListItem> GetDept()
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Store.dbo.[ST_DepartmentMaster]"))
                {

                    cmd.Parameters.AddWithValue("@t_flag", "S");
                    cmd.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    cmd.Parameters["@message"].Direction = ParameterDirection.Output;
                    List<ListItem> items = new List<ListItem>();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            items.Add(new ListItem
                            {
                                Value = sdr["Department_Id"].ToString(),
                                Text = sdr["Department_name"].ToString()
                            });
                        }
                    }
                    message = (string)cmd.Parameters["@message"].Value.ToString();
                    con.Close();
                    return items;
                }
            }
        }

        [System.Web.Services.WebMethod(EnableSession = true)]
        public static List<ListItem> GetVendor()
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Store.dbo.[ST_VendorMaster]"))
                {

                    cmd.Parameters.AddWithValue("@t_flag", "S");
                    cmd.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    cmd.Parameters["@message"].Direction = ParameterDirection.Output;
                    List<ListItem> items = new List<ListItem>();
                    con.Open();
                    cmd.Connection = con;
                    cmd.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        while (sdr.Read())
                        {
                            items.Add(new ListItem
                            {
                                Value = sdr["Vendor_id"].ToString(),
                                Text = sdr["Vendor_name"].ToString()
                            });
                        }
                    }
                    message = (string)cmd.Parameters["@message"].Value.ToString();
                    con.Close();
                    return items;
                }
            }
        }
    }

    public class Items_Transaction
    {
        public string Transaction_id { get; set; }
        public string Item_id { get; set; }
        public string Item_Name { get; set; }
        public string Transaction_date { get; set; }
        public string Department_Id { get; set; }
        public string Department_name { get; set; }
        public string Vendor_id { get; set; }
        public string Vendor_name { get; set; }
        public string Quantity { get; set; }

    }

}