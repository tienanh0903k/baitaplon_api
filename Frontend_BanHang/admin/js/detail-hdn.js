var app = angular.module("AppBanHang", []);
app.controller("CTHoaDonNhap", function ($scope, $http, $location) {
  
  $scope.mahdnhap;
  $scope.maNhaPhanPhoi;
  $scope.ngayTao;
  $scope.kieuthanhtoan;
  
  $scope.sanPhamNhap = [];
  $scope.listSanPham = [];
    $scope.showModal = false;
     $scope.openModal = function () {
       $scope.showModal = true;
     };
     $scope.closeModal = function () {
       $scope.showModal = false;
     };
     //lay san pham co san
      $scope.getSanPham = function () {
        $http({
          method: "GET",
          url: "https://localhost:44306/api/SanPham/get-all",
        }).then(function (response) {
          $scope.listSanPham = response.data;
        });
      };
      $scope.getSanPham();

      $scope.CapNhatTenSanPham = function () {
        // Tìm sản phẩm tương ứng với mã sản phẩm đã chọn
        var sanPhamChon = $scope.listSanPham.find(function (sp) {
          //console.log(sp.maSanPham);
          return sp.maSanPham == $scope.maSanPhamChon;
        });
        //console.log($scope.maSanPhamChon);
        if (sanPhamChon) {
          $scope.tenSanPham = sanPhamChon.tenSanPham;
        }
      };

      $scope.detailHDN;
      $scope.getHoaDonId = function() {
         var urlParams = new URLSearchParams(window.location.search);
         var maHoaDon = urlParams.get("id"); 
         $http({
           method: "GET",
           url: "https://localhost:44306/api/HoaDonNhaps/get-by-id/" + maHoaDon,
         }).then(function(res) {
           $scope.detailHDN = res.data;
           console.log($scope.detailHDN);
            $scope.mahdnhap = $scope.detailHDN.maHoaDon;
            $scope.maNhaPhanPhoi = $scope.detailHDN.tenNhaPhanPhoi;
            $scope.ngayTao = $scope.detailHDN.ngayTao;
            $scope.kieuthanhtoan = $scope.detailHDN.kieuThanhToan;

            $scope.sanPhamNhap =
              $scope.detailHDN.list_json_chitiet_hoa_don_nhap;
         })
      }
      $scope.getHoaDonId();


      //them moi hoa don
      $scope.tenSanPham;
      $scope.donViTinh;
      $scope.giaNhap;
      $scope.soLuongMoi;
      $scope.ThemMoiHoaDon = function (e) {
        e.preventDefault();
        $http({
          method: "PUT",
          url: "https://localhost:44306/api/HoaDonNhaps/update-hoadon",
          data: {
            maHoaDon: $scope.mahdnhap,
            maNhaPhanPhoi: $scope.detailHDN.maNhaPhanPhoi,
            ngayTao: "2023-11-21T15:38:51.081Z",
            kieuThanhToan: $scope.kieuthanhtoan,
            maTaiKhoan: 1,
            list_json_chitiet_hoa_don_nhap: [
              {
                maHoaDon: $scope.mahdnhap,
                tenSanPham: $scope.tenSanPham,
                soLuongNhap: $scope.soLuongMoi,
                donViTinh: $scope.donViTinh,
                giaNhap: $scope.giaNhap,
                tongTien: $scope.soLuongMoi * $scope.giaNhap,
                status: "1",
              },
            ],
          },
        })
          .then(function (response) {
            if (response.status === 200) {
              alert("Them thanh cong");
              $scope.closeModal();
            }
          })
          .catch(function (error) {
            console.log(error);
          });
      };


      //xoa 
      $scope.Xoa = function(x) {
        console.log(x.id);
        $http({
         method: "PUT",
          url: "https://localhost:44306/api/HoaDonNhaps/update-hoadon",
          data: {
            maHoaDon: $scope.mahdnhap,
            maNhaPhanPhoi: $scope.detailHDN.maNhaPhanPhoi,
            ngayTao: "2023-11-21T15:38:51.081Z",
            kieuThanhToan: $scope.kieuthanhtoan,
            maTaiKhoan: 1,
            list_json_chitiet_hoa_don_nhap: [
              {
                id: x.id,
                maHoaDon: $scope.mahdnhap,
                tenSanPham: $scope.tenSanPham,
                soLuongNhap: $scope.soLuongMoi,
                donViTinh: $scope.donViTinh,
                giaNhap: $scope.giaNhap,
                tongTien: $scope.soLuongMoi * $scope.giaNhap,
                status: "4",
              },
            ],
          },
        }).then(function (response) {
            if (response.status === 200) {
              alert("Xoa thanh cong");
              $scope.getHoaDonId();
            }
          })
      }
        
      
});