Return-Path: <linux-tip-commits+bounces-7565-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C01C95BEB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 01 Dec 2025 07:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B533A2945
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Dec 2025 06:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810BC222587;
	Mon,  1 Dec 2025 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qw6Joz0+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bZ030SbF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE2321D5AF;
	Mon,  1 Dec 2025 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764568885; cv=none; b=O3wYJZOMYQePUhmrlsoxVzE7jc8N/VKvFDAwYAVcDV8uZ2wNzGTL/4apP6O1ITeQpF5Q4fBmwm26PePj6rAtV2iaHCJDX6TGGGizv+OtnTYKXCXyGttqZtMRXugXglOE9dwGf06WlRsnw2MUYqz6v685PTK1w72FxBMuwH9MR3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764568885; c=relaxed/simple;
	bh=bE6sWyeOKD7BHfoV06cJXOgQYnrim/NmikYSUAJbZbM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eSeE8S/R1OJehHSLcHi0zFNBvVM0oREcyXsWRz3Ou5GrEp8t9TWKO1xpwLdpY/m9FcUkZwMuiHPFp34mchBcF8RFZmSrjEoiAHuebPHvJgGianNYSW2p/cLYSHqdiwdnyBgrNe/BOnYLPyKx5qXfKj9FiJwXWL69j8XFfVQmYdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qw6Joz0+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bZ030SbF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Dec 2025 06:01:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764568876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GtaqN/oCTXtyCF/C8WeLK8Ref2vIFG1C1vk9st7Oqw=;
	b=Qw6Joz0+aY6W2jOTSgLY3O6jnh4D1nW3SKypp8vM/ZEtUbu8XjT3L0Yko2rzh4RTRXAjVp
	SrfzI381i8cO2hZ2JEtnZPSqZHN2QfD4pVRhiIV0nAJjCXQhHtb0xDx0OKnxueP0wNzMg5
	P3CNIq+dbtFZcBI1sSHWN+foj1nYCjpDnVIhzIcd8i/jEag/ppvEnnUQ0rLMmMrhJjUMuG
	qoYjaTAAkOG8goKECGgNMFJ0dpUdP7vfgxf2CH/TbUuCZn0H60ZjWLaHgDrkONPCf/WYBp
	SXGpkaQbhqDPcWDyKYUY6j0QypWg1v4WTszw5kTngbNMvmIRBxL2vof6u7h7JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764568876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6GtaqN/oCTXtyCF/C8WeLK8Ref2vIFG1C1vk9st7Oqw=;
	b=bZ030SbF9Df4q5UI6zD4tvVWOP4o8wA+HFJxWjbUML6NIL/VkMCBx7I3Mvaq46ejfkJ6ic
	IZaWcRpz8qiXhNAw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Redo __mutex_init() to reduce
 generated code size
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251105142350.Tfeevs2N@linutronix.de>
References: <20251105142350.Tfeevs2N@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176456887481.498.15614079015252433650.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     51d7a054521de7085783a9a1ba15c3530863409a
Gitweb:        https://git.kernel.org/tip/51d7a054521de7085783a9a1ba15c353086=
3409a
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 05 Nov 2025 15:23:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Dec 2025 06:51:57 +01:00

locking/mutex: Redo __mutex_init() to reduce generated code size

mutex_init() invokes __mutex_init() providing the name of the lock and
a pointer to a the lock class. With LOCKDEP enabled this information is
useful but without LOCKDEP it not used at all. Passing the pointer
information of the lock class might be considered negligible but the
name of the lock is passed as well and the string is stored. This
information is wasting storage.

Split __mutex_init() into a _genereic() variant doing the initialisation
of the lock and a _lockdep() version which does _genereic() plus the
lockdep bits. Restrict the lockdep version to lockdep enabled builds
allowing the compiler to remove the unused parameter.

This results in the following size reduction:

        text     data       bss        dec  filename
  | 30237599  8161430   1176624   39575653  vmlinux.defconfig
  | 30233269  8149142   1176560   39558971  vmlinux.defconfig.patched
     -4.2KiB   -12KiB

  | 32455099  8471098  12934684   53860881  vmlinux.defconfig.lockdep
  | 32455100  8471098  12934684   53860882  vmlinux.defconfig.patched.lockdep

  | 27152407  7191822   2068040   36412269  vmlinux.defconfig.preempt_rt
  | 27145937  7183630   2067976   36397543  vmlinux.defconfig.patched.preempt=
_rt
     -6.3KiB    -8KiB

  | 29382020  7505742  13784608   50672370  vmlinux.defconfig.preempt_rt.lock=
dep
  | 29376229  7505742  13784544   50666515  vmlinux.defconfig.patched.preempt=
_rt.lockdep
     -5.6KiB

[peterz: folded fix from boqun]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20251125145425.68319-1-boqun.feng@gmail.com
Link: https://patch.msgid.link/20251105142350.Tfeevs2N@linutronix.de
---
 include/linux/mutex.h        | 45 +++++++++++++++++++++++++++--------
 kernel/locking/mutex-debug.c | 10 +--------
 kernel/locking/mutex.c       | 28 +++++++++++++++++-----
 kernel/locking/mutex.h       |  5 +---
 kernel/locking/rtmutex_api.c | 19 +++++++++++----
 5 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 847b81c..bf535f0 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -86,8 +86,23 @@ do {									\
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname =3D __MUTEX_INITIALIZER(mutexname)
=20
-extern void __mutex_init(struct mutex *lock, const char *name,
-			 struct lock_class_key *key);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void mutex_init_lockep(struct mutex *lock, const char *name, struct lock_cla=
ss_key *key);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_init_lockep(lock, name, key);
+}
+#else
+extern void mutex_init_generic(struct mutex *lock);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_init_generic(lock);
+}
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 /**
  * mutex_is_locked - is the mutex locked
@@ -111,17 +126,27 @@ extern bool mutex_is_locked(struct mutex *lock);
 #define DEFINE_MUTEX(mutexname)						\
 	struct mutex mutexname =3D __MUTEX_INITIALIZER(mutexname)
=20
-extern void __mutex_rt_init(struct mutex *lock, const char *name,
-			    struct lock_class_key *key);
-
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
=20
-#define __mutex_init(mutex, name, key)			\
-do {							\
-	rt_mutex_base_init(&(mutex)->rtmutex);		\
-	__mutex_rt_init((mutex), name, key);		\
-} while (0)
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void mutex_rt_init_lockdep(struct mutex *mutex, const char *name,
+			     struct lock_class_key *key);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_rt_init_lockdep(lock, name, key);
+}
=20
+#else
+extern void mutex_rt_init_generic(struct mutex *mutex);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_rt_init_generic(lock);
+}
+#endif /* !CONFIG_LOCKDEP */
 #endif /* CONFIG_PREEMPT_RT */
=20
 #ifdef CONFIG_DEBUG_MUTEXES
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 949103f..2c6b02d 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -78,16 +78,8 @@ void debug_mutex_unlock(struct mutex *lock)
 	}
 }
=20
-void debug_mutex_init(struct mutex *lock, const char *name,
-		      struct lock_class_key *key)
+void debug_mutex_init(struct mutex *lock)
 {
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	/*
-	 * Make sure we are not reinitializing a held lock:
-	 */
-	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
-#endif
 	lock->magic =3D lock;
 }
=20
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index de7d670..2a1d165 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -43,8 +43,7 @@
 # define MUTEX_WARN_ON(cond)
 #endif
=20
-void
-__mutex_init(struct mutex *lock, const char *name, struct lock_class_key *ke=
y)
+static void __mutex_init_generic(struct mutex *lock)
 {
 	atomic_long_set(&lock->owner, 0);
 	raw_spin_lock_init(&lock->wait_lock);
@@ -52,10 +51,8 @@ __mutex_init(struct mutex *lock, const char *name, struct =
lock_class_key *key)
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
 #endif
-
-	debug_mutex_init(lock, name, key);
+	debug_mutex_init(lock);
 }
-EXPORT_SYMBOL(__mutex_init);
=20
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
@@ -142,6 +139,11 @@ static inline bool __mutex_trylock(struct mutex *lock)
  * There is nothing that would stop spreading the lockdep annotations outwar=
ds
  * except more code.
  */
+void mutex_init_generic(struct mutex *lock)
+{
+	__mutex_init_generic(lock);
+}
+EXPORT_SYMBOL(mutex_init_generic);
=20
 /*
  * Optimistic trylock that only works in the uncontended case. Make sure to
@@ -166,7 +168,21 @@ static __always_inline bool __mutex_unlock_fast(struct m=
utex *lock)
=20
 	return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
 }
-#endif
+
+#else /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+void mutex_init_lockep(struct mutex *lock, const char *name, struct lock_cla=
ss_key *key)
+{
+	__mutex_init_generic(lock);
+
+	/*
+	 * Make sure we are not reinitializing a held lock:
+	 */
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(mutex_init_lockep);
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
 {
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 2e8080a..9ad4da8 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -59,8 +59,7 @@ extern void debug_mutex_add_waiter(struct mutex *lock,
 extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waite=
r *waiter,
 				      struct task_struct *task);
 extern void debug_mutex_unlock(struct mutex *lock);
-extern void debug_mutex_init(struct mutex *lock, const char *name,
-			     struct lock_class_key *key);
+extern void debug_mutex_init(struct mutex *lock);
 #else /* CONFIG_DEBUG_MUTEXES */
 # define debug_mutex_lock_common(lock, waiter)		do { } while (0)
 # define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
@@ -68,6 +67,6 @@ extern void debug_mutex_init(struct mutex *lock, const char=
 *name,
 # define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
 # define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
 # define debug_mutex_unlock(lock)			do { } while (0)
-# define debug_mutex_init(lock, name, key)		do { } while (0)
+# define debug_mutex_init(lock)				do { } while (0)
 #endif /* !CONFIG_DEBUG_MUTEXES */
 #endif /* CONFIG_PREEMPT_RT */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index bafd5af..59dbd29 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -515,13 +515,11 @@ void rt_mutex_debug_task_free(struct task_struct *task)
=20
 #ifdef CONFIG_PREEMPT_RT
 /* Mutexes */
-void __mutex_rt_init(struct mutex *mutex, const char *name,
-		     struct lock_class_key *key)
+static void __mutex_rt_init_generic(struct mutex *mutex)
 {
+	rt_mutex_base_init(&mutex->rtmutex);
 	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
-	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
 }
-EXPORT_SYMBOL(__mutex_rt_init);
=20
 static __always_inline int __mutex_lock_common(struct mutex *lock,
 					       unsigned int state,
@@ -542,6 +540,13 @@ static __always_inline int __mutex_lock_common(struct mu=
tex *lock,
 }
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
+void mutex_rt_init_lockdep(struct mutex *mutex, const char *name, struct loc=
k_class_key *key)
+{
+	__mutex_rt_init_generic(mutex);
+	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(mutex_rt_init_lockdep);
+
 void __sched mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
@@ -598,6 +603,12 @@ int __sched _mutex_trylock_nest_lock(struct mutex *lock,
 EXPORT_SYMBOL_GPL(_mutex_trylock_nest_lock);
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
=20
+void mutex_rt_init_generic(struct mutex *mutex)
+{
+	__mutex_rt_init_generic(mutex);
+}
+EXPORT_SYMBOL(mutex_rt_init_generic);
+
 void __sched mutex_lock(struct mutex *lock)
 {
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);

