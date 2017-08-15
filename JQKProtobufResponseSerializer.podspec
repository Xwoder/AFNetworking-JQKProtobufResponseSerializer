Pod::Spec.new do |s|
  s.name = "JQKProtobufResponseSerializer"
  s.version = "1.0.0"
  s.summary = "A summary of JQKProtobufResponseSerializer."
  s.summary = "Protobuf/Protocol Buffers request serializer for AFNetworking."
  s.homepage = "https://github.com/Xwoder/AFNetworking-JQKProtobufResponseSerializer"
  s.license = "MIT"
  s.author = { "Xwoder" => "Xwoder@vip.qq.com" }
  s.platform = :ios, "7.0"
  s.source = { :git => "https://github.com/Xwoder/AFNetworking-JQKProtobufResponseSerializer.git", :tag => "#{s.version}" }
  s.source_files = "JQKProtobufResponseSerializer", "JQKProtobufResponseSerializer/**/*.{h,m}"
  s.requires_arc = true
  s.user_target_xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1' }
  s.pod_target_xcconfig  = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1' }
  s.dependency "AFNetworking", ">= 2.6"
  s.dependency 'Protobuf', '>= 3.3.0'
end
