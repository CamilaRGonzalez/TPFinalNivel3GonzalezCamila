<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Perfil.aspx.cs" Inherits="TiendaOnline.Perfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>   
            <div class="card m-4">
                <div class="card-header">
                    <i class="fas fa-user me-1"></i> Información de Perfil
                </div>

                <div class="card-body">
                    <div class="row m-2">
                        <div class="col-sm-5">
                            <div>
                                <label class="form-label">Email</label>
                                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control txtEmail"/>
                                <label id="lblEmail" style="color:red;margin-bottom:auto;" class="form-label"></label>
                            </div>
                            <div>
                                <label class="form-label">Contraseña</label>
                                <asp:TextBox runat="server" TextMode="Password" ID="txtPass" CssClass="form-control txtPass"/>
                                <label id="lblPass" style="color:red;margin-bottom:auto;" class="form-label"></label>
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
                                <label for="txtIMG" class="form-label">Subir imagen</label>
                                <asp:FileUpload runat="server" CssClass="form-control" ID="inputFoto"  />
                            </div>
                            <div class="mb-2 border rounded">
                                <asp:Image ID="imgPerfil" CssClass="mx-auto d-block img-fluid" Height="272px" runat="server" />
                            </div>                                                               
                        </div>

                    </div>
                </div>

                <div class="card-footer"> 
                    <asp:Button OnClientClick="return validar()" OnClick="btnGuardar_Click" Text="Guardar" ID="btnGuardar" CssClass="btn btn-primary" runat="server" />            
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

    <script> 
        function validar(){
            let txtEmail = document.querySelector(".txtEmail");
            let txtPass = document.querySelector(".txtPass");
            let txtNombre = document.querySelector(".txtNombre");
            let txtApellido = document.querySelector(".txtApellido");
            let arrElementos = [txtEmail, txtPass, txtNombre, txtApellido];

            let lblEmail = document.querySelector("#lblEmail");
            let lblPass = document.querySelector("#lblPass");
            let lblNombre = document.querySelector("#lblNombre");
            let lblApellido = document.querySelector("#lblApellido");
            let arrLabels = [lblEmail, lblPass, lblNombre, lblApellido];

            let regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
            let mailCorrecto = regex.test(txtEmail.value);

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
            
                        
            if (txtEmail.value != "" && !mailCorrecto) {
                txtEmail.classList.add("is-invalid");
                lblEmail.textContent = "Formato email incorrecto";
                bandera = false;
            }
                             
            return bandera;
        }
    </script>
</asp:Content>
