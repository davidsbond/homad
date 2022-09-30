// Package nomad provides functions for interacting with a nomad cluster.
package nomad

import (
	"context"
	"net/http"
	"strings"
	"time"

	"github.com/hashicorp/nomad/api"
	"golang.org/x/exp/maps"
)

// NewClient returns a new nomad client configured to perform calls to the homelab.
func NewClient() (*api.Client, error) {
	return api.NewClient(&api.Config{
		Address:   "https://homelab.dsb.dev",
		Namespace: api.AllNamespacesNamespace,
		HttpClient: &http.Client{
			Timeout: time.Minute,
		},
	})
}

// GarbageCollect triggers all periodic jobs within the nomad cluster that are suffixed with "gc". This is the typical
// pattern for custom garbage collection jobs.
func GarbageCollect(ctx context.Context, client *api.Client) error {
	jobs, _, err := client.Jobs().List(&api.QueryOptions{Namespace: api.AllNamespacesNamespace})
	switch {
	case err != nil:
		return err
	case len(jobs) == 0:
		return nil
	}

	for _, job := range jobs {
		if ctx.Err() != nil {
			return ctx.Err()
		}

		if !strings.HasSuffix(job.Name, "gc") {
			continue
		}

		_, _, err = client.Jobs().PeriodicForce(job.ID, &api.WriteOptions{Namespace: job.Namespace})
		if err != nil {
			return err
		}
	}

	return nil
}

// Images returns a slice of all container image tags used by tasks within the nomad cluster.
func Images(ctx context.Context, client *api.Client) ([]string, error) {
	images := make(map[string]struct{})

	jobs, _, err := client.Jobs().List(&api.QueryOptions{Namespace: api.AllNamespacesNamespace})
	if err != nil {
		return nil, err
	}

	for _, job := range jobs {
		if ctx.Err() != nil {
			return nil, ctx.Err()
		}

		info, _, err := client.Jobs().Info(job.ID, &api.QueryOptions{Namespace: job.Namespace})
		if err != nil {
			return nil, err
		}

		for _, taskGroup := range info.TaskGroups {
			if ctx.Err() != nil {
				return nil, ctx.Err()
			}

			for _, task := range taskGroup.Tasks {
				if ctx.Err() != nil {
					return nil, ctx.Err()
				}

				if task.Driver != "docker" {
					continue
				}

				imageInterface, ok := task.Config["image"]
				if !ok {
					continue
				}

				image, ok := imageInterface.(string)
				if !ok {
					continue
				}

				images[image] = struct{}{}
			}
		}
	}

	return maps.Keys(images), nil
}
