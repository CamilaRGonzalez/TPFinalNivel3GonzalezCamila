<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TiendaOnline._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

   <asp:UpdatePanel runat="server">
        <ContentTemplate>   
             <div class="container-fluid px-5 my-5">
                 <!-- FILTROS-->
                 <div style="margin-bottom:inherit;">
                     <div class="row">
                        <div class="col">
                            <label class="form-label">Campo</label>
                            <asp:DropDownList runat="server" AutoPostBack="true" ID="ddlCampo" 
                             cssClass="form-select" OnSelectedIndexChanged="ddlCampo_SelectedIndexChanged">
                                <asp:ListItem selected="True">Todos</asp:ListItem>
                                <asp:ListItem Value="Nombre"  Text="Nombre" />
                                <asp:ListItem Value="C.Descripcion" Text="Categoría"/>
                                <asp:ListItem Value="M.Descripcion" Text="Marca" />
                                <asp:ListItem Value="Precio" Text="Precio" />
                            </asp:DropDownList> 
                        </div>
                        <div class="col">
                            <label class="form-label">Criterio</label>
                            <asp:DropDownList runat="server" ID="ddlCriterio" cssClass="form-select"></asp:DropDownList> 
                        </div>
                        <div class="col">
                            <label class="form-label">Filtro</label>
                            <asp:TextBox runat="server"  CssClass="form-control" ID="txtFiltro" />  
                            <%if(ddlCampo.SelectedValue == "Precio")
                              {%>
                                <asp:RegularExpressionValidator Display="Dynamic" ForeColor="Red" ValidationExpression="^[0-9]*\.?\,?[0-9]+$" ErrorMessage="Formato ##.## o ##,##" ControlToValidate="txtFiltro" runat="server"/>
                                <asp:RequiredFieldValidator Display="Dynamic" ErrorMessage="Campo vacío" ForeColor="Red" ControlToValidate="txtFiltro" runat="server" />
                            <%}
                              else if(ddlCampo.SelectedValue == "Nombre")
                              {%>
                                 <asp:RequiredFieldValidator Display="Dynamic" ErrorMessage="Campo vacío" ForeColor="Red" ControlToValidate="txtFiltro" runat="server" />
                            <%}%>
                        </div>
                         <div class="col">
                             <label class="form-label" style="margin-top:17px;">  </label>
                            <asp:Button Text="Filtrar" ID="btnFiltrar" CssClass="btn btn-primary form-control" runat="server" OnClick="btnFiltrar_Click" />                                
                        </div>
                      </div>
                    </div>
                 
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
                                            <asp:Button UseSubmitBehavior="false" OnClick="btnVerDetalle_Click" Text="Ver Detalle" CssClass="btn btn-outline-dark mt-auto" runat="server" ID="btnVerDetalle" CommandArgument='<%#Eval("Id")%>' CommandName="ProductoId" />
                                            <%if (!user.admin) 
                                              {%>
                                                <asp:Button UseSubmitBehavior="false" OnClick="btnFav_Click" Text="🤍Fav" CssClass="btn btn-danger btn-sm m-2" ID="btnFav" CommandArgument='<%#Eval("Id")%>' CommandName="ProductoId" runat="server" />
                                            <%}%>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>                                  
               </div>
            </div>

        <%if (favorito)
            {
                string texto;
                string imagen;
                if (noRepetido)
                {
                    texto = "Agregado a favoritos exitosamente!";
                    imagen = "/Imagenes/OK.jpg";
                }
                else
                {
                    texto = "Ya está en favoritos";
                    imagen = "/Imagenes/advertencia.jpg";
                }               
              %>
              <div class="modal" id="myModal" tabindex="-1">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-body" style="text-align:center;">
                            <img src="<%:imagen%>" height="100px" alt="Alternate Text" />
                            <p><%:texto%>!</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
               </div>
          <%}%>
            
        </ContentTemplate>        
    </asp:UpdatePanel>
    
    <script type="text/javascript">        
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(formatear);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(mostrarModal);

        formatear();
        mostrarModal();

        function mostrarModal() {
            var myModal = new bootstrap.Modal(document.getElementById('myModal'))
            myModal.show()
        }
        

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
