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
    public partial class DepartmentMaster : System.Web.UI.Page
    {
        static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
        private static string message = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static List<Department_mast> BindDept_Master()
        {
            //string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<Department_mast> lst = new List<Department_mast>();
                using (SqlConnection con = new SqlConnection(cs))
                {


                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_DepartmentMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "S");
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        lst.Add(new Department_mast
                        {
                            Department_Id = sdr["Department_Id"].ToString(),
                            Department_name = sdr["Department_name"].ToString()
                        });
                    }
                    con.Close();
                    message = (string)comm.Parameters["@message"].Value.ToString();
                    return lst;


                 
                }
                //using (SqlConnection con = new SqlConnection(cs))
                //{

                //    SqlCommand comm = new SqlCommand("Store.dbo.ST_ItemMaster", con);
                //    comm.CommandType = CommandType.StoredProcedure;
                //    comm.Parameters.AddWithValue("@t_flag", "S");
                //    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                //    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                //    con.Open();

                //    using (SqlDataReader sdr = comm.ExecuteReader())
                //    {
                //        while (sdr.Read())
                //        {
                //            lst.Add(new Department_mast
                //            {
                //                Department_Id = sdr["Department_Id"].ToString(),
                //                Department_name = sdr["Department_name"].ToString()
                //            });
                //        }
                //    }
                //    con.Close();
                //    message = (string)comm.Parameters["@message"].Value.ToString();
                //    return lst;
                //}


            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        [WebMethod]
        public static List<Department_mast> BindDept_Wise(string Department_name)
        {
            //string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
            try
            {
                List<Department_mast> lst = new List<Department_mast>();
                using (SqlConnection con = new SqlConnection(cs))
                {


                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_DepartmentMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "SLIKE");
                    comm.Parameters.AddWithValue("@Department_name", Department_name);
                    
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();
                    while (sdr.Read())
                    {
                        lst.Add(new Department_mast
                        {
                            Department_Id = sdr["Department_Id"].ToString(),
                            Department_name = sdr["Department_name"].ToString()
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
        public static List<Department_mast> GetDeptMaster(int Department_Id)
        {
            string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ToString();

            try
            {
                List<Department_mast> lst = new List<Department_mast>();

                //using (SqlConnection con = new SqlConnection(constr))
                //{
                //    con.Open();
                //    SqlCommand comm = new SqlCommand("Store.dbo.[ST_DepartmentMaster]",con);
                //    comm.CommandType = CommandType.StoredProcedure;
                //    comm.Parameters.AddWithValue("@t_flag", "SID");
                //    comm.Parameters.Add(new SqlParameter("@Department_Id", Department_Id));
                //    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                //    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                //    SqlDataReader sdr = comm.ExecuteReader();
                //    while (sdr.Read())
                //    {
                //        lst.Add(new Department_mast
                //        {
                //            Department_Id = sdr["Department_Id"].ToString(),
                //            Department_name = sdr["Department_name"].ToString()
                //        });
                //    }
                //    con.Close();
                //    message = (string)comm.Parameters["message"].Value.ToString();
                //    return lst;
                //}
               
                using (SqlConnection con = new SqlConnection(constr))
                {

                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_DepartmentMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    comm.Parameters.AddWithValue("@t_flag", "SID");
                    comm.Parameters.AddWithValue("@Department_Id", Department_Id);
                    comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
                    comm.Parameters["@message"].Direction = ParameterDirection.Output;
                    con.Open();
                    //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
                    SqlDataReader sdr = comm.ExecuteReader();

                    while (sdr.Read())
                    {
                        lst.Add(new Department_mast
                        {
                           
                            Department_Id = sdr["Department_Id"].ToString(),
                            Department_name = sdr["Department_name"].ToString()
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
        public static string saveDepartmentMaster(string Department_Id,string Department_name, string t_flag)
        {

            string response = string.Empty;
            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();
                    SqlCommand comm = new SqlCommand("Store.dbo.[ST_DepartmentMaster]", con);
                    comm.CommandType = CommandType.StoredProcedure;
                    if (Department_Id == "")
                    {
                        comm.Parameters.AddWithValue("@Department_Id", null);
                    }
                    else
                    {
                        comm.Parameters.AddWithValue("@Department_Id", Department_Id);
                    }
                    comm.Parameters.AddWithValue("@Department_name", Department_name);
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
        public static int deleteDeptMaster(string Department_Id)
        {
            int i;
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();
                SqlCommand com = new SqlCommand("Store.dbo.[ST_DepartmentMaster]", con);
                com.CommandType = CommandType.StoredProcedure;
                com.Parameters.AddWithValue("@t_flag", "D");
                com.Parameters.Add("@message", SqlDbType.VarChar, 500);
                com.Parameters["@message"].Direction = ParameterDirection.Output;
                com.Parameters.AddWithValue("@Department_Id", Department_Id);
                i = com.ExecuteNonQuery();
                message = (string)com.Parameters["@message"].Value.ToString();
                con.Close();
            }
            return i;
        }

    }
    public class Department_mast
    {
        public string Department_Id { get; set; }
        public string Department_name { get; set; }
     
    }
}