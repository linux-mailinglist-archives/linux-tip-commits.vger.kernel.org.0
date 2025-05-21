Return-Path: <linux-tip-commits+bounces-5682-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1D7ABF3B3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666F33A6466
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41B42673BA;
	Wed, 21 May 2025 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHLWxrNI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CclMrfJb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7FB265614;
	Wed, 21 May 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829173; cv=none; b=CtF921eNsi3b3I057a2TI4RXaTOejmuYzX1U7IakRhTnk51OWejGh9JMdOePDek+zO4+ysCcbjXYyAIhUQ6TFxPmyEbBdyaMrvE8npJx9SFrMuaku9+LK57vtN/LzoUxoQ513pZ87e9P/gRdXegq65spZXCO/F5tkCGWbeXzWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829173; c=relaxed/simple;
	bh=a0ttalBybsxc46S0ZBPy30W+pp3jgDsyzacVbKDgJDU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TWJQAHDzgLkCuLM6VeFwyMPHqp4cgbJeL2nxvJxaU07nVTEfuyCA+4yG16jm19n9ADWKYXiaFQ9C79q4VPQlihQtbzks8SX39eYFDl6l5cgHrXFMdWpaUTU/840fOmN7rEEYVrOoTITehgW9kvhenvYGmw40bYTgEUl3RZb4M8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHLWxrNI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CclMrfJb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:06:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Liwp7e1iMvPlJcQ7GzwJoXZ4vHalWLDmnkKiBCK8SeM=;
	b=tHLWxrNIQrev26QfzVNQTsNF2r9dE2Cuw62DQEnQn//xGBjX9fgyocLtT/b4z23QWzHIHo
	/TDPJZmLzRW2vbFue+OTjNfF+0gsvGozX9sj5nLP/QPZYnfWSAe46J+tNaDdsqPenpsnW2
	v3FWLRzTBScEBihxibHa7pjwqqu4uvagEgu7/TaZkK1fiAyedxuPO3P+CWeRau9KaHd/uC
	PbKOikYzoQdawq8LhOnl0KUHS3lfjhhQEB1whUgGWTt2yobvOZd3eoytfZQuyIxFnuIHWq
	5NkDH7WTLFMyxIH9fMfb0y4C2EeDEaL0+xWXDqGMDKTtbVbK+fJ2qxPchU8tgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829170;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Liwp7e1iMvPlJcQ7GzwJoXZ4vHalWLDmnkKiBCK8SeM=;
	b=CclMrfJbLvFS5BaeAVc4tDeXZUVd2vCA+UhHOLyMi2+gpFSj0AoM+ivXrI8FSuQ4Fhtvc4
	a5w/mJp4R7nUWYCA==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] selftests/futex: Use TAP output in futex_numa_mpol
Cc: andrealmeid@igalia.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250517151455.1065363-3-bigeasy@linutronix.de>
References: <20250517151455.1065363-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782916923.406.16681885117173207759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     7d4f494767918c80f2a99831728159b2aa398872
Gitweb:        https://git.kernel.org/tip/7d4f494767918c80f2a99831728159b2aa3=
98872
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 17 May 2025 17:14:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:40 +02:00

selftests/futex: Use TAP output in futex_numa_mpol

Use TAP output for easier automated testing.

Suggested-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/20250517151455.1065363-3-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 65 +++----
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index dd70532..d18949e 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -61,10 +61,8 @@ static void create_max_threads(void *futex_ptr)
 		thread_args[i].flags =3D FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUM=
A;
 		thread_args[i].result =3D 0;
 		ret =3D pthread_create(&threads[i], NULL, thread_lock_fn, &thread_args[i]);
-		if (ret) {
-			error("pthread_create failed\n", errno);
-			exit(1);
-		}
+		if (ret)
+			ksft_exit_fail_msg("pthread_create failed\n");
 	}
 }
=20
@@ -74,10 +72,8 @@ static void join_max_threads(void)
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
@@ -95,12 +91,12 @@ static void __test_futex(void *futex_ptr, int must_fail, =
unsigned int futex_flag
 		if (must_fail) {
 			if (ret < 0)
 				break;
-			fail("Should fail, but didn't\n");
-			exit(1);
+			ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
+					   to_wake, futex_flags);
 		}
 		if (ret < 0) {
-			error("Failed futex2_wake(%d)\n", errno, to_wake);
-			exit(1);
+			ksft_exit_fail_msg("Failed futex2_wake(%d, 0x%x): %m\n",
+					   to_wake, futex_flags);
 		}
 		if (!ret)
 			usleep(50);
@@ -111,16 +107,17 @@ static void __test_futex(void *futex_ptr, int must_fail=
, unsigned int futex_flag
=20
 	for (i =3D 0; i < MAX_THREADS; i++) {
 		if (must_fail && thread_args[i].result !=3D -1) {
-			fail("Thread %d should fail but succeeded (%d)\n", i, thread_args[i].resu=
lt);
+			ksft_print_msg("Thread %d should fail but succeeded (%d)\n",
+				       i, thread_args[i].result);
 			need_exit =3D 1;
 		}
 		if (!must_fail && thread_args[i].result !=3D 0) {
-			fail("Thread %d failed (%d)\n", i, thread_args[i].result);
+			ksft_print_msg("Thread %d failed (%d)\n", i, thread_args[i].result);
 			need_exit =3D 1;
 		}
 	}
 	if (need_exit)
-		exit(1);
+		ksft_exit_fail_msg("Aborting due to earlier errors.\n");
 }
=20
 static void test_futex(void *futex_ptr, int must_fail)
@@ -167,41 +164,41 @@ int main(int argc, char *argv[])
 		}
 	}
=20
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	mem_size =3D sysconf(_SC_PAGE_SIZE);
 	futex_ptr =3D mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MA=
P_ANONYMOUS, 0, 0);
-	if (futex_ptr =3D=3D MAP_FAILED) {
-		error("mmap() for %d bytes failed\n", errno, mem_size);
-		return 1;
-	}
+	if (futex_ptr =3D=3D MAP_FAILED)
+		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
+
 	futex_numa =3D futex_ptr;
=20
-	info("Regular test\n");
+	ksft_print_msg("Regular test\n");
 	futex_numa->futex =3D 0;
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	test_futex(futex_ptr, 0);
=20
-	if (futex_numa->numa =3D=3D FUTEX_NO_NODE) {
-		fail("NUMA node is left unitiliazed\n");
-		return 1;
-	}
+	if (futex_numa->numa =3D=3D FUTEX_NO_NODE)
+		ksft_exit_fail_msg("NUMA node is left unitiliazed\n");
=20
-	info("Memory too small\n");
+	ksft_print_msg("Memory too small\n");
 	test_futex(futex_ptr + mem_size - 4, 1);
=20
-	info("Memory out of range\n");
+	ksft_print_msg("Memory out of range\n");
 	test_futex(futex_ptr + mem_size, 1);
=20
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
-	info("Memory, RO\n");
+	ksft_print_msg("Memory, RO\n");
 	test_futex(futex_ptr, 1);
=20
 	mprotect(futex_ptr, mem_size, PROT_NONE);
-	info("Memory, no access\n");
+	ksft_print_msg("Memory, no access\n");
 	test_futex(futex_ptr, 1);
=20
 	mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
-	info("Memory back to RW\n");
+	ksft_print_msg("Memory back to RW\n");
 	test_futex(futex_ptr, 0);
=20
 	/* MPOL test. Does not work as expected */
@@ -213,20 +210,22 @@ int main(int argc, char *argv[])
 		ret =3D mbind(futex_ptr, mem_size, MPOL_BIND, &nodemask,
 			    sizeof(nodemask) * 8, 0);
 		if (ret =3D=3D 0) {
-			info("Node %d test\n", i);
+			ksft_print_msg("Node %d test\n", i);
 			futex_numa->futex =3D 0;
 			futex_numa->numa =3D FUTEX_NO_NODE;
=20
 			ret =3D futex2_wake(futex_ptr, 0, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | =
FUTEX2_NUMA | FUTEX2_MPOL);
 			if (ret < 0)
-				error("Failed to wake 0 with MPOL.\n", errno);
+				ksft_test_result_fail("Failed to wake 0 with MPOL: %m\n");
 			if (0)
 				test_futex_mpol(futex_numa, 0);
 			if (futex_numa->numa !=3D i) {
-				fail("Returned NUMA node is %d expected %d\n",
-				     futex_numa->numa, i);
+				ksft_test_result_fail("Returned NUMA node is %d expected %d\n",
+						      futex_numa->numa, i);
 			}
 		}
 	}
+	ksft_test_result_pass("NUMA MPOL tests passed\n");
+	ksft_finished();
 	return 0;
 }

