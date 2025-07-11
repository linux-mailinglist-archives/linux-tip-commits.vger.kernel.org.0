Return-Path: <linux-tip-commits+bounces-6096-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F6AB023BC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C338A6836E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A747C2F3C1B;
	Fri, 11 Jul 2025 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGFE7QXd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/r/H4vJZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC412EF670;
	Fri, 11 Jul 2025 18:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258818; cv=none; b=YlKYq6k5wRlUebRxzy8aU8VCJ4MDfeJqc9HfgKxZVfe4Jfb5ZoSvGaqs8OKIqTRiQvJDEg7k90zfzKYdzQX5Lu6DfIf5n/2vtW+gCOYDq+pESGa1WyyV8387vGTOGCq5nXkvcw/b2RwX/PDdFG19DSG806UYcjaq8u31rhA9YEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258818; c=relaxed/simple;
	bh=36/g1dJjruGqOPME+hUG0Ri6+2gnel8l4IiN2O/gTCA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p8E9JATdEbttHaaAU+VVgsgZBvngk0Wtn67upzYtbswsPL8ylxvRPa6rbDNppQnu25b2qrzx+BJ7r1ml5J/9DFUlDd67RzNBoJogRM4tmd9FcyOWCLnUgmZn31VJ+iXIYvl2A3PYFM1LUS6ZPSeojdUxqag+iYWroRpASrjsvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGFE7QXd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/r/H4vJZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 18:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752258814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSuKN5kl3KM2U5oxXMO2M3XwjjIRjD53ltk7qFhTpMM=;
	b=dGFE7QXdcL4FBR3Hse+cakbQZiVLz/lk1WxtBlj8TuUxY0/ztyAZMKoONTi2nt7F2EkF+a
	RvASZ5paKHPT5ug0mQlbeP20HtQEZ5b7h1DPjR8eH6qd4sp/I5k/RYeenPKW2YisUi0JHb
	h5Mw5jRXSUL5z2xLnqAlzjuoir73Lq0G6/1bH/KvXqH5+Fpa0+lBEeF3rpDnYI5hMcCAjM
	d/8k37FSF3NuVFrR2rUwe3ZUBtNLEdYM3RQ3PNXzpRI9B2xbYMSiAENJT8M6kiMAxd5a/e
	2P8qYbu5uqHmU+969rBqybBTNsdZnWdBbzHiNO/0mn0WKwKOtK4jQHQV9cOR6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752258814;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSuKN5kl3KM2U5oxXMO2M3XwjjIRjD53ltk7qFhTpMM=;
	b=/r/H4vJZd6Al7KbvsKw2dJOgHD1Y67wm+QlxIbUdIjM5ZDQnRnhMwwqtPQnYcOujHdEaX9
	rCPBPcAmiHe8BHAw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Remove support for IMMUTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710110011.384614-6-bigeasy@linutronix.de>
References: <20250710110011.384614-6-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225881387.406.4132217462285081008.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     16adc7f136dc143fdaa0d465172d7a1e6d5ae3c5
Gitweb:        https://git.kernel.org/tip/16adc7f136dc143fdaa0d465172d7a1e6d5ae3c5
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 10 Jul 2025 13:00:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Jul 2025 16:02:01 +02:00

selftests/futex: Remove support for IMMUTABLE

Testing for the IMMUTABLE part of the futex interface is not needed
after the removal of the interface.

Remove support for IMMUTABLE from the sefltest.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250710110011.384614-6-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 71 ++-----
 1 file changed, 22 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 625e3be..a9cedc3 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -26,14 +26,12 @@ static int counter;
 #ifndef PR_FUTEX_HASH
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
 #endif
 
-static int futex_hash_slots_set(unsigned int slots, int flags)
+static int futex_hash_slots_set(unsigned int slots)
 {
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, flags);
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, 0);
 }
 
 static int futex_hash_slots_get(void)
@@ -41,16 +39,11 @@ static int futex_hash_slots_get(void)
 	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
 }
 
-static int futex_hash_immutable_get(void)
-{
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
-}
-
 static void futex_hash_slots_set_verify(int slots)
 {
 	int ret;
 
-	ret = futex_hash_slots_set(slots, 0);
+	ret = futex_hash_slots_set(slots);
 	if (ret != 0) {
 		ksft_test_result_fail("Failed to set slots to %d: %m\n", slots);
 		ksft_finished();
@@ -64,13 +57,13 @@ static void futex_hash_slots_set_verify(int slots)
 	ksft_test_result_pass("SET and GET slots %d passed\n", slots);
 }
 
-static void futex_hash_slots_set_must_fail(int slots, int flags)
+static void futex_hash_slots_set_must_fail(int slots)
 {
 	int ret;
 
-	ret = futex_hash_slots_set(slots, flags);
-	ksft_test_result(ret < 0, "futex_hash_slots_set(%d, %d)\n",
-			 slots, flags);
+	ret = futex_hash_slots_set(slots);
+	ksft_test_result(ret < 0, "futex_hash_slots_set(%d)\n",
+			 slots);
 }
 
 static void *thread_return_fn(void *arg)
@@ -152,18 +145,14 @@ int main(int argc, char *argv[])
 {
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
-	int use_global_hash = 0;
 	int ret, retry = 20;
 	int c;
 
-	while ((c = getopt(argc, argv, "cghv:")) != -1) {
+	while ((c = getopt(argc, argv, "chv:")) != -1) {
 		switch (c) {
 		case 'c':
 			log_color(1);
 			break;
-		case 'g':
-			use_global_hash = 1;
-			break;
 		case 'h':
 			usage(basename(argv[0]));
 			exit(0);
@@ -178,7 +167,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(22);
+	ksft_set_plan(21);
 
 	ret = pthread_mutexattr_init(&mutex_attr_pi);
 	ret |= pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHERIT);
@@ -191,10 +180,6 @@ int main(int argc, char *argv[])
 	if (ret != 0)
 		ksft_exit_fail_msg("futex_hash_slots_get() failed: %d, %m\n", ret);
 
-	ret = futex_hash_immutable_get();
-	if (ret != 0)
-		ksft_exit_fail_msg("futex_hash_immutable_get() failed: %d, %m\n", ret);
-
 	ksft_test_result_pass("Basic get slots and immutable status.\n");
 	ret = pthread_create(&threads[0], NULL, thread_return_fn, NULL);
 	if (ret != 0)
@@ -267,7 +252,7 @@ retry_getslots:
 	futex_hash_slots_set_verify(32);
 	futex_hash_slots_set_verify(16);
 
-	ret = futex_hash_slots_set(15, 0);
+	ret = futex_hash_slots_set(15);
 	ksft_test_result(ret < 0, "Use 15 slots\n");
 
 	futex_hash_slots_set_verify(2);
@@ -285,28 +270,23 @@ retry_getslots:
 	ksft_test_result(ret == 2, "No more auto-resize after manaul setting, got %d\n",
 			 ret);
 
-	futex_hash_slots_set_must_fail(1 << 29, 0);
+	futex_hash_slots_set_must_fail(1 << 29);
+	futex_hash_slots_set_verify(4);
 
 	/*
-	 * Once the private hash has been made immutable or global hash has been requested,
-	 * then this requested can not be undone.
+	 * Once the global hash has been requested, then this requested can not
+	 * be undone.
 	 */
-	if (use_global_hash) {
-		ret = futex_hash_slots_set(0, 0);
-		ksft_test_result(ret == 0, "Global hash request\n");
-	} else {
-		ret = futex_hash_slots_set(4, FH_FLAG_IMMUTABLE);
-		ksft_test_result(ret == 0, "Immutable resize to 4\n");
-	}
+	ret = futex_hash_slots_set(0);
+	ksft_test_result(ret == 0, "Global hash request\n");
 	if (ret != 0)
 		goto out;
 
-	futex_hash_slots_set_must_fail(4, 0);
-	futex_hash_slots_set_must_fail(4, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(8, 0);
-	futex_hash_slots_set_must_fail(8, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(0, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(6, FH_FLAG_IMMUTABLE);
+	futex_hash_slots_set_must_fail(4);
+	futex_hash_slots_set_must_fail(8);
+	futex_hash_slots_set_must_fail(8);
+	futex_hash_slots_set_must_fail(0);
+	futex_hash_slots_set_must_fail(6);
 
 	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
 	if (ret != 0) {
@@ -317,14 +297,7 @@ retry_getslots:
 	join_max_threads();
 
 	ret = futex_hash_slots_get();
-	if (use_global_hash) {
-		ksft_test_result(ret == 0, "Continue to use global hash\n");
-	} else {
-		ksft_test_result(ret == 4, "Continue to use the 4 hash buckets\n");
-	}
-
-	ret = futex_hash_immutable_get();
-	ksft_test_result(ret == 1, "Hash reports to be immutable\n");
+	ksft_test_result(ret == 0, "Continue to use global hash\n");
 
 out:
 	ksft_finished();

