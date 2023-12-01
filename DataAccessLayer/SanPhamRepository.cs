using DataModel;
using Newtonsoft.Json;

namespace DataAccessLayer
{
    public class SanPhamRepository : ISanPhamRepository
    {
        private IDatabaseHelper _dbHelper;
        public SanPhamRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public SanPhamModels GetDatabyID(int id)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sanpham_get_by_id",
                     "@MaSanPham", id);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModels>().FirstOrDefault();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<SanPhamModels> GetByTheLoai(int danh_muc)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_LaySanPhamTheoChucNang",
                    "@ChucNang", danh_muc);
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);

                return dt.ConvertTo<SanPhamModels>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }



        public List<SanPhamModels> Search(int pageIndex, int pageSize, out long total, string ten_sp)
        {
            string msgError = "";
            total = 0;
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_san_pham_search",
                    "@page_index", pageIndex,
                    "@page_size", pageSize,
                    "@ten_san_pham", ten_sp
                    );
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                if (dt.Rows.Count > 0) total = (long)dt.Rows[0]["RecordCount"];
                return dt.ConvertTo<SanPhamModels>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        //getAll trang chuiu
        public List<AllProducts> GetAllHome()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_san_pham_get_all");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                string jsonString = dt.Rows[0]["AllProduct"].ToString();
                List<AllProducts> allProductsList = JsonConvert.DeserializeObject<List<AllProducts>>(jsonString);
                return allProductsList;
                //return dt.ConvertTo<AllProducts>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        public List<SanPhamModels> GetAll()
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "sp_san_pham_get_all");
                if (!string.IsNullOrEmpty(msgError))
                    throw new Exception(msgError);
                return dt.ConvertTo<SanPhamModels>().ToList();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        public bool Create(SanPhamModels model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_sanpham_create",
                    "@MaChuyenMuc", model.MaChuyenMuc,
                    "@TenSanPham", model.TenSanPham,
                    "@AnhDaiDien", model.AnhDaiDien,
                    "@NgayTao", model.NgayTao,
                    "@Gia", model.Gia,
                    "@SoLuong", model.SoLuong,
                    "@TrangThai", model.TrangThai,
                    "@LuotXem", model.LuotXem,
                    "@list_json_ct_sanpham", model.list_json_ctsanpham != null ? MessageConvert.SerializeObject(model.list_json_ctsanpham) : null
                );
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public bool Update(SanPhamModels model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_sanpham_update",
                    "@MaSanPham",  model.MaSanPham,
                    "@MaChuyenMuc", model.MaChuyenMuc,
                    "@TenSanPham", model.TenSanPham,
                    "@AnhDaiDien", model.AnhDaiDien,
                    "@NgayTao", model.NgayTao,
                    "@Gia", model.Gia,
                    "@SoLuong", model.SoLuong,
                    "@TrangThai", model.TrangThai,
                    "@LuotXem", model.LuotXem
                );
                if ((result != null && !string.IsNullOrEmpty(result.ToString())) || !string.IsNullOrEmpty(msgError))
                {
                    throw new Exception(Convert.ToString(result) + msgError);
                }
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


    }
}
