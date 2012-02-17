var jfbc = {
    login: {
        login_button_click: function()
        {
            if (FB.getSession())
            {
                self.location = jfbcOptionsPermsUrl;
            }
        },

        logout_button_click: function()
        {
            if (jfbcLogoutFacebook)
            {
                FB.logout(function(response) {
                    jfbc.login.redirect_to_logout();
                });
            }
            else
                jfbc.login.redirect_to_logout();
        },
        
        redirect_to_logout: function ()
        {
            self.location = jfbcLogoutLink;
        }
    },

    register: {
        checkUsernameAvailable: function()
        {
            var testName = $('username').value;
            if (testName != '')
                var myXHR = new XHR({
                    method:'get',
                    onSuccess:jfbc.register.showUsernameSuccess
                }).send('index.php', 'option=com_jfbconnect&view=loginregister&task=checkUsernameAvailable&username='+testName);
        },

        showUsernameSuccess: function(req)
        {
            var usernameSuccessElement = $('jfbcUsernameSuccess');
            if (req == 1)
            {
                usernameSuccessElement.innerHTML='<img src="' + jfbcRoot + 'images/apply_f2.png" width="20" height="20">' + jfbcUsernameIsAvailable;
            }
            else
            {
                usernameSuccessElement.innerHTML='<img src="' + jfbcRoot + 'images/cancel_f2.png" width="20" height="20">' + jfbcUsernameIsInUse;
            }

        },

        checkEmailAvailable: function()
        {
            var testEmail = $('email').value;
            if (testEmail != '' && jfbc.register.isEmail(testEmail))
                var myXHR = new XHR({
                    method:'get',
                    onSuccess:jfbc.register.showEmailSuccess
                }).send('index.php', 'option=com_jfbconnect&view=loginregister&task=checkEmailAvailable&email='+testEmail);
        },

        showEmailSuccess: function(req)
        {
            emailSuccessElement = document.getElementById('jfbcEmailSuccess');
            if (req == 1)
            {
                emailSuccessElement.innerHTML='<img src="' + jfbcRoot + 'images/apply_f2.png" width="20" height="20">' + jfbcEmailIsAvailable;
            }
            else
            {
                emailSuccessElement.innerHTML='<img src="' + jfbcRoot + 'images/cancel_f2.png" width="20" height="20">' + jfbcEmailIsInUse;
            }
        },

        isEmail: function( text )
        {
            var pattern = "^[\\w-_\.]*[\\w-_\.]\@[\\w]\.+[\\w]+[\\w]$";
            var regex = new RegExp( pattern );
            return regex.test( text );
        }
    },

    checkPermission: function(permission, callback)
    {
        FB.ensureInit(function()
        {
            FB.Connect.requireSession(function()
            {
                FB.Connect.showPermissionDialog(permission,
                    function(result)
                    {
                        callback();
                    }, false, null);
            });
        });

        return false;
    },

    dumpObj: function(obj, name, indent, depth)
    {
        if (depth > 10) {
            return indent + name + ": <Maximum Depth Reached>\n";
        }

        if (typeof obj == "object") {
            var child = null;
            var output = indent + name + "\n";
            indent += "\t";
            for (var item in obj)
            {
                try {
                    child = obj[item];
                } catch (e) {
                    child = "<Unable to Evaluate>";
                }
                if (typeof child == "object") {
                    output += dumpObj(child, item, indent, depth + 1);
                } else {
                    output += indent + item + ": " + child + "\n";
                }
            }
            return output;
        } else {
            return obj;
        }
    }
}
