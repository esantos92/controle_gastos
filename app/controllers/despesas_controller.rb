require "csv"

class DespesasController < ApplicationController
  before_action :set_despesa, only: %i[edit update destroy]

  def index
    @mes = mes_param(params[:mes])
    @despesas = Despesa.no_mes(@mes).ordenadas
    @total_mensal = Despesa.total_mensal(@mes)
    @despesa = Despesa.new(data: Date.current)
  end

  def new
    @despesa = Despesa.new(data: Date.current)
    @mes = mes_param(params[:mes])
  end

  def create
    @despesa = Despesa.new(despesa_params)

    if @despesa.save
      carregar_lista
      respond_to do |format|
        format.html { redirect_to despesas_path, notice: "Despesa cadastrada com sucesso." }
        format.turbo_stream do
          flash.now[:notice] = "Despesa cadastrada com sucesso."
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @mes = mes_param(params[:mes])
  end

  def update
    if @despesa.update(despesa_params)
      carregar_lista
      respond_to do |format|
        format.html { redirect_to despesas_path, notice: "Despesa atualizada com sucesso." }
        format.turbo_stream do
          flash.now[:notice] = "Despesa atualizada com sucesso."
          render :create
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @despesa.destroy
    carregar_lista
    respond_to do |format|
      format.html { redirect_to despesas_path, notice: "Despesa removida." }
      format.turbo_stream do
        flash.now[:notice] = "Despesa removida."
        render :create
      end
    end
  end

  def exportar
    despesas = Despesa.ordenadas
    csv_data = CSV.generate(headers: true) do |csv|
      csv << %w[data valor categoria descricao]
      despesas.each do |despesa|
        csv << [despesa.data, despesa.valor, despesa.categoria, despesa.descricao]
      end
    end

    send_data csv_data,
              filename: "despesas-#{Date.current}.csv",
              type: "text/csv"
  end

  def importar
    arquivo = params[:arquivo]
    if arquivo.blank?
      redirect_to despesas_path, alert: "Selecione um arquivo CSV para importar."
      return
    end

    linhas_importadas = 0
    CSV.foreach(arquivo.path, headers: true) do |row|
      despesa = Despesa.new(
        data: row["data"],
        valor: row["valor"],
        categoria: row["categoria"],
        descricao: row["descricao"]
      )
      linhas_importadas += 1 if despesa.save
    end

    redirect_to despesas_path, notice: "Importacao concluida: #{linhas_importadas} despesas."
  end

  private

  def set_despesa
    @despesa = Despesa.find(params[:id])
  end

  def despesa_params
    params.require(:despesa).permit(:valor, :data, :categoria, :descricao)
  end

  def mes_param(raw)
    return Date.current if raw.blank?

    Date.strptime(raw, "%Y-%m")
  rescue ArgumentError
    Date.current
  end

  def carregar_lista
    @mes = mes_param(params[:mes])
    @despesas = Despesa.no_mes(@mes).ordenadas
    @total_mensal = Despesa.total_mensal(@mes)
  end
end
