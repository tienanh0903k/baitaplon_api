var app = angular.module("AppBanHang", []);
app.controller("AdminHoaDonBan", function ($scope, $http, $location) {
  //thong tin hoa don
  $scope.listHoaDon;
  
  $scope.madonhang = JSON.parse(localStorage.getItem("madonhang"));
  $scope.tenKhachHang;
  $scope.diaChi;
  $scope.ngaytao;
  $scope.tongtien;
  $scope.trangThaiGiaoHang;
  $scope.maHoaDon;
  $scope.sdt;
  $scope.id;

  //khai bao don hang
  $scope.detailDonHang = {};

  $scope.Load = function () {
    if ($scope.madonhang) {
      $scope.getHoaDon();
      $scope.getDonHang();
    }
  };
  $scope.getHoaDon = function () {
    $http({
      method: "GET",
      url: "https://localhost:44306/api/HoaDon/get-all",
    }).then(function (res) {
      $scope.listHoaDon = res.data;
      console.log($scope.listHoaDon);
    });
  };


  $scope.getDonHang = function () {
    $http({
      method: "GET",
      url:
        "https://localhost:44306/api/DonHangs/get-detail/" + $scope.madonhang,
    }).then(function (response) {
      $scope.donhang = response.data[0];
      console.log($scope.donhang);
      let khachang = $scope.donhang.list_json_chitiet_khachhang[0];
      let sanpham = $scope.donhang.list_json_chitiet_donhang;
      $scope.detailDonHang = Object.assign({}, khachang, { list: sanpham });
      $scope.detailDonHang.id = $scope.donhang.maDonHang;
      //console.log($scope.detailDonHang);

      $scope.tenKhachHang = $scope.detailDonHang.tenKH;
      $scope.id = $scope.madonhang;
      $scope.diaChi = $scope.detailDonHang.diaChi;
      $scope.tongtien = 0;
      $scope.sdt = $scope.detailDonHang.sdt;

      let arr = $scope.detailDonHang.list;

      $scope.newArray = arr.map(function (item) {
        return {
          maSanPham: item.maSanPham,
          tongGia: item.giaMua,
          soLuongXuat: item.soLuong,
        };
      });
      console.log("nta",$scope.newArray);
      let items = $scope.detailDonHang.list;
      for (let i = 0; i < items.length; ++i) {
        //console.log(items[i]);
        $scope.tongtien += parseInt(items[i].giaMua * items[i].soLuong);
        console.log($scope.tongtien); //NaN
      }
    });
  };
  

  



  $scope.ThemHoaDon = function (event) {
    event.preventDefault();
    $http({
      method: "POST",
      url: "https://localhost:44306/api/HoaDon/create-hoadon",
      data: {
        maDonHang: $scope.madonhang,
        tenKH: $scope.detailDonHang.tenKH,
        diachi: $scope.detailDonHang.diaChi,
        trangThai: true,
        tongGia: $scope.tongtien,
        list_json_chitiethoadon: $scope.newArray,
      },
    })
      .then(function (response) {
        if (response.status === 200) {
          alert("Them hóa đơn thành công");
        }
        $scope.Load();
      })
      .catch(function (err) {
        console.log(err);
      });
  };


  $scope.CapNhat = function () {
    $http({
      method: "POST",
      url: "https://localhost:44306/api/HoaDon/update-hoadon",
      data: {
        maHoaDon: $scope.maHoaDon,
        maDonHang: $scope.madonhang,
        tenKH: $scope.tenKhachHang,
        diachi: $scope.diaChi,
        trangThai: true,
        tongGia: $scope.tongtien,
        list_json_chitiethoadon: [{}],
      },
    })
      .then(function (response) {
        if (response.status === 200) {
          alert("Sua thanh cong");
        }
      })
      .catch(function (err) {
        console.log(err);
      });
   }
 

  $scope.Sua = function(obj) {
     $scope.maHoaDon = obj.maHoaDon;
     $scope.madonhang = obj.maDonHang;
     $scope.tenKhachHang = obj.tenKH;
     $scope.diaChi = obj.diachi;
     $scope.ngaytao = obj.ngayTao;
     $scope.tongtien = obj.tongGia;
     $scope.sdt = obj.sdt;
     $scope.getDonHang();
  }

  

  $scope.NhapMoi = function() {
     $scope.maHoaDon = "";
     $scope.madonhang = "";
     $scope.tenKhachHang = "";
     $scope.diaChi = "";
     $scope.ngaytao = "";
     $scope.tongtien = "";
     $scope.sdt = "";
  }
  


  $scope.Xoa = function(obj) {
    let id = obj.maHoaDon;
    $http({
      method: "DELETE",
      url: "https://localhost:44306/api/HoaDon/update-hoadon/"+id,
    }).then(function (response) {
      if(response.status === 200) {
        alert(response.data.message);
        $scope.Load();
      }
    })
  }
  
  $scope.tenkh;
  $scope.fromDate;
  $scope.toDate;
  $scope.TimKiem = function() {
    $http({
      method: "POST",
      url: "https://localhost:44306/api/HoaDon/searchsp",
      data: {
        ten_khach: $scope.tenkh,
        fr_NgayTao: $scope.fromDate,
        to_NgayTao: $scope.toDate,
      },
    }).then(function(res) {
      $scope.listHoaDon = res.data.data;
    })
  }


  $scope.ChiTietHoaDon = function (obj) {
    window.location.href = "chitiethoadonban.html?id=" + obj.maHoaDon;
  };

   $scope.Load();
});
// {
//   "maHoaDon": 0,
//   "maDonHang": 0,
//   "tenKH": "string",
//   "diachi": "string",
//   "trangThai": true,
//   "list_json_chitiethoadon": [
//     {
//       "maSanPham": 0,
//       "soLuong": 0,
//       "tongGia": 0
//     }
//   ]
// }
