ActiveAdmin.register World do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  permit_params do
    permitted = [:the_end]
    permitted
  end

  form do |f|
    f.input :the_end
    f.actions
  end
end
