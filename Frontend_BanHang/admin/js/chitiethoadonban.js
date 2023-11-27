var app = angular.module("AppBanHang", []);
app.controller("DetailHoaDonBan", function ($scope, $http, $location) {
    $scope.maHoaDon;
    $scope.tenKhachHang;
    $scope.diaChi;
    $scope.ngaytao;
    $scope.tongtien;
    $scope.sdt;
    $scope.sanPhamChon;   

    $scope.listBill;
    $scope.detailBill = [];
    $scope.listSanPham = [];
    $scope.tenSanPham;
    $scope.getDetailBill = function() {
        var urlParams = new URLSearchParams(window.location.search);
        var maHoaDon = urlParams.get("id"); 
        $http({
          method: "GET",
          url: "https://localhost:44306/api/HoaDon/get-by-id/" + maHoaDon,
        }).then(function (response) {
          console.log(response.data);
          $scope.listBill = response.data;
          $scope.detailBill = $scope.listBill.list_json_chitiethoadon;

          $scope.maHoaDon = maHoaDon;
          $scope.tenKhachHang = $scope.listBill.tenKH;
          $scope.diaChi = $scope.listBill.diachi;
          $scope.ngaytao = $scope.listBill.ngayTao;
          $scope.tongtien = $scope.listBill.tongGia;
          $scope.sdt = $scope.listBill.sdt || '0293402834';
        });
    }
    $scope.getDetailBill();
    $scope.getSanPham = function() {
        $http({
          method: "GET",
          url: "https://localhost:44306/api/SanPham/get-all",
        }).then(function (response) {
           $scope.listSanPham = response.data;
        });
    }
    $scope.getSanPham();
     
    $scope.CapNhatTenSanPham = function () {
       // Tìm sản phẩm tương ứng với mã sản phẩm đã chọn
       var sanPhamChon = $scope.listSanPham.find(function (sp) {
         //console.log(sp.maSanPham);
            return sp.maSanPham == $scope.maSanPhamChon;
       });
       //console.log($scope.maSanPhamChon);
       if (sanPhamChon ) {
          $scope.tenSanPham = sanPhamChon.tenSanPham;
      } 
     };

    $scope.print = function () {
      // Chuyển đến trang "printer.html" và không thêm tiền tố "#!"
      window.location.href = "printer.html?id=" + $scope.maHoaDon;
    };
    $scope.inHoaDon = function () {
       window.print();
     };

});
