class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # a signed-in user can do everything
    if user.has_role? :admin
      # an admin can do everything
      can :manage, :all
    else
      can :vote_article, Article
      can :read, [Article,Comment]
      can :create, Comment
      can :manage, Comment do |comment|
        comment.try(:user).eql?(user)
      end

      if user.has_role? :blogger
        can :create, Article
        can :update, Article do |article|
          article.try(:user) == user
        end
        can :destroy, Article do |article|
          article.try(:user) == user
        end
        can :manage, Comment do |comment|
          comment.try(:article).try(:user).eql?(user)
        end
      end
    end
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end