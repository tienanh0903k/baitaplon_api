using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using BusinessLogicLayer;
using DataModel;

namespace Api.BanHang.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DanhMucController : ControllerBase
    {
        private IDanhMucBusiness _bus;
        public DanhMucController(IDanhMucBusiness bus)
        {
            _bus = bus;
        }

        [HttpGet]
        [Route("get-all")]
        public List<DanhMucModel> GetAllDanhMuc()
        {
            return _bus.GetAllDanhMuc();
        }

        [Route("create-danhmuc")]
        [HttpPost]
        public LoaiSanPhamModel CreateItem([FromBody] LoaiSanPhamModel model)
        {
            _bus.Create(model);
            return model;
        }

        [Route("update-danhmuc")]
        [HttpPost]
        public LoaiSanPhamModel UpdateItem([FromBody] LoaiSanPhamModel model)
        {
            _bus.Update(model);
            return model;
        }

        [Route("delete-danhmuc")]
        [HttpDelete]
        public LoaiSanPhamModel DeleteItem(LoaiSanPhamModel model)
        {
            _bus.Delete(model);
            return model;
        }
    }
}
