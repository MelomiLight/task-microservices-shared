.PHONY: proto clean

PROTO_DIR := proto
GEN_DIR := gen

# Найти все .proto файлы
PROTO_FILES := $(shell find $(PROTO_DIR) -name "*.proto")

proto: clean
	@echo "Generating proto files..."
	@mkdir -p $(GEN_DIR)
	@for proto_file in $(PROTO_FILES); do \
		echo "Processing $$proto_file"; \
		protoc -I $(PROTO_DIR) \
			--go_out=$(GEN_DIR) --go_opt=paths=source_relative \
			--go-grpc_out=$(GEN_DIR) --go-grpc_opt=paths=source_relative \
			$$proto_file; \
	done
	@echo "Proto generation complete!"

clean:
	@rm -rf $(GEN_DIR)

install-tools:
	@echo "Installing protoc plugins..."
	@go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	@go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest