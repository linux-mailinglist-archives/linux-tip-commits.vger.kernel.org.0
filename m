Return-Path: <linux-tip-commits+bounces-6243-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC8EB21313
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Aug 2025 19:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE086263C3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Aug 2025 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B722D3ED2;
	Mon, 11 Aug 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DpM8TDKg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z/vB4VX4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659B29BDBA;
	Mon, 11 Aug 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933115; cv=none; b=utyvEdksbXIuGx2LZfeqU0nndNuEcBaWvBUrDyK769IpQuLejKj9X/OC2cwc4IEmTPJjhP2sJiCdbynW8/WOahadWl/9MflWoPZxrVD/OiwhT3KIOXtSTOJyjUqaDrOx4ssYtrzeVkugzsmFUC4cZRHQamW2B4GNsWmPPsEE2zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933115; c=relaxed/simple;
	bh=Mr51pGZCpLW0ChniTNNlm3LmAhUQ+EpAcSf5C6gpb3Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HAcG0XAFtDFjm+HShIZX0vSDge2xesyPtcdjn6Ebg/8Arj3AFimYihdFXdi6WAa9L8YfQ0t9Rqd1+Xv7sRI5y2+kVFoTArDlIwXnQtwFDqYKwNAXDUrSyXWcNWrVGdIei0rRZk5pKe3IZ6iWgSmAJnWWvSfeJyva/1Zss1xJ+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DpM8TDKg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z/vB4VX4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Aug 2025 20:59:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754933111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqsES6jVDc9uIRKGOc6ivp3AYGfhaE85QUu5RbHj7dA=;
	b=DpM8TDKgmG/STbBNNrDm8cdgsizhKKXVzqODZHWZP1mC3pCviemhsrk5pxtYHW21OLMGP9
	DVclq9eUsdcdKPGMXIa0sADYT3AySCuFPLyswKXjL11CXlXzJQEvwZjBCfTvr3nFS90zzs
	gSqvnhgx9YpO2oiqHsTWxpBO8i/+BjJIq4UL3kuKImyyLLr2fZ6KdCdfsgmSuiv3S38UoY
	SYY2bx97KvRIAe3pbGUQes3QM2VPhjWUxWNg3PqliIyYoRHPc6mvFYkkTLrYzRbTdgUzN7
	OZofpAftcctSfdgziidjofhuNU3HM5T6GxQ/KrlSAEskciQl0gVlAo3He7jWkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754933111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqsES6jVDc9uIRKGOc6ivp3AYGfhaE85QUu5RbHj7dA=;
	b=Z/vB4VX4G4fLicIt/LytN3sStW9xICqRDVYlgJYUvDNs8St6Edt20P3R8e5WkYBlGjBBIx
	wj7mZAPkfU1GhFDw==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/urgent] cpu: Remove obsolete comment from takedown_cpu()
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250729191232.664931-1-longman@redhat.com>
References: <20250729191232.664931-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175451397101.1420.5655871917271400595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the smp/urgent branch of tip:

Commit-ID:     da274853fe7dbc7124e2dd84dad802be52a09321
Gitweb:        https://git.kernel.org/tip/da274853fe7dbc7124e2dd84dad802be52a=
09321
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Tue, 29 Jul 2025 15:12:32 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 06 Aug 2025 22:48:12 +02:00

cpu: Remove obsolete comment from takedown_cpu()

takedown_cpu() has a comment about "all preempt/rcu users must observe
!cpu_active()" which is kind of meaningless in this function. This
comment was originally introduced by commit 6acce3ef8452 ("sched: Remove
get_online_cpus() usage") when _cpu_down() was setting cpu_active_mask
and synchronize_rcu()/synchronize_sched() were added after that.

Later commit 40190a78f85f ("sched/hotplug: Convert cpu_[in]active
notifiers to state machine") added a new CPUHP_AP_ACTIVE hotplug
state to set/clear cpu_active_mask. The following commit b2454caa8977
("sched/hotplug: Move sync_rcu to be with set_cpu_active(false)")
move the synchronize_*() calls to sched_cpu_deactivate() associated
with the new hotplug state, but left the comment behind.

Remove this comment as it is no longer relevant in takedown_cpu().

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250729191232.664931-1-longman@redhat.com

---
 kernel/cpu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index faf0f23..db9f6c5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1309,9 +1309,6 @@ static int takedown_cpu(unsigned int cpu)
 	 */
 	irq_lock_sparse();
=20
-	/*
-	 * So now all preempt/rcu users must observe !cpu_active().
-	 */
 	err =3D stop_machine_cpuslocked(take_cpu_down, NULL, cpumask_of(cpu));
 	if (err) {
 		/* CPU refused to die */

