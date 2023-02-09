<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionCategorias.aspx.cs" Inherits="TiendaOnline.GestionCategorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style> 
        .modal-backdrop
        {
            opacity:0 !important;
        }
    </style>
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
           <!--TARJETA CONTENEDORA-->
            <div class="card border-0 m-4" style="margin-top:20px;">
                <div class="card-header border">
                    <i class="fas fa-table me-1"></i> Categorías
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-12">
                            <!-- Nuevo Articulo -->
                            <asp:Button OnClick="btnNuevaCateg_Click" Text="Crear Nueva" ID="btnNuevaCateg" CssClass="btn btn-success" runat="server" />
                        </div>
                    </div>
                    <hr />

                    <asp:GridView runat="server" ID="dgvCateg" cssClass="table"  AutoGenerateColumns="false"
                        DataKeyNames="Id" OnSelectedIndexChanged="dgvCateg_SelectedIndexChanged"
                        OnPageIndexChanging="dgvCateg_PageIndexChanging" AllowPaging="true" PageSize="10" HeaderStyle-HorizontalAlign="Center"
                         RowStyle-HorizontalAlign="Center">
                        <Columns>
                            <asp:BoundField HeaderText="Id" DataField="Id" />
                            <asp:BoundField HeaderText="Categoría" DataField="Descripcion" />   
                            <asp:CommandField HeaderText="Editar" ShowSelectButton="true" SelectText="✍︎" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>       
            

        <!--MODAL-->
        <%if (abrirModal)
            {
            string texto;
            string frase;
            if (id == 0)
            {
                texto = "Agregar Categoría";
                frase = "Nueva Categoría";
            }
            else
            {
                texto = "Modificar Categoría";
                frase = "Categoría";
            }               
            %>
                <div class="modal" id="myModal" tabindex="-1">
                <div class="modal-dialog">
                    <div class="modal-content bg-light">
                        <div class="modal-header" style="text-align:center;">
                            <h5><%:texto%></h5>
                        </div>
                        <div class="modal-body">
                            <asp:TextBox runat="server" CssClass="d-none" ID="txtID" />
                            <label class="form-label"><%:frase%></label>
                            <asp:TextBox runat="server" ID="txtCateg" CssClass="form-control txtCateg" />     
                            <asp:Label Text="" ID="lblError" CssClass="lblError" ForeColor="Red" runat="server" />
                        </div>

                        <div class="modal-footer">                                  
                            <asp:Button Text="Cerrar" ID="btnCerrar" OnClick="btnCerrar_Click"  data-bs-dismiss="modal" CssClass="btn btn-primary" runat="server" />
                            <asp:Button OnClientClick="return validarVacio()" Text="Guardar" CssClass="btn btn-success" ID="btnGuardar" OnClick="btnGuardar_Click" runat="server" />
                        </div>                                            
                    </div>
                </div>
                </div>
        <%}%>
        </ContentTemplate>
    </asp:UpdatePanel>


        
    <script type="text/javascript">        
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(mostrarModal);

        mostrarModal();

        function mostrarModal() {
            $('#myModal').modal('show');
        }

        function validarVacio() {
            if (document.querySelector(".txtCateg").value == "") {
                document.querySelector(".lblError").textContent = "Campo vacío";
                return false;
            }
            else {
                document.querySelector(".lblError").textContent = "";
                return true;
            }              
        }
              
    </script>
</asp:Content>
