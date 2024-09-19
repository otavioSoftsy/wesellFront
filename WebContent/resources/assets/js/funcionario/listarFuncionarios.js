var dados = [];
var sortOrder = {};
var funcionarios = [];
var dadosFiltrados = [];

const botaoDesativa = document.querySelector("#teste");
const botaoAtiva = document.querySelector(".botaoAtivaMenu");
const elemento = document.querySelector("#modalMenu");

botaoDesativa.addEventListener("click", () => {
  elemento.classList.add("animar-sair");
  elemento.classList.remove("animar-entrar");
});

botaoAtiva.addEventListener("click", () => {
  elemento.classList.add("animar-entrar");
  elemento.classList.remove("animar-sair");
});

$(document).ready(function () {
  $.ajax({
    url: url_base + "/funcionarios?page=0&size=12",
    type: "GET",
    async: false,
    beforeSend: function () {
      Swal.showLoading();
    },
    error: function (e) {
      Swal.close();
      console.log(e.responseJSON);
      Swal.fire({
        icon: "error",
        title: e.responseJSON.message,
      });
    },
  }).done(function (data) {
    Swal.close();
    $("#exportar-excel").click(function () {
      var planilha = XLSX.utils.json_to_sheet(data);
      var livro = XLSX.utils.book_new();
      XLSX.utils.book_append_sheet(livro, planilha, "Planilha1");
      XLSX.writeFile(livro, "FuncionariosLojista.xlsx");
    });

    funcionarios = data;
    dadosFiltrados = funcionarios;
    renderizarFuncionarios(dadosFiltrados);
    showPageNew(currentPage);
    renderPageNumbersNew();
  });

  function renderizarFuncionarios(funcionarios) {
    var html = funcionarios
      .map(function (item) {
        var buttonClass = item.ativo === "S" ? "btn-success" : "btn-danger";

        return (
          "<tr>" +
          "<td>" +
          '<button type="button" class="btn btn-status btn-sm ' +
          buttonClass +
          '" style="width: 63px; height: 31px; padding: 2px; display: flex; align-items: center; justify-content: center;" disabled>' +
          (item.ativo === "S"
            ? "<i class='fa-solid fa-check fa-xl'></i>"
            : '<i class="fa-solid fa-xmark fa-xl"></i>') +
          "</button>" +
          "</td>" +
          "<td>" +
          item.nome +
          "</td>" +
          "<td>" +
          item.cargo.cargo +
          "</td>" +
          "<td>" +
          item.lojista.nomeFantasia +
          "</td>" +
          "<td>" +
          item.cpf.replace(/^(\d{3})(\d{3})(\d{3})(\d{2})$/, "$1.$2.$3-$4") +
          "</td>" +
          '<td class="d-flex"><span style="width: 63px; margin-right: 5px; height: 31px; padding: 8px; display: flex; align-items: center; justify-content: center;" class="btn btn-warning btn-sm" data-value="' +
          item.idFuncionario +
          '" onclick="editar(this)"><i class="fa-solid fa-pen fa-lg"></i></span> <input type="checkbox" data-status="' +
          item.ativo +
          '" data-id="' +
          item.idFuncionario +
          '" onChange="alteraStatus(this)" checked data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="63" class="checkbox-toggle" data-size="sm"></td>' +
          "</tr>"
        );
      })
      .join("");

    $("#colaTabela").html(html);
  }

  $(".checkbox-toggle").each(function () {
    var status = $(this).data("status");
    if (status !== "S") {
      $(this).prop("checked", false);
    }
  });

  $("#inputBusca").on("input", function () {
    var valorBusca = $(this).val().toLowerCase();
    realizarBusca(valorBusca);
  });

  function realizarBusca(valorInput) {
    if (valorInput === "") {
      dadosFiltrados = funcionarios;
    } else {
      dadosFiltrados = funcionarios.filter(function (item) {
        return (
          item.nome.toLowerCase().includes(valorInput) ||
          item.cargo.cargo.toLowerCase().includes(valorInput) ||
          item.cpf.toLowerCase().includes(valorInput)
        );
      });
    }

    currentPage = 1;
    renderizarFuncionarios(dadosFiltrados);
    renderPageNumbersNew();
    showPageNew(currentPage);
    toggleNavigationNew();
  }

  function showPageNew(page) {
    var start = (page - 1) * rows;
    var end = start + rows;

    $("#colaTabela tr").hide();
    $("#colaTabela tr").slice(start, end).show();
    toggleNavigationNew();
  }

  function renderPageNumbersNew() {
    var totalRows = dadosFiltrados.length;
    var totalPages = Math.ceil(totalRows / rows);
    var pageNumbersHtml = "";

    if (totalPages > 1) {
      $("#pagination").removeAttr("hidden");

      var startPage = Math.max(1, currentPage - 1);
      var endPage = Math.min(totalPages, currentPage + 1);

      if (currentPage === 1) {
        endPage = Math.min(totalPages, 3);
      } else if (currentPage === totalPages) {
        startPage = Math.max(1, totalPages - 2);
      }

      if (totalPages > 1) {
        for (var i = startPage; i <= endPage; i++) {
          pageNumbersHtml +=
            '<li class="page-item ' +
            (i === currentPage ? "active" : "") +
            '">';
          pageNumbersHtml +=
            '<a class="page-link" href="#" data-page="' + i + '">' + i + "</a>";
          pageNumbersHtml += "</li>";
        }
      }

      $("#pagination").find("li.page-item:not(#prevB):not(#nextB)").remove();
      $("#pagination").find("li#prevB").after(pageNumbersHtml);

      $("#pagination").show();

      $("#pagination .page-link").click(function (e) {
        e.preventDefault();
        var page = $(this).data("page");
        if (page !== currentPage) {
          currentPage = page;
          showPageNew(currentPage);
          renderPageNumbersNew();
          toggleNavigationNew();
        }
      });
    } else {
      $("#pagination").attr("hidden", true);
    }
  }

  function toggleNavigationNew() {
    var totalRows = dadosFiltrados.length;
    var totalPages = Math.ceil(totalRows / rows);

    if (totalRows > rows) {
      $("#prevB, #nextB").show();
      $("#prevB").toggleClass("disabled", currentPage === 1);
      $("#nextB").toggleClass("disabled", currentPage === totalPages);

      $("#prevB a").click(function (e) {
        e.preventDefault();
        if (currentPage > 1) {
          currentPage--;
          showPageNew(currentPage);
          renderPageNumbersNew();
        }
      });

      $("#nextB a").click(function (e) {
        e.preventDefault();
        if (currentPage < totalPages) {
          currentPage++;
          showPageNew(currentPage);
          renderPageNumbersNew();
        }
      });
    } else {
      $("#prevB, #nextB").hide();
    }
  }
  $("#prevB").click(function () {
    if (currentPage > 1) {
      currentPage--;
      showPageNew(currentPage);
      renderPageNumbersNew();
    }
  });

  $("#nextB").click(function () {
    var totalRows = dadosFiltrados.length;
    var totalPages = Math.ceil(totalRows / rows);

    if (currentPage < totalPages) {
      currentPage++;
      showPageNew(currentPage);
      renderPageNumbersNew();
    }
  });
});

function editar(user) {
  var idFuncionario = user.getAttribute("data-value");
  window.location.href = "cadastroFuncionario?id=" + idFuncionario;
}
function alteraStatus(element) {
  var id = element.getAttribute("data-id");
  var status = element.getAttribute("data-status");

  const button = $(element).closest("tr").find(".btn-status");
  if (status === "S") {
    button.removeClass("btn-success").addClass("btn-danger");
    button.find("i").removeClass("fa-check").addClass("fa-xmark");
    element.setAttribute("data-status", "N");
  } else {
    button.removeClass("btn-danger").addClass("btn-success");
    button.find("i").removeClass("fa-xmark").addClass("fa-check");
    element.setAttribute("data-status", "S");
  }

  $.ajax({
    url:
      url_base +
      `/funcionarios/${id}${status === "S" ? "/desativar" : "/ativar"}`,
    type: "put",
    error: function (e) {
      console.log(e.responseJSON);
      Swal.fire({
        icon: "error",
        title: e.responseJSON.error,
      });
    },
  });
}
