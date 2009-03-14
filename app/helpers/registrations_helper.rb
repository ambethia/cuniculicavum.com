module RegistrationsHelper

  def available_character_options
    options = current_user.characters.map { |c| [c.name, c.id] }
    if current_user.officer?
      options << ["--", nil]
      options += Character.all.map { |c| [c.name, c.id] }
    end
    options
  end

end
