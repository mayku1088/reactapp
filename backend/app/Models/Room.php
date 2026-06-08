<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Room extends Model
{
    use HasFactory;

    protected $table = 'room';

    protected $casts = [
        'amenities' => 'array',
        'images' => 'array',
        'is_available' => 'boolean',
    ];

    protected $appends = ['hotel_image_url'];

    protected $guarded = [];

    public function hotel(): BelongsTo
    {
        return $this->belongsTo(Hotel::class, 'hotel');
    }

    public function getHotelImageUrlAttribute()
    {
        $company_images = [];

        foreach ($this->images as $image) {
            if (!empty($image)) {
                $company_image[] = asset("/storage/images/" . $image);
            }
        }

        return $company_image;
    }
}
