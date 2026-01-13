Return-Path: <linux-tip-commits+bounces-7903-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04515D1824D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF06530A838B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC14363C56;
	Tue, 13 Jan 2026 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cb0R+EBs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gNopdmfk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25493310636;
	Tue, 13 Jan 2026 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301011; cv=none; b=gcLzowiFSrv/5wRT43eQZzSDhRVLISVRD8Pzuz44mkqCjLK0uyHgljtRKy/T6ksQ/a4h24PkskcHcEJ1Qt5bNHB0TqG1xR9s/jDACssSFcLjOCQZp8ncDzZe10+FVWtm0KVew5blwhWUugMsQ/nYUHHLOTTTOEEQdRZoPt+W2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301011; c=relaxed/simple;
	bh=rTQ5ilbLC0isP7eQXoJMs9uBfGBIGCTrYW2gf81QLx4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r2N7apTmhb7RIIXi12Z+LL2dusIk5Uq9NztRCOEEkJiAyT+U5gVOTOR9PLO6RXzaHUnurzpdcWOaiaPmIfzpY2QlksvoGmLZb6T0WH67X1JLuZLZ4ckpgm5arP5SzApLx3J5YB18a8pLe3FZhH4ZgsPtkFTnpBSg7+tD+KUvygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cb0R+EBs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gNopdmfk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:43:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ICNrIUHeGiXrxMspEjkekFmiVCGrnAbejhskcnMOIM=;
	b=Cb0R+EBsCNFcZii2b3gl7jdHqs+VkPc+KJ3Nv/I+DKUcBpn2prtBlrUuY4mVnZe5doM6KI
	v7ymiumv2PdAto6wNXAAHQw/vHeopc8H+xa5xDkL5U/4qqyEx6eOMvZSIKB3AJqcPBk+qs
	sTuhZPnqRy/mPD2or0sPkqd4/xdPJOHFeLN89388D71rvsS2ew2toSvlqHzz2C7A0lH3fZ
	FOgCXr9vZAzlQWTGsE77YgA1ZkPoxP4MFgUE80ARafR3/mo8vIwpmUvRtFBuqW+JJ7T90s
	xDFZF4orNiWLMQCBs5C1JtZrwClI2U8Q+nmbeiTzCidfnftpof/5QZBHuPEJyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ICNrIUHeGiXrxMspEjkekFmiVCGrnAbejhskcnMOIM=;
	b=gNopdmfkUIxVqzaDH9hg4+18EmnpZwLP5icbsDZYJgSO6wJ/NiJNfMriX3NiiNFQhbhhfs
	tJZqIWp5iyiy/VAg==
From: "tip-bot2 for Pingfan Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/deadline: Remove unnecessary comment in
 dl_add_task_root_domain()
Cc: Pingfan Liu <piliu@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251125032630.8746-2-piliu@redhat.com>
References: <20251125032630.8746-2-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830100737.510.9606757321996709253.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     479972efc2e7c9e0b3743ac538b042fcd4f315d7
Gitweb:        https://git.kernel.org/tip/479972efc2e7c9e0b3743ac538b042fcd4f=
315d7
Author:        Pingfan Liu <piliu@redhat.com>
AuthorDate:    Tue, 25 Nov 2025 11:26:29 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 11:37:51 +01:00

sched/deadline: Remove unnecessary comment in dl_add_task_root_domain()

The comments above dl_get_task_effective_cpus() and
dl_add_task_root_domain() already explain how to fetch a valid
root domain and protect against races. There's no need to repeat
this inside dl_add_task_root_domain(). Remove the redundant comment
to keep the code clean.

No functional change.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://patch.msgid.link/20251125032630.8746-2-piliu@redhat.com
---
 kernel/sched/deadline.c |  9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 319439f..463ba50 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3162,20 +3162,11 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
=20
-	/*
-	 * Get an active rq, whose rq->rd traces the correct root
-	 * domain.
-	 * Ideally this would be under cpuset reader lock until rq->rd is
-	 * fetched.  However, sleepable locks cannot nest inside pi_lock, so we
-	 * rely on the caller of dl_add_task_root_domain() holds 'cpuset_mutex'
-	 * to guarantee the CPU stays in the cpuset.
-	 */
 	dl_get_task_effective_cpus(p, msk);
 	cpu =3D cpumask_first_and(cpu_active_mask, msk);
 	BUG_ON(cpu >=3D nr_cpu_ids);
 	rq =3D cpu_rq(cpu);
 	dl_b =3D &rq->rd->dl_bw;
-	/* End of fetching rd */
=20
 	raw_spin_lock(&dl_b->lock);
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));

