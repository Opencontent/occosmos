{ezscript_require( array( 'ezjsc::jquery' ) )}

<div class="block-type-singolo block-{$block.view}">

	{if $block.name}
		<h2 class="block-title">
			{$block.name} <img src="{'images/logo_COsmOs.png'|ezdesign(no)}" alt="logo-cosmos" width="40px" title="logo-cosmos" />
		</h2>
	{else}
		<h2 class="block-title">
			Chiedi a COsmOs <img src="{'images/logo_COsmOs.png'|ezdesign(no)}" alt="logo-cosmos" width="40px" title="logo-cosmos" />
		</h2>
	{/if}
	

<div class="border-box box-gray box-singolo">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc">
<div class="border-content">
	
	<div class="attribute-content">        
		<div class="cosmos-form">
			<form id="cosmos" name="cosmos" method="post">
				<textarea style="width: 100%;resize: none;" name="question" id="question" cols="25" rows="5" placeholder="{ezini('Settings', 'Intro', 'cosmos.ini')}"></textarea>
				<br/>
				<input class="defaultbutton right" type="button" onclick="ask();" value="Chiedi a COsmOs" />				
			</form>
		</div>
		
    </div>

</div>
</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>

</div>


<script>
	{literal}
	
	function ask()
	{
		
		var xmlhttp;
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}
		else
		{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				var response = xmlhttp.responseText;
				var html = jQuery('<div>').html(response).find('#cosmos-ambiti h3').html();
				//console.log( html );
				$('#question').val(html);
				//document.getElementById("question").innerHTML=html; //xmlhttp.responseText;
				//console.log( xmlhttp.responseText );
			}
		}
		var question = $('#question').val();
		if ( $.trim( question ) == "" ) {
			alert("Inserisci il testo nella casella e clicca su \"chiedi a Cosmos\"");
		}
		else
		{
			$('#question').val("Richiesta in corso. Attendere...");
			xmlhttp.open("GET","/cosmos/ask?question=" + question, true);
			xmlhttp.send();
		}
	}

	{/literal}
</script>