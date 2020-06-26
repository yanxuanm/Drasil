/** DerivedValues.swift
    Provides the function for calculating derived values
    - Authors: Nikitha Krithnan and W. Spencer Smith
*/
import Foundation

/** Calculates values that can be immediately derived from the inputs
    - Parameter inParams: structure holding the input values
*/
func derived_values(_ inParams: inout InputParameters) throws -> Void {
    var outfile: FileHandle
    do {
        outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
        try outfile.seekToEnd()
    } catch {
        throw "Error opening file."
    }
    do {
        try outfile.write(contentsOf: Data("function derived_values called with inputs: {".utf8))
        try outfile.write(contentsOf: Data("\n".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data("  inParams = ".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data("Instance of InputParameters object".utf8))
        try outfile.write(contentsOf: Data("\n".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data("  }".utf8))
        try outfile.write(contentsOf: Data("\n".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.close()
    } catch {
        throw "Error closing file."
    }
    
    inParams.h = 1.0 / 1000.0 * (inParams.t == 2.5 ? 2.16 : inParams.t == 2.7 ? 2.59 : inParams.t == 3.0 ? 2.92 : inParams.t == 4.0 ? 3.78 : inParams.t == 5.0 ? 4.57 : inParams.t == 6.0 ? 5.56 : inParams.t == 8.0 ? 7.42 : inParams.t == 10.0 ? 9.02 : inParams.t == 12.0 ? 11.91 : inParams.t == 16.0 ? 15.09 : inParams.t == 19.0 ? 18.26 : 21.44)
    do {
        outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
        try outfile.seekToEnd()
    } catch {
        throw "Error opening file."
    }
    do {
        try outfile.write(contentsOf: Data("var 'inParams.h' assigned ".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(String(inParams.h).utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(" in module DerivedValues".utf8))
        try outfile.write(contentsOf: Data("\n".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.close()
    } catch {
        throw "Error closing file."
    }
    
    inParams.LDF = pow(3.0 / Double(60), 7.0 / Double(16))
    do {
        outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
        try outfile.seekToEnd()
    } catch {
        throw "Error opening file."
    }
    do {
        try outfile.write(contentsOf: Data("var 'inParams.LDF' assigned ".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(String(inParams.LDF).utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(" in module DerivedValues".utf8))
        try outfile.write(contentsOf: Data("\n".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.close()
    } catch {
        throw "Error closing file."
    }
    
    if inParams.g == "AN" {
        inParams.GTF = 1
        do {
            outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
            try outfile.seekToEnd()
        } catch {
            throw "Error opening file."
        }
        do {
            try outfile.write(contentsOf: Data("var 'inParams.GTF' assigned ".utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.write(contentsOf: Data(String(inParams.GTF).utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.write(contentsOf: Data(" in module DerivedValues".utf8))
            try outfile.write(contentsOf: Data("\n".utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.close()
        } catch {
            throw "Error closing file."
        }
    }
    else if inParams.g == "FT" {
        inParams.GTF = 4
        do {
            outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
            try outfile.seekToEnd()
        } catch {
            throw "Error opening file."
        }
        do {
            try outfile.write(contentsOf: Data("var 'inParams.GTF' assigned ".utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.write(contentsOf: Data(String(inParams.GTF).utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.write(contentsOf: Data(" in module DerivedValues".utf8))
            try outfile.write(contentsOf: Data("\n".utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.close()
        } catch {
            throw "Error closing file."
        }
    }
    else if inParams.g == "HS" {
        inParams.GTF = 2
        do {
            outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
            try outfile.seekToEnd()
        } catch {
            throw "Error opening file."
        }
        do {
            try outfile.write(contentsOf: Data("var 'inParams.GTF' assigned ".utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.write(contentsOf: Data(String(inParams.GTF).utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.write(contentsOf: Data(" in module DerivedValues".utf8))
            try outfile.write(contentsOf: Data("\n".utf8))
        } catch {
            throw "Error printing to file."
        }
        do {
            try outfile.close()
        } catch {
            throw "Error closing file."
        }
    }
    else {
        throw "Undefined case encountered in function GTF"
    }
    
    inParams.SD = sqrt(pow(inParams.SD_x, 2) + pow(inParams.SD_y, 2) + pow(inParams.SD_z, 2))
    do {
        outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
        try outfile.seekToEnd()
    } catch {
        throw "Error opening file."
    }
    do {
        try outfile.write(contentsOf: Data("var 'inParams.SD' assigned ".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(String(inParams.SD).utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(" in module DerivedValues".utf8))
        try outfile.write(contentsOf: Data("\n".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.close()
    } catch {
        throw "Error closing file."
    }
    
    inParams.AR = inParams.a / inParams.b
    do {
        outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
        try outfile.seekToEnd()
    } catch {
        throw "Error opening file."
    }
    do {
        try outfile.write(contentsOf: Data("var 'inParams.AR' assigned ".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(String(inParams.AR).utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(" in module DerivedValues".utf8))
        try outfile.write(contentsOf: Data("\n".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.close()
    } catch {
        throw "Error closing file."
    }
    
    inParams.w_TNT = inParams.w * inParams.TNT
    do {
        outfile = try FileHandle(forWritingTo: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("log.txt"))
        try outfile.seekToEnd()
    } catch {
        throw "Error opening file."
    }
    do {
        try outfile.write(contentsOf: Data("var 'inParams.w_TNT' assigned ".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(String(inParams.w_TNT).utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.write(contentsOf: Data(" in module DerivedValues".utf8))
        try outfile.write(contentsOf: Data("\n".utf8))
    } catch {
        throw "Error printing to file."
    }
    do {
        try outfile.close()
    } catch {
        throw "Error closing file."
    }
}
