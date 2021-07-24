module ApplicationHelper
    def toastr_flash
    flash.each_with_object([]) do |(type, message), flash_messages|
        type = 'success' if type == 'notice'
        type = 'error' if type == 'alert'
        text = "<script>toastr.#{type}('#{message}', '', { closeButton: true, progressBar: true })</script>"
        flash_messages << text.html_safe if message
    end.join("\n").html_safe
    end

    def markdown(text)
        options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks]
        Markdown.new(text, *options).to_html.html_safe
    end
end
