# Install VirtualBox and its extensions
#brew install virtualbox
#brew install virtualbox-extension-pack

# Set VM configuration
$vmName = "MuleSoft_RPA_VM"
$vmRAM = 16 * 1024 # 16 GB
$vmCPU = 4
$vmDiskSize = 60 * 1024 # 60 GB
$vmOSISO = "/Users/smith.ryan/Documents/vbox/Win11_22H2_English_x64v1.iso"

# Create and configure the VM
VBoxManage createvm --name $vmName --ostype "Windows10_64" --register
VBoxManage modifyvm $vmName --cpus $vmCPU --memory $vmRAM --acpi on --boot1 dvd --nic1 nat
VBoxManage createhd --filename "$vmName.vdi" --size $vmDiskSize --variant Standard
VBoxManage storagectl $vmName --name "SATA Controller" --add sata --controller IntelAHCI --bootable on
VBoxManage storageattach $vmName --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$vmName.vdi"
VBoxManage storagectl $vmName --name "IDE Controller" --add ide --controller PIIX4 --bootable on
VBoxManage storageattach $vmName --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $vmOSISO

# Enable TPM 2.0
VBoxManage modifyvm $vmName --tpmversion 2.0

# Increase the VRAM size to 128MB
& VBoxManage modifyvm "MuleSoft_RPA_VM" --vram 128

# Enable 3D acceleration
& VBoxManage modifyvm "MuleSoft_RPA_VM" --accelerate3d on

# Update the guest OS type to Windows 11 (64-bit) if available
& VBoxManage modifyvm "MuleSoft_RPA_VM" --ostype Windows11_64

VBoxManage modifyvm MuleSoft_RPA_VM --graphicscontroller vmsvga

# Start the VM
VBoxManage startvm $vmName
