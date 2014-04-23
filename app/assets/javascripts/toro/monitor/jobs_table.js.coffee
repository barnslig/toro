class ToroMonitor.JobsTable extends ToroMonitor.AbstractJobsTable

  initialize: =>
    options =
      table_selector: 'table.jobs'
      columns:
        id: 0
        started_by: 1
        queue: 2
        class_name: 3
        name: 4
        created_at: 5
        started_at: 6
        duration: 7
        message: 8
        status: 9
        properties: 10
        args: 11
      column_options: [
        { bVisible: false }
        { bVisible: false }
        null
        null
        { bSortable: false }
        {
          fnRender: (oObj) =>
            @format_time_ago(oObj.aData[@columns.created_at])
        }
        {
          fnRender: (oObj) =>
            @format_time_ago(oObj.aData[@columns.started_at])
        }
        null
        { bSortable: false }
        {
          fnRender: (oObj) =>
            status = oObj.aData[@columns.status]
            class_name = switch status
              when 'failed'
                'danger'
              when 'complete'
                'success'
              when 'running'
                'primary'
              when 'scheduled'
                'inverse'
              else
                'info'
            html = """<a href="#" class="btn btn-#{class_name} btn-mini status-value">#{oObj.aData[@columns.status]}</a>"""
            if status == 'failed'
              html += """<a href="#" class="btn btn-mini btn-primary retry-job" data-job-id="#{oObj.aData[@columns.id]}">Retry<a>"""
            """<span class="action-buttons">#{html}</span>"""
        }
        { bVisible: false }
        { bVisible: false }
      ]
    
    return null unless $(options.table_selector).length

    @initialize_with_options(options)

$ ->
  new ToroMonitor.JobsTable
