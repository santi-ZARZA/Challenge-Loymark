using System.ComponentModel.DataAnnotations;

namespace UsuariosWebApi.Entities
{
    public class Usuario
    {
        [Key]
        public Nullable<long> idUsuario { get; set; }
        
        public string nombre { get; set; }
        public string apellido { get; set; }
        public string email { get; set; }
        public Nullable<int> telefono { get; set; }
        [DataType(DataType.Date)]
        [DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:MM/dd/yyyy}")]
        public DateTime fechaNacimiento { get; set; }
        public string paisResidente { get; set; }
        public bool notificacion { get; set; }
    }
}
