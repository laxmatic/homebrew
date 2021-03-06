module InstallRenamed
  def install_p(_, new_basename)
    super do |src, dst|
      if File.directory? src
        Pathname.new(dst).install Dir["#{src}/*"]
        next
      end

      append_default_if_different(src, dst)
    end
  end

  def cp_path_sub pattern, replacement
    super do |src, dst|
      append_default_if_different(src, dst)
    end
  end

  def + path
    super(path).extend(InstallRenamed)
  end

  def / path
    super(path).extend(InstallRenamed)
  end

  private

  def append_default_if_different src, dst
    if File.file? dst and !FileUtils.identical?(src, dst)
      dst += ".default"
    end
    dst
  end
end
