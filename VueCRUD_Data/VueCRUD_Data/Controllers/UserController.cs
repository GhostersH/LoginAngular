using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;
using VueCRUD_Data.Models;

namespace VueCRUD_Data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        private readonly IWebHostEnvironment _env;
        public UserController(IConfiguration configuration, IWebHostEnvironment env)
        {
            _configuration = configuration;
            _env = env;
        }

        [HttpGet]
        public JsonResult Get()
        {
            string query = @"select UserId, Nombre, Mail, Password, Token from
                            Users";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("databaseAngular");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult(table);
        }

        [HttpPost]
        public JsonResult Post(User user)
        {
            string query = @"insert into Users
                            values (@Nombre, @Mail, @Password, @Token)";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("databaseAngular");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@Nombre", user.Nombre);
                    myCommand.Parameters.AddWithValue("@Mail", user.Mail);
                    myCommand.Parameters.AddWithValue("@Password", user.Password);
                    myCommand.Parameters.AddWithValue("@Token", user.Token);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Added Successfully");
        }

        [HttpPut]
        public JsonResult Put(User user)
        {
            string query = @"
                            update Users set
                             Nombre = @Nombre,
                            Mail = @Mail,
                            Password = @Password,
                            Token = @Token 
                            where UserId = @UserId";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("databaseAngular");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@UserId", user.UserID);
                    myCommand.Parameters.AddWithValue("@Nombre", user.Nombre);
                    myCommand.Parameters.AddWithValue("@Mail", user.Mail);
                    myCommand.Parameters.AddWithValue("@Password", user.Password);
                    myCommand.Parameters.AddWithValue("@Token", user.Token);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Updated Successfully");
        }

        [HttpDelete("{id}")]
        public JsonResult Delete(int id)
        {
            string query = @"delete from Users
                            where UserId = @UserId";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("databaseAngular");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@UserId", id);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Deleted Successfully");
        }


        ///AUTHENTICATION
        ///
        [HttpPost]
        [Route("login")]
        public Reply Login([FromBody]AccesViewModel model)
        {
            Reply oR = new Reply();
            oR.result = 0;
            try
            {
                string query = @"select UserId, Nombre, Mail, Password, Token from
                            Users where Mail = @Mail and Password = @Password";

                string queryUpdate = @"update Users set Token = @Token 
                            where Mail = @Mail";

                DataTable table = new DataTable();
                string sqlDataSource = _configuration.GetConnectionString("databaseAngular");
                SqlDataReader myReader;
                using (SqlConnection myCon = new SqlConnection(sqlDataSource))
                {
                    myCon.Open();
                    using (SqlCommand myCommand = new SqlCommand(query, myCon))
                    {
                        myCommand.Parameters.AddWithValue("@Mail", model.mail);
                        myCommand.Parameters.AddWithValue("@Password", model.password);
                        myReader = myCommand.ExecuteReader();
                        table.Load(myReader);
                        myReader.Close();
                        myCon.Close();
                    }

                    if(table.Rows.Count > 0)
                    {
                        oR.result = 1;
                        oR.message = "Datos correctos";
                        oR.data = Guid.NewGuid().ToString();

                        myCon.Open();
                        using (SqlCommand myCommand = new SqlCommand(queryUpdate, myCon))
                        {
                            myCommand.Parameters.AddWithValue("@Mail", model.mail);
                            myCommand.Parameters.AddWithValue("@Token", oR.data);
                            myReader = myCommand.ExecuteReader();
                            table.Load(myReader);
                            myReader.Close();
                            myCon.Close();
                        }

                    }
                    else
                    {
                        oR.result = 0;
                        oR.message = "Datos incorrectos";
                    }
                }
            }
            catch(Exception ex)
            {
                oR.message = "Error al iniciar sesion, intentelo nuevamente";
                //oR.message = ex.ToString();
            }
            return oR;
        }

    }
}
