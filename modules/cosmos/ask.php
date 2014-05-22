<?php


$Module = $Params['Module'];
$http = eZHTTPTool::instance();
$tpl = eZTemplate::factory();

$postVariables = $http->attribute( 'post' );
$getVariables = $http->attribute( 'get' );

eZDebug::writeDebug( var_export( $postVariables, 1 ), "POST VARIABLES" );
eZDebug::writeDebug( var_export( $postVariables, 1 ), "GET VARIABLES" );

if( isset( $postVariables['question'] ) || isset( $getVariables['question'] ) ) // answer
{

	$question = ( isset( $postVariables['question'] ) ) ? $postVariables['question'] : $getVariables['question'];
	//eZDebug::writeNotice( var_export( eZINI::instance('cosmos.ini'), 1 ), "EZINI" );

	if ( eZINI::instance( 'cosmos.ini' )->hasVariable( 'Settings', 'GeonameId' ) )
    {
        $geonameId = (int) eZINI::instance( 'cosmos.ini' )->variable( 'Settings', 'GeonameId' );
    }
    else
    {
        $siteName = eZINI::instance()->variable( 'SiteSettings', 'SiteName' );
        $name = trim( str_replace( 'Comune di', '', $siteName ) );
        $geonameId = (int)  eZINI::instance( 'cosmos.ini' )->variable( 'GeoNames', $name );
    }
	$url = eZINI::instance( 'cosmos.ini' )->variable( 'Settings', 'Url' );
	
	//eZDebug::writeDebug( var_export( $geonameId, 1 ), "GEONAMEID" );
	//eZDebug::writeDebug( var_export( $url, 1 ), "URL" );
	
	//$geonameId = 6541469;
	//$url = "http://www.cosmosinrete.it/cosmos_ws/COSMOS_WS.asmx/Cosmos_SMS_in_Geo_Place";
	
	$postData = 'sIn=' . $question; //$postVariables['question'];
	$postData .= '&' . 'mGeoData=' . $geonameId;

	eZDebug::writeDebug( var_export( $postData, 1 ), "POST DATA" );
	
	$connectionTimeout = 60;
	$processTimeout = 60;
	
	$ch = curl_init();
	
	curl_setopt( $ch, CURLOPT_URL, $url );
	curl_setopt( $ch, CURLOPT_RETURNTRANSFER, 1 );
	curl_setopt( $ch, CURLOPT_CONNECTTIMEOUT, $connectionTimeout );
	curl_setopt( $ch, CURLOPT_TIMEOUT, $processTimeout );
	curl_setopt( $ch, CURLOPT_HEADER, 0);
	curl_setopt( $ch, CURLOPT_POST, strlen( $postData ) );
	curl_setopt( $ch, CURLOPT_POSTFIELDS, $postData );
	
	//eZDebug::writeDebug( var_export( $ch, 1 ), "CURL HANDLER" );

	$returnData = curl_exec( $ch );
	$errNo = curl_errno( $ch );
	$err = curl_error( $ch );
	curl_close( $ch );

	if ( $errNo )
	{
		//throw new Exception( 'Curl error: ' . $err, $errNo );
		$answer = "Errore in fase di richiesta a Cosmos, per favore riprova più tardi!";
		$tpl->setVariable( 'answer', $answer );
		$user = eZUser::currentUser();
		$Result['content'] = $tpl->fetch( 'design:ask.tpl' );
		return;
	}
	
    $substr = substr( $returnData, 0, 16);
    if( $substr == "System.Exception" )
    {
        $answer = "Questo comune non &egrave; abilitato a Cosmos Geografico.";
    }
    else
    {
        //eZDebug::writeNotice( var_export( $returnData, 1 ), "CURL RESPONSE" );
        $parser = simplexml_load_string( $returnData );
        //eZDebug::writeNotice( var_export( $parser, 1 ), "PARSER" );
        $answer = $parser->Answer;
    }
	
	//eZDebug::writeNotice( var_export( $answer, 1 ), "ANSWER" );

	$tpl->setVariable( 'answer', $answer );
			
	$user = eZUser::currentUser();
	
	$Result['content'] = $tpl->fetch( 'design:ask.tpl' );
	return;
	
}



$user = eZUser::currentUser();

$Result['content'] = $tpl->fetch( 'design:ask.tpl' );

?>
