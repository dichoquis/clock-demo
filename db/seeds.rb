User.delete_all
User.create!(
        username: 'dchoque',
        email: 'dchoque@gmail.com',
        first_name: 'David',
        last_name: 'Choque',
        password: 'dchoque',
        password_confirmation: 'dchoque',
        role: 1
)
