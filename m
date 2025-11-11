Return-Path: <linux-tip-commits+bounces-7308-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA331C4F0AF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 17:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C06189ACB0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88787354700;
	Tue, 11 Nov 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mD3jyXI/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1epcTIyp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FB33128D0;
	Tue, 11 Nov 2025 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878785; cv=none; b=bC+HIqRh0U1yIkn7eiisIFPXm1LV7OCWBNB9U/LBJWnYO6/DpAa9fHHMe6vccen1WApyC/qN8KvznTIaRiciFd9/V6P/hv4E5GqxMaEYzvii6TIcZY/m70lLs3LHoq7dIlF/tEqFfxsTJUro7s8MOX3D6NiKu8Qd81Ot+tNI0Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878785; c=relaxed/simple;
	bh=S5P/PhEdoD2k2xnS/aZY8xWRfjQ1chwbdFYooGWzon4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QFReGm4zCcgTxRDhHIChVrBpNSoSR0mHbjjCCHW7k6acOdRl4tX/l3/HpgdZBR6iRNaB+qM0t8VAog3iWVG6AIY5FsL6vfgqZZLqNX65f86tyMqSdj4zyKfryp07wLYxiP3BowZB0jaNpDjdMsuwxTHOpp4yiEXLl06kI3+Id40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mD3jyXI/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1epcTIyp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 16:33:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762878781;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ES7vbUa4cgoLAOp81KRbnzRbKDkr2RwaSrBkEXBX7jc=;
	b=mD3jyXI/W0PEaLF6BAd70FnwKIU+WsO+YDTOhXNzO+5U9tTGmFwz05zVW/DoaXM3LjBQmL
	c55K8lPH5T+CAvfQxi7s1StE7dk3vqYjXtEQWhAJYaiz7gouraPyGY+sdRxTYi/6+6NKUe
	udXBmEqKuGZ7ECs+3b/an7e3+w8w4vH55o/2f3GIZ5gA1IqSu8EKwFp/T7C1B6uo7QztYd
	jMhzQQWrAVzPiWCvLleV/0EBIuI4VtOA32QcSXU5u2ZBhLaJcSS7nPq0d1oAhTqQ8lz8Re
	7jXV2fIOdsP9SNgT4O2sb6BfSSb2+5LAHoNB0CVRDA///Wvsq81cptgG/d3ePQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762878781;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ES7vbUa4cgoLAOp81KRbnzRbKDkr2RwaSrBkEXBX7jc=;
	b=1epcTIypyhCMBiuj9PtM4OfehUeOr5rbtI4TmrSoreoX3u6BP14UFyADNVcvkCXDvqLWAa
	WbfoPLmlQOuJ3uAg==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/deadline: Minor cleanup in select_task_rq_dl()
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251014100342.978936-2-sshegde@linux.ibm.com>
References: <20251014100342.978936-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176287878001.498.15264501628715691732.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     65177ea9f64d7402a0b8028e0dbbd01e8a9d1b1d
Gitweb:        https://git.kernel.org/tip/65177ea9f64d7402a0b8028e0dbbd01e8a9=
d1b1d
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Tue, 14 Oct 2025 15:33:41 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 17:27:55 +01:00

sched/deadline: Minor cleanup in select_task_rq_dl()

In select_task_rq_dl, there is only one goto statement, there is no
need for it.

No functional changes.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://patch.msgid.link/20251014100342.978936-2-sshegde@linux.ibm.com
---
 kernel/sched/deadline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 4dd4b2f..67f540c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2384,7 +2384,7 @@ select_task_rq_dl(struct task_struct *p, int cpu, int f=
lags)
 	struct rq *rq;
=20
 	if (!(flags & WF_TTWU))
-		goto out;
+		return cpu;
=20
 	rq =3D cpu_rq(cpu);
=20
@@ -2422,7 +2422,6 @@ select_task_rq_dl(struct task_struct *p, int cpu, int f=
lags)
 	}
 	rcu_read_unlock();
=20
-out:
 	return cpu;
 }
=20

