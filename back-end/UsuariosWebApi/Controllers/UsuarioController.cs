using Microsoft.AspNetCore.Cors;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using UsuariosWebApi.Entities;
using UsuariosWebApi.Entities.DTO;
using UsuariosWebApi.Repositories;

namespace UsuariosWebApi.Controllers
{
    [EnableCors]
    [Route("api/[controller]")]
    [ApiController]
    public class UsuarioController : ControllerBase
    {
        
        private readonly ILogger<UsuarioController> _logger;
        private readonly IUsuario _usuario;

        public UsuarioController(ILogger<UsuarioController> logger, IUsuario usuario)
        {
            _logger = logger;
            _usuario = usuario;
        }

        [HttpGet]
        [Route("actividad")]
        public async Task<ActionResult<List<Entities.Actividad>>> GetActividades()
        {
            return Ok(await _usuario.GetActividades());
        }

        //[HttpGet(Name = "GetNumber")]
        [HttpGet]
        //Nullable<int> telefono, bool notificacion, string fechaNacimiento="", string paisResidente = "", string nombre = "", string apellido = "", string email = ""
        public async Task<ActionResult<List<Entities.Usuario>>> Get([FromQuery] UsuarioDTO filtro)
        {
            //var filtro = new UsuarioDTO()
            //{
            //    nombre = nombre,
            //    apellido = apellido,
            //    email = email,
            //    telefono = telefono,
            //    fechaNacimiento = fechaNacimiento,
            //    paisResidente = paisResidente,
            //    notificacion = notificacion
            //};
            return Ok(await _usuario.GetUsuarios(filtro));
        }


        [HttpPost]
        public async Task<int> Post([FromBody] UsuarioDTO usuario)
        {
            return await _usuario.InsertUsuario(usuario);
        }

        [HttpPut]
        public async Task<int> Put([FromBody] UsuarioDTO usuario)
        {
            return await _usuario.UpdateUsuario(usuario);
        }

        [HttpDelete]
        public async Task<int> Delete([FromQuery] long idUsuario)
        {
            return await _usuario.DeleteUsuarioById(idUsuario);
        }
    }
}
