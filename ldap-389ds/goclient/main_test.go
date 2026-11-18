package main

import "testing"

func TestUserFilter(t *testing.T) {
	cases := []struct {
		name     string
		username string
		want     string
	}{
		// nominal cases
		{
			name:     "plain username",
			username: "jdoe",
			want:     "(&(objectClass=person)(uid=jdoe))",
		},
		// edge cases
		{
			name:     "empty username",
			username: "",
			want:     "(&(objectClass=person)(uid=))",
		},
		{
			name:     "wildcard is escaped",
			username: "*",
			want:     `(&(objectClass=person)(uid=\2a))`,
		},
		{
			name:     "filter injection is escaped",
			username: "jdoe)(uid=*",
			want:     `(&(objectClass=person)(uid=jdoe\29\28uid=\2a))`,
		},
	}

	for _, tc := range cases {
		t.Run(tc.name, func(t *testing.T) {
			got := userFilter(tc.username)

			if got != tc.want {
				t.Errorf("want %q, got %q", tc.want, got)
			}
		})
	}
}
