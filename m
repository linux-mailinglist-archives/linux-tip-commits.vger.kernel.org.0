Return-Path: <linux-tip-commits+bounces-5680-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2E3ABF3AC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF3B3B0DED
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2223F265632;
	Wed, 21 May 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xxfqlFjU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ng86QKxz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B8264FB1;
	Wed, 21 May 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829172; cv=none; b=EQGKCF3q8HMTEE7ycLOnsifFZFZYcqXCN+nizkdGb8AmTJqeJtuwRHe5ijLVZpUrf9Lc3pXYDnuoomqmux7JUZUgeeNGptHmtuPXKJcXXidKxGsgraIhigew/ldjTIP0ohMvnXWLkX+PhvZtZEYRkJMu7lAXhR8FJGDXonlg/n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829172; c=relaxed/simple;
	bh=ttKx6+bVMj0R8Bu4g6AdibEZcp2w04mL41S35h67d5w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RJLifLFe0rHzl2PA53fVh2hQzwuxoA8/pRJ816y7KZs+liN5OvtqaYQ6iC8d7o/KZK8uW8HDpgGcwIwwcats0Abj0Y5M3Cj/Z3LACal2ugYmR++ilR7z7a9PDRbZBAgVHN8HXL6Z71pBMiDyQPw7y51+7U6lWaRsFtopQrmqfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xxfqlFjU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ng86QKxz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:06:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fD+WYY2rjZZT9UbJGCcCs7XoD2E72rJcnJAMtwHSnW4=;
	b=xxfqlFjU1wXqGvm6nztdra4pEDWPt290U38SmRa01pYm90w7m+K4jXSKukGZWBlaNtL0Mi
	U8ZTDAxAD/6hzC+FIZnqBffeKu8i7337j8GjWRTmr8RQzptZfr1D3eYQ+0epvbaGqwgZGf
	Vm96zi4WfeX5OeszE2lKNwgiF79IqknzdpJfbpxPnSxn6Q1ZmLccwLXnQ0loF2erhOe+rR
	q6M4+gJzC61NzLPJ79hHisUkAwzZMEcipHo11dHOGdg6EUj+mkreYN56v8gfHVnzXlxRXX
	rv0eEPL6H6GY7vCyIF7PytpV+RwdJHH1Qh6UnMiR00HERyiEd/1ewZCIDf7D8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829168;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fD+WYY2rjZZT9UbJGCcCs7XoD2E72rJcnJAMtwHSnW4=;
	b=Ng86QKxz851ZMw1YmcS/OhXxfTHU0Opxi002hfTjRmcLks/wnYFcW31R9xbf3nopGejBjb
	CvPcn0fkwSOLs5Cw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] tools headers: Synchronize prctl.h ABI header
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, andrealmeid@igalia.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250517151455.1065363-5-bigeasy@linutronix.de>
References: <20250517151455.1065363-5-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782916767.406.1898016885752796804.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     4140e2b31bedd87bfc53362441165979aa4fc5d8
Gitweb:        https://git.kernel.org/tip/4140e2b31bedd87bfc53362441165979aa4=
fc5d8
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Sat, 17 May 2025 17:14:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:41 +02:00

tools headers: Synchronize prctl.h ABI header

The prctl.h ABI header was slightly updated during the development of
the interface. In particular the "immutable" parameter became a bit in
the option argument.

Synchronize prctl.h ABI header again and make use of the definition in
the testsuite and "perf bench futex".

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/r/20250517151455.1065363-5-bigeasy@linutronix.de
---
 tools/include/uapi/linux/prctl.h                           |  1 +-
 tools/perf/bench/futex.c                                   |  4 +-
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 21 +++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prct=
l.h
index 21f30b3..43dec6e 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -367,6 +367,7 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
+# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
 # define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 02ae6c5..26382e4 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -9,12 +9,14 @@
=20
 void futex_set_nbuckets_param(struct bench_futex_parameters *params)
 {
+	unsigned long flags;
 	int ret;
=20
 	if (params->nbuckets < 0)
 		return;
=20
-	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, par=
ams->buckets_immutable);
+	flags =3D params->buckets_immutable ? FH_FLAG_IMMUTABLE : 0;
+	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, fla=
gs);
 	if (ret) {
 		printf("Requesting %d hash buckets failed: %d/%m\n",
 		       params->nbuckets, ret);
diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index 72a621d..2dca18f 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -26,13 +26,14 @@ static int counter;
 #ifndef PR_FUTEX_HASH
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
+# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
 # define PR_FUTEX_HASH_GET_IMMUTABLE	3
 #endif
=20
-static int futex_hash_slots_set(unsigned int slots, int immutable)
+static int futex_hash_slots_set(unsigned int slots, int flags)
 {
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, immutable);
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, flags);
 }
=20
 static int futex_hash_slots_get(void)
@@ -63,13 +64,13 @@ static void futex_hash_slots_set_verify(int slots)
 	ksft_test_result_pass("SET and GET slots %d passed\n", slots);
 }
=20
-static void futex_hash_slots_set_must_fail(int slots, int immutable)
+static void futex_hash_slots_set_must_fail(int slots, int flags)
 {
 	int ret;
=20
-	ret =3D futex_hash_slots_set(slots, immutable);
+	ret =3D futex_hash_slots_set(slots, flags);
 	ksft_test_result(ret < 0, "futex_hash_slots_set(%d, %d)\n",
-			 slots, immutable);
+			 slots, flags);
 }
=20
 static void *thread_return_fn(void *arg)
@@ -254,18 +255,18 @@ int main(int argc, char *argv[])
 		ret =3D futex_hash_slots_set(0, 0);
 		ksft_test_result(ret =3D=3D 0, "Global hash request\n");
 	} else {
-		ret =3D futex_hash_slots_set(4, 1);
+		ret =3D futex_hash_slots_set(4, FH_FLAG_IMMUTABLE);
 		ksft_test_result(ret =3D=3D 0, "Immutable resize to 4\n");
 	}
 	if (ret !=3D 0)
 		goto out;
=20
 	futex_hash_slots_set_must_fail(4, 0);
-	futex_hash_slots_set_must_fail(4, 1);
+	futex_hash_slots_set_must_fail(4, FH_FLAG_IMMUTABLE);
 	futex_hash_slots_set_must_fail(8, 0);
-	futex_hash_slots_set_must_fail(8, 1);
-	futex_hash_slots_set_must_fail(0, 1);
-	futex_hash_slots_set_must_fail(6, 1);
+	futex_hash_slots_set_must_fail(8, FH_FLAG_IMMUTABLE);
+	futex_hash_slots_set_must_fail(0, FH_FLAG_IMMUTABLE);
+	futex_hash_slots_set_must_fail(6, FH_FLAG_IMMUTABLE);
=20
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
 	if (ret !=3D 0) {

