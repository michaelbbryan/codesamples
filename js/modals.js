// This code processes objects and events on the web page, so it must
// be placed at the bottom, at the very end of the footer.

var OEregisterbutton  = document.getElementById("OEregister-button");
var OEregistermodal   = document.getElementById("OEregister-modal");
var OEregisterclose   = document.getElementById("OEregister-close");

var OEprofile        = document.getElementById("OEprofile");
var OEprofilemodal   = document.getElementById("OEprofile-modal");
var OEprofileclose   = document.getElementById("OEprofile-close");

var OElogin          = document.getElementById("OElogin");
var OEloginmodal     = document.getElementById("OElogin-modal");
var OEloginclose     = document.getElementById("OElogin-close");

// Registration processing

OEregisterbutton.onclick = function() {
  OEregistermodal.style.display = "block";
}

OEregisterclose.onclick = function() {
  OEregistermodal.style.display = "none";
}

function validateRegistrationForm() {

  var successflag = true;

  var name = document.OEregister.OEregister_form_name.value;
    document.getElementById("OEregister_form_name_err").innerHTML = "";
    if (name == "") {
      document.getElementById("OEregister_form_name_err").innerHTML = "Name is required.";
      successflag = false;
    }

  var email = document.OEregister.OEregister_form_email.value;
    document.getElementById("OEregister_form_email_err").innerHTML = "";
    var filter = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;
    if (email == "") {
      document.getElementById("OEregister_form_email_err").innerHTML = "Email is required.";
      successflag = false;
    } else if(filter.test(email) === false){
      document.getElementById("OEregister_form_email_err").innerHTML = "Email format is invalid.";
      successflag = false;
    }

  var pwdnew = document.OEregister.OEregister_form_pwdnew.value;
    document.getElementById("OEregister_form_pwdnew_err").innerHTML = "";
    if (pwdnew == "") {
      document.getElementById("OEregister_form_pwdnew_err").innerHTML = "Password is required.";
      successflag = false;
    }

  var pwdcon = document.OEregister.OEregister_form_pwdcon.value;
    document.getElementById("OEregister_form_pwdcon_err").innerHTML = "";
    if (pwdcon == "") {
      document.getElementById("OEregister_form_pwdcon_err").innerHTML = "Confirmation is required.";
      successflag = false;
    } else if (pwdcon != pwdnew) {
      document.getElementById("OEregister_form_pwdcon_err").innerHTML = "Confirmation doesnt match.";
      successflag = false;
    }

  return successflag;

}
//  profile Processing

OEprofile.onclick = function() {
  OEprofilemodal.style.display = "block";
}
OEprofileclose.onclick = function() {
  OEprofilemodal.style.display = "none";
}

function validateProfileForm() {
  var successflag = true;

  var name = document.OEprofile.OEprofile_form_name.value;
    document.getElementById("OEprofile_form_name_err").innerHTML = "";
    if (name == "") {
      document.getElementById("OEprofile_form_name_err").innerHTML = "Name is required.";
      successflag = false;
    }

  var email = document.OEprofile.OEprofile_form_email.value;
    document.getElementById("OEprofile_form_email_err").innerHTML = "";
    var filter = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;
    if (email == "") {
      document.getElementById("OEprofile_form_email_err").innerHTML = "Email is required.";
      successflag = false;
    } else if(filter.test(email) === false){
      document.getElementById("OEprofile_form_email_err").innerHTML = "Email format is invalid.";
      successflag = false;
    }

  var pwdnew = document.OEprofile.OEprofile_form_pwdnew.value;
    document.getElementById("OEprofile_form_pwdnew_err").innerHTML = "";
    if (pwdnew == "") {
      document.getElementById("OEprofile_form_pwdnew_err").innerHTML = "Password is required.";
      successflag = false;
    }

  var pwdcon = document.OEprofile.OEprofile_form_pwdcon.value;
    document.getElementById("OEprofile_form_pwdcon_err").innerHTML = "";
    if (pwdcon == "") {
      document.getElementById("OEprofile_form_pwdcon_err").innerHTML = "Confirmation is required.";
      successflag = false;
    } else if (pwdcon != pwdnew) {
      document.getElementById("OEprofile_form_pwdcon_err").innerHTML = "Confirmation does not match.";
      successflag = false;
    }

  return successflag;

}

// Login processing button

OElogin.onclick = function() {
  OEloginmodal.style.display = "block";
}
OEloginclose.onclick = function() {
  OEloginmodal.style.display = "none";
}

function validateLoginForm() {
  
  var successflag = true;

  var email = document.OElogin.OElogin_form_email.value;
    document.getElementById("OElogin_form_email_err").innerHTML = "";
    var filter = /^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;
    if (email == "") {
      document.getElementById("OElogin_form_email_err").innerHTML = "Email is required.";
      successflag = false;
    } else if(filter.test(email) === false){
      document.getElementById("OElogin_form_email_err").innerHTML = "Email format is invalid.";
      successflag = false;
    }

  var pwd = document.OElogin.OElogin_form_pass.value;
    document.getElementById("OElogin_form_pass_err").innerHTML = "";
    if (pwd == "") {
      document.getElementById("OElogin_form_pass_err").innerHTML = "Password is required.";
      successflag = false;
    }

  return successflag;

}


