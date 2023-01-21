<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormularioArticulo.aspx.cs" Inherits="TiendaOnline.FormularioArticulo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>   
            <% 
                string tituloModal = "";
                if (idArticulo == 0)
                    tituloModal = "Nuevo Artículo";
                else
                    tituloModal = "Editar Artículo";
            %>
            <div class="card" style="margin-top:20px;">
                <div class="card-header">
                    <i class="fas fa-boxes me-1"></i> <%:tituloModal%>
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-sm-4">                                         
                            <div class="mb-2">
                                <label for="txtIMG" class="form-label">URL Imagen</label>
                                <asp:TextBox runat="server" ID="txtIMG" CssClass="form-control" AutoPostBack="true" OnTextChanged="txtIMG_TextChanged" />  
                                <asp:RequiredFieldValidator Display="Dynamic" ErrorMessage="Campo vacío" ForeColor="Red" ControlToValidate="txtIMG" runat="server" />
                            </div>
                            <div class="mb-2 border rounded">
                                <asp:Image ID="imgProducto" CssClass="mx-auto d-block img-fluid" Height="210px" runat="server" />
                            </div>                                                               
                        </div>

                        <div class="col-sm-4">
                            <div class="mb-2">
                                <label class="form-label">Código Art</label>
                                <asp:TextBox runat="server" ID="txtCodigo" CssClass="form-control"/>
                                <asp:RequiredFieldValidator Display="Dynamic" ErrorMessage="Campo vacío" ForeColor="Red" ControlToValidate="txtCodigo" runat="server" />
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Nombre</label>
                                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control"/>
                                <asp:RequiredFieldValidator Display="Dynamic" ErrorMessage="Campo vacío" ForeColor="Red" ControlToValidate="txtNombre" runat="server" />
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Descripcion</label>
                                <asp:TextBox runat="server" ID="txtDescripcion" TextMode="MultiLine" Height="100px" CssClass="form-control"/>
                                <asp:RequiredFieldValidator Display="Dynamic" ErrorMessage="Campo vacío" ForeColor="Red" ControlToValidate="txtDescripcion" runat="server" />
                            </div>
                        </div>

                        <div class="col-sm-4">
                    
                            <div class="mb-2">
                                <label class="form-label">Precio</label>
                                <asp:TextBox runat="server" ID="txtPrecio" CssClass="form-control"/>  
                                <asp:RequiredFieldValidator Display="Dynamic" ErrorMessage="Campo vacío" ForeColor="Red" ControlToValidate="txtPrecio" runat="server" />
                                <asp:RegularExpressionValidator Display="Dynamic" ForeColor="Red" ValidationExpression="^[0-9]*\.?\,?[0-9]+$" ErrorMessage="Formato ##.## o ##,##" ControlToValidate="txtPrecio" runat="server"/>
                            </div>      
                            <div class="mb-2">
                                <label class="form-label">Categoría</label>
                                <asp:DropDownList runat="server"  ID="ddlCategoria" cssClass="form-select"></asp:DropDownList> 
                            </div>
                            <div class="mb-2">
                                <label class="form-label">Marca</label>
                                <asp:DropDownList runat="server"  ID="ddlMarca" cssClass="form-select"></asp:DropDownList> 
                            </div>  
                        </div>

                    </div>
                </div>

                <div class="card-footer"> 
                    <asp:Button OnClick="btnGuardar_Click" Text="Guardar" ID="btnGuardar" CssClass="btn btn-primary" runat="server" />
                    <% 
                      if(idArticulo != 0)
                      {%>
                        <asp:Button Text="Eliminar" CssClass="btn btn-danger" ID="btnEliminar" runat="server" OnClick="btnEliminar_Click"/>
                        <br />  
                        <asp:Label ID="lblEliminar" CssClass="d-none" Text="¿Esta seguro que quiere eliminar el artículo?" runat="server" />
                        <asp:Button ID="btnEliminarDef" OnClick="btnEliminarDef_Click" Text="Si, eliminar" CssClass="btn btn-danger btn-sm d-none" runat="server" />
                     <%} %>
            
                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
