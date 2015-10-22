((window, $) ->

  CHECK_INTERVAL = 3000

  filesContainer = $ '#ondd-file-list'
  filesUrl = filesContainer.data 'url'

  updateFileList = () ->
    filesContainer.load filesUrl

  setInterval updateFileList, CHECK_INTERVAL

  return

) this, this.jQuery
