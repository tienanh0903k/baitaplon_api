var app = angular.module("AppBanHang", []);
app.controller("AdminSanPham", function ($scope, $http) {
  $scope.products = [];
  $scope.pageSize = 5;
  $scope.totalItems = 0;
  $scope.pages = [];
  $scope.currentPage = 1;


  $scope.maSanPham;
  $scope.tenSanPham;
  $scope.ngayTao;
  $scope.soLuong;
  $scope.giaban;
  $scope.trangthai;
  $scope.tendanhmuc;

  $scope.selectedFile = null;
  $scope.imageSource = "";

  $scope.loadFile = function () {
    const imageInput = document.getElementById("imgproduct");

    if (imageInput.files && imageInput.files[0]) {
      const file = imageInput.files[0];

      const reader = new FileReader();
      reader.onload = function (e) {
        $scope.$apply(function () {
          $scope.imageSource = e.target.result;
        });
        console.log("Đường dẫn thật đến tệp: " + e.target.result);
      };
      reader.readAsDataURL(file);
    }
  };

  //phan trang
  $scope.getIndex = function () {
    let obj = {};
    //trang hien tai
    obj.page = $scope.currentPage;
    //so san phan tron 1 page
    obj.pageSize = $scope.pageSize;
    obj.ten_sp = "";
    $http({
      method: "POST",
      data: JSON.stringify(obj),
      url: "https://localhost:44323/api/GetSanPham/search",
    }).then(function (response) {
      //tong ban ghi
      $scope.totalItems = response.data.totalItems;
      $scope.products = response.data.data;

      // Tính toán số trang
      $scope.pages = [];
      for (
        var i = 1;
        i <= Math.round($scope.totalItems / $scope.pageSize);
        i++
      ) {
        $scope.pages.push(i);
        console.log($scope.pages);
      }

      $scope.setPage = function (page) {
        $scope.currentPage = page;
        $scope.getIndex();
      };
    });
  };
  $scope.getIndex();

  $scope.selectItems = [];

  $scope.getCategory = function () {
    $http({
      method: "GET",
      url: "https://localhost:44306/api/DanhMuc/get-all",
    }).then(function (response) {
      $scope.selectItems = response.data;
      console.log("Danh mục:", $scope.selectItems);
    });
  };

  $scope.getCategory();

  var currentUserJSON = localStorage.getItem("currentUser");
  $scope.currentUser = JSON.parse(currentUserJSON);
  console.log($scope.currentUser);
  // Kiểm tra quyền của người dùng
  $scope.isAdmin = function () {
    if ($scope.currentUser && $scope.currentUser.loaiTaiKhoan === 1) {
      return true;
    } else {
      return false;
    }
  };

  if (!$scope.isAdmin()) {
    alert("khong co quyen truy cap");
    window.location.href = "../index.html";
  }

  $scope.Them = function (event) {
    event.preventDefault();
//     	{
//   "maChuyenMuc": 2,
//   "tenSanPham": "Ao nam day mua dong",
//   "anhDaiDien": "string",
//   "gia": 0,
//  
//   "ngayTao": "2023-11-10T05:51:18.275Z",
//   "soLuong": 0,
//   "trangThai": true,
//   "luotXem": 0,
//   "list_json_ctsanpham": [
//     {

//       "anh1": "string",
//       "anh2": "string",
//       "maNhaSanXuat": 3,
//       "moTa": "string"
//     }
//   ]
// }

    // $http({
    //   method: "POST",
    //   data: {
    //     tenSanPham : $scope.tenSanPham,
    //     anhDaiDien: $scope.imageSource,
    //     gia :$scope.giaban,
    //     ngayTao: $scope.currentDate = new Date(),
    //     soLuong :$scope.soLuong,
    //     trangThai:$scope.trangthai,
    //      :$scope.tendanhmuc,
    //     TenSanPham: $scope.tenSP,
    //   }})

  };

  $scope.CellClick = function (product) {
    $scope.maSanPham = product.maSanPham;
    $scope.tenSanPham = product.tenSanPham;
    $scope.ngayTao = product.ngayTao;
    $scope.soLuong = product.soLuong;
    $scope.giaban = product.gia;
    $scope.trangthai = product.trangThai;
    $scope.imageSource = product.anhDaiDien;
    $scope.tendanhmuc = product.tenChuyenMuc;
    $scope.selectedCategory = $scope.selectItems.find(
      (item) => item.maChuyenMuc === product.maChuyenMuc
    );
  };
});


