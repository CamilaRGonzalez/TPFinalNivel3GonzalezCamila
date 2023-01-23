<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="TiendaOnline.Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
 
            <div class="card m-4">
                <div class="card-header">
                    <i class="fas fa-user me-1"></i> Información de Perfil
                </div>

                <div class="card-body">
                    <div class="row m-2">
                        <div class="col-sm">
                            <div>
                                <label for="txtIMG" class="form-label">Subir imagen</label>                               
                                <input accept="image/jpg, image/png, image/jpeg" type="file" id="inputFoto" class="form-control" runat="server" onchange="mostrarImagen(this)"/>
                                <label class="form-label"></label>
                            </div>
                            <div>
                                <label class="form-label">Email</label>
                                <asp:TextBox Enabled="false" runat="server" ID="txtEmail" CssClass="form-control txtEmail"/>
                                <label id="lblEmail" style="color:red;margin-bottom:auto;" class="form-label"></label>
                            </div>
                            <div>
                                <label class="form-label">Nombre</label>
                                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control txtNombre"/>  
                                <label id="lblNombre" style="color:red;margin-bottom:auto;" class="form-label"></label>
                            </div>      
                            <div>
                                <label class="form-label">Apellido</label>
                                <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control txtApellido"/> 
                                <label id="lblApellido" style="color:red;margin-bottom:auto;" class="form-label"></label>
                            </div> 
                        </div>

                        <div class="col-sm">                                         
                            <div class="mb-2">
                                <asp:Image ID="imgPerfil" CssClass="mx-auto d-block img-fluid imgPerfil" style="border-radius:25px;" Height="350px" runat="server" />
                            </div>                                                               
                        </div>

                    </div>
                </div>

                <div class="card-footer"> 
                    <asp:Button OnClientClick="return validar()" OnClick="btnGuardar_Click" Text="Guardar" ID="btnGuardar" CssClass="btn btn-primary" runat="server" />            
                </div>
            </div>


    <script> 

        function mostrarImagen(input) {
            if (input.files) {
                var lector = new FileReader();
                lector.onload = (e) => {
                    document.querySelector(".imgPerfil").src = e.target.result
                }
                lector.readAsDataURL(input.files[0]);
            }
        }

        function validar(){
            let txtNombre = document.querySelector(".txtNombre");
            let txtApellido = document.querySelector(".txtApellido");
            let arrElementos = [txtNombre, txtApellido];

            let lblNombre = document.querySelector("#lblNombre");
            let lblApellido = document.querySelector("#lblApellido");
            let arrLabels = [lblNombre, lblApellido];

            let bandera = true;


            for (let i = 0; i < arrElementos.length; i++) {
                if (arrElementos[i].value == "") {
                    arrElementos[i].classList.add("is-invalid");
                    arrLabels[i].textContent = "Campo vacío";
                    bandera = false;
                }
                else {
                    arrElementos[i].classList.remove("is-invalid");
                    arrLabels[i].textContent = "";
                }
            }
                                       
            return bandera;
        }
    </script>
</asp:Content>
