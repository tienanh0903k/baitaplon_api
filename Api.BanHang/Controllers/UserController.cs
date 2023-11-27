using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private IUserBusiness _userBusiness;
        public UserController(IUserBusiness userBusiness)
        {
            _userBusiness = userBusiness;
        }
        [HttpGet]
        //[Authorize]
        [Route("get-all")]
        public List<UserModel> GetAll()
        {
            return _userBusiness.GetAll();
        }

        [AllowAnonymous]
        [HttpPost("login")]
        public IActionResult Login([FromBody] AuthenticateModel model)
        {
            var user = _userBusiness.Login(model.Username, model.Password);
            if (user == null)
                return BadRequest(new { message = "Tài khoản hoặc mật khẩu không đúng!" });
            return Ok(new { mataikhoan = user.MaTaiKhoan, taikhoan = user.TenTaiKhoan, email = user.Email, token = user.token });
        }


        [Route("create-user")]
        [HttpPost]
        public UserModel CreateItem([FromBody] UserModel model)
        {
            _userBusiness.Create(model);
            return model;
        }

        [Route("update-khach")]
        [HttpPost]
        public UserModel UpdateItem([FromBody] UserModel model)
        {
            _userBusiness.Update(model);
            return model;
        }

        [Route("delete-user")]
        [HttpDelete]
        public UserModel DeleteItem(UserModel model)
        {
            _userBusiness.Delete(model);
            return model;
        }

      

    }
}
