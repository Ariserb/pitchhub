class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    # PitchCard auth abilities

    can :see_initiator, PitchCard do |pitch_card|
      pitch_card.initiator_scope.is_in_scope(user)
    end

    can :read_pitch, PitchCard do |pitch_card|
      pitch_card.pitch_card_scope.is_in_scope(user)
    end

    can :manage, PitchCard do |pitch_card|
      pitch_card.initiator.id == user.id
    end

    # PitchPoint comments auth abilities

    can :see_author, Comment do |comment|
      comment.author_scope.is_in_scope(user)
    end

    can :read_content, Comment do |comment|
      comment.content_scope.is_in_scope(user)
    end

    can :manage, Comment do |comment|
      comment.author.id == user.id
    end

    # PitchPoint suggestion auth abilities

    can :accept_suggestion, Suggestion do |suggestion|
      suggestion.pitch_point.pitch_card.initiator.id == user.id
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
