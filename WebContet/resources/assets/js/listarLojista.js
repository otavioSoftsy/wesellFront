const botaoDesativa = document.querySelector('#teste');
const botaoAtiva = document.querySelector('.botaoAtivaMenu');
const elemento = document.querySelector('#modalMenu');

botaoDesativa.addEventListener('click', () => {
  elemento.classList.add('animar-sair');
 elemento.classList.remove('animar-entrar');

});

botaoAtiva.addEventListener('click', () => {
  elemento.classList.add('animar-entrar');
  elemento.classList.remove('animar-sair');
  });



var lojistas = []

$(document).ready(function () {
	

  $.ajax({
    url: url_base + "/lojistas",
    type: "GET",
    async: false,
  })
    .done(function (data) {
      lojistas = data;
      renderizarLojistas(data);
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
      console.error("Erro na solicitação AJAX:", textStatus, errorThrown);
    });

    function renderizarLojistas(funcionarios) {
      var html = lojistas.map(function (item) {
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
          item.cnpj.replace(/^(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})$/, "$1.$2.$3/$4-$5") +
          "</td>" +
          "<td>" +
          item.nomeFantasia +
          "</td>" +
          "<td>" +
          item.razaoSocial +
          "</td>" +
          "<td>" +
          item.inscrEstadual +
          "</td>" +
           "<td>" +
          item.endereco +
          "</td>" +
           "<td>" +
          item.numero +
          "</td>" +
           "<td>" +
          item.bairro +
          "</td>" +
           "<td>" +
          item.cidade +
          "</td>" +
           "<td>" +
          item.estado +
          "</td>" +
           "<td>" +
          item.cep.replace(/^(\d{5})(\d{3})$/, "$1-$2") +
          "</td>" +
           "<td>" +
          item.site +
          "</td>" +
          '<td class="d-flex"><span style="width: 63px; margin-right: 5px; height: 31px; padding: 8px; display: flex; align-items: center; justify-content: center;" class="btn btn-warning btn-sm" data-value="' +
          item.idLojista +
          '" onclick="editar(this)"><i class="fa-solid fa-pen fa-lg"></i></span> <input type="checkbox" data-status="' +
          item.ativo +
          '" data-id="' +
          item.idLojista +
          '" onChange="alteraStatus(this)" checked data-toggle="toggle" data-onstyle="success" data-offstyle="danger" data-width="63" class="checkbox-toggle" data-size="sm"></td>' +
          "</tr>"
        );
      }).join("");
  
      $("#colaTabela").html(html);
    }

    $("#inputBusca").on("keyup", function() {
      var valorBusca = $(this).val().toLowerCase();
      
      if (valorBusca === '') {
        busca()
        $("#colaTabela tr").show();
      } else {
        $("#colaTabela tr").hide().filter(function() {
          return $(this).text().toLowerCase().indexOf(valorBusca) > -1;
        }).show();
      }
    });

    function realizarBusca(valorInput) {
      if (valorInput === '') {
        showPage(currentPage); 
      } else {
        $("#colaTabela tr").hide().filter(function() {
          return $(this).text().toLowerCase().indexOf(valorInput) > -1;
        }).show();
      }
    }
    
    $("#inputBusca").on("input", function() {
      var valorBusca = $(this).val().toLowerCase();
      realizarBusca(valorBusca);
    });

  var rows = 8;
	var currentPage = 1;

	showPage(currentPage);
	toggleNavigation();

	function showPage(page) {
		var start = (page - 1) * rows;
		var end = start + rows;

		$('.tabela-funcionarios tbody tr').hide();
		$('.tabela-funcionarios tbody tr').slice(start, end).show();
	}

	function toggleNavigation() {
		var totalRows = $('.tabela-funcionarios tbody tr').length;
		var totalPages = Math.ceil(totalRows / rows);

		if (totalRows > rows) {
			$('#prev, #next').show();
		} else {
			$('#prev, #next').hide();
		}
	}

	$('#prev').click(function() {
		if (currentPage > 1) {
			currentPage--;
			showPage(currentPage);
			toggleNavigation();
		}
	});

	$('#next').click(function() {
		var totalRows = $('.tabela-funcionarios tbody tr').length;
		var totalPages = Math.ceil(totalRows / rows);

		if (currentPage < totalPages) {
			currentPage++;
			showPage(currentPage);
			toggleNavigation();
		}
	});
  
  $('.checkbox-toggle').each(function() {
    var status = $(this).data('status');
    if (status !== 'S') {
      $(this).prop('checked', false);
    }
  });
});

function editar(user) {
  var idLojista = user.getAttribute("data-value");
  window.location.href = "cadastroDeLojista?id=" + idLojista;
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
    url: url_base + `/lojistas/${id}${status === "S" ? '/desativar' : '/ativar'}`,
    type: "put",
    error: function(e) {
			Toastify({
			text: e.responseJSON.error,
			duration: 2000,
			position: "center",
			close: true,
			className: "Toastify__toast--custom"
		}).showToast();
		console.log(e.responseJSON)
		}
  });

}
