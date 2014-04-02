actions :create, :delete
default_action :create

attribute :install_path     , name_attribute: true, kind_of: String, required: true
attribute :owner            , kind_of: String
attribute :group            , kind_of: String
attribute :mode             , kind_of: Fixnum
attribute :source_file      , kind_of: String
attribute :source_cookbook  , kind_of: String
