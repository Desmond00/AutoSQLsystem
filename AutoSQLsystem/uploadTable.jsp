<%@include file="menu.jsp"%>
<%@include file="userCheck.jsp"%>
<html>
   <head>
      <title>Upload table</title>
      <link rel="stylesheet" href="assets/css/background.css">
      <link rel="stylesheet" href="assets/css/form1.css">
      <link rel="stylesheet" href="assets/css/file.css">
      <script src="assets/js/jquery.js"></script>
   </head>
   
   <body>
   		<div class=formCont align=center style="position:relative!important; margin: 0px auto!important;">
		      <h3>Upload Table:</h3>
		      <p>Select a CSV/XLS/XLSX file to upload: </p><br />
		      <font class=reply>@@@THE DOCUMENT NAME MUST CONTAIN LESS THAN 10 LETTERS  AND DOCUMENT SIZE MUST BE LESS THAN 10MB</font><br><br>
		      <form id="fileUpload" method = "post" enctype = "multipart/form-data" >
		         <input  type="file" id="file" name = "file" size = "50" accept=".xls,.csv,.xlsx" />
		         <br />
		         <input type="button" value = "Upload"/>
		      </form>
		      <font class=reply>
			  <div id="progressBar" ></div>
		      <div id="show"></div>
		      <div id="message"></div>
		      </font>
   		</div>
   </body>
   
   <script>
   		var file;
   		var fileName;
		$(':file').on('change', function() {
			file = this.files[0];
			fileName = this.files[0].name;
			var fileSize = this.files[0].size;
			var fileExtension = fileName.substring(fileName.lastIndexOf('.'), fileName.length);	
			if(fileExtension == ".csv" || fileExtension == ".xls" || fileExtension == ".xlsx")
			{
				document.getElementById("progressBar").innerHTML = "<progress id=progressUp class=up></progress>";
				if (fileSize > 10485760) {
					alert('max upload size is 10MB');
					$(':file').val('');
					document.getElementById("progressBar").innerHTML = "";
				}
			}
			else {
				document.getElementById("show").innerHTML = "document type not supported";
				document.getElementById("progressBar").style.display = "none";
			}
		});

		$(':button').on('click', function() {
		    $.ajax({
		        // Your server script to process the upload
		        url: 'Upload',
		        type: 'POST',
		        // Form data
		        data: new FormData($('form')[0]),

		        // Tell jQuery not to process data or worry about content-type
		        // You *must* include these options!
		        cache: false,
		        contentType: false,
		        processData: false,

		        // Custom XMLHttpRequest
		        xhr: function() {
		            var myXhr = $.ajaxSettings.xhr();
		            if (myXhr.upload) {
		                // For handling the progress of the upload
		                myXhr.upload.addEventListener('progress', function(e) {
		                    if (e.lengthComputable) {
		                        $('#progressUp').attr({
		                            value: e.loaded,
		                            max: e.total,
		                        });
		                    }
		                } , false);
		            }
		            $('#show').html("<progress ></progress>");
					document.getElementById("show").style.display = "block";
		            $('#message').html("document: "+fileName+" has been uploaded. Now, It is being stored in database");
		            return myXhr;
		        }
		    })
		    .done(function(data) {
                console.log(data);
                document.getElementById("show").style.display = "none";
                if (data.success) {
                	$('#message').html("document: " + fileName + " has been uploaded and saved<br>");
                }
                else if(data.error) {
                	$('#message').html(data.error);
                }
                else {
                	$('#message').html("Error in document upload");
                }

            });
		    
		    
		});

   </script>
</html>