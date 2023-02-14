CREATE TABLE IF NOT EXISTS public.recipes
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id uuid NOT NULL,
    slug character varying COLLATE pg_catalog."default",
    group_id uuid NOT NULL,
    user_id uuid,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    description character varying COLLATE pg_catalog."default",
    image character varying COLLATE pg_catalog."default",
    total_time character varying COLLATE pg_catalog."default",
    prep_time character varying COLLATE pg_catalog."default",
    perform_time character varying COLLATE pg_catalog."default",
    cook_time character varying COLLATE pg_catalog."default",
    recipe_yield character varying COLLATE pg_catalog."default",
    "recipeCuisine" character varying COLLATE pg_catalog."default",
    rating integer,
    org_url character varying COLLATE pg_catalog."default",
    date_added date,
    date_updated timestamp without time zone,
    is_ocr_recipe boolean,
    last_made timestamp without time zone,
    CONSTRAINT recipes_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_slug_group_id_key UNIQUE (slug, group_id),
    CONSTRAINT recipes_group_id_fkey FOREIGN KEY (group_id)
        REFERENCES public.groups (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipe_assets
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id integer NOT NULL DEFAULT 'nextval('recipe_assets_id_seq'::regclass)',
    recipe_id uuid,
    name character varying COLLATE pg_catalog."default",
    icon character varying COLLATE pg_catalog."default",
    file_name character varying COLLATE pg_catalog."default",
    CONSTRAINT recipe_assets_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_assets_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipes_ingredients
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id integer NOT NULL DEFAULT 'nextval('recipes_ingredients_id_seq'::regclass)',
    "position" integer,
    recipe_id uuid,
    title character varying COLLATE pg_catalog."default",
    note character varying COLLATE pg_catalog."default",
    unit_id uuid,
    food_id uuid,
    quantity double precision,
    reference_id uuid,
    original_text character varying COLLATE pg_catalog."default",
    CONSTRAINT recipes_ingredients_pkey PRIMARY KEY (id),
    CONSTRAINT recipes_ingredients_food_id_fkey FOREIGN KEY (food_id)
        REFERENCES public.ingredient_foods (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT recipes_ingredients_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT recipes_ingredients_unit_id_fkey FOREIGN KEY (unit_id)
        REFERENCES public.ingredient_units (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipe_comments
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id uuid NOT NULL,
    text character varying COLLATE pg_catalog."default",
    recipe_id uuid NOT NULL,
    user_id uuid NOT NULL,
    CONSTRAINT recipe_comments_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_comments_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT recipe_comments_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipe_nutrition
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id integer NOT NULL DEFAULT 'nextval('recipe_nutrition_id_seq'::regclass)',
    recipe_id uuid,
    calories character varying COLLATE pg_catalog."default",
    fat_content character varying COLLATE pg_catalog."default",
    fiber_content character varying COLLATE pg_catalog."default",
    protein_content character varying COLLATE pg_catalog."default",
    carbohydrate_content character varying COLLATE pg_catalog."default",
    sodium_content character varying COLLATE pg_catalog."default",
    sugar_content character varying COLLATE pg_catalog."default",
    CONSTRAINT recipe_nutrition_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_nutrition_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipe_settings
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id integer NOT NULL DEFAULT 'nextval('recipe_settings_id_seq'::regclass)',
    recipe_id uuid,
    public boolean,
    show_nutrition boolean,
    show_assets boolean,
    landscape_view boolean,
    disable_amount boolean,
    disable_comments boolean,
    locked boolean,
    CONSTRAINT recipe_settings_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_settings_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipe_share_tokens
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id uuid NOT NULL,
    group_id uuid NOT NULL,
    recipe_id uuid NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    CONSTRAINT recipe_share_tokens_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_share_tokens_group_id_fkey FOREIGN KEY (group_id)
        REFERENCES public.groups (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT recipe_share_tokens_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipe_timeline_events
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id uuid NOT NULL,
    recipe_id uuid NOT NULL,
    user_id uuid NOT NULL,
    subject character varying COLLATE pg_catalog."default" NOT NULL,
    message character varying COLLATE pg_catalog."default",
    event_type character varying COLLATE pg_catalog."default",
    image character varying COLLATE pg_catalog."default",
    "timestamp" timestamp without time zone,
    CONSTRAINT recipe_timeline_events_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_timeline_events_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT recipe_timeline_events_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public.users (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)


CREATE TABLE IF NOT EXISTS public.recipe_instructions
(
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    id uuid NOT NULL,
    recipe_id uuid,
    "position" integer,
    type character varying COLLATE pg_catalog."default",
    title character varying COLLATE pg_catalog."default",
    text character varying COLLATE pg_catalog."default",
    CONSTRAINT recipe_instructions_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_instructions_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipe_ingredient_ref_link
(
    id integer NOT NULL DEFAULT 'nextval('recipe_ingredient_ref_link_id_seq'::regclass)',
    created_at timestamp without time zone,
    update_at timestamp without time zone,
    instruction_id uuid,
    reference_id uuid,
    CONSTRAINT recipe_ingredient_ref_link_pkey PRIMARY KEY (id),
    CONSTRAINT recipe_ingredient_ref_link_instruction_id_fkey FOREIGN KEY (instruction_id)
        REFERENCES public.recipe_instructions (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipes_to_categories
(
    recipe_id uuid,
    category_id uuid,
    CONSTRAINT recipes_to_categories_category_id_fkey FOREIGN KEY (category_id)
        REFERENCES public.categories (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT recipes_to_categories_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

CREATE TABLE IF NOT EXISTS public.recipes_to_tags
(
    recipe_id uuid,
    tag_id uuid,
    CONSTRAINT recipes_to_tags_recipe_id_fkey FOREIGN KEY (recipe_id)
        REFERENCES public.recipes (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT recipes_to_tags_tag_id_fkey FOREIGN KEY (tag_id)
        REFERENCES public.tags (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)