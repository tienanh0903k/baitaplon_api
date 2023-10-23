using BusinessLogicLayer;
using DataModel;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SanPhamController : ControllerBase
    {
        private ISanPhamBusiness _sanphamBusiness;
        public SanPhamController(ISanPhamBusiness sanphamBusiness)
        {
            _sanphamBusiness = sanphamBusiness;
        }

        [HttpGet]
        [Route("get-by-id/{id}")]
        public SanPhamModels GetDatabyID(int id)
        {
            return _sanphamBusiness.GetDatabyID(id);
        }

        [Route("create-sp")]
        [HttpPost]
        public SanPhamModels Create([FromBody] SanPhamModels model)
        {
            _sanphamBusiness.Create(model);
            return model;
        }
    }
}
