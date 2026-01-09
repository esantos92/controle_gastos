class Despesa < ApplicationRecord
  before_validation :normalizar_categoria

  validates :valor, numericality: { greater_than: 0 }
  validates :data, presence: true
  validate :data_nao_futura

  scope :ordenadas, -> { order(data: :desc, created_at: :desc) }

  def self.no_mes(mes)
    where(data: mes.beginning_of_month..mes.end_of_month)
  end

  def self.total_mensal(mes)
    no_mes(mes).sum(:valor)
  end

  def self.por_categoria(mes)
    no_mes(mes)
      .group("COALESCE(categoria, 'Sem categoria')")
      .sum(:valor)
  end

  def self.comparativo(inicio, fim)
    where(data: inicio.beginning_of_month..fim.end_of_month)
      .group("date_trunc('month', data)")
      .sum(:valor)
  end

  def self.recorrencias(inicio, fim)
    where(data: inicio.beginning_of_month..fim.end_of_month)
      .group("COALESCE(categoria, 'Sem categoria')")
      .count
  end

  private

  def normalizar_categoria
    self.categoria = "Sem categoria" if categoria.blank?
  end

  def data_nao_futura
    return if data.blank?

    errors.add(:data, "nao pode ser futura") if data > Date.current
  end
end
