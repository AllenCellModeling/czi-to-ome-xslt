#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pathlib import Path

import lxml.etree as ET

###############################################################################

resources = Path("./resources").resolve(strict=True)
xslt = Path("./xslt").resolve(strict=True)
czixml = str((resources / "s_3_t_1_c_3_z_5_meta.xml").resolve(strict=True))
czisubblock = str((resources / "s_3_t_1_c_3_z_5_subblock.xml").resolve(strict=True))
template = str((xslt / "czi-to-ome.xsl").resolve(strict=True))
output = Path("produced.ome.xml").resolve()
ome_schema = str(Path("ome/ome.xsd").resolve(strict=True))

###############################################################################

# Parse template and generate transform function
template = ET.parse(template)
transform = ET.XSLT(template)

# Parse CZI XML
czixml = ET.parse(czixml)
czisubblock = ET.parse(czisubblock)
id = czixml.getroot()
id.append(czisubblock.getroot())


# Attempt to run transform
try:
    ome = transform(czixml)

    # Write file
    with open(output, "w") as write_out:
        write_out.write(str(ome))

# Catch any exception
except Exception as e:
    print(f"Error during transform: {e}")
    print("-" * 80)
    print("Full Log:")
    for entry in transform.error_log:
        print((f"{entry.filename}: {entry.line}, "
              f"{entry.column}> {entry.message}>"))
    raise e


# Validate against schema
try:
    ome_schema = ET.parse(ome_schema)
    ome_schema = ET.XMLSchema(ome_schema)
    ome_schema.assertValid(ome)
    print("OME XML valid, schema validation ok.")

except ET.DocumentInvalid as e:
    print("Schema validation error:")
    raise e

except Exception as e:
    print("Unknown error:")
    raise e
