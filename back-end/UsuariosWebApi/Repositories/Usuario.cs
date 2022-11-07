using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System.Data;
using UsuariosWebApi.Entities;
using UsuariosWebApi.Entities.DTO;

namespace UsuariosWebApi.Repositories
{
    public class Usuario : IUsuario
    {
        private readonly DbContext _usuarioDB;

        public Usuario(DbContext dbContext)
        {
            _usuarioDB = dbContext;
        }
        public async Task<int> DeleteUsuarioById(long? idUsuario)
        {
            var parameter = new List<SqlParameter>();
            parameter.Add(new SqlParameter("@IdUsuario", idUsuario));

            var result = await _usuarioDB.Database
           .ExecuteSqlRawAsync(@"exec DeleteUsuarioById @IdUsuario", parameter.ToArray());

            return result;
        }

        public async Task<List<Entities.Usuario>> GetUsuarios(UsuarioDTO usuario)
        {
            var parameter = new List<SqlParameter>();
            parameter.Add(new SqlParameter("@nombre", usuario.nombre != null ? usuario.nombre : DBNull.Value));
            parameter.Add(new SqlParameter("@apellido", usuario.apellido != null ? usuario.apellido : DBNull.Value));
            parameter.Add(new SqlParameter("@email", usuario.email != null ? usuario.email : DBNull.Value));
            parameter.Add(new SqlParameter("@telefono", usuario.telefono != null ? usuario.telefono : DBNull.Value));
            parameter.Add(new SqlParameter("@fechaNacimineto", usuario.fechaNacimiento != null ? usuario.fechaNacimiento : DBNull.Value));
            parameter.Add(new SqlParameter("@paisResidente", usuario.paisResidente != null ? usuario.paisResidente : DBNull.Value));

            var result = await _usuarioDB
           .Set<Entities.Usuario>().FromSqlRaw(@"exec GetUsuarios @nombre, @apellido, @email, @telefono, @fechaNacimineto, @paisResidente", parameter.ToArray())
           .ToListAsync();

            return result;
        }

        public async Task<int> InsertUsuario(UsuarioDTO usuario)
        {
            var parameter = new List<SqlParameter>();
            parameter.Add(new SqlParameter("@nombre", usuario.nombre));
            parameter.Add(new SqlParameter("@apellido", usuario.apellido));
            parameter.Add(new SqlParameter("@email", usuario.email));
            parameter.Add(new SqlParameter("@telefono", usuario.telefono));
            parameter.Add(new SqlParameter("@fechaNacimineto", usuario.fechaNacimiento));
            parameter.Add(new SqlParameter("@paisResidente", usuario.paisResidente));
            parameter.Add(new SqlParameter("@notificacion", usuario.notificacion));

            var result = await _usuarioDB.Database
           .ExecuteSqlRawAsync(@"exec InsertUsuario @nombre, @apellido, @email, @telefono, @fechaNacimineto, @paisResidente, @notificacion", parameter.ToArray());

            return result;
        }

        public async Task<int> UpdateUsuario(UsuarioDTO usuario)
        {
            var parameter = new List<SqlParameter>();
            parameter.Add(new SqlParameter("@IdUsuario", usuario.idUsuario));
            parameter.Add(new SqlParameter("@nombre", usuario.nombre));
            parameter.Add(new SqlParameter("@apellido", usuario.apellido));
            parameter.Add(new SqlParameter("@email", usuario.email));
            parameter.Add(new SqlParameter("@telefono", usuario.telefono));
            parameter.Add(new SqlParameter("@fechaNacimineto", usuario.fechaNacimiento));
            parameter.Add(new SqlParameter("@paisResidente", usuario.paisResidente));
            parameter.Add(new SqlParameter("@notificacion", usuario.notificacion));

            var result = await _usuarioDB.Database
           .ExecuteSqlRawAsync(@"exec UpdateUsuario @IdUsuario, @nombre, @apellido, @email, @telefono, @fechaNacimineto, @paisResidente, @notificacion", parameter.ToArray());

            return result;
        }

        public async Task<List<Entities.Actividad>> GetActividades()
        {
            var result = await _usuarioDB
           .Set<Entities.Actividad>().FromSqlRaw(@"exec GetActividades")
           .ToListAsync();

            return result;
        }
    }
}
