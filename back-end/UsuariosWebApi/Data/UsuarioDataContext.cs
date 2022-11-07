using Microsoft.EntityFrameworkCore;
using UsuariosWebApi.Entities;

namespace UsuariosWebApi.Data
{
    public class UsuarioDataContext : DbContext
    {
        protected readonly IConfiguration Configuration;

        //public DataContext(IConfiguration configuration) => Configuration = configuration;

        public UsuarioDataContext(DbContextOptions<UsuarioDataContext> options) : base(options)
        { }

        public DbSet<Usuario> Usuarios { get; set; }
        public DbSet<Actividad> Actividades { get; set; }

    }
}
