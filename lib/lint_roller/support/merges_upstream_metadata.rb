module LintRoller
  module Support
    class MergesUpstreamMetadata
      def merge(plugin_yaml, upstream_yaml)
        result = plugin_yaml.dup

        upstream_yaml.each do |key, upstream_value|
          next unless result.key?(key)

          plugin_value = result[key]
          next unless plugin_value.is_a?(Hash) && upstream_value.is_a?(Hash)

          result[key] = plugin_value.merge(upstream_value) { |_sub_key, plugin_sub_value, _upstream_sub_value|
            plugin_sub_value
          }
        end

        result
      end
    end
  end
end
