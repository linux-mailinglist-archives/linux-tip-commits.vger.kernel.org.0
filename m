Return-Path: <linux-tip-commits+bounces-6382-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6F1B37AAD
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50E1A1B61A0E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED17314A76;
	Wed, 27 Aug 2025 06:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="er8ZAXK3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rnmED8lz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65B3148C8;
	Wed, 27 Aug 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277140; cv=none; b=M48hVh6SMg97mvpeg9sEKyR/mK5dOKSY8qHQl4x/4HjL2jLk9fWFv38ftgDlWqzNA3AG/abR7Flbgib0nZLmyEmU28oacL5EMS2e1Y/JcIhlTaAIc7XzLjI27LbWQaOlO1qQ3SMqDmzdTZuOQR6BmHjLaRRHRjGkqXo2QKQ8vJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277140; c=relaxed/simple;
	bh=qdUPsCe2c5V6aLdoDVO0WUgeE0UEJoBgUxftB60xTTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Anf1piu//5gsT9HqWR2VkNH5T4Rezs/WqLfj+V+qSWXj6nD7bRKA44SKgqLezc7eIN2qNxbuLPPQD6ADL7pG2MSfzWHTeGJRBv/1xq3sHpyxr0nHnJm+K9KENst9gYkpVHliVcf/gxCuntrU6qj8FdI+DbbMZkeDFkA2fbhmezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=er8ZAXK3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rnmED8lz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1+QhUSutOTnCFdNgJIy1ND+xr1gyO4p/+sVSr7ghcc=;
	b=er8ZAXK3Gi5AF+05m22t8S/iaVGKccoq73c4yRvm1vufUQdc8TU2ZDq5NMwFtLUgwDN/2w
	Up+nwz2prUr1qSxAhpaJe5xAq/+ktn3BIaL610VnDqolUPy+z/tY5Mp8AlDfGiOPfa6Cpo
	VlzIu/Gcp449yXTbpOzoqAk+KMmGRyb29AFHpU3r++JMZxC8fMaX3wDb4vUhDrCoKGep4O
	T8VENsMAqVSxbp+ToZwvLNoZ9l/Kub+FLxqSG0pkLadgC+5vuko180VO1fGfQ0eO+csQHL
	uT7tZe6fDDEbrs76S59DPeh7lnNA2EIN2O+mod96zw29gZHXmS8iNqjKKX69Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277137;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D1+QhUSutOTnCFdNgJIy1ND+xr1gyO4p/+sVSr7ghcc=;
	b=rnmED8lzaepFxkU7jOh0S2Q8/ag0TEWMmJgF2HC9xfPbbcEzqMelFgaFzcqcxG+liq0qor
	cFilAhIidGK1ufDw==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Always stop dl-server before
 changing parameters
Cc: Yuri Andriaccio <yurand2000@gmail.com>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C20250721-upstream-fix-dlserver-lessaggressive-b4-v?=
 =?utf-8?q?1-1-4ebc10c87e40=40redhat=2Ecom=3E?=
References: =?utf-8?q?=3C20250721-upstream-fix-dlserver-lessaggressive-b4-v1?=
 =?utf-8?q?-1-4ebc10c87e40=40redhat=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627713512.1920.8854712203683421367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     bb4700adc3abec34c0a38b64f66258e4e233fc16
Gitweb:        https://git.kernel.org/tip/bb4700adc3abec34c0a38b64f66258e4e23=
3fc16
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Mon, 21 Jul 2025 15:01:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 10:46:00 +02:00

sched/deadline: Always stop dl-server before changing parameters

Commit cccb45d7c4295 ("sched/deadline: Less agressive dl_server
handling") reduced dl-server overhead by delaying disabling servers only
after there are no fair task around for a whole period, which means that
deadline entities are not dequeued right away on a server stop event.
However, the delay opens up a window in which a request for changing
server parameters can break per-runqueue running_bw tracking, as
reported by Yuri.

Close the problematic window by unconditionally calling dl_server_stop()
before applying the new parameters (ensuring deadline entities go
through an actual dequeue).

Fixes: cccb45d7c4295 ("sched/deadline: Less agressive dl_server handling")
Reported-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lore.kernel.org/r/20250721-upstream-fix-dlserver-lessaggressive=
-b4-v1-1-4ebc10c87e40@redhat.com
---
 kernel/sched/debug.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 3f06ab8..02e16b7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -376,10 +376,8 @@ static ssize_t sched_fair_server_write(struct file *filp=
, const char __user *ubu
 			return  -EINVAL;
 		}
=20
-		if (rq->cfs.h_nr_queued) {
-			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
-		}
+		update_rq_clock(rq);
+		dl_server_stop(&rq->fair_server);
=20
 		retval =3D dl_server_apply_params(&rq->fair_server, runtime, period, 0);
 		if (retval)

