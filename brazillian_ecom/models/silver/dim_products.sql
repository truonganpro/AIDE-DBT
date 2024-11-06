SELECT
   rp.product_id,
   pcnt.product_category_name_english
FROM {{ ref('raw_products') }} AS rp
JOIN {{ ref('product_category_name_translation') }} AS pcnt
ON rp.product_category_name = pcnt.product_category_name