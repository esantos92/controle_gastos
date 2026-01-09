class DashboardsController < ApplicationController
  def mensal
    @mes = mes_param(params[:mes]) || Date.current
    @total_mensal = Despesa.total_mensal(@mes)
    @por_categoria = Despesa.por_categoria(@mes)
    @labels_categoria = @por_categoria.keys
    @totais_categoria = @por_categoria.values
  end

  def comparativo
    @inicio = mes_param(params[:inicio]) || Date.current.months_ago(2)
    @fim = mes_param(params[:fim]) || Date.current
    @inicio, @fim = @fim, @inicio if @inicio > @fim

    comparativo = Despesa.comparativo(@inicio, @fim).transform_keys(&:to_date)
    @labels_meses = meses_no_periodo(@inicio, @fim)
    @totais_meses = @labels_meses.map do |mes|
      comparativo[mes] || 0
    end

    @recorrencias = Despesa.recorrencias(@inicio, @fim).sort_by { |_, total| -total }
  end

  private

  def mes_param(raw)
    return nil if raw.blank?

    Date.strptime(raw, "%Y-%m")
  rescue ArgumentError
    nil
  end

  def meses_no_periodo(inicio, fim)
    meses = []
    atual = inicio.beginning_of_month
    while atual <= fim.beginning_of_month
      meses << atual
      atual = atual.next_month
    end
    meses
  end
end
