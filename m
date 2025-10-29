Return-Path: <linux-tip-commits+bounces-7041-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A911C1967F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254AE403920
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F37932D0EE;
	Wed, 29 Oct 2025 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IAhkE66L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itsWAtLx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A4732B9BC;
	Wed, 29 Oct 2025 09:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730579; cv=none; b=VjLkW5DP7EiWpFRoeEM8Xuh7vejzzIleMs62hOnt4cadz7GHYvkawIDjNBV0AYgElzAkUNnhkMMW1QlxBwnkQB5nBXAh7zkXx2qI94ULvEimtv+iQ3BLInEW8c6RaJ/03LOzoA1I/nbrweJAmTTGpgKyqRZPB9pviZWQ7LKqvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730579; c=relaxed/simple;
	bh=LSGwXCKv3/wg84ROhF/tp3l+zDH+f0pm5JjhGkkkCBY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WqnK4DAW65jPIK2oO2tfIbX0gulsYlit7D0HRl2u1Ghjsrwi+hDICbUoVnv476ja3PZbpYUTPonyOG743HUUoT0Nlgxd5zd0qlMdf0q24I/EpUDKfH0QWLvpJyX+TpufZXCtZjdwLhFHOjH/rMb/f+IlICqCtxYsdk79mHDOcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IAhkE66L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itsWAtLx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HI43O8DlCgmQcA5Umueg3kWDWokO67cw9iLa/BM5bb8=;
	b=IAhkE66L4/0EuhqdCruWfp/K51YjfDCSPybl7S/kN+uUmkukHZ4I7XiA5TWvGL1ipgKt1J
	0j/4bw3tcOkpLfjsXw+LzVaeyDuEo6DukpPi3QJrT+K0hIXVGtM225G1lqGmNIVW28EZDF
	a/UK383hw0yfnzLsFIOm0o9Q4VdhnTx4jI9bL9Hhrcm0ngwOPXL8vDOVZgLJWYgN27UPfA
	4zuZJWpzXHYY1o7yQrMRZqINV7jMlT2xZdjZhG8uCRms689kytmtEpz0uzfoNPyFcsDneI
	iPzcEJuYB/e6doPMikqx2qB9c7qRcgnJvJiZgrtd4lZnFDfZ8bcoPAd1YKP/jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HI43O8DlCgmQcA5Umueg3kWDWokO67cw9iLa/BM5bb8=;
	b=itsWAtLx9s2YIbkN6/EalXZ04PzxgOljhNYp0P5cLWzzVUzyTJzhXbX+L2FpD/nHjf7lWM
	eU2ZliWHKBWMOTDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind: Simplify unwind_user_faultable()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080119.271671514@infradead.org>
References: <20250924080119.271671514@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173057456.2601451.3608458082589938407.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     42b9138f81fc22c36128f9524bb21bc9eabfb1b8
Gitweb:        https://git.kernel.org/tip/42b9138f81fc22c36128f9524bb21bc9eab=
fb1b8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 15:49:14 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:56 +01:00

unwind: Simplify unwind_user_faultable()

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20250924080119.271671514@infradead.org
---
 kernel/unwind/deferred.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index 6395192..09617d8 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -128,17 +128,14 @@ int unwind_user_faultable(struct unwind_stacktrace *tra=
ce)
=20
 	cache =3D info->cache;
 	trace->entries =3D cache->entries;
-
-	if (cache->nr_entries) {
-		/*
-		 * The user stack has already been previously unwound in this
-		 * entry context.  Skip the unwind and use the cache.
-		 */
-		trace->nr =3D cache->nr_entries;
+	trace->nr =3D cache->nr_entries;
+	/*
+	 * The user stack has already been previously unwound in this
+	 * entry context.  Skip the unwind and use the cache.
+	 */
+	if (trace->nr)
 		return 0;
-	}
=20
-	trace->nr =3D 0;
 	unwind_user(trace, UNWIND_MAX_ENTRIES);
=20
 	cache->nr_entries =3D trace->nr;

