<?php

namespace App\Controller;

use App\Entity\Defi;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class AdminController extends AbstractController
{
    #[Route('/admin', name: 'app_admin')]
    public function index(EntityManagerInterface $entityManager): Response
    {

        if (!$this->getUser() || !$this->isGranted('ROLE_ADMIN')) {
            $this->addFlash('error', 'Accès refusé : Vous n\'êtes pas administrateur.');
            return $this->redirectToRoute('app_home');
        }


        $defisEnAttente = $entityManager->getRepository(Defi::class)->findBy(
            ['statut' => 'en_attente'],
            ['id' => 'DESC']
        );

        return $this->render('admin.html.twig', [
            'defis' => $defisEnAttente,
        ]);
    }

    #[Route('/defi/{id}/validate', name: 'app_admin_defi_validate')]
    public function validate(Defi $defi, EntityManagerInterface $entityManager): Response
    {

        if (!$this->isGranted('ROLE_ADMIN')) {
            return $this->redirectToRoute('app_home');
        }


        $defi->setStatut('realisable');
        $defi->setDateModeration(new \DateTime());

        $entityManager->flush();

        $this->addFlash('success', 'Le défi "' . $defi->getTitle() . '" a été validé et publié avec succès !');

        return $this->redirectToRoute('app_admin');
    }

    #[Route('/defi/{id}/delete', name: 'app_admin_defi_delete')]
    public function delete(Defi $defi, EntityManagerInterface $entityManager): Response
    {

        if (!$this->isGranted('ROLE_ADMIN')) {
            return $this->redirectToRoute('app_home');
        }


        $entityManager->remove($defi);
        $entityManager->flush();

        $this->addFlash('success', 'Le défi a été supprimé (refusé).');

        return $this->redirectToRoute('app_admin');
    }
}