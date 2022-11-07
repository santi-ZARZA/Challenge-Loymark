using UsuariosWebApi.Entities;
using UsuariosWebApi.Entities.DTO;

namespace UsuariosWebApi.Repositories
{
    public interface IUsuario
    {
        Task<List<Entities.Usuario>> GetUsuarios(UsuarioDTO usuario);
        Task<int> DeleteUsuarioById(Nullable<long> idUsuario);
        Task<int> UpdateUsuario(UsuarioDTO usuario);
        Task<int> InsertUsuario(UsuarioDTO usuario);
        Task<List<Entities.Actividad>> GetActividades();

    }
}
