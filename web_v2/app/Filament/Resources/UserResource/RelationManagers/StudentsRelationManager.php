<?php

namespace App\Filament\Resources\UserResource\RelationManagers;

use App\Filament\Resources\AngkatanResource;
use App\Filament\Resources\KelasResource;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class StudentsRelationManager extends RelationManager
{
    protected static string $relationship = 'student';

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('no_induk')
                    ->required()
                    ->maxLength(255),
                Forms\Components\Select::make('angkatan_id')
                    ->relationship('angkatan', 'tahun')
                    ->searchable()
                    ->preload()
                    ->createOptionForm([
                        AngkatanResource::getTahunFormField(),
                    ])
                    ->required(),
                Forms\Components\Select::make('kelas_id')
                    ->relationship('kelas', 'name')
                    ->searchable()
                    ->preload()
                    ->createOptionForm([
                        KelasResource::getNameFormField(),
                    ])
                    ->required(),
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('no_induk')
            ->columns([
                Tables\Columns\TextColumn::make('no_induk'),
            ])
            ->filters([
                //
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make(),
                Tables\Actions\AssociateAction::make(),
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
                Tables\Actions\DissociateAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DissociateBulkAction::make(),
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }
}
