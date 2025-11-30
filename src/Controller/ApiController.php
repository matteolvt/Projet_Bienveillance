<?php

namespace App\Controller;

use App\Repository\DefiRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

#[Route('/api', name: 'api_')]
class ApiController extends AbstractController
{
    #[Route('/defi/random', name: 'defi_random', methods: ['GET'])]
    public function random(DefiRepository $defiRepository): Response
    {
        $defi = $defiRepository->findRandomDefi();

        if (!$defi) {
            return $this->json([
                'error' => 'Aucun défi disponible pour le moment.'
            ], 404);
        }


        $data = [
            'id' => $defi->getId(),
            'titre' => $defi->getTitle(),
            'description' => $defi->getDescription(),
            'auteur' => $defi->getAuthor() ? $defi->getAuthor()->getName() : 'Anonyme',
            'date_validation' => $defi->getDateModeration() ? $defi->getDateModeration()->format('Y-m-d H:i:s') : null,
        ];


        $response = $this->json($data);


        $response->setEncodingOptions($response->getEncodingOptions() | JSON_UNESCAPED_UNICODE);

        $response->headers->set('Content-Type', 'application/json; charset=utf-8');

        return $response;
    }
}