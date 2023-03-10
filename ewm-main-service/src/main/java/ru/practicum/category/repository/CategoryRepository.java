package ru.practicum.category.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.practicum.category.model.Category;

import java.util.Collection;
import java.util.List;


public interface CategoryRepository extends JpaRepository<Category, Long> {

    Collection<Category> findAllByIdIn(List<Long> collectionId);
}
