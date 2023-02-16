package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestWindowsAppExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/windows-app",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
