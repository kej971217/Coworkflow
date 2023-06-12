/**
 * 
 */
$("#delBtn").on("click", function(event){
	event.preventDefault();
	
	let delForm = $("form#freeboard");
	
	Swal.fire({
	  title: '삭제할 글의 비밀번호 입력하랏!',
	  input: 'password',
	  inputAttributes: {
	    autocapitalize: 'off'
	  },
	  showCancelButton: true,
	  confirmButtonText: 'Delete',
	  showLoaderOnConfirm: true,
	  preConfirm: (password) => {
		let fd = new FormData(delForm.get(0));
		fd.append("boPass", password);
		 
	    return fetch(delForm.attr("action"), {
			method:delForm.attr("method")
			, headers : {
				"Accept":"application/json"
			}
			, body : fd
		}).then(response => {
	        if (!response.ok) {
	          throw new Error(response.statusText)
	        }
	        return response.json()
	      })
	      .catch(error => {
	        Swal.showValidationMessage(
	          `Request failed: ${error}`
	        )
	      })
	  },
	  allowOutsideClick: () => !Swal.isLoading()
	}).then((result) => {
	  let json = result.value;
	  if (result.isConfirmed && json.success) {
	      location.href=`${$.CPATH+json.location}`;
	  }else{
		Swal.fire({
		  icon : 'error'
	      , title: `${json.message}'`,	      
	    })
	  }
	})
	return false;
});

