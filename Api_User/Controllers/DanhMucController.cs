using Microsoft.AspNetCore.Mvc;
using DataModel;
using BusinessLogicLayer;

namespace Api_User.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DanhMucController : ControllerBase
    {

        private IDanhMucBusiness _danhmucBusiness;
        public DanhMucController(IDanhMucBusiness danhmucBusiness)
        {
            _danhmucBusiness = danhmucBusiness;
        }


        [HttpGet]
        [Route("get-product-by/{name}")]
        public List<DanhMucModel> GetDanhMuc(string name)
        {
            return _danhmucBusiness.GetDanhMuc(name);
        }


        [HttpGet]
        [Route("get-similar/{maDM}")]
        public List<DanhMucModel> GetSimilar(int maDM)
        {
            return _danhmucBusiness.GetSimilar(maDM);
        }
    }
}
