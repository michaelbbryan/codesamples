<!------- Footer Area ------------->
<table width="100%" class="OEfooter"> 
	<tr>
		<td width="100%" colspan="6">
			<br>
		</td>
	</tr>
	<tr style="font-size: large; vertical-align: middle;">
		<td width="44%" style="text-align: right;">

		</td>
		<td width="3%">
			<a href="https://www.linkedin.com/company/open-environments-llc">
				<img src="images/linkedin.png" class="OEsocial"></a>
		</td>
		<td width="3%">
			<a href="https://twitter.com/datamastery">
				<img src="images/twitter.png" class="OEsocial"></a>
		</td>
		<td width="3%">
			<a href="https://www.facebook.com/openenvironments">
				<img src="images/facebook.png" class="OEsocial"></a>
		</td>
		<td width="3%">
			<a href="https://www.instagram.com/openenvironments/">
				<img src="images/instagram.png" class="OEsocial"></a>
		</td>
		<td width="44%"></td>
	</tr>	
	<tr>
		<td width="100%" colspan="6" style="font-size: x-small; text-align: center;">
			<strong>&#169;2004-2021 Open Environments - All Rights Reserved<br><br>
		</td>
	</tr>
</table>
<!------  FUNCTIONALLY THE END OF HTML CONTENT DEFINITION ------------------>
<!------  FOLLOWED BY PROCESSING THAT CHANGES THAT CONTENT ----------------->
<script type="text/javascript" src="js/modals.js"></script>

<?php


// Set security condition, logged in or not, confirming cookies
if (isset($_SESSION['OEmember_id'])) {
    echo "<script>
        document.getElementById('OElogin').style.display = 'none';
        document.getElementById('OElogout').style.display = 'block';
        document.getElementById('OEsettings').style.display = 'block';
        document.getElementById('OEsettingsgrayed').style.display = 'none';
        document.getElementById('OEprofile').style.display = 'block';
        document.getElementById('OEprofilegrayed').style.display = 'none';
        document.getElementById('OEnotifications').style.display = 'block';
        document.getElementById('OEnotificationsgrayed').style.display = 'none';
    </script>";
} else {
    echo "<script>
        document.getElementById('OElogin').style.display = 'block';
        document.getElementById('OElogout').style.display = 'none';
        document.getElementById('OEsettings').style.display = 'none';
        document.getElementById('OEsettingsgrayed').style.display = 'block';
        document.getElementById('OEprofile').style.display = 'none';
        document.getElementById('OEprofilegrayed').style.display = 'block';
        document.getElementById('OEnotifications').style.display = 'none';
        document.getElementById('OEnotificationsgrayed').style.display = 'block';
    </script>";
}
?>
<!------  PHP processing to field submit events that preceded this page  ------------------>

</body>
</html>