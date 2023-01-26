<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TiendaOnline.Login" %>

<!DOCTYPE html>

<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <script src="Scripts/jquery-3.4.1.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
        <style> 
            .divider:after,
            .divider:before {
            content: "";
            flex: 1;
            height: 1px;
            background: #eee;
            }
            .h-custom {
            height: calc(100% - 73px);
            }
            @media (max-width: 450px) {
            .h-custom {
            height: 100%;
            }
            }
        </style>

    </head>
    <body class="bg-light">
        <form runat="server">
                <asp:ScriptManager runat="server">
                    <Scripts>
                        <%--To learn more about bundling scripts in ScriptManager see https://go.microsoft.com/fwlink/?LinkID=301884 --%>
                        <%--Framework Scripts--%>
                        <asp:ScriptReference Name="MsAjaxBundle" />
                        <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                        <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
                        <asp:ScriptReference Name="MenuStandards.js" Assembly="System.Web" Path="~/Scripts/WebForms/MenuStandards.js" />
                        <asp:ScriptReference Name="GridView.js" Assembly="System.Web" Path="~/Scripts/WebForms/GridView.js" />
                        <asp:ScriptReference Name="DetailsView.js" Assembly="System.Web" Path="~/Scripts/WebForms/DetailsView.js" />
                        <asp:ScriptReference Name="TreeView.js" Assembly="System.Web" Path="~/Scripts/WebForms/TreeView.js" />
                        <asp:ScriptReference Name="WebParts.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebParts.js" />
                        <asp:ScriptReference Name="Focus.js" Assembly="System.Web" Path="~/Scripts/WebForms/Focus.js" />
                        <asp:ScriptReference Name="WebFormsBundle" />
                        <%--Site Scripts--%>
                    </Scripts>
                </asp:ScriptManager>
                  <%
                      string titulo = "";
                      if(LogicaNegocio.Helper.tieneQueryString(this,"Registro"))
                          titulo = "Registro";
                      else
                          titulo="Login";
                   %>


                <div class="container m-5 mark bg-light">
                    <div class="m-5">                      
                      <div class="row">
                          <div class="col">
                            <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                              class="img-fluid" alt="Sample image">
                          </div>

                          <div class="col">
                              <div class="mt-2 mb-2">
                                  <h2><%:titulo%></h2>
                              </div>
                            <div>   
                              <asp:Label Text="" ID="lblMensajeExito" Enabled="false" ForeColor="Blue" runat="server" /> 
                              <!-- Email input -->
                              <div class="form-outline mb-3">
                                  <label class="form-label">Email</label>
                                  <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control form-control-lg" placeholder="Ingrese su email"/>       
                                  <label id="lblEmail" style="color:red;" class="form-label"></label>
                              </div>

                              <!-- Password input -->
                              <div class="form-outline mb-3">
                                  <label class="form-label">Contraseña</label>  
                                  <asp:TextBox runat="server" TextMode="Password" ID="txtPass" CssClass="form-control form-control-lg" placeholder="Ingrese su contraseña"/>                             
                                  <label id="lblPass" style="color:red;" class="form-label"></label>
                                  <asp:Label Text="" ID="txtMensajeError" Enabled="false" ForeColor="Red" runat="server" />
                              </div>
                             
                              <div class="text-center text-lg-start mt-4 pt-2">
                                  <asp:Button OnClientClick="return validar()" CssClass="btn btn-primary" style="padding-left: 2.5rem; padding-right: 2.5rem;" Text="Ingresar" ID="btnIngresar" OnClick="btnIngresar_Click" runat="server" />
                                <p class="small fw-bold mt-2 pt-1 mb-0"> No tiene una cuenta? <a href="Login.aspx?Registro=true"
                                    class="link-danger">Registrese</a></p>
                              </div>

                            </div>
                          </div>
                        </div>  
                    </div>
                  
                </div>

             <!--MODAL-->
            <%if(!(LogicaNegocio.Helper.tieneQueryString(this,"Registro") || LogicaNegocio.Helper.tieneQueryString(this,"Success") || LogicaNegocio.Helper.tieneQueryString(this,"salir")))
              {%>
                    <asp:UpdatePanel runat="server">
                            <ContentTemplate>   
                              <div class="modal" id="myModal" tabindex="-1">
                                <div class="modal-dialog">
                                    <div class="modal-content bg-light">
                                        <div class="modal-body">
                                            <div>   
                                                <h6>Cuenta admin:</h6>
                                                <p>Usuario: admin@admin.com <br />  
                                                  Contraseña: admin
                                                </p>
                                            </div>
                                            <div>   
                                                <h6>Cuenta usuario:</h6>
                                                <p>Usuario: user@user.com <br />    
                                                   Contraseña: user
                                                </p>
                                            </div>
                                        </div>
                                        <div class="modal-footer">                                  
                                            <button data-bs-dismiss="modal" class="btn btn-primary">Cerrar</button>
                                        </div>                                            
                                    </div>
                                </div>
                              </div>
                            </ContentTemplate>
                        </asp:UpdatePanel>
            <%}%>
            
                
                
                <script> 

                    $(document).ready(function () {                   
                          $('#myModal').modal('show');
                    });
                                     

                    function validar(){
                        document.querySelector("#txtMensajeError").textContent = "";
                        let txtEmail = document.querySelector("#txtEmail");
                        let txtPass = document.querySelector("#txtPass");
                        let regex = /^[-\w.%+]{1,64}@(?:[A-Z0-9-]{1,63}\.){1,125}[A-Z]{2,63}$/i;
                        let mailCorrecto = regex.test(txtEmail.value);
                        let bandera = true;

                        if(txtPass.value == ""){
                            txtPass.classList.add("is-invalid");
                            document.querySelector("#lblPass").textContent = "Campo vacío";
                            bandera = false;
                        }                       
                        else{
                            txtPass.classList.remove("is-invalid");
                            document.querySelector("#lblPass").textContent = "";
                        }
                        

                        if(txtEmail.value == "" || !mailCorrecto){
                            txtEmail.classList.add("is-invalid");
                            if(txtEmail.value == "" )
                                document.querySelector("#lblEmail").textContent= "Campo vacío";
                            else
                                document.querySelector("#lblEmail").textContent= "Formato email incorrecto";

                            bandera = false;
                        }                       
                        else{
                            txtEmail.classList.remove("is-invalid");
                            document.querySelector("#lblEmail").textContent= "";
                        }
                        
                             
                        return bandera;
                    }
                </script>
        </form>

    </body>
</html>
