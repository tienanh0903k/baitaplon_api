/* Get dữ liệu */

// const tbody = document.querySelector(".table-body");
// console.log(tbody);

// fetch("https://localhost:44306/api/User/get-all", {
//   method: "GET",
// })
//   .then((response) => response.json())
//   .then((data) => {
//     console.log(data);
//     data.forEach((item) => {
//       const row = document.createElement("tr");
//       row.innerHTML = `
//                     <td>${item.maTaiKhoan}</td>
//                     <td>${item.loaiTaiKhoan}</td>
//                     <td>${item.tenTaiKhoan}</td>
//                     <td>${item.matKhau}</td>
//                     <td>${item.email}</td>
//                     <td>
//                     <input type="checkbox" name="check_all">
//                     </td>
//                 `;
//       tbody.appendChild(row);
//     });
//   })
//   .catch((error) => console.error("Lỗi khi lấy dữ liệu từ API:", error));
