﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccessLayer;
using DataModel;

namespace BusinessLogicLayer
{
    public class DanhMucBusiness: IDanhMucBusiness
    {
        private IDanhMucRepository _res;
        public DanhMucBusiness(IDanhMucRepository res)
        {
            _res = res;
        }

        public List<DanhMucModel> GetDanhMuc(string name)
        {
            return _res.GetDanhMuc(name);
        }
    }
}
