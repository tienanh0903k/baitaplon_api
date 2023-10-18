using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;
using DataAccessLayer;

namespace DataAccessLayer
{
    public class NhaPhanPhoiRepository: INhaPhanPhoisRepository
    {
        private IDatabaseHelper _dbHelper;

        public NhaPhanPhoiRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public bool Create(NhaPhanPhois model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_nha_phan_phoi",
                "@TenNhaPhanPhoi", model.TenNhaPhanPhoi,
                "@DiaChi", model.DiaChi,
                "@SoDienThoai", model.SoDienThoai,
                "@Fax", model.Fax,
                "@MoTa", model.MoTa);
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


        public bool Create(NhaPhanPhois_SanPham model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_create_npp_sp",
                "@MaNhaPhanPhoi", model.MaNhaPhanPhoi,
                "@MaSanPham", model.MaSanPham
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
