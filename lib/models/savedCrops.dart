 // SavedCrops
 class SavedCrops {
   int? id;
   int? quantity;
   String? name;
   String? image;
   int? sellingPrice;
   String? quantityUnit;
   String? description;
   int? isSold;
   String? location;

   SavedCrops(
       {this.id,
         this.quantity,
         this.name,
         this.image,
         this.sellingPrice,
         this.quantityUnit,
         this.description,
         this.isSold,
         this.location});

   SavedCrops.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     quantity = json['quantity'];
     name = json['name'];
     image = json['image'];
     sellingPrice = json['selling_price'];
     quantityUnit = json['quantity_unit'];
     description = json['description'];
     isSold = json['is_sold'];
     location = json['location'];
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id'] = this.id;
     data['quantity'] = this.quantity;
     data['name'] = this.name;
     data['image'] = this.image;
     data['selling_price'] = this.sellingPrice;
     data['quantity_unit'] = this.quantityUnit;
     data['description'] = this.description;
     data['is_sold'] = this.isSold;
     data['location'] = this.location;
     return data;
   }
 }