# Create schemas

# Create tables
CREATE TABLE IF NOT EXISTS teams
(
    uid BINARY(16) NOT NULL,
    number INT,
    name VARCHAR(32),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS events
(
    uid BINARY(16) NOT NULL,
    year INT,
    shortname VARCHAR(32),
    fullname VARCHAR(64),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS inspection_checklist
(
    uid BINARY(16) NOT NULL,
    name VARCHAR(32),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS checklist_item_type
(
    uid BINARY(16) NOT NULL,
    type VARCHAR(32),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS checklist_item
(
    uid BINARY(16) NOT NULL,
    type BINARY(16),
    rule_ref BINARY(16),
    pass_cond BINARY(16),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS checklist_item_rule_reference
(
    uid BINARY(16) NOT NULL,
    rule VARCHAR(32),
    static_ref BINARY(16),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS inspection_instance
(
    uid BINARY(16) NOT NULL,
    team BINARY(16),
    event BINARY(16),
    event_clkist BINARY(16),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS inspection_visit
(
    uid BINARY(16) NOT NULL,
    instance BINARY(16),
    user BINARY(16),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS inspection_action
(
    uid BINARY(16) NOT NULL,
    visit BINARY(16),
    type BINARY(16),
    cklist_item BINARY(16),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS inspection_action_type
(
    uid BINARY(16) NOT NULL,
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS inspection_action_data
(
    uid BINARY(16) NOT NULL,
    ins_act BINARY(16),
    data_val INT,
    data_type BINARY(16),
    static_ref BINARY(16),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS static_references
(
    uid BINARY(16) NOT NULL,
    url VARCHAR(128),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS users
(
    uid BINARY(16) NOT NULL,
    username VARCHAR(16),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS user_permissions
(
    uid BINARY(16) NOT NULL,
    user_uid BINARY(16),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS inspection_data_type
(
    uid BINARY(16) NOT NULL,
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS checklist_members
(
    uid BINARY(16) NOT NULL,
    parent_checklist BINARY(16),
    cklist_item BINARY(16),
    entry_num INT,
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS transactions
(
    uid BINARY(16) NOT NULL,
    user BINARY(16),
    timestamp DATETIME,
    transaction_text VARCHAR(64),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS checklist_item_pass_cond
(
    uid BINARY(16) NOT NULL,
    condition VARCHAR(32),
    PRIMARY KEY(uid)
);

CREATE TABLE IF NOT EXISTS inspector_assignments
(
    uid BINARY(16) NOT NULL,
    instance BINARY(16),
    user BINARY(16),
    PRIMARY KEY(uid)
);


# Create FKs
ALTER TABLE inspection_instance
    ADD    FOREIGN KEY (team)
    REFERENCES teams(uid)
;
    
ALTER TABLE inspection_instance
    ADD    FOREIGN KEY (event)
    REFERENCES events(uid)
;
    
ALTER TABLE inspector_assignments
    ADD    FOREIGN KEY (instance)
    REFERENCES inspection_instance(uid)
;
    
ALTER TABLE inspector_assignments
    ADD    FOREIGN KEY (user)
    REFERENCES users(uid)
;
    
ALTER TABLE user_permissions
    ADD    FOREIGN KEY (user_uid)
    REFERENCES users(uid)
;
    
ALTER TABLE transactions
    ADD    FOREIGN KEY (user)
    REFERENCES users(uid)
;
    
ALTER TABLE inspection_action
    ADD    FOREIGN KEY (type)
    REFERENCES inspection_action_type(uid)
;
    
ALTER TABLE inspection_action_data
    ADD    FOREIGN KEY (ins_act)
    REFERENCES inspection_action(uid)
;
    
ALTER TABLE inspection_visit
    ADD    FOREIGN KEY (instance)
    REFERENCES inspection_instance(uid)
;
    
ALTER TABLE inspection_action
    ADD    FOREIGN KEY (visit)
    REFERENCES inspection_visit(uid)
;
    
ALTER TABLE inspection_visit
    ADD    FOREIGN KEY (user)
    REFERENCES users(uid)
;
    
ALTER TABLE inspection_action
    ADD    FOREIGN KEY (cklist_item)
    REFERENCES checklist_item(uid)
;
    
ALTER TABLE inspection_action_data
    ADD    FOREIGN KEY (data_type)
    REFERENCES inspection_data_type(uid)
;
    
ALTER TABLE inspection_action_data
    ADD    FOREIGN KEY (static_ref)
    REFERENCES static_references(uid)
;
    
ALTER TABLE checklist_item_rule_reference
    ADD    FOREIGN KEY (static_ref)
    REFERENCES static_references(uid)
;
    
ALTER TABLE checklist_item
    ADD    FOREIGN KEY (rule_ref)
    REFERENCES checklist_item_rule_reference(uid)
;
    
ALTER TABLE checklist_item
    ADD    FOREIGN KEY (pass_cond)
    REFERENCES checklist_item_pass_cond(uid)
;
    
ALTER TABLE checklist_item
    ADD    FOREIGN KEY (type)
    REFERENCES checklist_item_type(uid)
;
    
ALTER TABLE checklist_members
    ADD    FOREIGN KEY (cklist_item)
    REFERENCES checklist_item(uid)
;
    
ALTER TABLE checklist_members
    ADD    FOREIGN KEY (parent_checklist)
    REFERENCES inspection_checklist(uid)
;
    
ALTER TABLE inspection_instance
    ADD    FOREIGN KEY (event_clkist)
    REFERENCES inspection_checklist(uid)
;
    

