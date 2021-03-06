<?php

if(!empty($_POST)) {
	var_dump(mail($_POST['to'], $_POST['subject'], $_POST['message'], "From: teste@translate.com.br", "-f teste@translate.com.br"));
}


?>

<form action="" method="post">
<p>To <input type="text" name="to"/></p>
<p>Subject <input type="text" name="subject"/></p>
<textarea name="message" rows="5"></textarea>
<p>
<input type="submit"/></p>
</form>
