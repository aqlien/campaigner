class UserPresenter < BasePresenter
  delegate :fa_icon, :link_to, :policy, to: :@template, allow_nil: true
  presents :user

  def show_link
    if policy(:user).show?
      link_to(user, {title: 'Show', class: 'icon'}){fa_icon('eye')}
    end
  end

  def edit_link
    if policy(:user).edit?
      link_to(edit_user_path(user), {title: 'Edit', class: 'icon'}){fa_icon('wrench')}
    end
  end

  def destroy_link
    if policy(:user).destroy?
      link_to(user, {method: :delete, data: { confirm: 'Are you sure?' }, title: 'Destroy', class: 'icon'}){fa_icon('times')}
    end
  end

end
