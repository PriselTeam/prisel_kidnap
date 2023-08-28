net.Receive("Prisel_KidnapSystem:KidnapPlayer", function()
    Prisel.Kidnapping:ShowKidnappedPanel()
end)

net.Receive("Prisel_KidnapSystem:UnKidnapPlayer", function()
    Prisel.Kidnapping:CloseKidnappedPanel()
end)