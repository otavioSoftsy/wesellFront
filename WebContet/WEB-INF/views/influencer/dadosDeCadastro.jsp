<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
String contextPath = request.getContextPath();
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="robots" content="noindex" />

<title>Centro Universitário Sumaré</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet" />
<link
	href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
	rel="stylesheet" />
<script
	src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

<!-- CSS -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
	rel="stylesheet" />

<!-- FontAwesome -->
<script src="https://kit.fontawesome.com/2476720ce5.js"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="<%=contextPath%>/resources/assets/css/dadosDeCadastro.css" />

<!-- Animation-css -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
</head>

<body>
	<div class="bg-loading">
		<div class="spinner">
			<div class="rect1"></div>
			<div class="rect2"></div>
			<div class="rect3"></div>
			<div class="rect4"></div>
		</div>
	</div>

	<header class="d-flex flex-column menuPrincipal w-100  ">

		<div
			class="d-flex justify-content-between align-items-center shadowNovo menu-alto">

			<img alt="logo" src="<%=contextPath%>/resources/assets/img/logo.svg"
				class="logo-menu">
			<div class="p-4 d-flex gap-3">

				<a href="#"><i class="fa-solid fa-bell icone-menu"></i></a> <a
					href="dadosDeCadastro"><i class="fa-solid fa-user icone-menu"></i></a>

			</div>

		</div>
		
		<div class="abracaMenu modalMenu d-flex flex-column justify-content-between menu-baixo shadowNovo h-100">
		
		 <nav class="menu">
        <div class="item">
          <a class="sub-btn d-flex align-items-center"><i class="fa-solid fa-cube icone-menu"></i>Usuário
            <i class="fas fa-angle-right dropdown"></i
			></a>
          <div class="sub-menu">
            <a href="dadosDeCadastro" class="sub-item d-flex align-items-center"><i class="fa-solid fa-id-card icone-menu"></i>Meus dados</a>
			<a href="meusProdutos" class="sub-item"><i class="fa-brands fa-dropbox icone-menu"></i>Meus Produtos</a>
          </div>
        </div> 
      	<div class="item">
          <a class="sub-btn d-flex align-items-center"><i class="fa-solid fa-cubes-stacked icone-menu"></i> Afiliação
            <i class="fas fa-angle-right dropdown"></i></a>
          <div class="sub-menu">
             <a href="mercado" class="sub-item d-flex align-items-center"><i class="fa-solid fa-hand-holding-dollar icone-menu"></i>Mercado</a>
          </div>
        </div>
      </nav>
      
      <a href="#" class="d-flex align-items-center gap-3 text-decoration-none colorPreto">
      <i class="fa-solid fa-arrow-left icone-menu"></i> Sair </a>
      
		</div>			

	</header>

	<main class="main">

		<h1 style='font-weight: 300;' class="mt-2 text-center mt-2">Meus Dados</h1>
		
		<div class="d-flex gap-3 justify-content-center mb-2 mt-2">
			<button id="perfil" class="btn btn-secondary">Perfil</button>
			<button id="dadosBancario" class="btn btn-secondary">Dados Bancários</button>
		</div>
		
		<form id="formPerfil" class="d-flex flex-column align-items-center card form p-2 col-10 mx-auto animate__animated ">
  

        <div class="col-md-8 mb-4 d-flex flex-column gap-2 container-nomes pt-2 ">

        		<label for="nome" class="form-label">Nome:<span class="red">*</span></label> 
        		<input required autocomplete="off" type="text" id="nome" name="nome"
           		 class="form-control inputForm" maxlength="255"  />
            
        </div>
        
      

        <div class="col-md-8 mb-4 d-flex flex-column gap-2 container-nomes">
        
            <label for="data" class="form-label">Data de Nascimento:<span class="red">*</span></label> <input required
            autocomplete="off"  max='3000-01-01' type="date" id="dataNascimento" name="data"
            class="form-control inputForm" />  
       
        </div>
        
         <div class="col-md-8 mb-4 d-flex flex-column gap-2 container-nomes">
         
          <label for="numero" class="form-label">Número de Contato:<span class="red">*</span></label>
        		 <input required
           		 autocomplete="off" type="text" id="numero" name="numero"
          		  class="form-control inputForm" maxlength="11" placeholder="(00)00000-0000"
          		  data-mask="(00)00000-0000"/>
          		  
          </div>

        <div class="col-md-8 mb-4">
            <label for="email" class="form-label">E-mail:<span class="red">*</span></label> <input required
            autocomplete="off" type="email" id="email" name="email"
            class="form-control inputForm" maxlength="255" />
        </div>

        <div class="col-md-8 mb-4">
            <label for="senha" class="form-label">Senha:<span class="red">*</span></label> <input required
            autocomplete="off" type="password" id="senha" name="senha"
            class="form-control inputForm" maxlength="255" />
        </div>

        

        <div id="container-cpf" class="col-md-8 mb-4">
        	<label for="cpf" class="form-label">CPF:</label>
            <input  autocomplete="off" type="text" id="cpf" name="cpf"
            class="form-control inputForm" disabled maxlength="255" placeholder="000.000.000-00" 
            data-mask="000.000.000-00"/>
        </div>

        <div id="container-cnpj" class="col-md-8 mb-4 ">
         	<label for="cnpj" class="form-label">CNPJ:</label>
            <input  autocomplete="off" type="text" id="cnpj" name="cnpj"
            class="form-control inputForm" disabled maxlength="255" placeholder="00.000.000/0000-00" 
            data-mask="00.000.000/0000-00" />
        </div>

        <div class="col-md-8 mb-4">
           <button id="enviarFormInfluencer" class="btn btn-success btn-lg btn-block w-100">Salvar</button>
        </div>


    </form>
    
    <form id="formBancario" class="d-flex flex-column align-items-center card form p-2 col-10 mx-auto animate__animated d-none">
  
		 <div class="col-md-8 mb-4 d-flex flex-column mt-2 ">

        		<label for="banco" class="form-label">Banco:<span class="red">*</span></label> 
        		
				<select id="banco" required class="form-select" >
				</select>
			
        </div>
        
         <div class="col-md-8 mb-4 d-flex flex-column gap-2 container-nomes pt-2 ">

        		<label for="agencia" class="form-label">Agência:<span class="red">*</span></label> 
        		<input required autocomplete="off" type="number" id="agencia" name="agencia"
           		 class="form-control inputForm" maxlength="255"  />
            
        </div>
        
          <div class="col-md-8 mb-4 d-flex flex-column gap-2 container-nomes pt-2 ">

        		<label for="conta" class="form-label">Conta:<span class="red">*</span></label> 
        		<input required autocomplete="off" type="number" id="conta" name="conta"
           		 class="form-control inputForm" maxlength="255"  />
            
        </div>
        
        <div class="col-md-8 mb-4 d-flex flex-column gap-2 container-nomes pt-2 ">

        		<label for="digito" class="form-label">Dígito:<span class="red">*</span></label> 
        		<input required autocomplete="off" type="number" id="digito" name="digito"
           		 class="form-control inputForm" maxlength="255"  />
            
        </div>
        
        <div class="col-md-8 mb-4">
           <button id="enviarFormInfluencer" class="btn btn-success btn-lg btn-block w-100">Salvar</button>
        </div>


    </form>
	

	</main>

	<!--  	<footer >Copyright @ 2000-2024 - Todos os direitos reservados - Desenvolvido pela Softsy</footer> -->
	
	<script src="https://code.jquery.com/jquery-3.7.1.js"
		integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
		integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
		crossorigin="anonymous"></script>
	<script type="text/javascript"
		src="https://cdn.jsdelivr.net/npm/toastify-js"></script>
	<script
		src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
	<script src="<%=contextPath%>/resources/assets/js/comum.js"></script>
	<script
		src="<%=contextPath%>/resources//assets/js/dadosDeCadastro.js"></script>
</body>
</html>
