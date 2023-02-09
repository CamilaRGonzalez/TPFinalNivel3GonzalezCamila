<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Favoritos.aspx.cs" Inherits="TiendaOnline.Favoritos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       <asp:UpdatePanel runat="server">
        <ContentTemplate>   
             <div class="container-fluid px-5 my-5">
                 <!--Productos-->
                <div id="contenedor_producto" class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4">
                 
                    <asp:Repeater runat="server" ID="repRepetidor">
                        <ItemTemplate>
                            <div class="col mb-5">
                                <div class="card h-100">
                                    <!-- Imagen-->                                  
                                    <img class="card-img-top w-auto p-4" style="height:200px; align-self:center;" src="<%#Eval("UrlImg")%>" />                                                          
                                    <!-- Detalles-->
                                    <div class="card-body p-4">
                                        <div class="text-center">
                                            <!-- Nombre-->
                                            <h5 class="fw-bolder"><%#Eval("Nombre")%></h5>
                                            <!-- Precio-->
                                            <h6 id="Precio"><%#Eval("Precio")%></h6>                                        
                                        </div>
                                    </div>
                                    <!--Botones-->
                                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                        <div class="text-center">          
                                           <asp:Button UseSubmitBehavior="false" OnClick="btnUnfav_Click" Text="💔Quitar fav" CssClass="btn btn-danger btn-sm m-2" ID="btnUnfav" CommandArgument='<%#Eval("Id")%>' CommandName="ProductoId" runat="server" />                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>                                  
               </div>
            </div>            
        </ContentTemplate>        
    </asp:UpdatePanel>
    
    <script type="text/javascript">        
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(formatear);

        formatear();

        function formatear() {
            const formatter = new Intl.NumberFormat('es-AR', {
                style: 'currency',
                currency: 'ARS',
                minimumFractionDigits: 2
            })

            let tarjetas = document.querySelectorAll("#Precio");
            let precio;

            tarjetas.forEach((tarjeta) => {
                precio = tarjeta.textContent;
                precio = precio.replace(/,/g, '.');
                tarjeta.textContent = formatter.format(precio);
            })
        }
       
    </script>
</asp:Content>
