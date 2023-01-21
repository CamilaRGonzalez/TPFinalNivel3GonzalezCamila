<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionArticulos.aspx.cs" Inherits="TiendaOnline.GestionArticulos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <!--FILTROS-->
        <div style="margin-top:20px;">
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
                        <asp:Button Text="Filtrar" ID="btnFiltrar" CssClass="btn btn-primary form-control" runat="server" OnClick="btnFiltrar_Click"/>                                
                    </div>
             </div>
          </div>

            <!--TARJETA CONTENEDORA-->
            <div class="card border-0" style="margin-top:20px;">
                <div class="card-header border">
                    <i class="fas fa-boxes me-1"></i> Lista de Artículos
                </div>

                <div class="card-body">
                    <div class="row">
                        <div class="col-12">
                            <!-- Nuevo Articulo -->
                            <asp:Button OnClick="btnNuevoArt_Click" Text="Crear Nuevo" ID="btnNuevoArt" CssClass="btn btn-success" runat="server" />
                        </div>
                    </div>
                    <hr />

                    <asp:GridView runat="server" ID="dgvArticulos" cssClass="table"  AutoGenerateColumns="false"
                        DataKeyNames="Id" OnSelectedIndexChanged="dgvArticulos_SelectedIndexChanged"
                        OnPageIndexChanging="dgvArticulos_PageIndexChanging" AllowPaging="true" PageSize="10">
                        <Columns>
                            <asp:BoundField HeaderText="Código Art" DataField="Codigo" />
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                            <asp:BoundField HeaderText="Precio" DataFormatString="{0:C2}" DataField="Precio" />
                            <asp:BoundField HeaderText="Categoria" DataField="Categoria.Descripcion" /> 
                            <asp:BoundField HeaderText="Marca" DataField="Marca.Descripcion" />                            
                            <asp:CommandField HeaderText="Editar" ShowSelectButton="true" SelectText="✍︎" />
                        </Columns>
                    </asp:GridView>

                </div>
            </div>

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
