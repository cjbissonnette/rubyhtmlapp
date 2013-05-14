require 'bundler/setup'
require 'rubyhtmlapp'
require '<%=@params[:name]%>/version'
require '<%=@params[:name]%>/cli'
require '<%=@params[:name]%>/helpers'

<%- @params[:constant_array].each_with_index do |c,i| -%>
<%= '  '*i %>module <%= c %>
<%- end -%>
<%= '  '*@params[:constant_array].size %># Your code goes here...
<%- (@params[:constant_array].size-1).downto(0) do |i| -%>
<%= '  '*i %>end
<%- end -%>
