# CLAUDE.md

## Project Overview

**elanman** (eLan Manager) is an Ansible playbook generator for managing WHM/cPanel server infrastructure at scale. It takes a YAML "answer file" describing your infrastructure (brands, regions, roles, server nodes, configuration values) and generates a complete, customized Ansible playbook in `~/myelanman/`.

This is a two-phase system:
1. **Phase 1 (elanman)**: Run this generator to produce a playbook from your answer file
2. **Phase 2 (myelanman)**: The generated playbook manages actual servers

## Repository Structure

```
elanman.yaml              # Main Ansible playbook entry point (3 roles: common, cpanel, post)
managers.sample           # Ansible inventory template (localhost only)
Makefile                  # Build targets: setup, short

docs/                     # Sphinx documentation
  conf.py                 # Sphinx config
  index.rst               # Doc index

meta/
  main.yml                # Ansible Galaxy metadata (author, license, platforms)

roles/
  common/                 # Main processing role - core generator logic
    tasks/
      main.yaml           # Primary task orchestrator (generation workflow)
      mkdir.yaml          # Create role directory structure
      mkmaintasks.yaml    # Generate role main.yaml task files
      mktasks.yaml        # Generate individual task files
      mktemplate.yaml     # Copy/template template files
    vars/
      defaultobjects.yaml # Configuration schema (sections, objects, values, levels)
    files/
      answers.sample.yaml # Full example answer file (31 regions, 2 brands, 41 nodes)
      answers.short.yaml  # Minimal example (1 region, 1 brand, 1 node)
      *.j2                # Template source files (CSF, CXS, FTP configs)
    templates/
      *.j2                # Jinja2 templates for generated playbook output

  cpanel/                 # WHM API integration role
    files/                # EasyApache profiles, WHM API wrapper script
    templates/            # WHM API call templates
    tasks/main.yaml       # Copy profiles, create API templates

  post/                   # Post-generation role (optional outputs)
    tasks/
      main.yaml           # Orchestrate static portal + Django site
      django_site.yaml    # Generate Django project
      static_portal.yaml  # Generate static HTML portal
    vars/
      django_site.yaml    # Django app config (models, views as YAML)
      static_portal.yaml  # Static portal config
    files/
      Pipfile             # Python deps for Django output
    templates/
      *.j2                # Django project templates (settings, models, views, etc.)
      *.html              # Static portal HTML templates
```

## Key Concepts

### Answer File Structure
The answer file (`answers.yaml`) defines infrastructure hierarchically:
- **Brands** → business units
- **Regions** → geographic locations
- **Roles** → server types (sharedhosting, dnsonly, mailonly, ftponly)
- **Server Nodes** → physical/virtual servers
- **Logical Groups** → prod/test/dev environments
- **Configuration Sections/Objects/Values** → hierarchical config with role/brand/region filtering

### Configuration Hierarchy
`configurationlevels` maps config values to specific scopes:
- Global: role=0, brand=0, region=0
- Role-specific, brand-specific, region-specific
- Most specific scope wins

### Role System
- **Addon roles**: `common` (runs first), `postrun` (runs last)
- **Primary roles**: `sharedhosting`, `dnsonly`, `mailonly`, `ftponly`
- Each generated role gets: `vars/`, `tasks/`, `templates/`, `defaults/`

## Build Commands

```bash
make setup    # Full generation from answer file
make short    # Quick test with minimal configuration (answers.short.yaml)
```

Both invoke `ansible-playbook elanman.yaml` against localhost. The `short` target passes `-e short=true`.

## Development Conventions

- **YAML**: All config files use `---` header
- **Templates**: Jinja2 files use `.j2` extension
- **IDs**: Short abbreviations for entities (e.g., `br1`, `r1`, `sha`, `comn`)
- **Output directory**: All generated playbook files go to `~/myelanman/`
- **Version tracking**: `makefileversion` in `elanman.yaml` (currently `"0.12"`)
- **License**: GPL-3.0
- **Target platforms**: EL 6, EL 7 (RHEL/CentOS)
- **Ansible version**: 2.4+

## Key Files for Understanding the System

| File | Why It Matters |
|------|---------------|
| `elanman.yaml` | Entry point, defines role execution order and global vars |
| `roles/common/vars/defaultobjects.yaml` | Complete configuration schema |
| `roles/common/tasks/main.yaml` | Full generation workflow (20+ steps) |
| `roles/common/files/answers.sample.yaml` | Real-world example of answer file structure |
| `roles/common/templates/mainvars.yaml.j2` | Most complex template - filters config by role/brand/region |
| `roles/post/vars/django_site.yaml` | Django models/views/serializers defined as YAML |

## What NOT to Change Without Care

- `defaultobjects.yaml` defines the entire configuration schema - changes cascade everywhere
- `mainvars.yaml.j2` has complex nested Jinja2 logic for hierarchical config filtering
- Template files often contain nested Jinja2 (templates generating templates) - be careful with escaping
- The `main.yaml` task orchestrator ordering matters - steps depend on prior state

## .gitignore Notes

Excluded: `*.retry`, `.idea/`, `.DS_Store`, `managers` (local inventory), `files/answers-*` (timestamped backups)
