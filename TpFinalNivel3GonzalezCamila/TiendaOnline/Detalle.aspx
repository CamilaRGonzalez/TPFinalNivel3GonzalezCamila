<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detalle.aspx.cs" Inherits="TiendaOnline.Detalle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
        <div class="container px-4 px-lg-5 my-5">
        <div class="row gx-4 gx-lg-5 align-items-center">
            <div class="col-md-6" style="text-align:center;"><img style="max-height:400px; max-width:300px;" class="card-img-top mb-5 mb-md-0 w-auto" src="<%:articulo.UrlImg %>" alt="..." /></div>
            <div class="col-md-6">
                <div class="small mb-1">Categoría: <%:articulo.Categoria.Descripcion%></div>
                <div class="small mb-1">Marca: <%:articulo.Marca.Descripcion%></div>
                <h1 class="fw-bolder"><%:articulo.Nombre %></h1>
                <div class="fs-5 mb-4">
                    <h5 id="Precio"><%:articulo.Precio %></h5>
                </div>
                <h5 >Descripción</h5>
                <p class="lead"><%:articulo.Descripcion %></p>
                <div class="d-flex">
                    <a href="Default.aspx" class="btn btn-danger w-50 text-center me-3">
                        <i class="fas fa-undo-alt"></i> Volver
                    </a>
                </div>
            </div>
        </div>
    </div>

<script>    
    const formatter = new Intl.NumberFormat('es-AR', {
        style: 'currency',
        currency: 'ARS',
        minimumFractionDigits: 2
    })

    let precio = document.querySelector("#Precio").textContent;
    precio = precio.replace(/,/g, '.');
    document.querySelector("#Precio").textContent = formatter.format(precio);

</script>
</asp:Content>
