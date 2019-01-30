


func (e encPubkey) id() enode.ID {
	return enode.ID(crypto.Keccak256Hash(e[:]))
}
