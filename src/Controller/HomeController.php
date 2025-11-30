<?php

namespace App\Controller;

use App\Repository\DefiRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'app_home')]
    public function index(DefiRepository $defiRepository, Request $request): Response
    {
        $previousId = $request->query->get('previous');

        $defi = $defiRepository->findRandomDefi((int) $previousId);

        return $this->render('index.html.twig', [
            'controller_name' => 'HomeController',
            'defi' => $defi,
        ]);
    }
}