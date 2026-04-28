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

  И теперь в вашей системе вы можете выдать эффект: <code>EFFECTS.Add(ply, "health", "name", 50, 10)</code>
  
  <code>ply</code> - игрок;
  
  <code>"health"</code> - тип модуля;
  
  <code>"name"</code> - уникальный ID эффекта <i>(может быть любым)</i>;
  
  <code>50</code> - количество выдаваемых ХП;
  
  <code>10</code> - время жизни эффекта <i>(0 = бесконечно)</i>;

  убедитесь, что инициализируете в вашем аддоне таблицу <code>EFFECTS</code>, иначе получите ошибку.
</div>
