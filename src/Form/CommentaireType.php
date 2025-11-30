<?php

namespace App\Form;

use App\Entity\Commentaire;
use App\Entity\Defi;
use App\Entity\User;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;

class CommentaireType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('text', TextareaType::class, [
                'label' => 'Votre message',
                'attr' => [
                    'placeholder' => 'Racontez comment s\'est passé votre défi...',
                    'rows' => 4,
                    'class' => 'form-control'
                ]
            ])
            ->add('typeCommentaire', ChoiceType::class, [
                'label' => 'Type de message',
                'choices' => [
                    'Partage d\'expérience' => 'experience',
                    'Demande d\'aide / Conseil' => 'aide',
                ],
                'expanded' => true,
                'multiple' => false,
                'attr' => ['class' => 'mb-3']
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Commentaire::class,
        ]);
    }
}
