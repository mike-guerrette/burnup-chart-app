class ScopeChangeController < ApplicationController

  def new
    @scope_change = Scope_Change.new
  end

  def create
    @project = Project.find(params[:project_id])
    @scope_change = @project.scope_changes.create(params[:scope_change].permit(:scope))

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def scope_params
      params.require(:scope_change).permit(:scope)
    end

end
