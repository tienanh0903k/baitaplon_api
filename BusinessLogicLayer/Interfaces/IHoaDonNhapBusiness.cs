﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataModel;

namespace BusinessLogicLayer
{
    public partial interface IHoaDonNhapBusiness
    {
        List<HoaDonNhapModel> GetAll();
    }
}
