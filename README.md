# EffectsSystem [~на стадии доработки~]

<div>
  <h2>Добавление нового модуля:</h2>
  <pre><code>
EFFECTS.RegisterModule("health", {
    defaultValue = 0,
    apply = function(ply, total)
        local newMax = ply:GetMaxHealth() + total
        ply:SetMaxHealth(newMax)
        if ply:Health() > newMax then
            ply:SetHealth(newMax)
        end
    end
})
  </code></pre>

  <p1>И теперь в вашей системе вы можете выдать эффект: <code>EFFECTS.Add(ply, "health", "name", 50, 10)</code></p1>
  
  <p1><code>ply</code> - игрок;</p1>
  
  <p1><code>"health"</code> - тип модуля;</p1>
  
  <p1><code>"name"</code> - уникальный ID эффекта <i>(может быть любым)</i>;</p1>
  
  <p1><code>50</code> - количество выдаваемых ХП;</p1>
  
  <p1><code>10</code> - время жизни эффекта <i>(0 = бесконечно)</i>;</p1>
</div>
