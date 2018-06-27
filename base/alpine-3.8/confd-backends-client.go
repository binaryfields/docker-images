package backends

import (
	"errors"
	"strings"

	"github.com/kelseyhightower/confd/backends/env"
	"github.com/kelseyhightower/confd/backends/file"
	"github.com/kelseyhightower/confd/log"
)

// The StoreClient interface is implemented by objects that can retrieve
// key/value pairs from a backend store.
type StoreClient interface {
	GetValues(keys []string) (map[string]string, error)
	WatchPrefix(prefix string, keys []string, waitIndex uint64, stopChan chan bool) (uint64, error)
}

// New is used to create a storage client based on our configuration.
func New(config Config) (StoreClient, error) {
	if config.Backend == "" {
		config.Backend = "env"
	}
	backendNodes := config.BackendNodes

	if config.Backend == "file" {
		log.Info("Backend source(s) set to " + strings.Join(config.YAMLFile, ", "))
	} else {
		log.Info("Backend source(s) set to " + strings.Join(backendNodes, ", "))
	}

	switch config.Backend {
	case "env":
		return env.NewEnvClient()
	case "file":
		return file.NewFileClient(config.YAMLFile, config.Filter)
	}
	return nil, errors.New("Invalid backend")
}
