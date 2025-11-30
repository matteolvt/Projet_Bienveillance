<?php

namespace App\Entity;

use App\Repository\DefiPropositionRepository;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: DefiPropositionRepository::class)]
#[ORM\Table(name: 'defi_proposition')]
class DefiProposition
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(name: 'defi_proposition_id')]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: Defi::class)]
    #[ORM\JoinColumn(name: 'defi_id', referencedColumnName: 'defi_id', nullable: false)]
    private ?Defi $defi = null;

    #[ORM\ManyToOne(targetEntity: User::class)]
    #[ORM\JoinColumn(name: 'user_id', referencedColumnName: 'user_id', nullable: false)]
    private ?User $user = null;

    public function getId(): ?int
    {
        return $this->id;
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