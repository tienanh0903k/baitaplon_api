var app = angular.module("AppBanHang", []);
app.controller("AdminHoaDonNhap", function ($scope, $http, $location) {
    $scope.infoHDB;

    $scope.mahdnhap;
    $scope.ngayTao;
    $scope.maNhaPhanPhoi = "1";
    $scope.kieuthanhtoan;
    $scope.getHDB = function () {
        $http({
          method: "GET",
          url: "https://localhost:44306/api/HoaDonNhaps/get-All",
        }).then(function(res) {
            $scope.infoHDB = res.data;
        })
    }

    $scope.options = []; 
    $scope.loadData = function () {
      $http({
        method: "GET",
        url: "https://localhost:44306/api/NhaPhanPhois/get-all",
      }).then(function (res) {
        $scope.options = res.data;
      });
    };

    $scope.getHDB();
    $scope.loadData();



    //them
    $scope.ThemHoaDon = function () {
      var ngayTaoDate = new Date($scope.ngayTao);
      $http({
        method: "POST",
        url: "https://localhost:44306/api/HoaDonNhaps/create-hoadon",
        data: {
          maNhaPhanPhoi: $scope.maNhaPhanPhoi,
          ngayTao: ngayTaoDate,
          kieuThanhToan: $scope.kieuthanhtoan,
          maTaiKhoan: 1,
        },
      }).then(function (response) {
        if (response.status === 200) {
          alert("Them thanh ong");
        }
      });
    };

    $scope.Sua = function (x) {
        $scope.mahdnhap = x.maHoaDon;
        $scope.maNhaPhanPhoi = x.maNhaPhanPhoi.toString();
        $scope.ngayTao = x.ngayTao;
        $scope.kieuthanhtoan = x.kieuThanhToan;
    };

    $scope.CapNhat = function() {
      var ngayTaoDate = new Date($scope.ngayTao);
        $http({
          method: "PUT",
          url: "https://localhost:44306/api/HoaDonNhaps/update-hoadon",
          data: {
            maHoaDon: $scope.mahdnhap,
            maNhaPhanPhoi: $scope.maNhaPhanPhoi,
            ngayTao: ngayTaoDate,
            kieuThanhToan: $scope.kieuthanhtoan,
            maTaiKhoan: 1,
          },
        }).then(function (response) {
          if (response.status == 200) {
            alert("Sua thanh cong");
          }
        });
    }

    $scope.ChiTietHoaDon = function(x) {
      window.location.href = "detail-hdn.html?id=" + x.maHoaDon;
    }


})
