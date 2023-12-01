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
        [Route("get-all")]
        public List<SanPhamModels> GetAll()
        {
            return _sanphamBusiness.GetAll();
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

        [Route("update-sp")]
        [HttpPut]
        public SanPhamModels Update([FromBody] SanPhamModels model)
        {
            _sanphamBusiness.Update(model);
            return model;
        }

        [Route("search-sp")]
        [HttpPost]
        public IActionResult Search([FromBody] Dictionary<string, object> formData)
        {
            try
            {
                var page = int.Parse(formData["page"].ToString());
                var pageSize = int.Parse(formData["pageSize"].ToString());
                string ten_sp = "";
                if (formData.Keys.Contains("ten_sp") && !string.IsNullOrEmpty(Convert.ToString(formData["ten_sp"]))) { ten_sp = Convert.ToString(formData["ten_sp"]); }
                string dia_chi = "";
                long total = 0;
                var data = _sanphamBusiness.Search(page, pageSize, out total, ten_sp);
                return Ok(
                    new
                    {
                        TotalItems = total,
                        Data = data,
                        Page = page,
                        PageSize = pageSize
                    }
                    );
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }




    }
}
