
function formatarDataParaBR(data) {
	var dataObj = new Date(data);
	var dia = String(dataObj.getDate()).padStart(2, '0');
	var mes = String(dataObj.getMonth() + 1).padStart(2, '0');
	var ano = dataObj.getFullYear();
	return dia + '/' + mes + '/' + ano;
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
		url: url_base + `/vendedor/${id}${status === "S" ? '/desativar' : '/ativar'}`,
		type: "put",
		beforeSend: function() {
			Swal.showLoading()
		},
		error: function(e) {
			Swal.close();
			console.log(e.responseJSON.message);
			Swal.fire({
				icon: "error",
				title: "Oops...",
				text: "Não foi possível realizar esse comando!",
			});
		}
	}).done(function(data) {
		Swal.close();
	})
}

$(document).ready(function() {
	$.ajax({
		url: url_base + "/vendedor",
		type: "GET",
		async: false,
		beforeSend: function() {
			Swal.showLoading()
		},
		error: function(e) {
			Swal.close();
			console.log(e.responseJSON.message);
			Swal.fire({
				icon: "error",
				title: "Oops...",
				text: "Não foi possível realizar esse comando!",
			});
		}
	}).done(function(data) {
		Swal.close();

		$('#exportar-excel').click(function() {
			var planilha = XLSX.utils.json_to_sheet(data);
			var livro = XLSX.utils.book_new();
			XLSX.utils.book_append_sheet(livro, planilha, "Planilha1");
			XLSX.writeFile(livro, "cargos.xlsx");
		});

		cargos = data;
		renderizarInfluencer(data);
	})

	function renderizarInfluencer(influencers) {
		var html = influencers.map(function(item) {
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
				formatarDataParaBR(item.dtNasc) +
				"</td>" +
				"<td>" +
				item.celular.replace(/^(\d{2})(\d{5})(\d{4})$/, "($1)$2-$3") +
				"</td>" +
				'<td class="d-flex"><input type="checkbox" data-status="' +
				item.ativo +
				'" data-id="' +
				item.idVendedor +
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