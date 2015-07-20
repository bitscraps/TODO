class Sessions
  renderLogin: () ->
    loginContainer = $('<div class=login>')

    username_label = $('<label>Username</label>')
    loginContainer.append(username_label)

    username = $('<input name=username id="username">')
    loginContainer.append(username)

    password_label = $('<label>Password</label>')
    loginContainer.append(password_label)

    password = $('<input type=password name=password id="password">')
    loginContainer.append(password)

    loginButton = $('<button>Log In</button>')
    loginButton.on('click', =>
      this.attemptLogin()

    )
    loginContainer.append(loginButton)

    createLink = $('<a href=#>Create an account</a>')
    createLink.on('click', =>
      window.Account.renderCreateAccount()

    )
    loginContainer.append(createLink)

    $('.left-action').html('')
    $('.right-action').html('')
    $('.title').html('wrangler')
    $('.content').html(loginContainer)

  attemptLogin: () ->
    $.post('/api/session',
      { username: $('#username').prop('value'), password: $('#password').prop('value') }
    ).done( ->
       window.Lists.renderLists()
    ).fail( ->
      $('.content').append($('<div class="error">Unable to login</div>'))
    )

  logout: () ->
    $.ajax('/api/session',
      type: 'DELETE'
    ).done(=>
      this.renderLogin()
    )

$ ->
  window.Sessions = new Sessions()
