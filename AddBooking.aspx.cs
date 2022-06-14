using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
using System.Web.Script.Serialization;
using System.Web.Services;


namespace WebShop
{
  public partial class AddBooking : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      if (!IsPostBack)
      {
        //if (Request.QueryString["t_tano"] != null)
        //  HttpContext.Current.Session.Add("t_tano", Request.QueryString["t_tano"].ToString());
        if (Session["t_usid"] != null)
        {
          HttpContext.Current.Session["t_usid"] = Session["t_usid"].ToString();
        }

      }
    }

    private static string message = string.Empty;
    static string cs = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;

    [WebMethod]
    public static List<tdtst1505m000> GetItemDescription(string t_item)
    {
      try
      {
        List<tdtst1505m000> prclst = new List<tdtst1505m000>();
        using (SqlConnection con = new SqlConnection(cs))
        {

          con.Open();

          SqlCommand comm = new SqlCommand("testdb..[WS_GetCustItemMaster]", con);
          comm.CommandType = CommandType.StoredProcedure;
          //comm.Parameters.AddWithValue("@Action", "SELECTID");
          comm.Parameters.Add(new SqlParameter("@item", t_item));
          //comm.Parameters.Add("@message", SqlDbType.Char, 500);
          //comm.Parameters["@message"].Direction = ParameterDirection.Output;

          SqlDataReader rdr = comm.ExecuteReader();

          while (rdr.Read())
          {
            prclst.Add(new tdtst1505m000
            {

              t_dsca = rdr["t_dsca"].ToString(),

            });
          }
          con.Close();
          //message = (string)comm.Parameters["@message"].Value;
          return prclst;
        }
      }
      catch (Exception ex)
      {
        throw ex;
      }
    }

    [WebMethod]
    public static List<ttdtst100100> GetCustInfo(string t_scbp)
    {
      try
      {
        List<ttdtst100100> prclst = new List<ttdtst100100>();
        using (SqlConnection con = new SqlConnection(cs))
        {

          con.Open();

          SqlCommand comm = new SqlCommand("select t_bpid,t_desc,t_phne from swlive..ttdtst100100 where t_bpid='" + t_scbp + "'", con);
          //comm.CommandType = CommandType.StoredProcedure;
          //comm.Parameters.AddWithValue("@Action", "SELECTID");
          //comm.Parameters.Add(new SqlParameter("@t_bpid", t_scbp));

          SqlDataReader rdr = comm.ExecuteReader();
          while (rdr.Read())
          {
            prclst.Add(new ttdtst100100
            {

              t_desc = rdr["t_desc"].ToString(),
              t_phne = rdr["t_phne"].ToString()

            });
          }
          con.Close();

          return prclst;
        }
      }
      catch (Exception ex)
      {
        throw ex;
      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst172100> BindBookingDetails(string t_bkno)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst172100> Prdlst = new List<ttdtst172100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_AddBooking]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_bkno", t_bkno);

          comm.Parameters.AddWithValue("@t_flag", "S");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
          comm.Parameters.Add("@totalamt", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
          comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;
          comm.Parameters["@totalamt"].Direction = ParameterDirection.Output;
          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst172100
            {
              t_bkno = sdr["t_bkno"].ToString(),
              t_pono = sdr["t_pono"].ToString(),
              t_item = sdr["t_item"].ToString(),
              t_itemdsca = sdr["t_itemdsca"].ToString(),
              t_qoor = Convert.ToSingle(sdr["t_qoor"].ToString()),
              t_pric = Convert.ToSingle(sdr["t_pric"].ToString()),
              t_oamt = Convert.ToSingle(sdr["t_oamt"].ToString()),
              t_qtno = sdr["t_qtno"].ToString(),
              BookStatus = sdr["BookStatus"].ToString()

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return Prdlst;
        }

      }
      catch (Exception ex)
      {
        throw ex;
      }

    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst171100> GetBookingHeader(string t_bkno)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst171100> Prdlst = new List<ttdtst171100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_AddBooking]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_bkno", t_bkno);

          comm.Parameters.AddWithValue("@t_flag", "H");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
          comm.Parameters.Add("@totalamt", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
          comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;
          comm.Parameters["@totalamt"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst171100
            {
              t_bkno = sdr["t_bkno"].ToString(),
              t_date = sdr["t_date"].ToString(),
              t_prbp = sdr["t_prbp"].ToString(),
              t_srep = sdr["t_srep"].ToString(),
              t_scbp = sdr["t_scbp"].ToString(),
              t_tdlg = sdr["t_tdlg"].ToString(),
              t_advc = Convert.ToSingle(sdr["t_advc"].ToString()),
              t_amnt = Convert.ToSingle(sdr["t_amnt"].ToString())

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return Prdlst;
        }

      }
      catch (Exception ex)
      {
        throw ex;
      }
    }

    [System.Web.Services.WebMethod(EnableSession = true)]
    public static List<ttdtst172100> GetBookingDetails(string t_bkno, string t_pono)
    {
      string constr = ConfigurationManager.ConnectionStrings["SqlConn"].ConnectionString;
      try
      {
        List<ttdtst172100> Prdlst = new List<ttdtst172100>();
        using (SqlConnection con = new SqlConnection(constr))
        {

          con.Open();
          SqlCommand comm = new SqlCommand("testdb..[WS_AddBooking]", con);
          comm.CommandType = CommandType.StoredProcedure;
          comm.Parameters.AddWithValue("@t_bkno", t_bkno);
          comm.Parameters.AddWithValue("@t_pono_code", t_pono);
          comm.Parameters.AddWithValue("@t_flag", "R");
          comm.Parameters.Add("@message", SqlDbType.VarChar, 500);
          comm.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
          comm.Parameters.Add("@totalamt", SqlDbType.VarChar, 500);
          comm.Parameters["@message"].Direction = ParameterDirection.Output;
          comm.Parameters["@new_identity"].Direction = ParameterDirection.Output;
          comm.Parameters["@totalamt"].Direction = ParameterDirection.Output;

          //comm.Parameters.Add(new SqlParameter("@t_orno", SalOrd));
          SqlDataReader sdr = comm.ExecuteReader();
          while (sdr.Read())
          {
            Prdlst.Add(new ttdtst172100
            {
              t_bkno = sdr["t_bkno"].ToString(),
              t_pono = sdr["t_pono"].ToString(),
              t_item = sdr["t_item"].ToString(),
              t_qoor = Convert.ToSingle(sdr["t_qoor"].ToString()),
              t_pric = Convert.ToSingle(sdr["t_pric"].ToString()),
              t_oamt = Convert.ToSingle(sdr["t_oamt"].ToString()),
              t_qtno = sdr["t_qtno"].ToString(),
              t_itemdsca = sdr["t_itemdsca"].ToString(),

            });
          }
          con.Close();
          message = (string)comm.Parameters["@message"].Value.ToString();
          return Prdlst;
        }

      }
      catch (Exception ex)
      {
        throw ex;
      }

    }

    [System.Web.Services.WebMethod]
    public static String[] deleteBookingDetails(string t_bkno, string t_pono)
    {
      string i_msg, status; ;
      string comb = string.Empty;
      i_msg = "";
      float t_amt = 0;
      string[] output = new string[] { "", "" };

      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      sqlcom.Parameters.AddWithValue("@t_bkno", t_bkno);
      sqlcom.Parameters.AddWithValue("@t_pono_code", t_pono);
      sqlcom.Parameters.AddWithValue("@t_flag", "D");
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
      sqlcom.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
      sqlcom.Parameters.Add("@totalamt", SqlDbType.VarChar, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@totalamt"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "testdb..[WS_AddBooking]";

      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString();
        status = (string)sqlcom.Parameters["@new_identity"].Value.ToString();
        t_amt = Convert.ToSingle((string)sqlcom.Parameters["@totalamt"].Value.ToString().Trim());
        msg1 = result;
        comb = i_msg + "," + status + "," + t_amt;
        output = comb.Split(',');

        if (result == "success")
        {
          return output;
        }
        else
        {
          string comb1 = result;
          output = comb1.Split(',');
          return output;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return output;
      }
      //return output;
    }


    [System.Web.Services.WebMethod]
    public static String[] saveBooking(string t_bkno, string t_date, string t_prbp, string t_srep, string t_scbp,
     string t_tdlg, string t_advc, string t_item, string t_qoor, string t_pric,
     string t_oamt, string t_qtno, string t_flag, string t_pono_code)
    {

      string i_bkno;
      string i_msg;
      i_msg = "";
      float t_amt = 0;
      string[] output = new string[] { "", "" };


      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      if (t_bkno == "")
      {
        sqlcom.Parameters.AddWithValue("@t_bkno", null);
      }
      else
      {
        sqlcom.Parameters.AddWithValue("@t_bkno", t_bkno);
      }
      sqlcom.Parameters.AddWithValue("@t_date", t_date);
      sqlcom.Parameters.AddWithValue("@t_prbp", t_prbp);
      sqlcom.Parameters.AddWithValue("@t_srep", t_srep);
      sqlcom.Parameters.AddWithValue("@t_scbp", t_scbp);
      sqlcom.Parameters.AddWithValue("@t_tdlg", t_tdlg);
      //sqlcom.Parameters.AddWithValue("@t_amnt", t_amnt);
      sqlcom.Parameters.AddWithValue("@t_advc", t_advc);
      sqlcom.Parameters.AddWithValue("@t_item", t_item);
      sqlcom.Parameters.AddWithValue("@t_qoor", t_qoor);
      sqlcom.Parameters.AddWithValue("@t_pric", t_pric);
      sqlcom.Parameters.AddWithValue("@t_oamt", t_oamt);
      sqlcom.Parameters.AddWithValue("@t_qtno", t_qtno);
      sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
      sqlcom.Parameters.AddWithValue("@t_pono_code", Convert.ToInt16(t_pono_code));
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
      sqlcom.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
      sqlcom.Parameters.Add("@totalamt", SqlDbType.VarChar, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@totalamt"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_AddBooking";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_bkno = (string)sqlcom.Parameters["@new_identity"].Value.ToString().Trim();
        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString().Trim();
        t_amt = Convert.ToSingle((string)sqlcom.Parameters["@totalamt"].Value.ToString().Trim());
        HttpContext.Current.Session.Add("t_bkno", i_bkno);
        msg1 = result;
        string comb = i_bkno + "," + i_msg + "," + t_amt;
        output = comb.Split(',');
        if (result == "success")
        {
          return output;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return output;
      }
      return output;
    }

    [System.Web.Services.WebMethod]
    public static String[] saveHeader(string t_bkno, string t_date, string t_prbp, string t_srep, string t_scbp,
     string t_tdlg, string t_advc, string t_flag, string t_pono_code)
    {

      string i_bkno;
      string i_msg;
      i_msg = "";
      float t_amt = 0;
      string[] output = new string[] { "", "" };


      NBDataAccess NBData = new NBDataAccess();
      NBDataAccess.ErrorAttributes objErr = new NBDataAccess.ErrorAttributes();
      SqlCommand sqlcom = new SqlCommand();
      sqlcom.CommandType = CommandType.StoredProcedure;
      if (t_bkno == "")
      {
        sqlcom.Parameters.AddWithValue("@t_bkno", null);
      }
      else
      {
        sqlcom.Parameters.AddWithValue("@t_bkno", t_bkno);
      }
      sqlcom.Parameters.AddWithValue("@t_date", t_date);
      sqlcom.Parameters.AddWithValue("@t_prbp", t_prbp);
      sqlcom.Parameters.AddWithValue("@t_srep", t_srep);
      sqlcom.Parameters.AddWithValue("@t_scbp", t_scbp);
      sqlcom.Parameters.AddWithValue("@t_tdlg", t_tdlg);
      //sqlcom.Parameters.AddWithValue("@t_amnt", t_amnt);
      sqlcom.Parameters.AddWithValue("@t_advc", t_advc);
     
      sqlcom.Parameters.AddWithValue("@t_flag", t_flag);
      sqlcom.Parameters.AddWithValue("@t_pono_code", Convert.ToInt16(t_pono_code));
      sqlcom.Parameters.Add("@message", SqlDbType.VarChar, 500);
      sqlcom.Parameters.Add("@new_identity", SqlDbType.VarChar, 500);
      sqlcom.Parameters.Add("@totalamt", SqlDbType.VarChar, 500);
      sqlcom.Parameters["@message"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@new_identity"].Direction = ParameterDirection.Output;
      sqlcom.Parameters["@totalamt"].Direction = ParameterDirection.Output;
      sqlcom.CommandText = "WS_AddBooking";
      string result = "", msg1 = "";
      try
      {
        result = NBData.ExecuteCommand(sqlcom, ref objErr);
        i_bkno = (string)sqlcom.Parameters["@new_identity"].Value.ToString().Trim();
        i_msg = (string)sqlcom.Parameters["@message"].Value.ToString().Trim();
        t_amt = Convert.ToSingle((string)sqlcom.Parameters["@totalamt"].Value.ToString().Trim());
        HttpContext.Current.Session.Add("t_bkno", i_bkno);
        msg1 = result;
        string comb = i_bkno + "," + i_msg + "," + t_amt;
        output = comb.Split(',');
        if (result == "success")
        {
          return output;
        }
      }
      catch (Exception ex)
      {
        result = ex.Message;
        return output;
      }
      return output;
    }

  }

  public class tdtst1505m000
  {

    public string t_item { get; set; }
    public string t_dsca { get; set; }
    public string t_unit { get; set; }

  }
  public class ttdtst100100
  {

    public string t_bpid { get; set; }
    public string t_desc { get; set; }
    public string t_phne { get; set; }

  }
  public class ttdtst172100
  {
    public string t_link { get; set; }
    public string t_bkno { get; set; }
    public string t_pono { get; set; }
    public string t_item { get; set; }
    public string t_itemdsca { get; set; }
    public float t_qoor { get; set; }
    public float t_pric { get; set; }
    public float t_oamt { get; set; }
    public string t_qtno { get; set; }
    public string BookStatus { get; set; }
    

  }



}
