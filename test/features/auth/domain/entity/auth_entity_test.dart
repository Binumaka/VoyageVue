import 'package:flutter_test/flutter_test.dart';
import 'package:voyagevue/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthEntity', () {
    test('should be equal when all fields are the same', () {
      final user1 = AuthEntity(
        userId: '123',
        email: 'john.doe@example.com',
        image: 'image.png',
        role: 'admin',
        username: 'john_doe',
        password: 'password123',
      );

      final user2 = AuthEntity(
        userId: '123',
        email: 'john.doe@example.com',
        image: 'image.png',
        role: 'admin',
        username: 'john_doe',
        password: 'password123',
      );

      expect(user1, equals(user2)); // They should be equal
    });

    test('should not be equal when fields differ', () {
      final user1 = AuthEntity(
        userId: '123',
        email: 'john.doe@example.com',
        image: 'image.png',
        role: 'admin',
        username: 'john_doe',
        password: 'password123',
      );

      final user2 = AuthEntity(
        userId: '124', // Different userId
        email: 'john.doe@example.com',
        image: 'image.png',
        role: 'admin',
        username: 'john_doe',
        password: 'password123',
      );

      expect(user1, isNot(equals(user2))); // They should not be equal
    });

    test('should have default role as "user"', () {
      final user = AuthEntity(
        email: 'john.doe@example.com',
        username: 'john_doe',
        password: 'password123',
      );

      expect(user.role, 'user'); // Default role should be 'user'
    });

    test('should not allow changes to properties after creation', () {
    });
  });
}
