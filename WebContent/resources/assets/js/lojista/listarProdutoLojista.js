const botaoDesativa = document.querySelector('#teste');
const botaoAtiva = document.querySelector('.botaoAtivaMenu');
const elemento = document.querySelector('#modalMenu');

/*botaoDesativa.addEventListener('click', () => {
  elemento.classList.add('animar-sair');
 elemento.classList.remove('animar-entrar');

});

botaoAtiva.addEventListener('click', () => {
  elemento.classList.add('animar-entrar');
  elemento.classList.remove('animar-sair');
  });*/

var user = localStorage.getItem("usuario")
var usuario = JSON.parse(user);

$("#usuarioNome").text(usuario.nome)

var produto = []
var imge = []

$(document).ready(function () {
	

  $.ajax({
    url: url_base + "/produtos/lojista/" + usuario.lojistaId,
    type: "GET",
    async: false,
  })
    .done(function (data) {
		
	$('#exportar-excel').click(function() {	
	var planilha = XLSX.utils.json_to_sheet(data);
	var livro = XLSX.utils.book_new();
	XLSX.utils.book_append_sheet(livro, planilha, "Planilha1");
	XLSX.writeFile(livro, "produtosLojista.xlsx");
	});
      produto = data;
      renderizarProduto(data);
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
      console.error("Erro na solicitação AJAX:", textStatus, errorThrown);
    });

    function renderizarProduto(produto) {
	
      var html = produto.map(function (item) {
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
          item.nomeProduto +
          "</td>" +
          "<td>" +
          item.descrProduto +
          "</td>" +
           "<td>" +
          item.categorias.categoria +
          "</td>" +
           "<td>" +
          item.subcategorias.nome +
          "</td>" +
           "<td>" +
           "R$ "+
          item.preco.toLocaleString('pt-br', {minimumFractionDigits: 2}) +
          "</td>" +
           "<td>" +
           "R$ "+
          item.comissao.toLocaleString('pt-br', {minimumFractionDigits: 2})+
          "</td>" +
           "<td>" +
          item.lojista.nomeFantasia +
          "</td>" +
          '<td class="d-flex"><span style="width: 63px; margin-right: 5px; height: 31px; padding: 8px; display: flex; align-items: center; justify-content: center;" class="btn btn-warning btn-sm" data-value="' +
          item.idProduto +
          '" onclick="editar(this)"><i class="fa-solid fa-pen fa-lg"></i></span> <input type="checkbox" data-status="' +
          item.ativo +
          '" data-id="' +
          item.idProduto +
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
		
	    generatePaginationList(totalPages); // Chama a função para gerar a lista de paginação


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
	
	function generatePaginationList(totalPages) {
    var paginationList = $('#pagination-list');
    paginationList.empty(); // Limpa a lista antes de adicionar novos itens

    // Adiciona item "Prev"
    var prevListItem = $('<li class="page-item">');
    var prevLink = $('<a class="page-link" href="#" aria-label="Previous">&laquo;</a>').attr('data-page', 'prev');
    prevListItem.append(prevLink);
    paginationList.append(prevListItem);

    for (let i = 1; i <= totalPages; i++) {
        var listItem = $('<li class="page-item">');
        var link = $('<a class="page-link" href="#"></a>').text(i).attr('data-page', i);

        link.on('click', function(e) {
            e.preventDefault(); // Previne o comportamento padrão do link
            var page = $(this).data('page');

            // Atualiza currentPage baseado no item clicado
            if (page === 'prev') {
                currentPage = Math.max(1, currentPage - 1);
            } else if (page === 'next') {
                currentPage = Math.min(totalPages, currentPage + 1);
            } else {
                currentPage = page;
            }

            showPage(currentPage);
            toggleNavigation();
        });

        listItem.append(link);
        paginationList.append(listItem);
    }

    // Adiciona item "Next"
    var nextListItem = $('<li class="page-item">');
    var nextLink = $('<a class="page-link" href="#" aria-label="Next">&raquo;</a>').attr('data-page', 'next');
    nextListItem.append(nextLink);
    paginationList.append(nextListItem);

    // Atualiza o manipulador de clique para 'prev' e 'next' separadamente para evitar conflitos
    prevLink.add(nextLink).on('click', function(e) {
        e.preventDefault();
        var page = $(this).data('page');

        if (page === 'prev' && currentPage > 1) {
            currentPage--;
        } else if (page === 'next' && currentPage < totalPages) {
            currentPage++;
        }

        showPage(currentPage);
        toggleNavigation();
    });
}
  
  $('.checkbox-toggle').each(function() {
    var status = $(this).data('status');
    if (status !== 'S') {
      $(this).prop('checked', false);
    }
  });
});



function editar(user) {
  var idProduto = user.getAttribute("data-value");
  window.location.href = "cadastroProdutoLojista?id=" + idProduto;
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
    url: url_base + `/produtos/${id}${status === "S" ? '/desativar' : '/ativar'}`,
    type: "put",
    success: function() {
    			  Toastify({
					text: `${status === "S" ? 'desativado' : 'ativado'} Com Sucesso!`,
					duration: 2000,
					position: "center",
					close: true,
					className: "Toastify__toast--custom"
				}).showToast();
				
    },
    error: function(error) {
      console.error("Erro ao alterar status do funcionario:", error);
    }
  }).done(function(){
	   
  });

}
