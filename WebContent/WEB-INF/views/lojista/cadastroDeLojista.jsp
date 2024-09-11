<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>

<% String contextPath = request.getContextPath(); %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<html>
  <head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="robots" content="noindex" />

    <title>Wesell</title>

    <!-- Bootstrap -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
      crossorigin="anonymous"
    />
    <script
      charset="UTF-8"
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous"
    ></script>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css"
      rel="stylesheet"
    />
    <script
      charset="UTF-8"
      src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"
    ></script>

    <!-- CSS -->
    <link
      rel="stylesheet"
      type="text/css"
      href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css"
    />
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
      rel="stylesheet"
    />

    <!-- FontAwesome -->
    <script
      charset="UTF-8"
      src="https://kit.fontawesome.com/3ce21ff22c.js"
      crossorigin="anonymous"
    ></script>
    <link
      rel="stylesheet"
      href="<%=contextPath%>/resources/assets/css/style.css?v=<%=(int)(Math.random()*10000)%>"
    />

    <!-- Sweetalert -->
    <script
      charset="UTF-8"
      src="https://cdn.jsdelivr.net/npm/sweetalert2@11"
    ></script>
    <script charset="UTF-8" src="sweetalert2.all.min.js"></script>

    <!-- Animation-css -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />
  </head>

  <body>
    <header id="menu"></header>

    <div class="bg-loading">
      <div class="spinner">
        <div class="rect1"></div>
        <div class="rect2"></div>
        <div class="rect3"></div>
        <div class="rect4"></div>
      </div>
    </div>

    <button id="teste" type="button" class="btn botaoDesativaMenu">
      <i class="fa-solid fa-arrow-right" style="color: #ffffff"></i>
    </button>

    <button type="button" class="btn botaoAtivaMenu">
      <i class="fa-solid fa-arrow-left mover-left"></i>
    </button>
    <main class="py-4 container-res">
      <section class="mb-5">
        <div class="card">
          <div class="card-body title">
            <i class="fa-solid fa-shop"></i>
            <span id="tituloPagina">Cadastro de Lojista</span>
          </div>
        </div>
      </section>
      <section class="pt-4">
        <form
          id="form-funcionario"
          class="card form p-5 col-8 mx-auto animate__animated animate__bounceInUp"
        >
          <h1 id="tituloForm" class="text-center mb-5">Cadastro</h1>
          <input
            type="text"
            id="usuarioCadastro"
            hidden
            value="${funcionario.idUsuario}"
          />

          <div class="row mb-2">
            <div class="col-md-6">
              <label for="nomeFantasia" class="form-label"
                >Nome Fantasia:<span class="red">*</span>
              </label>
              <input
                required
                autocomplete="off"
                type="text"
                id="nomeFantasia"
                name="nomeFantasia"
                class="form-control inputForm"
                maxlength="255"
              />
            </div>
            <div class="col-md-6">
              <label for="razaoSocial" class="form-label"
                >Razão Social:<span class="red">*</span></label
              >
              <input
                type="text"
                id="razaoSocial"
                autocomplete="off"
                name="razaoSocial"
                required
                class="form-control inputForm"
                maxlength="255"
              />
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-6">
              <label for="cnpj" class="form-label"
                >CNPJ:<span class="red">*</span></label
              >
              <input
                required
                autocomplete="off"
                type="text"
                id="cnpj"
                name="cnpj"
                class="form-control inputForm"
                maxlength="14"
                data-mask="00.000.000/0000-00"
              />
            </div>
            <div class="col-md-6">
              <label for="inscricaoEstadual" class="form-label"
                >Inscrição Estadual:</label
              >
              <input
                type="text"
                id="inscricaoEstadual"
                autocomplete="off"
                name="inscricaoEstadual"
                class="form-control inputForm"
                maxlength="9"
              />
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-6">
              <label for="cep" class="form-label"
                >CEP:<span class="red">*</span></label
              >
              <input
                type="text"
                id="cep"
                required
                autocomplete="off"
                name="cep"
                class="form-control inputForm"
                maxlength="8"
                data-mask="00000-000"
              />
            </div>
            <div class="col-md-6">
              <label for="endereco" class="form-label"
                >Endereço:<span class="red">*</span></label
              >
              <input
                type="text"
                id="endereco"
                required
                autocomplete="off"
                name="endereco"
                class="form-control inputForm"
                maxlength="255"
              />
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-6">
              <label for="numero" class="form-label"
                >N°:<span class="red">*</span></label
              >
              <input
                required
                autocomplete="off"
                type="text"
                id="numero"
                name="numero"
                class="form-control inputForm"
                maxlength="10"
              />
            </div>
            <div class="col-md-6">
              <label for="bairro" class="form-label"
                >Bairro:<span class="red">*</span></label
              >
              <input
                type="text"
                id="bairro"
                required
                autocomplete="off"
                name="bairro"
                class="form-control inputForm"
                maxlength="255"
              />
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-6">
              <label for="complemento" class="form-label">Complemento:</label>
              <input
                type="text"
                id="complemento"
                autocomplete="off"
                name="complemento"
                class="form-control inputForm"
                maxlength="255"
              />
            </div>
            <div class="col-md-6">
              <label for="estado" class="form-label"
                >Estado:<span class="red">*</span></label
              >
              <input
                type="text"
                id="estado"
                required
                autocomplete="off"
                name="estado"
                class="form-control inputForm"
                maxlength="2"
              />
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-6">
              <label for="cidade" class="form-label"
                >Cidade:<span class="red">*</span></label
              >
              <input
                type="text"
                id="cidade"
                required
                autocomplete="off"
                name="text"
                class="form-control inputForm"
                maxlength="255"
              />
            </div>
            <div class="col-md-6">
              <label for="site" class="form-label"
                >Site:<span class="red">*</span></label
              >
              <input
                type="text"
                id="site"
                required
                autocomplete="off"
                name="site"
                class="form-control inputForm"
                maxlength="255"
              />
            </div>
          </div>

          <div class="row mb-4">
            <div class="col-md-6">
              <label for="calcularFrete" class="form-label"
                >Calcular Frete:<span class="red">*</span>
              </label>
              <div class="form-control">
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="calcularFrete"
                    id="calcularFreteSim"
                    value="S"
                    required
                  />
                  <label class="form-check-label" for="calcularFreteSim"
                    >Sim</label
                  >
                </div>
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="calcularFrete"
                    id="calcularFreteNao"
                    value="N"
                    required
                  />
                  <label class="form-check-label" for="calcularFreteNao"
                    >Não</label
                  >
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <label for="avisoRecebimento" class="form-label"
                >Aviso de Recebimento:<span class="red">*</span>
              </label>
              <div class="form-control" id="avisoRecebimento">
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="avisoRecebimento"
                    id="avisoRecebimentoS"
                    value="S"
                    required
                  />
                  <label class="form-check-label" for="avisoRecebimentoS"
                    >Sim</label
                  >
                </div>
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="avisoRecebimento"
                    id="avisoRecebimentoN"
                    value="N"
                    required
                  />
                  <label class="form-check-label" for="avisoRecebimentoN"
                    >Não</label
                  >
                </div>
              </div>
            </div>
          </div>

          <div class="row mb-4">
            <div class="col-md-6">
              <label for="maosProprias" class="form-label"
                >Mãos Próprias:<span class="red">*</span>
              </label>
              <div class="form-control" id="maosProprias">
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="maosProprias"
                    id="maosPropriasSim"
                    value="S"
                    required
                  />
                  <label class="form-check-label" for="maosPropriasSim"
                    >Sim</label
                  >
                </div>
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="maosProprias"
                    id="maosPropriasNao"
                    value="N"
                    required
                  />
                  <label class="form-check-label" for="maosPropriasNao"
                    >Não</label
                  >
                </div>
              </div>
            </div>
            <div class="col-md-6" id="cardCEP">
              <label for="cepCd" class="form-label"
                >CEP do CD:<span class="red">*</span></label
              >
              <input
                type="tel"
                class="form-control"
                id="cepCd"
                data-mask="00000-000"
                name="cepCd"
              />
            </div>
          </div>

          <div class="row mb-4">
            <div class="col-md-6">
              <label for="aceitaBoleto" class="form-label"
                >Aceita Boleto:<span class="red">*</span>
              </label>
              <div class="form-control">
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="aceitaBoleto"
                    id="aceitaBoletoS"
                    value="S"
                    required
                  />
                  <label class="form-check-label" for="aceitaBoletoS"
                    >Sim</label
                  >
                </div>
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="aceitaBoleto"
                    id="aceitaBoletoN"
                    value="N"
                    required
                  />
                  <label class="form-check-label" for="aceitaBoletoN"
                    >Não</label
                  >
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <label for="aceitaPix" class="form-label"
                >Aceita Pix:<span class="red">*</span></label
              >
              <div class="form-control">
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="aceitaPix"
                    id="aceitaPixSim"
                    value="S"
                    required
                  />
                  <label class="form-check-label" for="aceitaPixSim">Sim</label>
                </div>
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="aceitaPix"
                    id="aceitaPixNao"
                    value="N"
                    required
                  />
                  <label class="form-check-label" for="aceitaPixNao">Não</label>
                </div>
              </div>
            </div>
          </div>

          <div class="row mb-4">
            <div class="col-md-6">
              <label for="aceitaCartao" class="form-label"
                >Aceita Cartão:<span class="red">*</span>
              </label>
              <div class="form-control">
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="aceitaCartao"
                    id="aceitaCartaoSim"
                    value="S"
                    required
                  />
                  <label class="form-check-label" for="aceitaCartaoSim"
                    >Sim</label
                  >
                </div>
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="aceitaCartao"
                    id="aceitaCartaoNao"
                    value="N"
                    required
                  />
                  <label class="form-check-label" for="aceitaCartaoNao"
                    >Não</label
                  >
                </div>
              </div>
            </div>
            <div class="col-md-6">
              <label for="possuiParcelamento" class="form-label"
                >Possui Parcelamento:<span class="red">*</span>
              </label>
              <div class="form-control" id="possuiParcelamento">
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="possuiParcelamento"
                    id="possuiParcelamentoS"
                    value="S"
                    required
                  />
                  <label class="form-check-label" for="possuiParcelamentoS"
                    >Sim</label
                  >
                </div>
                <div class="form-check form-check-inline">
                  <input
                    class="form-check-input"
                    type="radio"
                    name="possuiParcelamento"
                    id="possuiParcelamentoN"
                    value="N"
                    required
                  />
                  <label class="form-check-label" for="possuiParcelamentoN"
                    >Não</label
                  >
                </div>
              </div>
            </div>
          </div>

          <div class="row mb-4">
            <div class="col-md-6">
              <label for="maximoParcelas" class="form-label"
                >Máximo de Parcelas:<span class="red">*</span>
              </label>
              <input
                type="text"
                id="maximoParcelas"
                required
                autocomplete="off"
                name="maximoParcelas"
                data-mask="00"
                class="form-control"
              />
            </div>
            <div class="col-md-6">
              <label for="valorMinimoDaCompra" class="form-label"
                >Valor Mínimo da Compra:<span class="red">*</span>
              </label>
              <input
                type="text"
                id="valorMinimoDaCompra"
                required
                autocomplete="off"
                name="valorMinimoDaCompra"
                class="form-control inputForm"
                maxlength="12"
              />
            </div>
          </div>

          <div class="row mb-2">
            <div class="col-md-12 text-center">
              <button
                type="submit"
                id="btn-submit"
                class="btn confirm btn-primary btn-register"
              >
                Cadastrar
              </button>
            </div>
          </div>

          <!-- Button modal de cadastro  -->
          <button
            type="button"
            style="display: none"
            class="btn btn-primary"
            id="openModalBtn"
            data-bs-toggle="modal"
            data-bs-target="#exampleModal"
          >
            Launch demo modal
          </button>

          <!-- Modal de cadastro -->
          <div
            class="modal fade"
            id="exampleModal"
            tabindex="-1"
            aria-labelledby="exampleModalLabel"
            aria-hidden="true"
          >
            <div class="modal-dialog">
              <div class="modal-content">
                <div class="modal-header">
                  <i
                    id="icone-modal"
                    class="fa-solid fa-check circulo-border"
                  ></i>
                  <h1
                    class="modal-title fs-5 titulo-modal"
                    id="exampleModalLabel"
                  >
                    Seu Cadastro Foi Realizado!
                  </h1>
                </div>
              </div>
            </div>
          </div>
        </form>
      </section>
    </main>
    <script
      charset="UTF-8"
      src="https://code.jquery.com/jquery-3.7.1.js"
      integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
      crossorigin="anonymous"
    ></script>
    <script
      charset="UTF-8"
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
      integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
      crossorigin="anonymous"
    ></script>
    <script
      charset="UTF-8"
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
      integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
      crossorigin="anonymous"
    ></script>
    <script
      charset="UTF-8"
      type="text/javascript"
      src="https://cdn.jsdelivr.net/npm/toastify-js"
    ></script>
    <script
      charset="UTF-8"
      src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"
    ></script>
    <script
      charset="UTF-8"
      src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"
    ></script>
    <script
      charset="UTF-8"
      src="<%=contextPath%>/resources/assets/js/comum.js?v=<%=(int)(Math.random()*10000)%>"
    ></script>
    <script
      charset="UTF-8"
      src="<%=contextPath%>/resources/assets/js/lojista/cadastroDeLojista.js"
    ></script>
  </body>
</html>
