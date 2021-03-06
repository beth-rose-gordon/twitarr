Twitarr.PostsNewView = Ember.View.extend
  FOUR_MB: 4 * 1024 * 1024
  uploadPercent: null
  uploadPercentStyle: null
  currentUploads: []

  didInsertElement: ->
    $('#fileupload').fileupload
      dataType: 'json'
      dropZone: $('#photo-upload-div')
      submit: (e, data) =>
        filename = data.files[0].name
        if(data.files[0].size > @FOUR_MB)
          @get('controller').addPhotoError(filename, 'File was larger than 4MB')
          return false
        extension = /\.\w+$/.exec(filename)
        unless @isValidExtension(extension)
          @get('controller').addPhotoError(filename, 'Did not have a valid extension')
          return false
        @currentUploads.addObject filename
        true
      done: (e, data) =>
        @currentUploads.removeObject file.name for file in data.files
        @set 'uploadPercent', null if @currentUploads.length < 1
        alert data.result.status unless data.result.status is 'ok'
        controller = @get('controller')
        for photo_data in data.result.files
          if photo_data.status is 'ok'
            controller.addPhoto(Twitarr.Photo.create(photo_data.filename))
          else
            controller.addPhotoError(photo_data.filename, photo_data.status)
          null
        null
      progress: (e, data) =>
        val = parseInt(data.loaded / data.total * 100, 10)
        @set 'uploadPercent', val
        @set 'uploadPercentStyle', "width: #{val}%"

    $('#photo-upload-div').click ->
      $('#fileupload').click()

  isValidExtension: (extension) ->
    return false unless extension
    extension[0].toLowerCase() in ['.jpg', '.jpeg', '.png', '.gif']
