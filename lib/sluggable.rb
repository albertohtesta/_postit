module Sluggable
	extend ActiveSupport::Concern
	
	included do
		before_save :generate_slug!
		class_attribute :slug_column
	end

	def to_param
		self.slug
	end

	def generate_slug!
		the_slug = to_slug(self.send(self.class.slug_column.to_sym))
		post = self.class.find_by slug: the_slug
		count = 2
		while post && post != self
			the_slug = append_suffix(the_slug, count)
			post = self.class.find_by slug: the_slug
			count += 1
		end
		self.slug = the_slug.downcase
	end

	def append_suffix(str1, count)
		if str1.split('-').last.to_i != 0
			return str1.split('-').slice(0...-1).join('-') + "-" + count.to_s
		else
			return str1 + "-" + count.to_s
		end
	end

	def to_slug(name)
		str1 = name.strip
		str1.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
		str1.gsub! /-+/,"-"
		return str1.downcase
	end

	module ClassMethods
		def sluggable_column(col_name)
			self.slug_column = col_name
		end
	end

end