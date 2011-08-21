module ApplicationHelper
  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end
  
  def link_to_add_fields(name, f, association, partial_path)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(partial_path.to_s, :f => builder)
    end
    link_to_function(name, ("add_fields(this, '#{association}', '#{escape_javascript(fields)}')"))
  end
	
  def username_by_id(us)
    u = User.find(us)	  
  	  
    name = ''	  
    if !u.artist_name.nil? && !u.artist_name.blank?
      name = u.artist_name + ' '
    end
    
    if name == '' && !u.name.nil? && !u.name.blank?
      name = u.name	
    end
    
    if name == '' && !u.username.nil? && !u.username.blank?
      name = u.username    
    end
    
    if name.nil? && name.blank?
      name = ''    
    end 
    
    return name
  end
  
  def username(u)
    name = ''	  
    if !u.artist_name.nil? && !u.artist_name.blank?
      name = u.artist_name + ' '
    end
    
    if name == '' && !u.name.nil? && !u.name.blank?
      name = u.name	
    end
    
    if name == '' && !u.username.nil? && !u.username.blank?
      name = u.username    
    end
    
    if name.nil? && name.blank?
      name = ''    
    end 
    
    return name
  end
  
  def user_name_limit_characters(d)
      un = username(d)
      if un.length > 20
        un = un.split(/@/)[0]
        un = un[0..20]
      end
    return un
  end
  
  def twitter_link(u)
    if u.match(/twitter/)
      link_u = u
    else
      link_u = "http://www.twitter.com/" + u
    end	    
    	    
    return link_u	  
  end
  
  def facebook_link(u)
    if u.match(/facebook/)
      link_u = u
    else
      link_u = "http://www.facebook.com/" + u
    end	    
    	    
    return link_u	  
  end  
  
  def youTube_link(u)
    if u.match(/youtube/)
      link_u = u
    else
      link_u = "http://www.youtube.com/user/" + u
    end	    
    	    
    return link_u
  end
  
  def website_Link(u)
    if u.match(/http/)
      link_u = u
    else
      link_u = "http://" + u
    end	    
    	    
    return link_u
  end
  
end
