<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="Project_Nusantara_Resto.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Nusantara Resto</title>
    <link rel="icon" href="image/logo.ico" />
    <!-- Link CSS -->
    <style>
        body {
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .center {
            text-align: center;
        }

        h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }

        p {
            font-size: 1.5rem;
            margin-bottom: 2rem;
        }

        button {
            background-color: #4CAF50;
            color: white;
            font-size: 1.5rem;
            border: none;
            padding: 1rem 2rem;
            border-radius: 80px;
            cursor: pointer;
        }
    </style>

    <!-- CDN Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

        <!-- JS Jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- CSS Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous" />

    <!--link animate css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
</head>

<body>

    <div class="container">
        <div class="center">
            <h1 class="animate__animated animate__headShake animate__infinite">Selamat Datang di Nusantara Resto</h1>
            <p>"Rasa Nusantara, Nikmati dalam Setiap Gigitan di Resto Kami."</p>
            <button data-bs-toggle="modal" data-bs-target="#myModal" class="mt-3" type="button">Pesan Makanan</button>
        </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <!-- Tambahkan kelas CSS "bg-success" di sini -->
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Form Pemesanan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form runat="server" method="post">
                        <div class="mb-3">
                            <label for="nomor-meja" class="form-label">Nomor Meja</label>
                            <input type="number" class="form-control" id="nomor-meja" name="nomor-meja" required min="1" max="25" />
                        </div>
                        <div class="mb-3">
                            <label for="nama-pemesan" class="form-label">Nama Pemesan</label>
                            <input type="text" class="form-control" id="nama-pemesan" name="nama-pemesan" required />
                        </div>
                        <div class="mb-3">
                            <label for="no-hp-pemesan" class="form-label">No. HP Pemesan</label>
                            <input type="number" class="form-control" id="no-hp-pemesan" name="no-hp-pemesan" required min="1" maxlength="13" />
                        </div>
                
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <asp:Button ID="Button1" class="btn btn-success" onclick="BtnSubmit_Click" runat="server" Text="Pesan" />
                    </div>
                    </form>
                    </div>
                    </div>
                
            </div>
        </div>




    <!-- JS Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous">
    </script>



    <!-- JS validasi no hp -->
    <script>
        document.querySelector('#Button1').addEventListener('click', function (event) {
            var noHp = document.querySelector('#no-hp-pemesan').value;
            if (isNaN(noHp) || noHp.length < 10 || noHp.length > 13) {
                event.preventDefault();
                alert('Nomor HP tidak valid!');
            }
        });
    </script>
    </body>
</html>
