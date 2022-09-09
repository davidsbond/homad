// Package nomad provides functions for interacting with a nomad cluster.
package nomad

import "github.com/hashicorp/nomad/api"

// NewClient returns a new nomad client configured to perform calls to the homelab.
func NewClient() (*api.Client, error) {
	return api.NewClient(&api.Config{
		Address: "https://homelab.dsb.dev",
	})
}
