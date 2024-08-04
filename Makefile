BUILD_ENV = CGO_ENABLED=0
OPTIONS = -trimpath -ldflags "-w -s"

.PHONY: all admin agent linux_agent windows_agent darwin_agent mips_agent arm_agent windows_admin linux_admin darwin_admin windows_nogui_agent clean

all: admin agent

admin:
	${BUILD_ENV} GOOS=linux GOARCH=386 go build ${OPTIONS} -o release/stowaway_linux_386_admin admin/admin.go
	${BUILD_ENV} GOOS=linux GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_linux_amd64_admin admin/admin.go
	${BUILD_ENV} GOOS=linux GOARCH=arm64 go build ${OPTIONS} -o release/stowaway_linux_arm64_admin admin/admin.go
	${BUILD_ENV} GOOS=windows GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_windows_amd64_admin.exe admin/admin_win.go
	${BUILD_ENV} GOOS=windows GOARCH=386 go build ${OPTIONS} -o release/stowaway_windows_386_admin.exe admin/admin_win.go
	${BUILD_ENV} GOOS=darwin GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_darwin_amd64_admin admin/admin.go
	${BUILD_ENV} GOOS=darwin GOARCH=arm64 go build ${OPTIONS} -o release/stowaway_darwin_arm64_admin admin/admin.go

agent:
	${BUILD_ENV} GOOS=linux GOARCH=386 go build ${OPTIONS} -o release/stowaway_linux_386_agent agent/agent.go
	${BUILD_ENV} GOOS=linux GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_linux_amd64_agent agent/agent.go
	${BUILD_ENV} GOOS=linux GOARCH=arm64 go build ${OPTIONS} -o release/stowaway_linux_arm64_agent agent/agent.go
	${BUILD_ENV} GOOS=windows GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_windows_amd64_agent.exe agent/agent.go
	${BUILD_ENV} GOOS=windows GOARCH=386 go build ${OPTIONS} -o release/stowaway_windows_386_agent.exe agent/agent.go
	${BUILD_ENV} GOOS=darwin GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_darwin_amd64_agent agent/agent.go
	${BUILD_ENV} GOOS=darwin GOARCH=arm64 go build ${OPTIONS} -o release/stowaway_darwin_arm64_agent agent/agent.go
	${BUILD_ENV} GOOS=linux GOARCH=arm GOARM=5 go build ${OPTIONS} -o release/stowaway_arm_eabi5_agent agent/agent.go
	${BUILD_ENV} GOOS=linux GOARCH=mipsle go build ${OPTIONS} -o release/stowaway_mipsel_agent agent/agent.go

linux_agent:
	${BUILD_ENV} GOOS=linux GOARCH=386 go build ${OPTIONS} -o release/stowaway_linux_386_agent agent/agent.go
	${BUILD_ENV} GOOS=linux GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_linux_amd64_agent agent/agent.go
	${BUILD_ENV} GOOS=linux GOARCH=arm64 go build ${OPTIONS} -o release/stowaway_linux_arm64_agent agent/agent.go

windows_agent:
	${BUILD_ENV} GOOS=windows GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_windows_amd64_agent.exe agent/agent.go
	${BUILD_ENV} GOOS=windows GOARCH=386 go build ${OPTIONS} -o release/stowaway_windows_386_agent.exe agent/agent.go

darwin_agent:
	${BUILD_ENV} GOOS=darwin GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_darwin_amd64_agent agent/agent.go
	${BUILD_ENV} GOOS=darwin GOARCH=arm64 go build ${OPTIONS} -o release/stowaway_darwin_arm64_agent agent/agent.go

mips_agent:
	${BUILD_ENV} GOOS=linux GOARCH=mipsle go build ${OPTIONS} -o release/stowaway_mipsel_agent agent/agent.go

arm_agent:
	${BUILD_ENV} GOOS=linux GOARCH=arm GOARM=5 go build ${OPTIONS} -o release/stowaway_arm_eabi5_agent agent/agent.go

windows_admin:
	${BUILD_ENV} GOOS=windows GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_windows_amd64_admin.exe admin/admin_win.go
	${BUILD_ENV} GOOS=windows GOARCH=386 go build ${OPTIONS} -o release/stowaway_windows_386_admin.exe admin/admin_win.go

linux_admin:
	${BUILD_ENV} GOOS=linux GOARCH=386 go build ${OPTIONS} -o release/stowaway_linux_386_admin admin/admin.go
	${BUILD_ENV} GOOS=linux GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_linux_amd64_admin admin/admin.go
	${BUILD_ENV} GOOS=linux GOARCH=arm64 go build ${OPTIONS} -o release/stowaway_linux_arm64_admin admin/admin.go

darwin_admin:
	${BUILD_ENV} GOOS=darwin GOARCH=amd64 go build ${OPTIONS} -o release/stowaway_darwin_amd64_admin admin/admin.go
	${BUILD_ENV} GOOS=darwin GOARCH=arm64 go build ${OPTIONS} -o release/stowaway_darwin_arm64_admin admin/admin.go

# Here is a special situation
# You can see Stowaway get the params passed by the user through console by default
# But if you define the params in the program(instead of passing them by the console),you can just run Stowaway agent by double-click
# Sounds great? Right?
# But it is slightly weird on Windows since double-clicking Stowaway agent or entering "shell" command in Stowaway admin will spawn a cmd window
# That makes Stowaway pretty hard to hide itself
# To solve this,here is my solution
# First, check the detail in "agent/shell.go", follow my instruction and change some codes
# Then, run `make windows_nogui_agent` and get your bonus!

windows_nogui_agent:
	${BUILD_ENV} GOOS=windows GOARCH=amd64 go build -trimpath -ldflags="-w -s -H=windowsgui" -o release/stowaway_windows_amd64_agent.exe agent/agent.go 
	${BUILD_ENV} GOOS=windows GOARCH=386 go build -trimpath -ldflags="-w -s -H=windowsgui" -o release/stowaway_windows_386_agent.exe agent/agent.go 

clean:
	@rm release/stowaway_*