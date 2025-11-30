<?php

namespace App\Controller;

use App\Entity\Commentaire;
use App\Entity\Defi;
use App\Form\CommentaireType;
use App\Form\DefiType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class DefiController extends AbstractController
{
    #[Route('/defi/{id}', name: 'app_defi_show')]
    public function show(Defi $defi, EntityManagerInterface $entityManager, Request $request): Response
    {

        $commentaires = $entityManager->getRepository(Commentaire::class)->findBy(
            ['defi' => $defi],
            ['date' => 'DESC']
        );


        $commentaire = new Commentaire();
        $form = $this->createForm(CommentaireType::class, $commentaire);
        $form->handleRequest($request);


        if ($form->isSubmitted() && $form->isValid()) {
            $user = $this->getUser();
            if (!$user) {
                return $this->redirectToRoute('app_login');
            }

            $commentaire->setUser($user);
            $commentaire->setDefi($defi);
            $commentaire->setDate(new \DateTime());
            $commentaire->setStatut('posté');

            /** @var \App\Entity\User $user */
            $commentaire->setTitle('Retour de ' . ($user->getName() ?? 'membre'));

            $entityManager->persist($commentaire);
            $entityManager->flush();

            $this->addFlash('success', 'Votre expérience a été partagée avec succès !');

            return $this->redirectToRoute('app_defi_show', ['id' => $defi->getId()]);
        }

        return $this->render('show.html.twig', [
            'defi' => $defi,
            'commentaires' => $commentaires,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/proposer-defi', name: 'app_defi_new')]
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();
        if (!$user) {
            $this->addFlash('error', 'Vous devez être connecté pour proposer un défi.');
            return $this->redirectToRoute('app_login');
        }

        $defi = new Defi();
        $form = $this->createForm(DefiType::class, $defi);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $defi->setAuthor($user);
            $defi->setStatut('en_attente');

            $entityManager->persist($defi);
            $entityManager->flush();

            $this->addFlash('success', 'Votre proposition a été envoyée ! Elle sera visible après validation par un administrateur.');

            return $this->redirectToRoute('app_home');
        }

        return $this->render('new.html.twig', [
            'form' => $form->createView(),
        ]);
    }


    #[Route('/defi/{id}/relever', name: 'app_defi_relever')]
    public function relever(Defi $defi): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        $this->addFlash('success', 'Bravo ! Vous avez relevé le défi "' . $defi->getTitle() . '". Bonne chance ! 🍀');

        return $this->redirectToRoute('app_defi_show', ['id' => $defi->getId()]);
    }

    #[Route('/defi/{id}/signaler', name: 'app_defi_signaler')]
    public function signaler(Defi $defi): Response
    {
        if (!$this->getUser()) {
            return $this->redirectToRoute('app_login');
        }

        $this->addFlash('warning', 'Merci. Ce défi a été signalé à la modération et sera vérifié rapidement.');

        return $this->redirectToRoute('app_defi_show', ['id' => $defi->getId()]);
    }
}