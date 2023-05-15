<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginAdmin.aspx.cs" Inherits="Project_Nusantara_Resto.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Nusantara Resto || Admin</title>
    <!--Link eksternal bootstrap-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous"/>

    <!--link bootstrap icon-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css"/>

    <!--custom css-->
    <link rel="stylesheet" href="css/LoginAdmin.css"/>

    <!--link animate css-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <!--Link eksternal font awesome-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>

    <!-- Link Swiper's CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.css" />

    <!--Box icons-->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'/>
</head>
<body>



    <!-- Login -->
    <section>
        <div>
            <div class="container-fluid p-3 mt-5">
                <div class="row">
                    <div class="col-sm-9 col-md-7 col-lg-4 mx-auto">
                        <div class="cardLogin card border-0 shadow rounded-3 my-5">
                            <div class="card-body p-4 p-sm-5">
                                <h2 class="card-title text-center mb-5 fw-bold text-white" style="font-family: cursive;">Login for Admin
                                </h2>
                                <form style="height: 200px;" method="post" runat="server">
                                    <div class="input-group mb-3">
                                        <asp:TextBox class="form-control" ID="name" name="name" placeholder="Name" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="input-group mb-3">
                                        <asp:TextBox class="form-control" ID="password" name="password" placeholder="Password" runat="server" TextMode="Password"></asp:TextBox>
                                        <span class="input-group-text">
                                            <i class="fa fa-eye-slash" id="togglePassword" style="cursor: pointer"></i>
                                        </span>
                                    </div>
                                    <div class="d-grid">
                                        <asp:Button class="mt-3 btn btn-login text-uppercase fw-bold" ID="btnLoginAdmin" runat="server" Text="Login" OnClick="BtnLogin_Click" />
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Login -->




    <!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper/swiper-bundle.min.js"></script>


    <!--link java script -->
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="js/script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous">
    </script>
</body>
</html>
