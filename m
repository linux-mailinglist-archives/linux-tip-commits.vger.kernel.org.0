Return-Path: <linux-tip-commits+bounces-3205-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE050A0B792
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2025 13:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C13A3E03
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2025 12:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB9E2343D8;
	Mon, 13 Jan 2025 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rl9m9kMB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SLRPx0DM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0CF231C80;
	Mon, 13 Jan 2025 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736773137; cv=none; b=Dh5hukjaW93o6qX9aFwmLYllPfRxHDfuhf0L+qlIPIiaHQcv0Qnjdbhxvw3v8Qldp28EJh1X9b+bl1j0oHrsEQsoAAoGYlVCmGHJiLCjj9i+T1Sa9JW/kwQd2RbOXve7yk6724jnZmPimarU2FjLFFSUMwXo8zt+QreneAM6d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736773137; c=relaxed/simple;
	bh=5ipG2t313edebld4lL3Enc3vCiGGX+4exEpy7Sp0Vgg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Sq/E6+I3Gbj5Bn9zle6s5Sk/eBdNDEDHzgdQ+5n7hjeMUxbMX8XtMn68qZx04h7Svw43FjUNRWikATkMDd2YI3GawF9g2TJuachPp64pRM0NuRwJn3YxkWv0rDMaYN8MVlYrdQG4s3DnndS1qoY6O6QvFEvAF2pGV0+mXseLxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rl9m9kMB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SLRPx0DM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Jan 2025 12:58:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736773133;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meQVfGS8Sz8xxnmyq070nFsX7qCieDlmqzhsoo3AOas=;
	b=rl9m9kMBgLT2LK4q/S0jwu7WQFuKuPzKoec2IPOp4n9S3PF0ROyyNqoxjdLhdENwrWtfYc
	ytH3jSfIguEpesyMdAhGqmaTTnibqZ8IKIUvkPFgHPRlEZ/Sc+gYJrEhs1TH327s94iWie
	aooIwjS4tT5SsLU2HLBaFtUFCTiSKzwJvucWqoMa8XuMTN7holJiJ/jM+llu1gzwaHzPxb
	T3Bpsyw5TJ7oLf5S183KXWikD0c2A0cLAsUILq0RXh2PGgYO927TLhz+jDDjNE7oV8bVEk
	60/8ZDLvlURxcxp0ImiGkJ5svY2uMurvzXh5NnsgRL/NH8uqrXzzCfptEPPkuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736773133;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=meQVfGS8Sz8xxnmyq070nFsX7qCieDlmqzhsoo3AOas=;
	b=SLRPx0DMLZ3id2YXs3wj2DjczT0zSY+fqND2jeToKOP+x2N3Vbu+CPEC7SwIwkhymzmLcw
	0Sz3+iaNz3EHjfDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250110115720.GA17405@noisy.programming.kicks-ass.net>
References: <20250110115720.GA17405@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173677313261.399.16609836040504211717.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     66951e4860d3c688bfa550ea4a19635b57e00eca
Gitweb:        https://git.kernel.org/tip/66951e4860d3c688bfa550ea4a19635b57e00eca
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 13 Jan 2025 13:50:11 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jan 2025 13:50:56 +01:00

sched/fair: Fix update_cfs_group() vs DELAY_DEQUEUE

Normally dequeue_entities() will continue to dequeue an empty group entity;
except DELAY_DEQUEUE changes things -- it retains empty entities such that they
might continue to compete and burn off some lag.

However, doing this results in update_cfs_group() re-computing the cgroup
weight 'slice' for an empty group, which it (rightly) figures isn't much at
all. This in turn means that the delayed entity is not competing at the
expected weight. Worse, the very low weight causes its lag to be inflated,
which combined with avg_vruntime() using scale_load_down(), leads to artifacts.

As such, don't adjust the weight for empty group entities and let them compete
at their original weight.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250110115720.GA17405@noisy.programming.kicks-ass.net
---
 kernel/sched/fair.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eeed8e3..2695843 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3956,7 +3956,11 @@ static void update_cfs_group(struct sched_entity *se)
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
 	long shares;
 
-	if (!gcfs_rq)
+	/*
+	 * When a group becomes empty, preserve its weight. This matters for
+	 * DELAY_DEQUEUE.
+	 */
+	if (!gcfs_rq || !gcfs_rq->load.weight)
 		return;
 
 	if (throttled_hierarchy(gcfs_rq))

