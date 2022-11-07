using System.ComponentModel.DataAnnotations;

namespace UsuariosWebApi.Entities
{
    public class Actividad
    {
        [Key]
        public long idActividad { get; set; }
        public DateTime fechaCreacion { get; set; }
        public long idUsuario { get; set; }
        public string nombreCompleto { get; set; }
        public string actividad { get; set; }

    }
}
