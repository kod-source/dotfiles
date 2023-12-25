package 'go'

# [
#     'github.com/go-delve/delve/cmd/dlv@latest',
#     'golang.org/x/tools/cmd/godoc@latest',
#     'golang.org/x/tools/cmd/goimports@latest',
#     'golang.org/x/tools/gopls@latest',
#     'github.com/cosmtrek/air@latest',
#     'github.com/schemalex/git-schemalex/cmd/git-schemalex@latest',
#     'github.com/shogo82148/goa-v1/...@v1',
#     'goa.design/goa/v3/cmd/goa@v3',
#     'google.golang.org/protobuf/cmd/protoc-gen-go@latest',
#     'google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest',
#     'github.com/google/wire/cmd/wire@latest',
#     'github.com/shogo82148/schemalex-deploy/cmd/schemalex-deploy@latest',
#     'github.com/tsenart/vegeta@latest',
#     'github.com/kyoh86/richgo@latest',
#     'go.uber.org/mock/mockgen@latest',
#     'golang.org/x/vuln/cmd/govulncheck@latest'
# ].each do |pkg|
#     execute "Install #{pkg}" do
#         command "go install #{pkg}"
#         not_if "go list #{pkg}"
#     end
# end
