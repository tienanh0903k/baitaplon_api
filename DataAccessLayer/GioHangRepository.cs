using DataModel;

namespace DataAccessLayer
{
    public class GioHangRepository:IGioHangRepository
    {   
        private IDatabaseHelper _dbHelper;
        public GioHangRepository(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }


         
        public bool Create(GioHangModel model)
        {
            string msgError = "";
            try
            {
                var result = _dbHelper.ExecuteScalarSProcedureWithTransaction(out msgError, "sp_giohang_create",
                "@MaTaiKhoan", model.MaTaiKhoan,
                "@list_json_chitiet_giohang", model.list_ct_gio_hang != null ? MessageConvert.SerializeObject(model.list_ct_gio_hang) : null);
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
