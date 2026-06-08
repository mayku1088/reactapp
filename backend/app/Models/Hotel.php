<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Hotel extends Model
{
    use HasFactory;

    protected $table = 'hotel';

    protected $guarded = [];

    public function owns(): BelongsTo
    {
        return $this->belongsTo(User::class, 'owner', '_id');
    }
}
