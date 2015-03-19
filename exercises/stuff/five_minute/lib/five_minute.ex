defmodule FiveMinute do


  people = DB.find_customers
  orders = Orders.for_customers(people)
  tax    = sales_tax(orders, 2013)
  filing = prepare_filing(tax)

  filing = prepare_filing(sales_tax(Orders.for_customers(DB.find_customers)))
  

  filing = DB.find_customers
           |> Orders.for_customers
           |> sales_tax(2013)
           |> prepare_filing
end
