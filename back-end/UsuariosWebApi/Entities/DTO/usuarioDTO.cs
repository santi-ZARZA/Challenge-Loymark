using System.Text.Json.Serialization;

namespace UsuariosWebApi.Entities.DTO
{
    public class UsuarioDTO
    {
        public Nullable<long> idUsuario { get; set; }
        public string nombre { get; set; }
        public string apellido { get; set; }
        public string email { get; set; }
        public Nullable<int> telefono { get; set; }
        public string fechaNacimiento { get; set; }
        public string paisResidente { get; set; }
        public bool notificacion { get; set; }
    }
}
