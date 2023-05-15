<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="qrcode.aspx.cs" Inherits="Project_Nusantara_Resto.qrcode" %>

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
            height: 90vh;
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

                #qrcode {
          display: flex;
          justify-content: center;
          align-items: center;
          margin-top: 3rem;
        }
    </style>

    <!-- qrcode -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>

    <!-- JS Jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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
            <h1 class="animate__animated animate__headShake animate__infinite">Tunjukkan QR Code Kepada kasir!</h1>
            <div id="qrcode"></div>
            
        </div>
    </div>

    <!-- JS Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous">
    </script>

    <!--JS QR CODE -->
    <script>
    // Get the cart data from local storage
    let cartData = localStorage.getItem('cart');
    let cart = JSON.parse(cartData);

    // Get the code from local storage
    let orderCode = '<%= Session["orderCode"] %>';
    let namaPemesan = '<%= Session["nama-pemesan"] %>';
    let noHpPemesan = '<%= Session["no-hp-pemesan"] %>';
    let mejaPemesan = '<%= Session["nomor-meja"] %>';


    // Create a JSON object with the cart data and customer info
    let jsonData = {
        orderCode: orderCode,
        mejaPemesan: mejaPemesan,
        namaPemesan: namaPemesan,
        noHpPemesan: noHpPemesan,
        metodePembayaran: "Tunai",
        items: [],
        grandTotal: 0
    };
    
        // Calculate the subtotal and grand total
    cart.forEach((item) => {
        let hargaMakanan = parseInt(item.hargaMakanan.replace('.', '')); // mengubah "10.000" menjadi 10000
        let subtotal = hargaMakanan * item.quantity;
        let formattedHarga = 'Rp ' + hargaMakanan.toLocaleString('id-ID');

        jsonData.items.push({
            menuCode: item.menuCode,
            namaMakanan: item.namaMakanan,
            hargaMakanan: formattedHarga,
            quantity: item.quantity,
            subtotal: 'Rp ' + subtotal.toLocaleString('id-ID') // add Rp to the subtotal
        });
        jsonData.grandTotal += subtotal;
    });

// Add Rp to the grand total and format it with dots as thousand separator
jsonData.grandTotal = 'Rp ' + jsonData.grandTotal.toLocaleString('id-ID');



    // Create a QR code with the JSON data
    let qrcode = new QRCode(document.getElementById("qrcode"), {
        text: JSON.stringify(jsonData),
        width: 256,
        height: 256,
        colorDark: "#000000",
        colorLight: "#ffffff",
        correctLevel: QRCode.CorrectLevel.H
    });

    // Remove the cart data from local storage
    localStorage.removeItem("cart");

    //remove session
    <%Session.Remove("nomor-meja");%>
    <%Session.Remove("nama-pemesan");%>
    <%Session.Remove("no-hp-pemesan");%>
    <%Session.Remove("orderCode");%>
    </script>


    </body>
</html>
