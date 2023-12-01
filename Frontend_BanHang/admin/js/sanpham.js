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
  $scope.maChuyenMuc;

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
    obj.ten_sp = $scope.timKH;
    $http({
      method: "POST",
      data: JSON.stringify(obj),
      url: "https://localhost:44306/api/SanPham/search-sp",
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

  
  $scope.Them = function () {
    var maChuyenMuc = parseInt($scope.selectedCategory, 10);
    $http({
      method: "POST",
      url: "https://localhost:44306/api/SanPham/create-sp",
      data: {
        maChuyenMuc: maChuyenMuc,
        tenSanPham: $scope.tenSanPham,
        anhDaiDien: $scope.imageSource,
        gia: $scope.giaban,
        ngayTao: $scope.ngayTao,
        soLuong: $scope.soLuong,
        trangThai: $scope.trangthai === "true" ? true : false,
      },
    }).then(function (res) {
      if(res.status === 200) {
        alert('Them thanh cong');
      }
    });

  };

  $scope.Sua = function(x) {
    $scope.maSanPham = x.maSanPham;
    $scope.tenSanPham = x.tenSanPham;
     $scope.ngayTao = new Date(x.ngayTao);
    $scope.soLuong = x.soLuong;
    $scope.giaban = x.gia;
    $scope.trangthai = x.trangThai;
    $scope.imageSource = x.anhDaiDien;
    $scope.selectedCategory = x.maChuyenMuc.toString();
    console.log(x);
  }


  //sua
  $scope.CapNhat = function () {
    var maChuyenMuc = parseInt($scope.selectedCategory, 10);
    $http({
      method: "PUT",
      url: "https://localhost:44306/api/SanPham/update-sp",
      data: {
        maSanPham: $scope.maSanPham,
        maChuyenMuc: maChuyenMuc,
        tenSanPham: $scope.tenSanPham,
        anhDaiDien: $scope.imageSource,
        gia: $scope.giaban,
        ngayTao: $scope.ngayTao,
        soLuong: $scope.soLuong,
        trangThai: $scope.trangthai === "true" ? true : false,
      },
    }).then(function (res) {
      if (res.status === 200) {
        alert("Sửa thanh cong");
      }
    });
  };


  $scope.Xoa = function (x) {
    var r = confirm("Bạn có chắc muốn xóa không?")
    if (r == true) {
      $http({
        method: "DELETE",
        url: "https://localhost:44306/api/SanPham/delete-sp/" + x.maSanPham,
      }).then(function(res) {
        if (res.status === 200) {
          alert("Xoa thanh cong");
        }
      }) 
    }
    
  };

});


