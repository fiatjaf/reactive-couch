deps = ['lib/superagent', 'lib/lodash', 'lib/react', 'lib/history', 'components/RadioField', 'components/MoneyField', 'components/PacienteField', 'components/PagamentosField']
factory = (request, _, React, History, RadioField, MoneyField, PacienteField, PagamentosField) ->
  {style, button, div, span, a, p, hr, dl, dt, dd, label, fieldset, legend, table, tr, th, td, h1, h2, h3, form, input, textarea} = React.DOM

  Operacao = React.createClass
    getInitialState: ->
      operacao: @props.operacao or {}
      editing: false

    componentDidMount: ->
      self = this
      ee.on 'showOperacao', (operacao) ->
        self.setState operacao: operacao
        History.to "/operacao/#{operacao._id}"

    saveOperacao: (e) ->
      operacao = @state.operacao
      self = @
      request.post('/_ddoc/_update/operacao')
             .send(operacao)
             .end (res) ->
                console.log res
                if res.ok
                  operacao = JSON.parse res.body
                  self.setState operacao: operacao
      e.preventDefault()

    startEditing: (e) ->
      @setState editing: true
      e.preventDefault()

    handleChange: (e) ->
      operacao = @state.operacao
      operacao[e.target.name] = e.target.value
      @setState operacao: operacao

    render: ->
      operacao = @state.operacao
      if @state.editing or not @props.ref
        (tr {},
          (td {},
            (DateField
              name: 'date'
              value: operacao.date
              onChange: @handleChange)
          )
          (td {},
            (RadioField
              name: 'cod'
              fields: [{
                label: '1',
                value: 1
              }, {
                label: '2',
                value: 2
              }, {
                label: '3',
                value: 3
              }, {
                label: '4',
                value: 4
              }]
              reportValue: @handleChange
              value: operacao.cod),
          ),
          (td {},
            (PacienteField
              name: pacienteid
              value: operacao.pacienteid
              onChange: @handleChange)
          ),
          (td {},
            (MoneyField
              name: 'orcamento'
              value: operacao.orcamento
              onChange: @handleChange
            ) if @state.cod in (1, 2),
          ),
          (td {},
            (PagamentosField
              name: 'pagamento'
              onChange: @handleChange
              value: operacao.pagamentos
            ) if @state.code in (1, 3, 4),
          ),
          (td {},
            (input
              type: 'text'
              name: 'dentista'
              onChange: @handleChange
              value: operacao.dentista)
          )
          (td {},
            (button type: 'submit', 'Salvar')
          ),
        )
      else
        (div {},
          (tr {},
            (td {}, operacao.date),
            (td {}, operacao.cod),
            (td {}, operacao.paciente.ficha),
            (td {}, operacao.paciente.nome),
            (td {}, operacao.orcamento),
            (td {}, operacao.valor),
            (td {}, operacao.dentista),
            (td {},
              (button {onClick: @startEditing}, 'editar')
            )
          )
        )

  return Operacao

if typeof define == 'function' and define.amd
  define deps, factory
else if typeof exports == 'object'
  module.exports = factory.apply @, deps.map require
