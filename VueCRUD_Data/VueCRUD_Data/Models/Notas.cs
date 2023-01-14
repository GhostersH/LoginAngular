namespace VueCRUD_Data.Models
{
    public class Notas
    {
        public int NotaID { get; set; }
        public int UserID { get; set; }
        public string? ubicacion { get; set; }
        public DateTime fecha { get; set; }
        public string? nota { get; set; }
    }
}
