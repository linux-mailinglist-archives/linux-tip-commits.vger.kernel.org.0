Return-Path: <linux-tip-commits+bounces-7301-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CC08CC4D6EE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E1FC34E19F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75935359FB5;
	Tue, 11 Nov 2025 11:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RK+D/wuU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uc3Ph0qq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5355535A12C;
	Tue, 11 Nov 2025 11:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861043; cv=none; b=EVrUr6cl2lzG1bsNf7WDWiopooyCLarwukbRigwdTa0hBeBcd4+blye3Ii/XFrrmNNXfFfQrAoWsG1QHaznvnsRJed/b+VuhZLNzSzBOSdQ5cqdTGuuJ0AyGymWX/sbh+bgJ6JQng0luEUAO5kJz4hY5z9efkvr3A8gqjswORuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861043; c=relaxed/simple;
	bh=cWE9WaxpXi5KP6XAPYvjGIVzy2I2kxp1K2BGN20XPdk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CMIzW5Nm9Zkw0a/RqgzwkP5ZIxqwr4G/cZISWwLvGz9U3OWS+C90Uh4RQgsDA9NHVNlTuJ+VAFebgsiIRF92f0/RASL8dnF2x8uW9ltFCBfeUwgCQmxwMds8Nc5yVtoUadlVq0F85pPR2/ie+wMXZXIwWbKIhnB26uhTwnPWhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RK+D/wuU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uc3Ph0qq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp68P68z8ZtkPG4Im1g91sUXH5C8B8K3j+KRVHSBHqw=;
	b=RK+D/wuUYgNaWpHECbQj3enC5dB1Uf781AC/XmgTW8rWasNOVE0SciB5D6pd9Bi0GDhxjN
	DY3EydKTbw+Mi5+qOaX5jxGR2xE2vjHkAfF6VRYw4L8zrXqUog/p7vwIfb9Iu2aTpwFV0s
	vO3NoP5w7ogRdsDK4fdbAtaYRg3Dknn900ex8rRBBxhEoKE+4fA7UHhPsuIz/yeOJd8Rvh
	k3oV2x4gagbs21i87IEo7BGLOZgXNgDHKF37c1TAMhNhpa+vNUWaAab/GrByXZF36vIMjK
	1JSATjGRpRDMmbACzOuuhdnabKdp5NECH7srD9o59M2fXBslIUiHWZxVmN/YWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rp68P68z8ZtkPG4Im1g91sUXH5C8B8K3j+KRVHSBHqw=;
	b=Uc3Ph0qq5Qrh4GtlvmDOwVIbUJT48UG/oZc/r/COlLWyb5rxe5a1DjMJuh/JJuF+XOv0hb
	fR8RZvhjIumuF/CQ==
From: "tip-bot2 for Hao Jia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Remove double update_rq_clock() in
 __set_cpus_allowed_ptr_locked()
Cc: Hao Jia <jiahao1@lixiang.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029093655.31252-1-jiahao.kernel@gmail.com>
References: <20251029093655.31252-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286103844.498.12254783433336302431.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e40cea333e60c548e047eaddec6ca48c6632424b
Gitweb:        https://git.kernel.org/tip/e40cea333e60c548e047eaddec6ca48c663=
2424b
Author:        Hao Jia <jiahao1@lixiang.com>
AuthorDate:    Wed, 29 Oct 2025 17:36:55 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:38 +01:00

sched/core: Remove double update_rq_clock() in __set_cpus_allowed_ptr_locked()

Since commit d4c64207b88a ("sched: Cleanup the sched_change NOCLOCK usage"),
update_rq_clock() is called in do_set_cpus_allowed() -> sched_change_begin()
to update the rq clock. This results in a duplicate call update_rq_clock()
in __set_cpus_allowed_ptr_locked().

While holding the rq lock and before calling do_set_cpus_allowed(),
there is nothing that depends on an updated rq_clock.

Therefore, remove the redundant update_rq_clock() in
__set_cpus_allowed_ptr_locked() to avoid the warning about double
rq clock updates.

Fixes: d4c64207b88a ("sched: Cleanup the sched_change NOCLOCK usage")
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://patch.msgid.link/20251029093655.31252-1-jiahao.kernel@gmail.com
---
 kernel/sched/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67b5f2f..68f19aa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2999,8 +2999,6 @@ static int __set_cpus_allowed_ptr_locked(struct task_st=
ruct *p,
 	unsigned int dest_cpu;
 	int ret =3D 0;
=20
-	update_rq_clock(rq);
-
 	if (kthread || is_migration_disabled(p)) {
 		/*
 		 * Kernel threads are allowed on online && !active CPUs,

