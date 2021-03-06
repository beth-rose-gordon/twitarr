Twitarr::Application.routes.draw do
  root 'home#index'

  post 'announcements/submit'
  post 'announcements/delete'

  post 'posts/submit'
  post 'posts/delete'
  get 'posts/popular'
  put 'posts/favorite'
  get 'posts/list'
  get 'posts/search'
  get 'posts/all'
  post 'posts/reply'
  post 'posts/upload'
  get 'posts/tag_autocomplete'

  get 'seamail/inbox'
  get 'seamail/outbox'
  post 'seamail/new'
  get 'seamail/archive'
  post 'seamail/do_archive'

  post 'user/login'
  get 'user/logout'
  get 'user/username'
  post 'user/change_password'
  post 'user/new'
  get 'user/autocomplete'
  get 'user/profile'
  get 'user/update_status'

  get 'admin/users'
  get 'admin/find_user'
  post 'admin/update_user'
  post 'admin/activate'
  put 'admin/add_user'
  post 'admin/reset_password'

  get 'photo/preview/*photo', { to: 'photo#preview', :format => false }

  get 'api/v1/user/auth'
  get 'api/v1/user/test'

end
