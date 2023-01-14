﻿package ru.practicum.adminApi.comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.util.DefaultUriBuilderFactory;
import ru.practicum.client.BaseClient;

import java.util.Map;

@Service
public class CommentClientAdmin extends BaseClient {

    @Autowired
    public CommentClientAdmin(@Value("${main-service-server.url}") String serverUrl, RestTemplateBuilder builder) {
        super(
                builder
                        .uriTemplateHandler(new DefaultUriBuilderFactory(serverUrl + "/admin"))
                        .requestFactory(HttpComponentsClientHttpRequestFactory::new)
                        .build()
        );
    }

    public ResponseEntity<Object> deleteComment(Long commentId) {
        return delete("/comments/" + commentId);
    }

    public ResponseEntity<Object> changeAbilityToComment(Long eventId) {
        return patch("/events/" + eventId + "/comments");
    }

    public ResponseEntity<Object> getCommentsOneUser(Long userId, Integer from, Integer size) {
        Map<String, Object> parameters = Map.of(
                "from", from,
                "size", size
        );
        return get("/comments/" + userId, parameters);
    }
}
