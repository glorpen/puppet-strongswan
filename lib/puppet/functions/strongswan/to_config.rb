require 'json'

Puppet::Functions.create_function(:'strongswan::to_config') do
    dispatch :to_config do
        param 'Hash', :data
    end

    def to_config(data, key=nil, level=0)
        padding_str = "  " * [level - 1, 0].max
    
        if data.is_a?(Hash)
            value = data.map do |child_key, child_value|
                to_config(child_value, child_key, level+1)
            end.join("\n")
    
            if key === nil
                return value
            else
                # handle section extends
                if key.is_a?(Array)
                    section = "#{key[0]} : #{key[1..].join(', ')}"
                else
                    section = key
                end
    
                return "#{padding_str}#{section} {\n#{value}\n#{padding_str}}"
            end
        end
    
        # handle special key "include"
        if key == 'include'
            if data.is_a?(Array)
                return data.map do |value|
                    "#{padding_str}#{key} #{::JSON.dump(value.to_s)}"
                end.join("\n")
            else
                return "#{padding_str}#{key} #{::JSON.dump(data.to_s)}"
            end
        end
    
        if data.is_a?(Array)
            return "#{padding_str}#{key} = " + ::JSON.dump(data.map do |v|
                to_config(v, nil, level + 1)
            end.join(","))
        end
    
        if key
            "#{padding_str}#{key} = #{::JSON.dump(data.to_s)}"
        else
            data.to_s
        end
    end
end
