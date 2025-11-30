<?php

namespace App\Entity;

use App\Repository\CommentaireRepository;
use Doctrine\DBAL\Types\Types;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: CommentaireRepository::class)]
#[ORM\Table(name: 'commentaire')]
class Commentaire
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(name: 'commentaire_id')]
    private ?int $id = null;

    #[ORM\Column(length: 100)]
    private ?string $title = null;

    #[ORM\Column(type: Types::TEXT)]
    private ?string $text = null;

    #[ORM\Column(type: Types::DATETIME_MUTABLE)]
    private ?\DateTimeInterface $date = null;

    #[ORM\Column(length: 50)]
    private ?string $statut = null;

    #[ORM\Column(name: 'type_commentaire', length: 50)]
    private ?string $typeCommentaire = null;

    #[ORM\Column(name: 'date_moderation', type: Types::DATETIME_MUTABLE, nullable: true)]
    private ?\DateTimeInterface $dateModeration = null;

    #[ORM\ManyToOne(targetEntity: User::class)]
    #[ORM\JoinColumn(name: 'user_id', referencedColumnName: 'user_id', nullable: false)]
    private ?User $user = null;

    #[ORM\ManyToOne(targetEntity: Defi::class)]
    #[ORM\JoinColumn(name: 'defi_id', referencedColumnName: 'defi_id', nullable: true)]
    private ?Defi $defi = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }
    public function setTitle(string $title): static
    {
        $this->title = $title;
        return $this;
    }

    public function getText(): ?string
    {
        return $this->text;
    }
    public function setText(string $text): static
    {
        $this->text = $text;
        return $this;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }
    public function setDate(\DateTimeInterface $date): static
    {
        $this->date = $date;
        return $this;
    }

    public function getStatut(): ?string
    {
        return $this->statut;
    }
    public function setStatut(string $statut): static
    {
        $this->statut = $statut;
        return $this;
    }

    public function getTypeCommentaire(): ?string
    {
        return $this->typeCommentaire;
    }
    public function setTypeCommentaire(string $typeCommentaire): static
    {
        $this->typeCommentaire = $typeCommentaire;
        return $this;
    }

    public function getDateModeration(): ?\DateTimeInterface
    {
        return $this->dateModeration;
    }
    public function setDateModeration(?\DateTimeInterface $dateModeration): static
    {
        $this->dateModeration = $dateModeration;
        return $this;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }
    public function setUser(?User $user): static
    {
        $this->user = $user;
        return $this;
    }

    public function getDefi(): ?Defi
    {
        return $this->defi;
    }
    public function setDefi(?Defi $defi): static
    {
        $this->defi = $defi;
        return $this;
    }
}