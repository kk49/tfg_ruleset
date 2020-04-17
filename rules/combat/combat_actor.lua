function onInit()
    DB.addHandler(link_db_ref.getValue(), 'onUpdate', onUpdateHandler)
    DB.addHandler(link_db_ref.getValue(), 'onChildUpdate', onUpdateHandler)
    Gui.onInit_handle('combat_actor', self)
end

function onClose()
    DB.removeHandler(link_db_ref.getValue(), 'onChildUpdate', onUpdateHandler)
    DB.removeHandler(link_db_ref.getValue(), 'onUpdate', onUpdateHandler)
end

function onFirstLayout()
    Gui.onFirstLayout_handle('combat_actor', self)
end

function onUpdateHandler(actor_node, child_node)
    actor = Core.dbCast(actor_node, Combat.k_interface_combat_actor)
    node = getDatabaseNode()

    chits_available = actor:initiativeGet()
    chits_used =  actor:initiativeUsedGet()
    chits_remaining = chits_available - chits_used
    DB.setValue(node, 'initiative_cur', 'number', chits_remaining)

    stamina = actor:staminaGet()
    stamina_used = actor:staminaUsedGet()
    stamina_remaining = stamina - stamina_used
    DB.setValue(node, 'stamina_cur', 'number', stamina_remaining)
end

function elementOpen()
    db_ref = link_db_ref.getValue()
    Interface.openWindow(Core.editorFind(db_ref), db_ref)
end

function elementDrag(button, x, y, drag_info)
    --Debug.console('elementDrag', button, x, y, drag_info)
    db_ref = link_db_ref.getValue()
    drag_info.setShortcutData(Core.editorFind(db_ref), db_ref)
    drag_info.setType('shortcut')
end
