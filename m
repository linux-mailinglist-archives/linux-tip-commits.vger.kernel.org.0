Return-Path: <linux-tip-commits+bounces-6675-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84541B81400
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 19:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880811C80852
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AC42FFDFD;
	Wed, 17 Sep 2025 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mA6Ve/AE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wYyBQO0t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0670C2FE048;
	Wed, 17 Sep 2025 17:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131692; cv=none; b=Sdpq1LEdQnR189NpXcGm5DQlOjwWJIh0vtu1PL3H+IJICTLyI2Yih+VifpFGyW0R2QQWqUx8q+Xb0rVRcWeDlK54VIj/0FKozvOR7h/fXSII34MUbp106bDgQfyAtBDKTR+P6wxnnJrzkM+2ei4+uWwt6vC/X66Dgc5wSO6D5iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131692; c=relaxed/simple;
	bh=752Be6hbwRLPR3IkCkmLxqZmf/8PRA0fbTBxs4T9geU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UvqFiQmTCWze+lpgVdiNFkvN+iXmteNTnD/eIDqd/xDxQRP7p/Rp/SsNtvKcvPtWml9fN68jmTa0/l9iGHub+PqkoSZmH31Fkh7BxxN+htVuI+3/meeq9yLywr4aoC9zErOwBay+dTeosgKoQhsBbBh6fsL+VqW5XHD0+nWuK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mA6Ve/AE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wYyBQO0t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 17:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758131688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYt/yzDuawtyniFYDydHGYChIqGNIy8InKAeltWYSxY=;
	b=mA6Ve/AEnXBCraQsY/V8k7jQqE6Y48GHhJa3KR8xoC98eZx/FTxXhFP5RVvuf7msK3xhir
	XKCYpV9br5d3PoziPIQD2gZsXnzc1zBfPGVl4D0ZTY8zTdbF13Uugk9P1/pUm20/QPF2Co
	xClCt/e56oqDdE0vrkJwPk/iQn03Z4OfaQr0OzfL5bBqxzwmnHELhKgOhZtwQRxDw5vF4B
	LUN/+85bQ9MhWo9Z29u/BNrpbR8qmByTjXShjFkSvhsTzHUAvov+dkIH7Vqjv+7XouKZlM
	LUv/vlo8spttEjEt//FX3PNRWwR3J3r565pjH9Z1M87r7T0Bil57g4PQ1jdHOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758131688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WYt/yzDuawtyniFYDydHGYChIqGNIy8InKAeltWYSxY=;
	b=wYyBQO0tMz/qzC96N1sCmjWhkIpb6Wyq1PsVy3fo2GEdJhDVk8aDItnjWt6hXp8ZZnBTSn
	+yloFz9H7zvaQ7Dg==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftest/futex: Make the error check more
 precise for futex_numa_mpol
Cc: andrealmeid@igalia.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Waiman Long <longman@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250915212630.965328-2-bigeasy@linutronix.de>
References: <20250915212630.965328-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175813168753.709179.3298089968284650771.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     c1c863457780adfb2e29fa9a85897179ad3903e6
Gitweb:        https://git.kernel.org/tip/c1c863457780adfb2e29fa9a85897179ad3=
903e6
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Mon, 15 Sep 2025 23:26:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Sep 2025 19:48:44 +02:00

selftest/futex: Make the error check more precise for futex_numa_mpol

Instead of just checking if the syscall failed as expected, check as
well if the returned error code matches the expected error code.

[ bigeasy: reword the commmit message ]

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 36 ++++---
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/too=
ls/testing/selftests/futex/functional/futex_numa_mpol.c
index 802c15c..dd7b05e 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -77,7 +77,7 @@ static void join_max_threads(void)
 	}
 }
=20
-static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_=
flags)
+static void __test_futex(void *futex_ptr, int err_value, unsigned int futex_=
flags)
 {
 	int to_wake, ret, i, need_exit =3D 0;
=20
@@ -88,11 +88,17 @@ static void __test_futex(void *futex_ptr, int must_fail, =
unsigned int futex_flag
=20
 	do {
 		ret =3D futex2_wake(futex_ptr, to_wake, futex_flags);
-		if (must_fail) {
-			if (ret < 0)
-				break;
-			ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
-					   to_wake, futex_flags);
+
+		if (err_value) {
+			if (ret >=3D 0)
+				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
+						   to_wake, futex_flags);
+
+			if (errno !=3D err_value)
+				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) expected error was %d, but ret=
urned %d (%s)\n",
+						   to_wake, futex_flags, err_value, errno, strerror(errno));
+
+			break;
 		}
 		if (ret < 0) {
 			ksft_exit_fail_msg("Failed futex2_wake(%d, 0x%x): %m\n",
@@ -106,12 +112,12 @@ static void __test_futex(void *futex_ptr, int must_fail=
, unsigned int futex_flag
 	join_max_threads();
=20
 	for (i =3D 0; i < MAX_THREADS; i++) {
-		if (must_fail && thread_args[i].result !=3D -1) {
+		if (err_value && thread_args[i].result !=3D -1) {
 			ksft_print_msg("Thread %d should fail but succeeded (%d)\n",
 				       i, thread_args[i].result);
 			need_exit =3D 1;
 		}
-		if (!must_fail && thread_args[i].result !=3D 0) {
+		if (!err_value && thread_args[i].result !=3D 0) {
 			ksft_print_msg("Thread %d failed (%d)\n", i, thread_args[i].result);
 			need_exit =3D 1;
 		}
@@ -120,14 +126,14 @@ static void __test_futex(void *futex_ptr, int must_fail=
, unsigned int futex_flag
 		ksft_exit_fail_msg("Aborting due to earlier errors.\n");
 }
=20
-static void test_futex(void *futex_ptr, int must_fail)
+static void test_futex(void *futex_ptr, int err_value)
 {
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA);
 }
=20
-static void test_futex_mpol(void *futex_ptr, int must_fail)
+static void test_futex_mpol(void *futex_ptr, int err_value)
 {
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA | FUTEX2_MPOL);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | F=
UTEX2_NUMA | FUTEX2_MPOL);
 }
=20
 static void usage(char *prog)
@@ -184,16 +190,16 @@ int main(int argc, char *argv[])
=20
 	/* FUTEX2_NUMA futex must be 8-byte aligned */
 	ksft_print_msg("Mis-aligned futex\n");
-	test_futex(futex_ptr + mem_size - 4, 1);
+	test_futex(futex_ptr + mem_size - 4, EINVAL);
=20
 	futex_numa->numa =3D FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
-	test_futex(futex_ptr, 1);
+	test_futex(futex_ptr, EFAULT);
=20
 	mprotect(futex_ptr, mem_size, PROT_NONE);
 	ksft_print_msg("Memory, no access\n");
-	test_futex(futex_ptr, 1);
+	test_futex(futex_ptr, EFAULT);
=20
 	mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
 	ksft_print_msg("Memory back to RW\n");

