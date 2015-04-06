class TemplatesController < ApplicationController
  def index
  end

  def dashboard
  end

  def todo_list
  end

  def template
    render template: "templates/#{params[:path]}", layout: nil
  end
end
