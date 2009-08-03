class Image < ActiveRecord::Base
  def self.up
      create_table :images do |t|
        t.column "name", :string
        t.column "year", :string
        t.column "medium", :string
        t.column "image_path", :string
      end
  end
  
  def self.down
          drop_table :images
  end
  def file= (f)
    @file = f
  end
  def validate 
    # Empty 'name' field is not allowed
    errors.add_on_empty 'name'

    # @file should contain file uploaded by HTTP 
    # it is either StringIO object (if file was smaller than 10Kb)
    # or Tempfile (otherwise)
    if not (@file.kind_of? StringIO or @file.kind_of? Tempfile)
      errors.add_to_base("No file selected")
      return
    end

    # We can't use StringIO data to call external programs
    # So, if object is StringIO -- we have to create Tempfile
    # Unfortunatly, in Rails it is impossible to force all uploads to be Tempfiles
    if @file.kind_of? StringIO
      # Yes, if @file is StringIO, create new Tempfile and copy everything to it 
      @real_file = Tempfile.new("AEGALLERY")
      while not @file.eof? 
        @real_file.write @file.read
      end
    else
      # Most uploads will be Tempfiles
      @real_file = @file
    end

    # Here is a call to ImageMagick tool identity 
    # it prints to standard output 
    # type, width and height of images 
    # (this is specified by -format %m,%w,%h)
    identify = `#{IMAGE_MAGICK_PATH}/identify -format %m,%w,%h #{@real_file.path} 2>&1`
    # Now identity is a string like "JPEG,640,480"

    # We split this string to array 
    @jpeg_info = identify.split(',', 3)
    # convert width and height to integer and assign it to object fields 
    self.width = @jpeg_info[1].to_i
    self.height = @jpeg_info[2].to_i      

    # Finally, cheking if everything was fine with this image 
    # if file was not valid JPEG -- something will fail here
    if @jpeg_info == nil or @jpeg_info[0] != 'JPEG' or self.width <= 0 or self.height <= 0
       errors.add_to_base("Wrong image format (use only JPEG) or broken data")
       return
    end

  end
            
end
