module ApplicationHelper
  def human_boolean(boolean)
    boolean ? 'Si' : 'No'
  end
  def link_to_add_fields(name, f, association)
  	new_object = f.object.send(association).klass.new
  	id = new_object.object_id
  	fields = f.fields_for(association, new_object, child_index: id) do |builder|
  		render(association.to_s.singularize + "_fields", f: builder)
  	end
  	button_to(name, '#', class: "add_fields btn btn-success", data: {id: id, fields: fields.gsub("\n", "")})
  end
  def link_to_add_row_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    button_to(name, '#', class: "add_row_fields btn btn-success", data: {id: id, fields: fields.gsub("\n", "")})
  end
  def is_active_controller(controller_name)
    params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
    params[:action] == action_name ? "active" : nil
  end
  def is_active_mantenimiento()
    controller_name = params[:controller]
    case controller_name
    when 'businesses'
      'active'
    when 'suppliers'
      'active'
    when 'categories'
      'active'
    when 'products'
      'active'
    when 'clients'
      'active'
    when 'vehicles'
      'active'
    when 'drivers'
      'active'
    else
      nil
    end
  end
end
