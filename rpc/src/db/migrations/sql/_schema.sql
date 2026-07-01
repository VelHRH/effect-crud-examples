\restrict mQL4bxwQDyyaSJ3SBIjdlAfwuhxToIL1VJOgh7ujXFGqK0lM1DuWNaBm53mykma

CREATE FUNCTION public.set_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
      NEW.updated_at = now();
      RETURN NEW;
    END;
    $$;

CREATE TABLE public.effect_sql_migrations (
    migration_id integer NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    name text NOT NULL
);

CREATE TABLE public.rooms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE ONLY public.effect_sql_migrations
    ADD CONSTRAINT effect_sql_migrations_pkey PRIMARY KEY (migration_id);

ALTER TABLE ONLY public.rooms
    ADD CONSTRAINT rooms_pkey PRIMARY KEY (id);

CREATE TRIGGER rooms_set_updated_at BEFORE UPDATE ON public.rooms FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

\unrestrict mQL4bxwQDyyaSJ3SBIjdlAfwuhxToIL1VJOgh7ujXFGqK0lM1DuWNaBm53mykma

\restrict CLO94VmdOtgpKoy5LS0cngi9KAdGwPYhZ8nuXcNMHiEqnpFJpUfAdXdmDkUdSaz

INSERT INTO public.effect_sql_migrations (migration_id, created_at, name) VALUES (1, '2026-07-01 09:35:47.177011+00', 'create_rooms_table');

\unrestrict CLO94VmdOtgpKoy5LS0cngi9KAdGwPYhZ8nuXcNMHiEqnpFJpUfAdXdmDkUdSaz