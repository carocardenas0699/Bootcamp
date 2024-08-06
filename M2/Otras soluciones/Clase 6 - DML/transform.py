import pandas as pd

def hash_function(key):
    return sum(index * ord(character) for index, character in enumerate(repr(key), start=1))

df = pd.read_csv("Sales Transaction v.4a.csv")

df = df.head(10000)

df['Country_id'] = df['Country'].apply(hash_function)
df['product_id'] = df['ProductNo']

df_country=df[['Country_id','Country']].drop_duplicates()
df_country.to_csv('country.csv',index=False)

df_product = df[['product_id','ProductName','Price']].drop_duplicates(subset='product_id')

df_product.to_csv('producto.csv', index=False)

df = df[['product_id', 'Price','Quantity', 'CustomerNo', 'Country_id']]

df.to_csv('Transaction.csv', index=False)