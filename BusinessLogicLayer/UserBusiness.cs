using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Net.Sockets;
using System.Security.Claims;
using System.Text;

namespace BusinessLogicLayer
{
    public class UserBusiness:IUserBusiness
    {
        private IUserRepository _res;
        private string secret;
        public UserBusiness(IUserRepository res, IConfiguration configuration)
        {
            _res = res;
            secret = configuration["AppSettings:Secret"];
        }

        public List<UserModel> GetAll()
        {
            return _res.GetAll();
        }

        public UserModel Login(string taikhoan, string matkhau)
        {
            var user = _res.Login(taikhoan, matkhau);
            if (user == null)
                return null; 
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.TenTaiKhoan.ToString()),
                    new Claim(ClaimTypes.StreetAddress, user.Email)
                }),
                Expires = DateTime.UtcNow.AddDays(7),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.Aes128CbcHmacSha256)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            user.token = tokenHandler.WriteToken(token);
            return user; 
        }
        //them tai khoan
        public bool Create(UserModel model)
        {
            return _res.Create(model);
        }

        public bool Update(UserModel model)
        {
            return _res.Update(model);
        }
        //xoa tk
        public bool Delete(UserModel model)
        {
            return _res.Delete(model);
        }
    }
}