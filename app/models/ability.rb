class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    if user.has_role? :Administración
      can :manage, :all
    elsif user.has_role? :Logística
      can :manage, RemissionGuide
      can :manage, ControlGuide
      can :manage, ProductLot
      can :manage, Product
      can :manage, Category
      can :manage, PurchaseOrder
      can :manage, SalesOrder
      can :manage, Contract
      can :edit, User
      cannot :read, User  
      can :read, :all
    elsif user.has_role? :Almacén
      can :manage, ProductLot
      can :manage, Product
      can :manage, Category
      can :edit, User
      cannot :read, User  
    elsif user.has_role? :Usuario
      can :edit, User
      cannot :read, User
      can :read, :all
    else
      can :create, User
      can :read, :all
      cannot :read, User  
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
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
