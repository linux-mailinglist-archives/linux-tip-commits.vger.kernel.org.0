Return-Path: <linux-tip-commits+bounces-6101-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E528B023C5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120DFA8026D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Jul 2025 18:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CAF2F4A13;
	Fri, 11 Jul 2025 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4nCEDovK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttnAmFGa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E825F2F4330;
	Fri, 11 Jul 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258821; cv=none; b=D3BIcH8eVWnoo+xOTWei9Pu4xeG7oCVlxRnDptvu6Bs/Gqp0ecw8U1RmmRMy9fMKokSuV5nbpGSR5WT4usNY2u2rek6vRN+InaBMb6T03h2AWKV27n8/N0FGGy4tKqPfsr8IjP8I9wWJZZS98KHZVLZqAEdEnz1Z6Yx5xOe8SHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258821; c=relaxed/simple;
	bh=w/nyayWtuuRj1tj9iMpS5LCwAELs/1AZtbyYy53hFDc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EQ8OIlIl9oZOj9vbiF6mzdHeUXN2Ahx5pkmEh19mjnKm92g6t5RaGYWf5dnt9uPgT303uACdWawZhCAB3UUK/AFNPpVNkHzuvOqh+nvipoU+ThRBG4QmujGC/NGGG/zSgWgZEXHJgBXMY0lqsnFMT7d1yFacHQhAoPnRtEOiW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4nCEDovK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttnAmFGa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Jul 2025 18:33:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752258818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=US7ztmPHK6fXU+8Ry/CugZ+DLMQriIgMxpRsxrvLH78=;
	b=4nCEDovKLiVojXh8HkoQpyJGL8Ozw0M3Z7Yp7lNXniBs60uuh6wAKViG0AVlXCSoMPq+HB
	0pO+CYftuav90ZbX7EsrtHtZw4t9En+JPVIi8Y8JP21vjebrvqZXMBPFrbZ91wF6IYsgwn
	7CAYW+uFcPv3tsgN6kXJHVAVHoUDlNKBIhaaxTT/R0ROWyKNdpxzOTXEYA397KfJ15vNfx
	ktMjhDZBw3i+jfrg/gu9WTj2XmkCnRzGewrmn5X1Uig12dFMa/LDjR3X43e1035ytJl2O6
	71uGvwqz6NA2XiByqUYtoYbJNQZtn/Ej3pi62u3tJ6f0BvyhB8Q14HXOYl4TIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752258818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=US7ztmPHK6fXU+8Ry/CugZ+DLMQriIgMxpRsxrvLH78=;
	b=ttnAmFGaHUvSxSxYO3RJnwun2stJF9xQQKSHjBFOYYkuPq1xXrtzQSu0f++c4hqYTb737o
	Nv9MSqeTJhO1gkCQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Adapt the private hash test to
 RCU related changes
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710110011.384614-2-bigeasy@linutronix.de>
References: <20250710110011.384614-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175225881721.406.13703866724451292167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     a255b78d14324f8a4a49f88e983b9f00818d1194
Gitweb:        https://git.kernel.org/tip/a255b78d14324f8a4a49f88e983b9f00818d1194
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 10 Jul 2025 13:00:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Jul 2025 16:02:00 +02:00

selftests/futex: Adapt the private hash test to RCU related changes

The auto scaling on create creation used to automatically assign the new
hash because there was the private hash was unused and could be replaced
right away.

This is already racy because if the private hash is in use by a thread
then the visibile resize will be delayed. With the upcoming change to
wait for a RCU grace period before the hash can be assigned, the test
will always fail.

If the reported number of hash buckets is not updated after an
auto scaling event, block on an acquired lock with a timeout. The timeout
is the delay to wait towards a grace period and locking and a locked
pthread_mutex_t ensure that glibc calls into kernel using futex
operation which will assign new private hash if available.
This will retry every 100ms up to 2 seconds in total.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250710110011.384614-2-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 42 ++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 24a92dc..625e3be 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -111,6 +111,30 @@ static void join_max_threads(void)
 	}
 }
 
+#define SEC_IN_NSEC	1000000000
+#define MSEC_IN_NSEC	1000000
+
+static void futex_dummy_op(void)
+{
+	pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
+	struct timespec timeout;
+	int ret;
+
+	pthread_mutex_lock(&lock);
+	clock_gettime(CLOCK_REALTIME, &timeout);
+	timeout.tv_nsec += 100 * MSEC_IN_NSEC;
+	if (timeout.tv_nsec >=  SEC_IN_NSEC) {
+		timeout.tv_nsec -= SEC_IN_NSEC;
+		timeout.tv_sec++;
+	}
+	ret = pthread_mutex_timedlock(&lock, &timeout);
+	if (ret == 0)
+		ksft_exit_fail_msg("Succeffuly locked an already locked mutex.\n");
+
+	if (ret != ETIMEDOUT)
+		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", ret);
+}
+
 static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
@@ -129,7 +153,7 @@ int main(int argc, char *argv[])
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
 	int use_global_hash = 0;
-	int ret;
+	int ret, retry = 20;
 	int c;
 
 	while ((c = getopt(argc, argv, "cghv:")) != -1) {
@@ -208,8 +232,24 @@ int main(int argc, char *argv[])
 	 */
 	ksft_print_msg("Online CPUs: %d\n", online_cpus);
 	if (online_cpus > 16) {
+retry_getslots:
 		futex_slotsn = futex_hash_slots_get();
 		if (futex_slotsn < 0 || futex_slots1 == futex_slotsn) {
+			retry--;
+			/*
+			 * Auto scaling on thread creation can be slightly delayed
+			 * because it waits for a RCU grace period twice. The new
+			 * private hash is assigned upon the first futex operation
+			 * after grace period.
+			 * To cover all this for testing purposes the function
+			 * below will acquire a lock and acquire it again with a
+			 * 100ms timeout which must timeout. This ensures we
+			 * sleep for 100ms and issue a futex operation.
+			 */
+			if (retry > 0) {
+				futex_dummy_op();
+				goto retry_getslots;
+			}
 			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
 				       futex_slots1, futex_slotsn);
 			ksft_exit_fail_msg(test_msg_auto_inc);

