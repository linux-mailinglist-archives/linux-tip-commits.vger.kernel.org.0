Return-Path: <linux-tip-commits+bounces-5800-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22387AD8482
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA063B31E6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7502EA488;
	Fri, 13 Jun 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GTCYFJkK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ggblss/h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7132E92CD;
	Fri, 13 Jun 2025 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800247; cv=none; b=bSQ7ttCMQZ9g3dOgG2ElnllqZLmlUIijlrlDUudQGwlUIEKxMS76iJH/XYeCZfM2MnOxX2tCK9p6VEK5xB9MtkOU9hSdTKij5nlWOkQ9Mqmi+/EJvwrmKWO8aU98400RpP36f30uGvtRGmOfwPWDuKywf6P8pBJ2DRV45w+n8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800247; c=relaxed/simple;
	bh=dYq8od3uvRwYXEhtJAcLtRYpcEj6/ncbPplBpFE/bvc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Us5NcG/ZMMtJ3v6zW4g3jXUyf/q7X5LJwZlB8Oil0iqRwamKE92YBdZ2gaO2J811ISc7g0sdPSDhz5mfsxI7q9Ceq0kjtrSbXFBL0agWGqpu3FvmRzlQhgHxWZXfLJskcyIJF1iKQLgnr/NyGvN8udIH7a2SjG+HOIluDhOg+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GTCYFJkK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ggblss/h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0yOyy0+idcYjgS0nbumL3KJaQPxqZ/vE39Hd5VCn0I=;
	b=GTCYFJkKt/cPZ0iMNF+NapfMxZoWtOrQjzkzXkQ2T2VuRGUln89uEv4TvL6J7sFhT79iVF
	24hjPoBo1oGJ1mg1EFnkhtWHmPBLPXAfWEn0i28vERRTXrivOTPcZGOb1/TRt2QUCbI0Wi
	UYNKRjM4/PsgQPc3pD5wZoPB83VDylYK2ADirdlkmieFf8EivixHK7C+BYKQItXm5vOfzg
	rwjz1BdcFwj/pmr5aw1e5mvgFXRrrTkbwdd8KMYodjtUiMYU9EhmbX+2qLiKYyNCZrvbxa
	pOgXNmKPe5ePutNOkopO/aNuaw2dNupBY162EFIO2jsH9xYzc+qBFXW/bEct+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800244;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0yOyy0+idcYjgS0nbumL3KJaQPxqZ/vE39Hd5VCn0I=;
	b=Ggblss/hbwwwaBBDBD7KKzM3i8uF20a55hZ3N+20vKey/6As4CPHPJKFMhzWKhzRL3U4wP
	LkKHraAlLmK9lRCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of try_to_wake_up()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-24-mingo@kernel.org>
References: <20250528080924.2273858-24-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024305.406.17376063791408775212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d0a0a055a58617ac8dd9418f08346e94310f1096
Gitweb:        https://git.kernel.org/tip/d0a0a055a58617ac8dd9418f08346e94310f1096
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:19 +02:00

sched/smp: Use the SMP version of try_to_wake_up()

Simplify the scheduler by making CONFIG_SMP=y logic within
try_to_wake_up() unconditional.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-24-mingo@kernel.org
---
 kernel/sched/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c155ee0..d20fea6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4202,7 +4202,6 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 			break;
 
-#ifdef CONFIG_SMP
 		/*
 		 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 		 * possible to, falsely, observe p->on_cpu == 0.
@@ -4281,9 +4280,6 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 			psi_ttwu_dequeue(p);
 			set_task_cpu(p, cpu);
 		}
-#else /* !CONFIG_SMP: */
-		cpu = task_cpu(p);
-#endif /* !CONFIG_SMP */
 
 		ttwu_queue(p, cpu, wake_flags);
 	}

