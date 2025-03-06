import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voyagevue/features/bucketlist/domain/entity/bucketlist_entity.dart';
import 'package:voyagevue/features/bucketlist/domain/repository/Bucketlist_repository.dart';

part 'bucketlist_event.dart';
part 'bucketlist_state.dart';

class BucketlistBloc extends Bloc<BucketlistEvent, BucketlistState> {
  final IBucketlistRepository bucketlistRepository;

  BucketlistBloc(this.bucketlistRepository) : super(BucketlistInitial()) {
    on<LoadBucketlist>((event, emit) async {
      emit(BucketlistLoading());
      try {
        final bucketlist = await bucketlistRepository.getBucketlist(event.userId);
        print("Fetched Bucketlist: $bucketlist");
        emit(BucketlistLoaded(bucketlist));
      } catch (e) {
        emit(BucketlistError('Failed to load Bucketlist: $e'));
      }
    });

    on<RemoveFromBucketlist>((event, emit) async {
      try {
        emit(BucketlistLoading());
        await bucketlistRepository.removeFromBucketlist(event.id);
        final updatedBucketlist = await bucketlistRepository.getBucketlist(event.id);
        emit(BucketlistLoaded(updatedBucketlist));
      } catch (e) {
        emit(BucketlistError('Failed to remove item from wishlist: $e'));
      }
    });

    on<AddToBucketlist>((event, emit) async {
      try {
        emit(BucketlistLoading());
        await bucketlistRepository.addToBucketlist(
          BucketListEntity(
            title: event.title,
            image: event.image,
            id: '',
            description: '',
          ),
        );

        final updatedBucketlist =
            await bucketlistRepository.getBucketlist(event.title);
        emit(BucketlistLoaded(updatedBucketlist));
      } catch (e) {
        emit(BucketlistError('Failed to add item to bucketlist: $e'));
      }
    });
  }
}
