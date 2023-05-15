<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="pesanan.aspx.cs" Inherits="Project_Nusantara_Resto.pesanan" %>

<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Nusantara Resto || Pesanan</title>
    <link rel="icon" href="image/logo.ico" />
    <!-- Link CSS -->
    <link rel="stylesheet" href="pesanan.css" />

    <!-- CDN Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <!-- JS Jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- CSS Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous" />
</head>

<body>
    <!-- Navbar -->
    <section>
        <nav class="p-lg-3 shadow-lg navbar navbar-expand-lg navbar-light bg-light fixed-top">
            <div class="container-fluid">
                <!-- Toggler -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Logo / Brand -->
                <a style="color: rgb(1, 32, 65)" class="navbar-brand mx-auto mx-lg-5" href="index.aspx">
                    <i style="color: green" class="fas fa-utensils"></i> Nusantara Resto
                </a>

                <!-- Menu -->
                <div class="collapse navbar-collapse justify-content-center me-5" id="navbarNav">
                    <ul class="navbar-nav ">
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-kategori="ayam">Ayam</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-kategori="daging">Daging</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-kategori="gulai">Gulai</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-kategori="minuman">Minuman</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-kategori="tambahan">Tambahan</a>
                        </li>
                    </ul>
                </div>

                <!-- Card Icon -->
                <div class="carticon justify-content-end mx-lg-5">
                    <button class="btn btn-success" type="button" data-bs-toggle="modal" data-bs-target="#cartModal">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span id="cartItemCount">0</span>
                    </button>
                </div>
            </div>
        </nav>
    </section>

    <!-- Modal cart -->
    <section>
        <div class="modal fade" id="cartModal" tabindex="-1" aria-labelledby="cartModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="cartModalLabel">Keranjang Pemesanan</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <div class="modal-body">
                        <div id="cartItems"></div>
                        <div id="cartTotal"></div>
                        <hr />
                        <center><div>Order Code : <%=Session["orderCode"]%></div>
                        <div>Meja Pemesan : <%=Session["nomor-meja"]%></div>
                        <div>Nama Pemesan : <%=Session["nama-pemesan"]%></div>
                        <div>No Hp Pemesan : <%=Session["no-hp-pemesan"]%></div></center>
                    </div>
                    <div class="modal-footer">
                       <div id="pembayaran" class="me-auto">Metode Pembayaran:<select class="form-select" aria-label="Default select example">
                          <option selected>Tunai</option>
                        </select></div>
                        <button type="button" class="btn btn-secondary mt-4" data-bs-dismiss="modal">Close</button>
                        <button type="button" id="buttonbayar" class="btn btn-primary mt-4">Lanjut</button>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!-- Menu Title and search -->
    <section>
        <div style="margin-top: 100px;" class="container-fluid">
            <div class="row">
                <div class="d-flex col-sm-12 justify-content-center">
                    <div class="circle menutitle">
                        <span>ayam</span>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!-- Card Menu -->
    <section>
        <div style="margin-top: 60px;" class="container">
            <div id="konten-makanan" class="row">
            </div>
        </div>

    </section>


    <%// Buat koneksi ke database
        string connectionString = "server=localhost;database=nusantara_resto;uid=root;pwd=;";
        using (MySqlConnection conn = new MySqlConnection(connectionString))
        {
            // Buat query untuk mengambil data makanan
            string query = "SELECT menu.menuCode, menu.menuName,menu.menuDesc,menu.menuStock,menu.menuImage,menu.menuPrice FROM menu WHERE menu.menuStock >1";
            MySqlCommand cmd = new MySqlCommand(query, conn);

            // Buka koneksi dan jalankan query
            conn.Open();
            MySqlDataReader reader = cmd.ExecuteReader();

            // Looping untuk membaca hasil query
            while (reader.Read())
            {
                string menuCode = reader["menuCode"].ToString();
                string namaMakanan = reader["menuName"].ToString();
                int menuStock = Convert.ToInt32(reader["menuStock"]);
                string hargaMakanan = ((decimal)reader["menuPrice"]).ToString("N0");
                string deskripsiMakanan = reader["menuDesc"].ToString();
                byte[] imageData = (byte[])reader["menuImage"];
                string base64String = Convert.ToBase64String(imageData, 0, imageData.Length);
                string imageUrl = "data:image/png;base64," + base64String;
    %>

    <!-- Modal untuk masukin kecart -->
    <section>
        <div class="modal fade modalhidee" id="addToCartModal<%=menuCode%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Tambahkan ke Keranjang</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-6">
                                <img class="img-fluid" src="<%=imageUrl%>" />
                            </div>
                            <div class="col-6">
                                <h5><%=namaMakanan%></h5>
                                <p><%=deskripsiMakanan%></p>
                                <p>Harga : Rp. <%=hargaMakanan%></p>
                                <p>Jumlah :
                                    <input style="width: 30%;" type="number" id="jumlah<%=menuCode%>" value="1" min="1" required /></p>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                            <button type="button" class="btn btn-primary" data-menustock="<%=menuStock%>" data-menucode="<%=menuCode%>" data-namamakanan="<%=namaMakanan%>" data-harga="<%=hargaMakanan%>" data-image="<%=imageUrl%>" onclick="addToCart(event)">Tambahkan ke Keranjang</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <% }
            // Tutup koneksi dan reader
            reader.Close();
            conn.Close();
        }
    %>



    <!-- Footer -->
    <section>
        <footer style="background-color: #223522;" class="shadow-lg text-white pt-5 mt-5 pb-4">
            <div class="container text-center">
                <div class="row text-center">


                    <div class="col-sm-4 mx-auto mt-3">
                        <h5 class="mb-4 font-weight-bold" style="color: rgb(0, 252, 96)">Services </h5>
                        <p class="Judul2">
                            <a href="#" style="text-decoration: none; color: #fff">Fast Delivery</a>
                        </p>
                        <p class="Judul2">
                            <a href="#" style="text-decoration: none; color: #fff">Best Quality</a>
                        </p>
                        <p class="Judul2">
                            <a href="#" style="text-decoration: none; color: #fff">Fresh Food</a>
                        </p>
                        <p class="Judul2">
                            <a href="#" style="text-decoration: none; color: #ffff">Nusantara Food</a>
                        </p>
                    </div>

                    <div class="col-sm-4 mx-auto mt-3">
                        <h5 class="mb-4 font-weight-bold" style="color: rgb(0, 252, 96)">Opening Hours</h5>
                        <p>Monday: 8:00am to 11:00pm</p>
                        <p>Tuesday: 8:00am to 11:00pm</p>
                        <p>Wednesday: 8:00am to 11:00pm</p>
                        <p>Thursday: 8:00am to 11:00pm</p>
                        <p>Friday: 8:00am to 11:00pm</p>
                        <p>Saturday and Sunday: Closed</p>

                    </div>
                    <div class="col-sm-4 mx-auto mt-3">
                        <h5 class="mb-4 font-weight-bold" style="color: rgb(0, 252, 96)">Food & Drinks</h5>
                        <div class="description2">
                            <p class="Judul2">
                                <a href="#" style="text-decoration: none; color: #ffff">Ayam</a>
                            </p>
                            <p class="Judul2">
                                <a href="#" style="text-decoration: none; color: #fff">Daging</a>
                            </p>
                            <p class="Judul2">
                                <a href="#" style="text-decoration: none; color: #ffff">Gulai</a>
                            </p>
                            <p class="Judul2">
                                <a href="#" style="text-decoration: none; color: #ffff">Juice</a>
                            </p>
                        </div>
                    </div>
                </div>

                <hr class="mb-4" />
                <div class="row">
                    <div class="col-sm-12 text-center">
                        <p>
                            &copy; Copyright 2023 All right reserved by

              <strong>Nusantara<span> Resto</span></strong>
                        </p>
                    </div>
                    <div class="col-sm-12 text-center">
                        <ul class="list-unstyled list-inline">
                            <li class="list-inline-item">
                                <a href="#" class="btn-floating btn-sm text-white" style="font-size: 23px; border-radius: 50%;"><i
                                    class="fab fa-facebook"></i></a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#" class="btn-floating btn-sm text-white" style="font-size: 23px;"><i
                                    class="fab fa-twitter"></i></a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#" class="btn-floating btn-sm text-white" style="font-size: 23px;"><i
                                    class="fab fa-google-plus"></i></a>
                            </li>
                            <li class="list-inline-item">
                                <a href="#" class="btn-floating btn-sm text-white" style="font-size: 23px;"><i
                                    class="fab fa-youtube"></i></a>
                            </li>

                        </ul>

                    </div>
                </div>


            </div>

        </footer>
    </section>

    <!-- JS biar langsung ada konten tentang makanan kategori ayam -->
    <script>
        window.onload = function () {
            var ayamLink = document.querySelector('[data-kategori="ayam"]');
            ayamLink.click();
        }
    </script>

    <!-- js sweetalert -->
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <!-- JS gambar menu(bulat) -->
    <script>$(document).ready(function () {
            var images = {
                "ayam": "https://resepkoki.id/wp-content/uploads/2017/11/Resep-Ayam-Bakar-Padang-1.jpg",
                "daging": "https://cdn-brilio-net.akamaized.net/news/2020/05/21/185022/1234835-1000xauto-resep-daging-padang.jpg",
                "gulai": "https://th.bing.com/th/id/OIP.dgYEhHCVFQZXNso0jlzP_QAAAA?pid=ImgDet&rs=1",
                "minuman": "https://media.istockphoto.com/photos/fresh-juice-picture-id499369340?k=6&m=499369340&s=170667a&w=0&h=hVFkKKlAq6iOwfOw5y6kJnqHKKqXRUk3G29HvB6p4Xg=",
                "tambahan": "https://th.bing.com/th/id/OIP.aC5Qm9zFtLdfGxCm1uRqowHaG1?pid=ImgDet&rs=1",
            };

            // Ketika link navbar diklik
            $('a[data-kategori]').click(function (e) {
                e.preventDefault();

                // Ambil data kategori dari atribut data-kategori pada link navbar
                var kategori = $(this).data('kategori');

                // Ubah gambar pada kelas circle sesuai dengan kategori yang dipilih
                $('.circle').css('background', 'url(' + images[kategori] + ') no-repeat center center/cover');

                // Ubah teks pada elemen <span> sesuai dengan kategori yang dipilih
                $('.circle span').text(kategori);
            });
        });


    </script>

    <script>
        //jadi ketika load, ngejalanin fungsi showcartmodal()
        window.addEventListener('load', function () {
            showCartModal();
        });

        // fungsi untuk menambahkan makanan ke keranjang
        function addToCart(event) {

            // ambil data makanan dari button
            const menuCode = event.target.getAttribute("data-menuCode");
            const quantity = document.getElementById("jumlah" + menuCode).value;
            const namaMakanan = event.target.getAttribute("data-namaMakanan");
            const hargaMakanan = event.target.getAttribute("data-harga");
            const stock = event.target.getAttribute("data-menuStock");
            const imageUrl = event.target.getAttribute("data-image");


            // cek apakah makanan sudah ada di keranjang
            let cart = localStorage.getItem("cart");
            if (cart) {
                cart = JSON.parse(cart);

                // cek apakah makanan sudah ada di keranjang
                const existingItemIndex = cart.findIndex(item => item.menuCode === menuCode);
                // periksa apakah quantity melebihi stock
                if (parseInt(quantity) > stock) {
                    alert(`Jumlah quantity melebihi jumlah stock (${stock})`);
                    return;
                }
                if (existingItemIndex !== -1) {
                    // jika makanan sudah ada, tambahkan quantity
                    cart[existingItemIndex].quantity += parseInt(quantity);
                } else {
                    // jika makanan belum ada, tambahkan ke keranjang
                    cart.push({
                        menuCode,
                        namaMakanan,
                        hargaMakanan,
                        imageUrl,
                        quantity: parseInt(quantity)
                    });
                }
            } else {
                // jika keranjang masih kosong, tambahkan makanan pertama
                cart = [{
                    menuCode,
                    namaMakanan,
                    hargaMakanan,
                    imageUrl,
                    quantity: parseInt(quantity)
                }];
            }

            // simpan keranjang ke local storage
            localStorage.setItem("cart", JSON.stringify(cart));


            // sembunyikan modal
            $('#addToCartModal' + menuCode).modal('hide');

            // tampilkan modal keranjang
            showCartModal();

        }


        function showCartModal() {
            let cartItems = JSON.parse(localStorage.getItem('cart'));
            let cartContent = '';

            if (cartItems && cartItems.length > 0) {
                let totalHarga = 0;

                for (let i = 0; i < cartItems.length; i++) {
                    let item = cartItems[i];
                    let subtotal = parseInt(item.quantity) * parseFloat(item.hargaMakanan);
                    totalHarga += subtotal;

                    cartContent += `
        <div class="row mb-3">
            <div class="col-3">
                <img src="${item.imageUrl}" class="img-fluid" alt="${item.namaMakanan}">
            </div>
            <div class="col-6">
                <p class="fw-bold">${item.namaMakanan}</p>
                <p class="mb-1">${item.quantity} x Rp ${item.hargaMakanan.toLocaleString('id-ID')}</p>
                <button type="button" class="btn btn-sm btn-danger me-auto" onclick="removeFromCart(${i})">Hapus</button>
            </div>
            <div class="col-3">
                <p class="text-end">${subtotal.toLocaleString('id-ID', { minimumFractionDigits: 3, style: 'currency', currency: 'IDR' }).replace(',', '.')}</p>
            </div>
        </div>
    `;
                }


                let totalContent = `
    <div class="row">
        <div class="col-9">
            <p class="fw-bold">Total Harga:</p>
        </div>
        <div class="col-3">
            <p class="text-end">${totalHarga.toLocaleString('id-ID', { minimumFractionDigits: 3, style: 'currency', currency: 'IDR' }).replace(',', '.')}</p>
        </div>
    </div>
`;

                document.getElementById('cartItems').innerHTML = cartContent;
                document.getElementById('cartTotal').innerHTML = totalContent;
            } else {
                cartContent = '<p>Keranjang belanja kosong.</p>';
                document.getElementById('cartItems').innerHTML = cartContent;
                document.getElementById('cartTotal').innerHTML = '';
            }
            // Ambil jumlah item di keranjang dari local storage
            const cartItemCount = cartItems.reduce((acc, item) => acc + parseInt(item.quantity), 0);


            // Tampilkan jumlah item di tombol keranjang di navbar
            const cartItemCountElement = document.getElementById("cartItemCount");
            if (cartItemCount === 0) {
                cartItemCountElement.innerHTML = `0`;
            } else {
                cartItemCountElement.innerHTML = `${cartItemCount}`;
            }

        }


        //fungsi buat hapus yang ada dicart
        function removeFromCart(index) {
            let cartItems = JSON.parse(localStorage.getItem('cart'));
            cartItems.splice(index, 1);
            localStorage.setItem('cart', JSON.stringify(cartItems));
            showCartModal();
        }


    </script>




    <!-- JS query ajax -->
    <script>
        $(document).ready(function () {
            // Ketika link navbar diklik
            $('a[data-kategori]').click(function (e) {
                e.preventDefault();

                // Ambil data kategori dari atribut data-kategori pada link navbar
                var kategori = $(this).data('kategori');

                // Buat request Ajax untuk mengambil data makanan sesuai kategori
                $.ajax({
                    url: 'getDataMakanan.aspx',
                    type: 'POST',
                    data: {
                        kategori: kategori
                    },
                    success: function (response) {
                        // Isi konten makanan dengan data yang diterima dari server
                        $('#konten-makanan').html(response);
                    },
                    error: function () {
                        alert('Terjadi kesalahan saat mengambil data makanan!');
                    }
                });
            });
        });
    </script>

   <!-- JS sweetalert dan validasi stok juga-->
<script>// Get a reference to the button element
    // Get a reference to the button element
    const buttonbayar = document.getElementById('buttonbayar');

    // Add an event listener to the button
    buttonbayar.addEventListener('click', () => {
        // Display a Sweet Alert dialog
        swal({
            title: "Apakah pesanan anda sudah benar?",
            icon: "warning",
            buttons: ["Cancel", "Buat QR Code"],
        })
            .then((willCreateQR) => {
                if (willCreateQR) {
                    // Get the cart data from local storage
                    let cartData = localStorage.getItem('cart');
                    let cart = JSON.parse(cartData);

                    // Check if the cart array is empty
                    if (cart.length === 0) {
                        // Return error message
                        swal("Isi keranjang pemesanan terlebih dahulu!", {
                            icon: "error",
                        });
                    } else {

                        // Perform validation by sending an AJAX request to the server for each item in the cart
                        cart.forEach((item) => {
                            let menuCode = item.menuCode;
                            let quantity = parseInt(item.quantity);

                            // Perform validation by sending an AJAX request to the server
                            $.ajax({
                                type: "POST",
                                url: "Validatequantity.aspx",
                                data: { menuCode: menuCode, quantity: quantity },
                                success: function (response) {
                                    console.log("Response received: " + response);
                                    if (response == "success") {
                                        swal({
                                            title: "Generating QR Code!",
                                            icon: "success",
                                            
                                        });
                                        setTimeout(() => {                                           
                                            // Redirect to the next page
                                            window.location.href = "qrcode.aspx";
                                        }, 2500);
                                    } else if (response == "error") {
                                        swal("Jumlah pesanan melebihi stok yang tersedia!", {
                                            icon: "error",
                                        });
                                    } else {
                                        swal("Terjadi kesalahan saat memproses pesanan. Silakan coba lagi nanti.", {
                                            icon: "error",
                                        });
                                        setTimeout(() => {
                                            // Remove the cart data from local storage
                                            localStorage.removeItem("cart");

                                            // Redirect to the next page
                                            window.location.href = "index.aspx";
                                        }, 2500);
                                    }

                                }
                            });
                        });
                    }
                }
            });
    });
</script>


    <!-- JS Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous">
    </script>

</body>

</html>
