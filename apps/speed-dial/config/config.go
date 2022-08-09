// Package config provides the configuration of the speed-dial application.
package config

import (
	"os"
	"sort"

	"gopkg.in/yaml.v3"
)

type (
	// The Config type represents the configuration of the application.
	Config struct {
		Port  int    `yaml:"port"`  // The port to serve HTTP traffic on.
		Links []Link `yaml:"links"` // The links the dashboard should contain.
	}

	// The Link type represents a single link shown on the dashboard.
	Link struct {
		Name     string `yaml:"name"`      // The name of the application.
		URL      string `yaml:"url"`       // The URL to the application.
		ImageURL string `yaml:"image_url"` // The image to display for the application.
	}
)

// Load the file at the given location and unmarshal it into a Config type. The links are sorted lexicographically
// by name before being returned.
func Load(location string) (Config, error) {
	data, err := os.ReadFile(location)
	if err != nil {
		return Config{}, err
	}

	var config Config
	if err = yaml.Unmarshal(data, &config); err != nil {
		return Config{}, err
	}

	sort.Slice(config.Links, func(i, j int) bool {
		return config.Links[i].Name < config.Links[j].Name
	})

	return config, nil
}
