using BusinessLogicLayer;
using DataAccessLayer;
using DataModel;
using System.Reflection;

namespace BusinessLogicLayer
{
    public class SanPhamBusiness: ISanPhamBusiness
    {
        private ISanPhamRepository _res;
        public SanPhamBusiness(ISanPhamRepository res)
        {
            _res = res;
        }

        //for admin
        public SanPhamModels GetDatabyID(int id)
        {
            return _res.GetDatabyID(id);
        }

        public List<SanPhamModels> GetAll(string ten_cm)
        {
            string msgError = "";
            try
            {
                if (string.IsNullOrEmpty(ten_cm))
                {
                    // Xử lý trường hợp ten_cm là null hoặc rỗng
                    // Lấy tất cả sản phẩm hoặc thực hiện tương tự
                    return _res.GetAll(null);
                }
                else
                {
                    // Xử lý trường hợp ten_cm có giá trị
                    // Lấy sản phẩm theo danh mục hoặc thực hiện tương tự
                    return _res.GetAll(ten_cm);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModels> Search(int pageIndex, int pageSize, out long total, string ten_sp)
        {
            return _res.Search(pageIndex, pageSize, out total, ten_sp);
        }

        public bool Create(SanPhamModels model)
        {
            return _res.Create(model);
        }



        //get all trang chu cho nguoi dung
        public List<AllProducts> GetAllHome()
        {
            return _res.GetAllHome();
        }
    }
}
