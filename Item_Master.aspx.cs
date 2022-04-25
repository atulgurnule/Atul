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
    public partial class Item_Master : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        private static string message = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<Items_Master> BindItems_Master()
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<Items_Master> lst = new List<Items_Master>();
                using (SqlConnection con = new SqlConnection(constr))
                {


                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_ItemMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        lst.Add(new Items_Master
                        {
                            Item_Id = Convert.ToInt32(sdr["Item_Id"].ToString()),
                            Item_Name = sdr["Item_Name"].ToString(),
                            Category = sdr["Category"].ToString(),
                            Rate = sdr["Rate"].ToString(),
                            Balance_Quantity = sdr["Balance_Quantity"].ToString()
                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@message"].Value.ToString();
                    return lst;


                    //SqlCommand comm = new SqlCommand("[ST_ItemMaster]", con);
                    //comm.CommandType = CommandType.StoredProcedure;
                    //comm.Parameters.AddWithValue("@t_flag", "S");
                    //comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    //comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    ////SqlParameter parmOUT = new SqlParameter("@message", SqlDbType.NVarChar, 500);
                    ////parmOUT.Direction = ParameterDirection.Output;
                    ////comm.Parameters.Add(parmOUT);

                    //con.Open(); 
                    //SqlDataReader sdr = comm.ExecuteReader();

                    //message = (string)comm.Parameters["@message"].Value.ToString();
                    //while (sdr.Read())
                    //{
                    //    lst.Add(new Items_Master
                    //    {
                    //        Item_Id = Convert.ToInt32(sdr["Item_Id"].ToString()),
                    //        Item_Name = sdr["Item_Name"].ToString(),
                    //        Category = sdr["Category"].ToString(),
                    //        Rate = Convert.ToInt32(sdr["Rate"].ToString()),
                    //        Balance_Quantity = Convert.ToInt32(sdr["Balance_Quantity"].ToString())

                    //    });
                    //}
                    //con.Close();
                    //message = (string)comm.Parameters["message"].Value.ToString();
                    //return lst;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        //[WebMethod]
        //public static List<Items_Master> BindItems_Master()
        //{
        //    string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        //    List<Items_Master> lst = new List<Items_Master>();
        //    using (SqlConnection conn=new SqlConnection(constr))
        //    {
        //        SqlCommand cmd = new SqlCommand("Store.dbo.[ST_ItemMaster]", conn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.AddWithValue("@t_flag", "S");
        //        cmd.Parameters.Add("@message", SqlDbType.VarChar, 500);
        //        cmd.Parameters["@message"].Direction = ParameterDirection.Output;
        //        conn.Open();
        //        SqlDataReader sdr = cmd.ExecuteReader();
        //        while (sdr.Read())
        //        {
        //            lst.Add(new Items_Master
        //            {

        //                Item_Id = Convert.ToInt32(sdr["Item_Id"].ToString()),
        //                Item_Name = sdr["Item_Name"].ToString(),
        //                Category = sdr["Category"].ToString(),
        //                Rate = sdr["Rate"].ToString(),
        //                Balance_Quantity = sdr["Balance_Quantity"].ToString()

        //            });
        //        }
        //        conn.Close();
        //        message = (string)cmd.Parameters["@message"].Value.ToString();

        //        return lst;
        //    }

        //}
        [WebMethod]
        public static List<Items_Master> BindItems_Wise(string Item_Name)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<Items_Master> lst = new List<Items_Master>();
                using (SqlConnection con = new SqlConnection(constr))
                {


                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_ItemMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "SLIKE");
                    comm.Parameters.AddWithValue("@Item_Name", Item_Name);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        lst.Add(new Items_Master
                        {
                            Item_Id = Convert.ToInt32(sdr["Item_Id"].ToString()),
                            Item_Name = sdr["Item_Name"].ToString(),
                            Category = sdr["Category"].ToString(),
                            Rate = sdr["Rate"].ToString(),
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
        public static List<Items_Master> GetItemMaster(string Item_Id)
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
                    comm.Parameters.AddWithValue("@Item_Id", Item_Id);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                   
                    while (sdr.Read())
                    {
                        lst.Add(new Items_Master
                        {
                            Item_Id = Convert.ToInt32(sdr["Item_Id"].ToString()),
                            Item_Name = sdr["Item_Name"].ToString(),
                            Category = sdr["Category"].ToString(),
                            Rate = sdr["Rate"].ToString(),
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

        [System.Web.Services.WebMethod]
        public static string saveItemMaster(string Item_Id,string Item_Name, int Category, float Rate, int Balance_Quantity, string t_flag)
        {

            string response = string.Empty;
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    
                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_ItemMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    if (Item_Id == "")
                    {
                        comm.Parameters.AddWithValue("@Item_Id", null);
                    }
                    else
                    {
                        comm.Parameters.AddWithValue("@Item_Id", Item_Id);
                    }
                    comm.Parameters.AddWithValue("@Item_Name", Item_Name);
                    comm.Parameters.AddWithValue("@Category", Category);
                    comm.Parameters.AddWithValue("@Rate", Rate);
                    comm.Parameters.AddWithValue("@Balance_Quantity", Balance_Quantity);
                    comm.Parameters.AddWithValue("@t_flag", t_flag);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
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
        public static int deleteItemMaster(string Item_Id)
        {
            int i;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("Store.dbo.[ST_ItemMaster]", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@t_flag", "D");
                com.Parameters.Add("@message", SqlDbType.VarChar, 500);
                com.Parameters["@message"].Direction = ParameterDirection.Output;
                com.Parameters.AddWithValue("@Item_Id", Item_Id);
                i = com.ExecuteNonQuery();
                message = (string)com.Parameters["@message"].Value.ToString();
                con.Close();
            }
            return i;
        }
    }
    public class Items_Master
    {
        public int Item_Id { get; set; }
        public string Item_Name { get; set; }
        public string Category { get; set; }
        public string Rate { get; set; }
        public string Balance_Quantity { get; set; }
   
    }
}