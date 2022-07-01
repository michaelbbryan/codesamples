// These are utilities reused across the website,
//     rather than being dedicated to a single feature.

// Message popups
function OEmessage_close() {
	document.getElementById('OEmessage').style.display = "none";
   window.location.replace("index.php");
	}
function OEmessage_open(msg) {
	document.getElementById('OEmessage').style.display = "block";
	document.getElementById("OEmessage-content").innerHTML = msg;
	}
window.onclick = function(event) {
   if (event.target == OEmessage) {
      OEmessagemodal.style.display = "none";
      }
    }

// handle input data characters
function clean_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

// make a form submit when a return key is pressed
// <div onKeyPress="return checkSubmit(event)"/>
function checkSubmit(e) {
   if(e && e.keyCode == 13) {
      document.forms[0].submit();
   }
}
