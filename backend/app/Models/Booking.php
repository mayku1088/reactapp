<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Booking extends Model
{
    use HasFactory;

    protected $table = 'booking';

    protected $guarded = [];

    public function owns(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user', '_id');
    }

    public function roomm(): BelongsTo
    {
        return $this->belongsTo(Room::class, 'room');
    }

    public function hot(): BelongsTo
    {
        return $this->belongsTo(Hotel::class, 'hotel');
    }
}
