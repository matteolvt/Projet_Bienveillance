<?php

namespace App\Repository;

use App\Entity\Defi;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Defi>
 */
class DefiRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Defi::class);
    }

    /**
     * @param int|null $excludedId 
     */
    public function findRandomDefi(?int $excludedId = null): ?Defi
    {

        $defis = $this->findBy(['statut' => 'realisable']);

        if (empty($defis)) {
            return null;
        }

        if ($excludedId) {
            $filteredDefis = array_filter($defis, function (Defi $defi) use ($excludedId) {
                return $defi->getId() !== $excludedId;
            });

            if (!empty($filteredDefis)) {
                $defis = array_values($filteredDefis);
            }
        }

        $randomKey = array_rand($defis);

        return $defis[$randomKey];
    }
}