<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="menu.aspx.cs" Inherits="Project_Nusantara_Resto.WebForm2" %>

<%@ Import Namespace="MySql.Data.MySqlClient" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Nusantara Resto || Admin</title>

    <!--Link external bootstrap-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css" />
    <link href="css/styles.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css" />
    <script src="https://use.fontawesome.com/releases/v6.4.0/js/all.js" crossorigin="anonymous"></script>
    <style>
        .resized-image {
            width: 150px; /* Set the desired width */
            height: 100px; /* Set the desired height */
        }
    </style>
</head>

<body class="sb-nav-fixed">
    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
        <!-- Navbar Brand-->
        <style>
            .navbar-brand:hover,
            .navbar-brand > span:hover {
                color: rgb(243, 230, 230) !important;
            }
        </style>
        <a class="navbar-brand ps-3" style="color: forestgreen; font-size: 27px; font-weight: 500;" href="../index.aspx">Nusantara<span style="color: antiquewhite;">Resto</span></a>

        <!-- Sidebar Toggle-->
        <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
            <i class="fas fa-bars"></i>
        </button>

        <!-- Navbar Search-->
        <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
        </form>

        <!-- Navbar-->
        <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                    <li><a class="dropdown-item"><%= Session["adminName"] %></a></li>
                    <li><a class="dropdown-item" href="../LoginAdmin.aspx?pesan=logout">Log out</a></li>
                </ul>
            </li>
        </ul>
    </nav>

    <div id="layoutSidenav">
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">Menu</div>
                        <a class="nav-link" href="kategori.aspx">
                            <div class="sb-nav-link-icon"><i class="bi bi-list"></i></div>
                            Category (Fixed data)
                        </a>
                        <a class="nav-link" href="menu.aspx">
                            <div class="sb-nav-link-icon"><i class="bi bi-menu-button"></i></div>
                            Menu
                        </a>
                        <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-bs-parent="#sidenavAccordion">
                            <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordionPages">
                                </div>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="sb-sidenav-footer">
                    <div class="small">Logged in as:</div>
                    <%=Session["adminName"] %>
                </div>
            </nav>
        </div>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Menu</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item active">Menu Detail</li>
                    </ol>
                    <div class="mt-3">
                        <!-- For update message -->
                        <% if (!string.IsNullOrEmpty(Request.QueryString["update"]))
                            { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Update </strong><%= Request.QueryString["update"] %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>

                        <% if (!string.IsNullOrEmpty(Request.QueryString["error"]))
                            { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Update </strong><%= Request.QueryString["error"] %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>

                        <!-- For delete message -->
                        <% if (!string.IsNullOrEmpty(Request.QueryString["delete"]))
                            { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Delete </strong><%= Request.QueryString["delete"] %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>

                        <!-- For error message -->
                        <% if (!string.IsNullOrEmpty(Request.QueryString["error"]))
                            { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Delete </strong><%= Request.QueryString["error"] %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>


                        <!-- For create message -->
                        <% if (!string.IsNullOrEmpty(Request.QueryString["create"]))
                            { %>
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Create </strong><%= Request.QueryString["create"] %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>

                        <% if (!string.IsNullOrEmpty(Request.QueryString["error"]))
                            { %>
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Create </strong><%= Request.QueryString["error"] %>
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% } %>
                    </div>
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            DataTable
                       
                        </div>
                        <div style="text-align: left;" class="mt-3 ms-3">
                            <a href="CreateMenu.aspx">
                                <button style="font-size: 20px; border-radius: 15px;" class="btn btn-success"><i class="bi bi-plus-lg"></i>Add Data</button></a>
                        </div>
                        <div class="card-body">
                            <table id="datatablesSimple">
                                <thead class="table-dark">
                                    <tr>
                                        <th>menuCode</th>
                                        <th>categoryCode</th>
                                        <th>menuName</th>
                                        <th>menuDesc</th>
                                        <th>menuStock</th>
                                        <th>menuImage</th>
                                        <th>menuPrice</th>
                                        <th>adminCode</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                        //koneksi ke database MySQL
                                        string connString = "Server=localhost;Database=nusantara_resto;Uid=root;Pwd=;";
                                        using (MySqlConnection conn = new MySqlConnection(connString))
                                        {
                                            //query untuk membaca data dari tabel menu dengan join category
                                            string query = "SELECT * FROM menu";
                                            MySqlCommand cmd = new MySqlCommand(query, conn);

                                            //membuka koneksi dan membaca data menggunakan MySqlDataReader
                                            conn.Open();
                                            MySqlDataReader reader = cmd.ExecuteReader();

                                            if (reader.HasRows)
                                            {
                                                while (reader.Read())
                                                {
                                                    string menuCode = reader["menuCode"].ToString();
                                                    string categoryCode = reader["categoryCode"].ToString();
                                                    string menuName = reader["menuName"].ToString();
                                                    string menuDesc = reader["menuDesc"].ToString();
                                                    int menuStock = reader.GetInt32("menuStock");
                                                    byte[] menuImage = (byte[])reader["menuImage"];
                                                    string imageBase64String = Convert.ToBase64String(menuImage);
                                                    string menuPrice =
                       ((decimal)reader["menuPrice"]).ToString("N0");
                                                    string adminCode = reader["adminCode"].ToString();
                                    %>
                                    <tr>
                                        <td><%= menuCode %></td>
                                        <td><%= categoryCode %></td>
                                        <td><%= menuName %></td>
                                        <td><%= menuDesc %></td>
                                        <td><%= menuStock %></td>
                                        <td>
                                            <img src="data:image/jpeg;base64,<%=imageBase64String %>" class="resized-image" /></td>
                                        <td><%= menuPrice %></td>
                                        <td><%= adminCode %></td>
                                        <td>
                                            <a href="UpdateMenu.aspx?id=<%=menuCode%>"><i class="fas fa-edit"></i></a>
                                            <a href="DeleteMenu.aspx?id=<%=menuCode%>"><i class="fas fa-trash"></i></a>
                                        </td>
                                    </tr>
                                    <% 
                                                }
                                            }
                                            else
                                            {
                                                Response.Write("No data found");
                                            }

                                            reader.Close();
                                            conn.Close();
                                        }
                                    %>
                                </tbody>

                            </table>
                        </div>
                    </div>
                </div>
            </main>

            <footer class="py-4 bg-light mt-auto">
                <div class="container-fluid px-4">
                    <div class="d-flex align-items-center justify-content-center small">
                        <div class="text-muted">
                            &copy; Nusantara Resto Website 2023
                       
                        </div>
                    </div>
                </div>
            </footer>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.3.0/Chart.bundle.js"></script>
    <script src="js/script.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script type="text/javascript" charset="utf8"
        src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.js"></script>


    <script>
        $(document).ready(function () {
            $('#datatablesSimple').DataTable({
                responsive: true,
                autoWidth: true
            });
        });
    </script>

    <script>
        $(document).ready(function () {
            $('#datatablesSimple').addClass("table table-striped table-bordered");
        });
    </script>

    <script>
        function validateFile(event) {
            // Get the file input element
            var input = document.getElementById('image-upload');

            // Check if the selected file is an image
            if (!input.files[0].type.startsWith('image/')) {
                alert('Please select an image file!!!');
                event.preventDefault();
                return false;
            }

            // Check if the selected file size is within the allowed limit
            const file = input.files[0];
            const fileSize = file.size; // Get the file size in bytes

            if (fileSize > 300000) { // If size is greater than 300KB (300000 bytes)
                // Image is too large
                alert('Image size is too large. Size cannot be more than 300kb, Please choose a smaller image!!!');
                event.preventDefault();
                return false;
            }

            return true;
        }
    </script>
</body>
</html>
