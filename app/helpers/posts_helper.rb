module PostsHelper
  def markdown(source)
    options = [:hard_wrap, :filter_html, :autolink, :no_intraemphasis, :fenced_code, :gh_blockcode] 
    strip_html_wrapper(highlight_code(Redcarpet.new(source, *options).to_html)).html_safe
  end

  def strip_html_wrapper(nokogiri_doc)
    nokogiri_doc.search("//body").inner_html
  end

  def highlight_code(source)
    doc = Nokogiri::HTML(source)
    doc.search("//pre[@lang]").each do |pre|
      pre.replace CodeRay.scan(pre.text.rstrip, pre[:lang]) 
    end
    doc
  end
end
