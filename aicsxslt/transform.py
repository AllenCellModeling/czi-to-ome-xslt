from pathlib import Path

import lxml.etree as ET

###############################################################################

resources = Path("./resources").resolve(strict=True)
xslt = Path("./xslt").resolve(strict=True)  
czixml = str((resources / "s_3_t_1_c_3_z_5_meta.xml").resolve(strict=True))
# commented out now that subblock metadata is in the czi metadata export
czisubblock = str((resources / "s_3_t_1_c_3_z_5_subblock.xml").resolve(strict=True))
template = str((xslt / "czi-to-ome.xsl").resolve(strict=True))
output = Path("produced.ome.xml").resolve()

###############################################################################

# Parse template and generate transform function
template = ET.parse(template)
transform = ET.XSLT(template)

# Parse CZI XML
czixml = ET.parse(czixml)

# Attempt to run transform
try:
    ome = transform(czixml, subblock_file=ET.XSLT.strparam(czisubblock))

    # Write file
    with open(output, "w") as write_out:
        write_out.write(str(ome))

# Catch any exception
except Exception as e:
    print(f"Error: {e}")
    print("-" * 80)
    print("Full Log:")
    for entry in transform.error_log:
        print(f"{entry.filename}: {entry.line}, {entry.column}> {entry.message}>")
