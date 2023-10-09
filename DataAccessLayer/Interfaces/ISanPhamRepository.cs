﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace DataAccessLayer
{
    public interface ISanPhamRepository
    {
        SanPhamModels GetDatabyID(int id);

        List<SanPhamModels> GetAll();
    }
}