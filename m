Return-Path: <linux-tip-commits+bounces-5683-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81065ABF3B4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E394E5BC1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C21264A83;
	Wed, 21 May 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqlK75BK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="irRT2oZr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F8266F00;
	Wed, 21 May 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829175; cv=none; b=L6veK+BObpiuKMPR8LRnJfZYfLBi3Wc5nMiRLngE0dEvOvR2czSzIqcS7v/6RF/f3Pvkn42IoB3iVP3KZsZM+NSow0OkdlFGxLw9v/+3IbodskIdb0NqqDa/AvUwPlW+qXh/ZIGGeO5atgp9E08O6F4Mv45igCUwTGH28ME4pDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829175; c=relaxed/simple;
	bh=HjWX2zcKFZirLuEA09aedjy3tKmbHnhy21p4Cf6CxsQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L2E60G4PdbSfuQgVYNv6sOQ+nFgk9ZwJNd5tbAfOlvACILoooaBM9RWbAtkGGaytROPbPOSSDuLIirw1Mp/QthJopApxJJkptGum2VGUMfbIos0vyoyxsOSiIZn3165KdJctWGz0BEIKVgiBFBmdhsEAkopN2cTgrl6O9Dyodjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqlK75BK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=irRT2oZr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:06:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LrjNymgOI1vygZde0ghk7LLjdcruG9FkREDRt3oC2g=;
	b=aqlK75BKT/Han0zq9gQB4sIqh7phWAlozuJQlRCH43n2C5wn0iOlbnEczO/nQVWg99bBCv
	f35/MYLtVKwKmpyYbLxatHybg0aaytlnDt/LQ7HpnCsVFXna3aUaBL/tLqt0jiZfqcSNdl
	bDo+xFWw0/JuMFlIchaD8RH0scaJFggARZdEk0O1o1QTsOi6tfm4nSGgH9QnExmjfoEYFY
	ds99vHU2NEiUvoY332BcoUb/sM3hr4cIeaSiCNm8ABmj6jkeAKByUecP8Fk9Kd3lBI/4cD
	r9uMLbmFr478wk+xYPif4CAhfYaKo3WGIt08Ve9PKr6L3ekTiAucDC/xJa5+ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829171;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+LrjNymgOI1vygZde0ghk7LLjdcruG9FkREDRt3oC2g=;
	b=irRT2oZrHGid6DxiFjttc/kBsu9EGtZxWZEJtQ7SSaI5lcpqjRXT8aaR5+IeJRw8YSP2Yl
	7h+/fEsnSyTiB2BA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] selftests/futex: Use TAP output in futex_priv_hash
Cc: andrealmeid@igalia.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250517151455.1065363-2-bigeasy@linutronix.de>
References: <20250517151455.1065363-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782917007.406.15972596392264390144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     2b7363602973d1073f0e1775698fa62477a9a495
Gitweb:        https://git.kernel.org/tip/2b7363602973d1073f0e1775698fa62477a=
9a495
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 17 May 2025 17:14:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:40 +02:00

selftests/futex: Use TAP output in futex_priv_hash

Use TAP output for easier automated testing.

Suggested-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/20250517151455.1065363-2-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 148 ++-----
 1 file changed, 62 insertions(+), 86 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index 4d37650..72a621d 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -51,15 +51,16 @@ static void futex_hash_slots_set_verify(int slots)
=20
 	ret =3D futex_hash_slots_set(slots, 0);
 	if (ret !=3D 0) {
-		error("Failed to set slots to %d\n", errno, slots);
-		exit(1);
+		ksft_test_result_fail("Failed to set slots to %d: %m\n", slots);
+		ksft_finished();
 	}
 	ret =3D futex_hash_slots_get();
 	if (ret !=3D slots) {
-		error("Set %d slots but PR_FUTEX_HASH_GET_SLOTS returns: %d\n",
-		       errno, slots, ret);
-		exit(1);
+		ksft_test_result_fail("Set %d slots but PR_FUTEX_HASH_GET_SLOTS returns: %=
d, %m\n",
+		       slots, ret);
+		ksft_finished();
 	}
+	ksft_test_result_pass("SET and GET slots %d passed\n", slots);
 }
=20
 static void futex_hash_slots_set_must_fail(int slots, int immutable)
@@ -67,12 +68,8 @@ static void futex_hash_slots_set_must_fail(int slots, int =
immutable)
 	int ret;
=20
 	ret =3D futex_hash_slots_set(slots, immutable);
-	if (ret < 0)
-		return;
-
-	fail("futex_hash_slots_set(%d, %d) expected to fail but succeeded.\n",
-	       slots, immutable);
-	exit(1);
+	ksft_test_result(ret < 0, "futex_hash_slots_set(%d, %d)\n",
+			 slots, immutable);
 }
=20
 static void *thread_return_fn(void *arg)
@@ -97,10 +94,8 @@ static void create_max_threads(void *(*thread_fn)(void *))
=20
 	for (i =3D 0; i < MAX_THREADS; i++) {
 		ret =3D pthread_create(&threads[i], NULL, thread_fn, NULL);
-		if (ret) {
-			error("pthread_create failed\n", errno);
-			exit(1);
-		}
+		if (ret)
+			ksft_exit_fail_msg("pthread_create failed: %m\n");
 	}
 }
=20
@@ -110,10 +105,8 @@ static void join_max_threads(void)
=20
 	for (i =3D 0; i < MAX_THREADS; i++) {
 		ret =3D pthread_join(threads[i], NULL);
-		if (ret) {
-			error("pthread_join failed for thread %d\n", errno, i);
-			exit(1);
-		}
+		if (ret)
+			ksft_exit_fail_msg("pthread_join failed for thread %d\n", i);
 	}
 }
=20
@@ -127,6 +120,9 @@ static void usage(char *prog)
 	       VQUIET, VCRITICAL, VINFO);
 }
=20
+static const char *test_msg_auto_create =3D "Automatic hash bucket init on t=
hread creation.\n";
+static const char *test_msg_auto_inc =3D "Automatic increase with more than =
16 CPUs\n";
+
 int main(int argc, char *argv[])
 {
 	int futex_slots1, futex_slotsn, online_cpus;
@@ -156,56 +152,50 @@ int main(int argc, char *argv[])
 		}
 	}
=20
+	ksft_print_header();
+	ksft_set_plan(22);
=20
 	ret =3D pthread_mutexattr_init(&mutex_attr_pi);
 	ret |=3D pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHERIT=
);
 	ret |=3D pthread_mutex_init(&global_lock, &mutex_attr_pi);
 	if (ret !=3D 0) {
-		fail("Failed to initialize pthread mutex.\n");
-		return 1;
+		ksft_exit_fail_msg("Failed to initialize pthread mutex.\n");
 	}
-
 	/* First thread, expect to be 0, not yet initialized */
 	ret =3D futex_hash_slots_get();
-	if (ret !=3D 0) {
-		error("futex_hash_slots_get() failed: %d\n", errno, ret);
-		return 1;
-	}
+	if (ret !=3D 0)
+		ksft_exit_fail_msg("futex_hash_slots_get() failed: %d, %m\n", ret);
+
 	ret =3D futex_hash_immutable_get();
-	if (ret !=3D 0) {
-		error("futex_hash_immutable_get() failed: %d\n", errno, ret);
-		return 1;
-	}
+	if (ret !=3D 0)
+		ksft_exit_fail_msg("futex_hash_immutable_get() failed: %d, %m\n", ret);
=20
+	ksft_test_result_pass("Basic get slots and immutable status.\n");
 	ret =3D pthread_create(&threads[0], NULL, thread_return_fn, NULL);
-	if (ret !=3D 0) {
-		error("pthread_create() failed: %d\n", errno, ret);
-		return 1;
-	}
+	if (ret !=3D 0)
+		ksft_exit_fail_msg("pthread_create() failed: %d, %m\n", ret);
+
 	ret =3D pthread_join(threads[0], NULL);
-	if (ret !=3D 0) {
-		error("pthread_join() failed: %d\n", errno, ret);
-		return 1;
-	}
+	if (ret !=3D 0)
+		ksft_exit_fail_msg("pthread_join() failed: %d, %m\n", ret);
+
 	/* First thread, has to initialiaze private hash */
 	futex_slots1 =3D futex_hash_slots_get();
 	if (futex_slots1 <=3D 0) {
-		fail("Expected > 0 hash buckets, got: %d\n", futex_slots1);
-		return 1;
+		ksft_print_msg("Current hash buckets: %d\n", futex_slots1);
+		ksft_exit_fail_msg(test_msg_auto_create);
 	}
=20
+	ksft_test_result_pass(test_msg_auto_create);
+
 	online_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS + 1);
-	if (ret !=3D 0) {
-		error("pthread_barrier_init failed.\n", errno);
-		return 1;
-	}
+	if (ret !=3D 0)
+		ksft_exit_fail_msg("pthread_barrier_init failed: %m.\n");
=20
 	ret =3D pthread_mutex_lock(&global_lock);
-	if (ret !=3D 0) {
-		error("pthread_mutex_lock failed.\n", errno);
-		return 1;
-	}
+	if (ret !=3D 0)
+		ksft_exit_fail_msg("pthread_mutex_lock failed: %m.\n");
=20
 	counter =3D 0;
 	create_max_threads(thread_lock_fn);
@@ -215,14 +205,17 @@ int main(int argc, char *argv[])
 	 * The current default size of hash buckets is 16. The auto increase
 	 * works only if more than 16 CPUs are available.
 	 */
+	ksft_print_msg("Online CPUs: %d\n", online_cpus);
 	if (online_cpus > 16) {
 		futex_slotsn =3D futex_hash_slots_get();
 		if (futex_slotsn < 0 || futex_slots1 =3D=3D futex_slotsn) {
-			fail("Expected increase of hash buckets but got: %d -> %d\n",
-			      futex_slots1, futex_slotsn);
-			info("Online CPUs: %d\n", online_cpus);
-			return 1;
+			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
+				       futex_slots1, futex_slotsn);
+			ksft_exit_fail_msg(test_msg_auto_inc);
 		}
+		ksft_test_result_pass(test_msg_auto_inc);
+	} else {
+		ksft_test_result_skip(test_msg_auto_inc);
 	}
 	ret =3D pthread_mutex_unlock(&global_lock);
=20
@@ -234,17 +227,12 @@ int main(int argc, char *argv[])
 	futex_hash_slots_set_verify(16);
=20
 	ret =3D futex_hash_slots_set(15, 0);
-	if (ret >=3D 0) {
-		fail("Expected to fail with 15 slots but succeeded: %d.\n", ret);
-		return 1;
-	}
+	ksft_test_result(ret < 0, "Use 15 slots\n");
+
 	futex_hash_slots_set_verify(2);
 	join_max_threads();
-	if (counter !=3D MAX_THREADS) {
-		fail("Expected thread counter at %d but is %d\n",
-		       MAX_THREADS, counter);
-		return 1;
-	}
+	ksft_test_result(counter =3D=3D MAX_THREADS, "Created of waited for %d of %=
d threads\n",
+			 counter, MAX_THREADS);
 	counter =3D 0;
 	/* Once the user set something, auto reisze must be disabled */
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
@@ -253,10 +241,8 @@ int main(int argc, char *argv[])
 	join_max_threads();
=20
 	ret =3D futex_hash_slots_get();
-	if (ret !=3D 2) {
-		printf("Expected 2 slots, no auto-resize, got %d\n", ret);
-		return 1;
-	}
+	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manaul setting, g=
ot %d\n",
+			 ret);
=20
 	futex_hash_slots_set_must_fail(1 << 29, 0);
=20
@@ -266,17 +252,13 @@ int main(int argc, char *argv[])
 	 */
 	if (use_global_hash) {
 		ret =3D futex_hash_slots_set(0, 0);
-		if (ret !=3D 0) {
-			printf("Can't request global hash: %m\n");
-			return 1;
-		}
+		ksft_test_result(ret =3D=3D 0, "Global hash request\n");
 	} else {
 		ret =3D futex_hash_slots_set(4, 1);
-		if (ret !=3D 0) {
-			printf("Immutable resize to 4 failed: %m\n");
-			return 1;
-		}
+		ksft_test_result(ret =3D=3D 0, "Immutable resize to 4\n");
 	}
+	if (ret !=3D 0)
+		goto out;
=20
 	futex_hash_slots_set_must_fail(4, 0);
 	futex_hash_slots_set_must_fail(4, 1);
@@ -287,7 +269,7 @@ int main(int argc, char *argv[])
=20
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
 	if (ret !=3D 0) {
-		error("pthread_barrier_init failed.\n", errno);
+		ksft_exit_fail_msg("pthread_barrier_init failed: %m\n");
 		return 1;
 	}
 	create_max_threads(thread_lock_fn);
@@ -295,21 +277,15 @@ int main(int argc, char *argv[])
=20
 	ret =3D futex_hash_slots_get();
 	if (use_global_hash) {
-		if (ret !=3D 0) {
-			error("Expected global hash, got %d\n", errno, ret);
-			return 1;
-		}
+		ksft_test_result(ret =3D=3D 0, "Continue to use global hash\n");
 	} else {
-		if (ret !=3D 4) {
-			error("Expected 4 slots, no auto-resize, got %d\n", errno, ret);
-			return 1;
-		}
+		ksft_test_result(ret =3D=3D 4, "Continue to use the 4 hash buckets\n");
 	}
=20
 	ret =3D futex_hash_immutable_get();
-	if (ret !=3D 1) {
-		fail("Expected immutable private hash, got %d\n", ret);
-		return 1;
-	}
+	ksft_test_result(ret =3D=3D 1, "Hash reports to be immutable\n");
+
+out:
+	ksft_finished();
 	return 0;
 }

