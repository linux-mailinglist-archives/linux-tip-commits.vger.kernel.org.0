Return-Path: <linux-tip-commits+bounces-8197-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJGNAegag2l9hwMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8197-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 11:09:44 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D195E44B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 11:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF18C3019F3B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Feb 2026 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233E23D6484;
	Wed,  4 Feb 2026 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bCgXeZTY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/SUMuvD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600A3D5237;
	Wed,  4 Feb 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770199725; cv=none; b=ma3gqJ8FcHWIlGCvzrvNum6kzM/GoOo9f31S4Fv/bzinlLFNhyBxb7o7ZKTbzWtxpQcDh0M5hDLuAgKeshOJWsYQYiJekpCw1Qv1/U6kWdcfQW2OIMbRIYzcRwO7AVAKLGZckCZ7WZBAWlFgDLRt/5FFmF68Z5k4mLVr+vOFuBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770199725; c=relaxed/simple;
	bh=UfhEI1B9EVtGt9/5EYF2+fTN084B+C8nip09FKJrdME=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W8b5sl7V3T8STLF9zwQVcQZZbsl75vDvzS7zI8EHjDKerHnnenKhYL9xeNKlsF7HNffFL0a0yhhPuQf1bHhGgbOooRsxOhzE4W/mmMZGH/XFQGlpr2JtXa+pfQ96eO/8cuMbqJA32Z3xfq0Jnq3aVb7HwcRVu2ca0fQecp/XoVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bCgXeZTY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/SUMuvD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Feb 2026 10:08:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770199722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYZiEueiALawpyRS1o61/P5k8+6z3NsyoIHoixuYKbc=;
	b=bCgXeZTYO+rqFyJVgConfyJq9IwF6IRgawiv+KT+wCvhLRvJDq5DYf0/M0bear0xmMPOfn
	/c6nkOJhzuL1sgaVTunPoaGfw4Hjz3yeNxCNQT1aWton8gJPWv+dASULK5oqd7Clcylb6j
	aPSMBe3U8kkN4ip//hLup/psEcM6+pvuAH7d4PQ4aJ4T+yoz2d4JOVv0kHTIkqcFUHSb3S
	vf/GGjYns+t7h6Br2IHCDtSD8nuCIk58akC7psCWFxxE7dpJAaG3cX6aTmQjpm7Z2SBVOc
	Un1gDiOqpMVqEsPhHHnvlulqYrwZ5ZF5kbW8l1xjX9/A0AE6ujAEzhnaStmkVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770199722;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UYZiEueiALawpyRS1o61/P5k8+6z3NsyoIHoixuYKbc=;
	b=m/SUMuvDYphDcI+InxWBJbazNrY0rMGcbrGePm4IUL60t2cC4QxC3ia/gxOnhCAH+e0HAV
	hQ+TS8C0J6KBWdDA==
From: "tip-bot2 for Yuwen Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Fix incorrect result reporting
 of futex_requeue test item
Cc: Yuwen Chen <ywen.chen@foxmail.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <tencent_51851B741CC4B5EC9C22AFF70BA82BB60805@qq.com>
References: <tencent_51851B741CC4B5EC9C22AFF70BA82BB60805@qq.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177019972082.2495410.8441988381020898500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8197-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foxmail.com:email,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[foxmail.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 6D195E44B2
X-Rspamd-Action: no action

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     d317e2ef9dcf673c9f37cda784284af7c6812757
Gitweb:        https://git.kernel.org/tip/d317e2ef9dcf673c9f37cda784284af7c68=
12757
Author:        Yuwen Chen <ywen.chen@foxmail.com>
AuthorDate:    Wed, 28 Jan 2026 10:03:10 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 04 Feb 2026 10:51:46 +01:00

selftests/futex: Fix incorrect result reporting of futex_requeue test item

When using the TEST_HARNESS_MAIN macro definition to declare the main
function, it is required to use the EXPECT*() and ASSERT*() macros in
conjunction and not ksft_test_result_*(). Otherwise, even if a test item
fails, the test will still return a success result because
ksft_test_result_*() does not affect the test harness state.

Convert the code to use EXPECT/ASSERT() variants, which ensures that the
overall test result is fail if one of the EXPECT()s fails.

[ tglx: Massaged change log to explain _why_ ksft_test_result*() is the wrong
  	choice ]

Fixes: f341a20f6d7e ("selftests/futex: Refactor futex_requeue with kselftest_=
harness.h")
Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/tencent_51851B741CC4B5EC9C22AFF70BA82BB60805@q=
q.com
---
 tools/testing/selftests/futex/functional/futex_requeue.c | 49 +------
 1 file changed, 8 insertions(+), 41 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools=
/testing/selftests/futex/functional/futex_requeue.c
index 35d4be2..dcf0d5f 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -34,34 +34,18 @@ TEST(requeue_single)
 	volatile futex_t _f1 =3D 0;
 	volatile futex_t f2 =3D 0;
 	pthread_t waiter[10];
-	int res;
=20
 	f1 =3D &_f1;
=20
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
-	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
-		ksft_exit_fail_msg("pthread_create failed\n");
+	ASSERT_EQ(0, pthread_create(&waiter[0], NULL, waiterfn, NULL));
=20
 	usleep(WAKE_WAIT_US);
=20
-	ksft_print_dbg_msg("Requeuing 1 futex from f1 to f2\n");
-	res =3D futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
-	if (res !=3D 1)
-		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-
-	ksft_print_dbg_msg("Waking 1 futex at f2\n");
-	res =3D futex_wake(&f2, 1, 0);
-	if (res !=3D 1) {
-		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-	} else {
-		ksft_test_result_pass("futex_requeue simple succeeds\n");
-	}
+	EXPECT_EQ(1, futex_cmp_requeue(f1, 0, &f2, 0, 1, 0));
+	EXPECT_EQ(1, futex_wake(&f2, 1, 0));
 }
=20
 TEST(requeue_multiple)
@@ -69,7 +53,7 @@ TEST(requeue_multiple)
 	volatile futex_t _f1 =3D 0;
 	volatile futex_t f2 =3D 0;
 	pthread_t waiter[10];
-	int res, i;
+	int i;
=20
 	f1 =3D &_f1;
=20
@@ -77,30 +61,13 @@ TEST(requeue_multiple)
 	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
 	 * At futex_wake, wake INT_MAX (should be exactly 7).
 	 */
-	for (i =3D 0; i < 10; i++) {
-		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
-			ksft_exit_fail_msg("pthread_create failed\n");
-	}
+	for (i =3D 0; i < 10; i++)
+		ASSERT_EQ(0, pthread_create(&waiter[i], NULL, waiterfn, NULL));
=20
 	usleep(WAKE_WAIT_US);
=20
-	ksft_print_dbg_msg("Waking 3 futexes at f1 and requeuing 7 futexes from f1 =
to f2\n");
-	res =3D futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
-	if (res !=3D 10) {
-		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-	}
-
-	ksft_print_dbg_msg("Waking INT_MAX futexes at f2\n");
-	res =3D futex_wake(&f2, INT_MAX, 0);
-	if (res !=3D 7) {
-		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
-				      res ? errno : res,
-				      res ? strerror(errno) : "");
-	} else {
-		ksft_test_result_pass("futex_requeue many succeeds\n");
-	}
+	EXPECT_EQ(10, futex_cmp_requeue(f1, 0, &f2, 3, 7, 0));
+	EXPECT_EQ(7, futex_wake(&f2, INT_MAX, 0));
 }
=20
 TEST_HARNESS_MAIN

