var app = angular.module("AppBanHang", []);
app.controller("AdminTaiKhoan", function ($scope, $http) {
    
    $scope.tentaikhoan;
    $scope.matkhau;
    $scope.email;
    $scope.loaisp = "2";
    

    $scope.taiKhoans;
    $scope.getTaiKhoan = function() {
        $http({
          method: "GET",
          url: "https://localhost:44306/api/User/get-all",
        }).then(function(response) {
            $scope.taiKhoans = response.data;
            console.log(response.data);
        })
    }

    $scope.ThemTaiKhoan = function() {
        $http({
          method: "POST",
          url: "https://localhost:44306/api/User/create-user",
          data: {
            loaiTaiKhoan: $scope.loaisp,
            tenTaiKhoan: $scope.tentaikhoan,
            matKhau: $scope.matkhau,
            email: $scope.email,
          },
        })
          .then(function (response) {
            if(response.status === 200) {
                alert("Them thanh cong");
            }
          })
          .catch((err) => console.log(err));
    }
    $scope.getTaiKhoan();
})





// {
//   "maTaiKhoan": 0,
//   "loaiTaiKhoan": 0,
//   "tenTaiKhoan": "string",
//   "matKhau": "string",
//   "email": "string",
//   "token": "string",
//   "list_json_chitiettaikhoan": [
//     {
//       "maChiTietTaiKhoan": 0,
//       "hoTen": "string",
//       "diaChi": "string",
//       "soDienThoai": "string",
//       "anhDaiDien": "string"
//     }
//   ]
// }