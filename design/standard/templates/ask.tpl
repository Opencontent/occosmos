<div class="border-box">
<div class="border-tl"><div class="border-tr"><div class="border-tc"></div></div></div>
<div class="border-ml"><div class="border-mr"><div class="border-mc float-break">


<div class="content-view-full">
    <div class="class-folder">		
		
		<div class="attribute-header">
			<h1>Chiedi a Cosmos!</h1>
		</div>
		
		<div class="logo">
			<img src="{'images/logo_COsmOs.png'|ezdesign(no)}" alt="logo-cosmos" title="logo-cosmos" />
		</div>
		
		<div id="cosmos-ambiti" class="cosmos-ambiti">
			{if and(is_set( $answer ), $answer|eq("")|not())}
				<h3>{$answer}</h3>
			{else}
				<h2>{ezini( 'Settings', 'Ambiti', 'cosmos.ini')}</h2>
			{/if}
		</div>


<div class="cosmos-form" style="float:left;">
		<form id="cosmos" name="cosmos" method="post" action="ask">
	{*<input type="hidden" name="__VIEWSTATE" id="__VIEWSTATE" value="/wEPDwULLTEzOTU3MzI0ODNkZEDIf8pUTcGbf1Ydvk2SNZ+/ZKvl" />
	<input type="hidden" name="__EVENTVALIDATION" id="__EVENTVALIDATION" value="/wEWAwL4jrm6AwKM54rGBgKD5e2sBazwexDY10hgGyQ1GffS0rQOEx0x" />*}
	<textarea name="question" id="question" cols="35" rows="13"></textarea>
	<br/>
	<input type="submit" name="Ask" value=" Chiedi a Cosmos " id="ask" title="scrivi domanda e clicca qui." />	
</form>	
</div>

<div class="attribute-description" style="float: left; padding: 30px;">
	Gli ambiti gestiti dal sistema sono: Comuni, Meteo, Trasporto extraurbano e Farmacie.
	Esempio di domande:
	<ul>
	<li>Farmacie di turno?"</li>
	<li>Quanto costa parcheggiare in via Grazioli?</li>
	<li>Quali sono gli orari della biblioteca principale?</li>
	<li>Orario treni per <em>destinazione</em> dopo le 16.00?</li>
	<li>Dove si trova l'URP?</li>
	</ul>
</div>

</div></div></div>
<div class="border-bl"><div class="border-br"><div class="border-bc"></div></div></div>
</div>