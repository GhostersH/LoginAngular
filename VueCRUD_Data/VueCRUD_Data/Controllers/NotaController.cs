using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Data;
using System.Data.SqlClient;
using VueCRUD_Data.Models;

namespace VueCRUD_Data.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NotaController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        private readonly IWebHostEnvironment _env;
        public NotaController(IConfiguration configuration, IWebHostEnvironment env)
        {
            _configuration = configuration;
            _env = env;
        }

        [HttpGet]
        public JsonResult Get()
        {
            string query = @"select NotaId, UserId, ubicacion, fecha, nota from
                            Nota";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("VueCRUD");
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
        public JsonResult Post(Notas nota)
        {
            string query = @"insert into Nota
                            values (@UserId, @ubicacion, @fecha, @nota)";

            DataTable table = new DataTable();
            string sqlDataSource = _configuration.GetConnectionString("VueCRUD");
            SqlDataReader myReader;
            using (SqlConnection myCon = new SqlConnection(sqlDataSource))
            {
                myCon.Open();
                using (SqlCommand myCommand = new SqlCommand(query, myCon))
                {
                    myCommand.Parameters.AddWithValue("@UserId", nota.UserID);
                    myCommand.Parameters.AddWithValue("@ubicacion", nota.ubicacion);
                    myCommand.Parameters.AddWithValue("@fecha", nota.fecha);
                    myCommand.Parameters.AddWithValue("@nota", nota.nota);
                    myReader = myCommand.ExecuteReader();
                    table.Load(myReader);
                    myReader.Close();
                    myCon.Close();
                }
            }

            return new JsonResult("Added Successfully");
        }


    }
}
