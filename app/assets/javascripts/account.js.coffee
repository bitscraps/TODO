class Account
  renderCreateAccount: () ->
    accountContainer = $('<div class=create_account>')

    username_label = $('<label>Username</label>')
    accountContainer.append(username_label)

    username = $('<input name=user[username] id="user_username">')
    accountContainer.append(username)

    password_label = $('<label>Password</label>')
    accountContainer.append(password_label)

    password = $('<input type=password name=user[password] id="user_password">')
    accountContainer.append(password)

    password_confirmation_label = $('<label>Password Confirmation</label>')
    accountContainer.append(password_confirmation_label)

    password = $('<input type=password name=user[password_confirmation] id="user_password_confirmation">')
    accountContainer.append(password)

    createButton = $('<button>Create my account</button>')
    createButton.on('click', =>
      this.createAccount()

    )
    accountContainer.append(createButton)

    $('.content').html(accountContainer)

  createAccount: () ->
    $.ajax('/api/users',
      data: { user: { username: $('#user_username').prop('value'), password: $('#user_password').prop('value'), password_confirmation: $('#user_password_confirmation').prop('value') }  }
      type: 'POST'
    ).done( ->
      window.Lists.renderLists()
    ).fail( ->
      $('.content').append($('<div class="error">Unable to create an account</div>'))
    )

$ ->
  window.Account = new Account
