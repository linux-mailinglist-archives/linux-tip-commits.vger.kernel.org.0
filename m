Return-Path: <linux-tip-commits+bounces-1347-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C61B8FD13A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 16:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA31F25CF8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Jun 2024 14:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E5C3A8C0;
	Wed,  5 Jun 2024 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jjdi6VfW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9FkO87nl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED827702;
	Wed,  5 Jun 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599279; cv=none; b=AP38hH9qdPvN5Lxord5dCUksvDKMD4exglex0BBvQloi5THv+4rkoCH+bLurEz11TfY99v4pppYFkqhvr9o4HDUYj05oh6GXctchCHsvmqN3hqoQSpkIiODkC4ut+d75/KIzGqybeFQOWX3mBVjxOiwuHeeLN4rtWloanaJJYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599279; c=relaxed/simple;
	bh=NHDlMq4zVASGYwP3wqLssSIjtLD9lNecBMZVvGRfQlU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EGtRZEg9NsqLXZMWtyArYhNrDFOWxIL9mGDV9Y3GPyBImnAcFlHHPQg7rtLs7Pcu4bEMr+BspdYCdbgvbukGDr39FEWTgrVTC2POq9VSwjEuXKQ1vKxpElHwVoSBKC2FsgtaXPcmFIUVZ/eGqxf8PRax/DQiX/AdcsoFf9D5FCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jjdi6VfW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9FkO87nl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Jun 2024 14:54:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717599273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mrh43luRsp07N3QOm2XsMjER4wk/H8Bu+bitFmDc+Sg=;
	b=jjdi6VfWEs7kOJAOA1ruNjIOkGbdGos1W2lK5rMwobEmaIyVnqc6rzBdYicz8b6KEMUeUh
	3003g6eq3BCzkm59pqj7KpAHiXB03rt+Q84KnQ8Rrtp1IotgcfkF1ZaqhkKn5XAdn7ZGrd
	YpD4el09dYOj6QWJ8vYSynvvomwap1GGPuHIrjMuIy3naTGDjmDVaGPx84jyHvqrVUHRh1
	qjHshKIO3KVBIsUmWBIAKURnKDRLbEU9N7WGTXa9X6I02DG4bSY3hzD9KCHa7o3wgQeENi
	IC4BWpu4rC4L62JBANso5b7rGrYQR8JRLzmJcEfo5sCJ/dL6r43uUWymuVIr4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717599273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mrh43luRsp07N3QOm2XsMjER4wk/H8Bu+bitFmDc+Sg=;
	b=9FkO87nlMFhungtmOEpHEplD3AXK9cVKS1w59FmlBKTrMAGhOgUWPJRUGmYBoJJl7smDhh
	kD7sMFCz4nsfzZCA==
From: "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/balance: Skip unnecessary updates to idle
 load balancer's flags
Cc: Tim Chen <tim.c.chen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
References: <20240531205452.65781-1-tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171759927306.10875.2450909647126184930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f90cc919f9e5cbfcd0b952290c57ef1317f4e91e
Gitweb:        https://git.kernel.org/tip/f90cc919f9e5cbfcd0b952290c57ef1317f=
4e91e
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Fri, 31 May 2024 13:54:52 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 05 Jun 2024 15:52:36 +02:00

sched/balance: Skip unnecessary updates to idle load balancer's flags

We observed that the overhead on trigger_load_balance(), now renamed
sched_balance_trigger(), has risen with a system's core counts.

For an OLTP workload running 6.8 kernel on a 2 socket x86 systems
having 96 cores/socket, we saw that 0.7% cpu cycles are spent in
trigger_load_balance(). On older systems with fewer cores/socket, this
function's overhead was less than 0.1%.

The cause of this overhead was that there are multiple cpus calling
kick_ilb(flags), updating the balancing work needed to a common idle
load balancer cpu. The ilb_cpu's flags field got updated unconditionally
with atomic_fetch_or().  The atomic read and writes to ilb_cpu's flags
causes much cache bouncing and cpu cycles overhead. This is seen in the
annotated profile below.

             kick_ilb():
             if (ilb_cpu < 0)
               test   %r14d,%r14d
             =E2=86=91 js     6c
             flags =3D atomic_fetch_or(flags, nohz_flags(ilb_cpu));
               mov    $0x2d600,%rdi
               movslq %r14d,%r8
               mov    %rdi,%rdx
               add    -0x7dd0c3e0(,%r8,8),%rdx
             arch_atomic_read():
  0.01         mov    0x64(%rdx),%esi
 35.58         add    $0x64,%rdx
             arch_atomic_fetch_or():

             static __always_inline int arch_atomic_fetch_or(int i, atomic_t =
*v)
             {
             int val =3D arch_atomic_read(v);

             do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
  0.03  157:   mov    %r12d,%ecx
             arch_atomic_try_cmpxchg():
             return arch_try_cmpxchg(&v->counter, old, new);
  0.00         mov    %esi,%eax
             arch_atomic_fetch_or():
             do { } while (!arch_atomic_try_cmpxchg(v, &val, val | i));
               or     %esi,%ecx
             arch_atomic_try_cmpxchg():
             return arch_try_cmpxchg(&v->counter, old, new);
  0.01         lock   cmpxchg %ecx,(%rdx)
 42.96       =E2=86=93 jne    2d2
             kick_ilb():

With instrumentation, we found that 81% of the updates do not result in
any change in the ilb_cpu's flags.  That is, multiple cpus are asking
the ilb_cpu to do the same things over and over again, before the ilb_cpu
has a chance to run NOHZ load balance.

Skip updates to ilb_cpu's flags if no new work needs to be done.
Such updates do not change ilb_cpu's NOHZ flags.  This requires an extra
atomic read but it is less expensive than frequent unnecessary atomic
updates that generate cache bounces.

We saw that on the OLTP workload, cpu cycles from trigger_load_balance()
(or sched_balance_trigger()) got reduced from 0.7% to 0.2%.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20240531205452.65781-1-tim.c.chen@linux.intel=
.com
---
 kernel/sched/fair.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 63113dc..41b5838 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11892,6 +11892,13 @@ static void kick_ilb(unsigned int flags)
 		return;
=20
 	/*
+	 * Don't bother if no new NOHZ balance work items for ilb_cpu,
+	 * i.e. all bits in flags are already set in ilb_cpu.
+	 */
+	if ((atomic_read(nohz_flags(ilb_cpu)) & flags) =3D=3D flags)
+		return;
+
+	/*
 	 * Access to rq::nohz_csd is serialized by NOHZ_KICK_MASK; he who sets
 	 * the first flag owns it; cleared by nohz_csd_func().
 	 */

