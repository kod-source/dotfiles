define :tap do
    name = params[:name]

    execute "brew tap #{name}" do
        command "brew tap #{name}"
    end
end
