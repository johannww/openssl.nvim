local M = {}

local CERT = "certificate"
local PKEY = "privatekey"
local PUBKEY = "publickey"
local CSR = "csr"
local CRL = "crl"

M.cmds = {
    [CERT] = "openssl x509 -in %s -text -noout",
    [PKEY] = "openssl pkey -in %s -text -noout",
    [PUBKEY] = "openssl pkey -pubin -in %s -text -noout",
    [CSR] = "openssl req -in %s -text -noout",
    [CRL] = "openssl crl -in %s -text -noout"
}

M.type = function (certPem)
    certPem = type(certPem) == "table" and certPem[1] or certPem

    if string.find(certPem, "BEGIN CERTIFICATE REQUEST") then
        return CSR
    elseif string.find(certPem, "BEGIN CERTIFICATE") then
        return CERT
    elseif string.find(certPem, "BEGIN PRIVATE KEY") then
        return PKEY
    elseif string.find(certPem, "BEGIN PUBLIC KEY") then
        return PUBKEY
    elseif string.find(certPem, "BEGIN X509 CRL") then
        return CRL
    end
    return nil
end

M.getCmd = function (certPem)
    local t = M.type(certPem)
    return M.cmds[t]
end

return M
