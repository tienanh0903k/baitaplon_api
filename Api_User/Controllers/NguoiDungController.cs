using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using DataModel;
using BusinessLogicLayer;

namespace Api_User.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class NguoiDungController : ControllerBase
    {
        private IUserBusiness _userBusiness;
        public NguoiDungController(IUserBusiness userBusiness)
        {
            _userBusiness = userBusiness;
        }
        //api cho nguoi dung dang nhap
        [HttpPost("login")]
        public IActionResult Login([FromBody] AuthenticateModel model)
        {
            var user = _userBusiness.Login(model.Username, model.Password);
            if (user == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu không đúng!" });
            return Ok(new { taikhoan = user.TenTaiKhoan, email = user.Email, token = user.token });
        }

        //api dang ky cho nguoi dung tao tai khoan
        [Route("create-user")]
        [HttpPost]
        public UserModel CreateItem([FromBody] UserModel model)
        {
            _userBusiness.Create(model);
            return model;
        }
    }
}
