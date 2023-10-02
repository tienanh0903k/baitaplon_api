using DataModel;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessLogicLayer
{
    public partial interface IUserBusiness
    {
        List<UserModel> GetAll();
        bool Create(UserModel model);
        bool Update(UserModel model);
        bool Delete(UserModel model);
        UserModel Login(string taikhoan, string matkhau);
    }
}
