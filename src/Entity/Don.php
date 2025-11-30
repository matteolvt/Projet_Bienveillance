<?php

namespace App\Entity;

use App\Repository\DonRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: DonRepository::class)]
#[ORM\Table(name: 'don')]
class Don
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(name: 'don_id')]
    private ?int $id = null;

    #[ORM\Column]
    private ?float $montant = null;

    #[ORM\Column(type: 'boolean')]
    private ?bool $anonyme = null;

    #[ORM\ManyToOne(targetEntity: User::class)]
    #[ORM\JoinColumn(name: 'user_id', referencedColumnName: 'user_id', nullable: false)]
    private ?User $user = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getMontant(): ?float
    {
        return $this->montant;
    }
    public function setMontant(float $montant): static
    {
        $this->montant = $montant;
        return $this;
    }

    public function isAnonyme(): ?bool
    {
        return $this->anonyme;
    }
    public function setAnonyme(bool $anonyme): static
    {
        $this->anonyme = $anonyme;
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
}