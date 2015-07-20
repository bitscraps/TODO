class Login
  renderLogin: () ->
    loginContainer = $('<div class=login>')

    username_label = $('<label>Username</label>')
    loginContainer.append(username_label)

    username = $('<input name=username id="username">')
    loginContainer.append(username)

    password_label = $('<label>Password</label>')
    loginContainer.append(password_label)

    password = $('<input name=password id="password">')
    loginContainer.append(password)

    loginButton = $('<button>Log In</button>')
    loginButton.on('click', =>
      this.attemptLogin()

    )
    loginContainer.append(loginButton)

    $('.content').append(loginContainer)

  attemptLogin: () ->
    $.post('/api/session',
      { username: $('#username').prop('value'), password: $('#password').prop('value') }
    ).done( ->
       window.Lists.renderLists()
    ).fail( ->
      $('.content').append($('<div class="error">Unable to login</div>'))
    )

$ ->
  window.Login = new Login()
  window.Login.renderLogin()
