using DataModel;

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

        public List<SanPhamModels> GetAll(string tenChuyenMuc)
        {
            string msgError = "";
            try
            {
                var dt = _dbHelper.ExecuteSProcedureReturnDataTable(out msgError, "GetAllSanPhamByDanhMuc", "@TenChuyenMuc", tenChuyenMuc);

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


    }
}
