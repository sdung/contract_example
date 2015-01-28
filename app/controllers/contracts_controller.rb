require 'repository'

class ContractsController < ApplicationController
  def initialize
    super
    @@service = ContractServices.new()
  end

  # GET /contracts
  # GET /contracts.json
  def index
    contracts = @@service.all

    respond_to do |format|
      format.html { render "contracts/index", :locals => {:contracts => contracts} }
      format.json { render json: contracts }
    end
  end

  # GET /contracts/1
  # GET /contracts/1.json
  def show
    begin
      contract = @@service.find(params[:id])

      respond_to do |format|
        format.html { render "contracts/show", :locals => {:contract => contract} }
        format.json { render json: contract }
      end

    rescue => error
      respond_to do |format|
        format.html { redirect_to contracts_path, alert: error.message }
      end
    end

  end

  # GET /contracts/new
  def new
    contract = @@service.dummy()

    respond_to do |format|
      format.html { render "contracts/new", :locals => {:contract => contract} }
      format.json { render json: contract, status: :created, location: contract }
    end

  end

  # GET /contracts/1/edit
  def edit
    begin
      contract = @@service.find(params[:id])
      respond_to do |format|
        format.html { render "contracts/edit", :locals => {:contract => contract} }
      end

    rescue => error
      respond_to do |format|
        format.html { redirect_to contracts_path, alert: error.message }
      end
    end

  end

  # POST /contracts
  # POST /contracts.json
  def create
    begin
      contract = @@service.create(contract_params)
      respond_to do |format|
        format.html { redirect_to contract_path(contract.id), notice: 'Contract was successfully created.' }
        format.json { render json: contract, status: :created, location: contract }
      end
    rescue ContractServices::ValidationError => error
      respond_to do |format|
        format.html { render "contracts/new", :locals => {:contract => error.model} }
        format.json { render json: contract.errors, status: :unprocessable_entity }
      end
    rescue => error
      respond_to do |format|
        format.html { redirect_to contracts_path, alert: error.message }
      end
    end

  end

  # PATCH/PUT /contracts/1
  # PATCH/PUT /contracts/1.json
  def update
    begin
      contract = @@service.update(params[:id], contract_params)
      respond_to do |format|
        format.html { redirect_to contract_path(contract.id), notice: 'Contract was successfully updated.' }
        format.json { head :no_content }
      end
    rescue ContractServices::ValidationError => error
      respond_to do |format|
        format.html { render "contracts/new", :locals => {:contract => error.model} }
        format.json { render json: contract.errors, status: :unprocessable_entity }
      end
    rescue => error
      respond_to do |format|
        format.html { redirect_to contracts_path, alert: error.message }
      end
    end
  end

  # DELETE /contracts/1
  # DELETE /contracts/1.json
  def destroy
    begin
      @@service.delete(params[:id])
      respond_to do |format|
        format.html { redirect_to contracts_url, notice: 'Contract was successfully destroyed.' }
        format.json { head :no_content }
      end

    rescue => error
      respond_to do |format|
        format.html { redirect_to contracts_path, alert: error.message }
      end
    end

  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def contract_params
    params.require(:contract).permit(:name)
  end
end
