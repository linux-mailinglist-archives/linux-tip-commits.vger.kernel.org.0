Return-Path: <linux-tip-commits+bounces-7001-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98638C0F4E5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 254AC4E7FAF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428630AAC8;
	Mon, 27 Oct 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CxSqRq6M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MjyLpKOk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05342C3242;
	Mon, 27 Oct 2025 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582656; cv=none; b=rLh+c7jkKtzrM+0pOfbzxH0Wf6AgxwA57/VFm3wMY8Xj4sfODx2EBMBT8VgTBnKnVp3m1Ou6XPhSjF36UkbxZ+oOKRSGkpTrxOzMPYdVYD6aM1J6jIFK5IdlvVrOWzSFwTM7sCO/S0aiFFo5GsNHzf/SBK7YUoI4CXbSv2sPrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582656; c=relaxed/simple;
	bh=bRcYH5iP5sGtcRja3oMVeK2qzp3Ewx3d9OtUM9SA/JQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dzq05hCW3E7LDLZyXhhMEfWGnu5Rj86uC/zJ9q9y/lQQAAkxjPis7dNnGr/SrgDrb0HW4fW7ohwj9T+74ubRHuFGjsdo51uS8kuN25UVyaRigJhO5G/8LQBgZx/PRXP6Syaf5Np+9GIxg5xUZqkTq8CRjn8zwWesFzxOHIUQe/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CxSqRq6M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MjyLpKOk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:30:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSFQwXTF+e6TQRu2PFDOnuhPdz7Pnjb7HuEXEpVO070=;
	b=CxSqRq6M/6h+1xItobk+9iOdJCyKjDtGt0tnV+NBgXZg32KBErIrFfOPUJOFefgxzqDqQQ
	+nizhvUTGvN4QJgChhfz9y8FXnAgW2SIip29s96BnX6usa34IWUr2NjtazjFYv07WslJga
	xh6Ry+KNc6hA5Yd1ayh2b0Ns7B7vhHq8fWKne1U7xCuRqLR3gkjr3IYvElmVwah7ckv072
	BYaqRxt5oUbXLRWkhsJno5I3S6QiL8yvrTJ+W/vO0iiKDP+DAgd6yhSJb28VbziI43mPNq
	D3tItV56aqpDfTGmXrzKYySc7M4+ql4hAjfhc2f9GOqflrxQE8tD2OaD0yoGJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSFQwXTF+e6TQRu2PFDOnuhPdz7Pnjb7HuEXEpVO070=;
	b=MjyLpKOkUr8/z3zybPRDJJkguBDFnZRf0IZu3S+WQmbfSlclxMTnN5SKMu/BJcNCYi0mAG
	alLlNuIU5h7eNrAA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer
Cc: Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-27-maz@kernel.org>
References: <20251020122944.3074811-27-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158265018.2601451.13034572433944072857.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fa9d2777387346645a40ab37cfb0c37b3ef40cc9
Gitweb:        https://git.kernel.org/tip/fa9d2777387346645a40ab37cfb0c37b3ef=
40cc9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:37 +01:00

perf: arm_pmu: Kill last use of per-CPU cpu_armpmu pointer

Having removed the use of the cpu_armpmu per-CPU variable from the
interrupt handling, the only user left is the BRBE scheduler hook.

It is easy to drop the use of this variable by following the pointer to the
generic PMU structure, and get the arm_pmu structure from there.

Perform the conversion and kill cpu_armpmu altogether.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-27-maz@kernel.org
---
 drivers/perf/arm_pmu.c       | 5 -----
 drivers/perf/arm_pmuv3.c     | 2 +-
 include/linux/perf/arm_pmu.h | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 959ceb3..f7abd13 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -104,7 +104,6 @@ static const struct pmu_irq_ops percpu_pmunmi_ops =3D {
 	.free_pmuirq =3D armpmu_free_percpu_pmunmi
 };
=20
-DEFINE_PER_CPU(struct arm_pmu *, cpu_armpmu);
 static DEFINE_PER_CPU(int, cpu_irq);
 static DEFINE_PER_CPU(const struct pmu_irq_ops *, cpu_irq_ops);
=20
@@ -725,8 +724,6 @@ static int arm_perf_starting_cpu(unsigned int cpu, struct=
 hlist_node *node)
 	if (pmu->reset)
 		pmu->reset(pmu);
=20
-	per_cpu(cpu_armpmu, cpu) =3D pmu;
-
 	irq =3D armpmu_get_cpu_irq(pmu, cpu);
 	if (irq)
 		per_cpu(cpu_irq_ops, cpu)->enable_pmuirq(irq);
@@ -746,8 +743,6 @@ static int arm_perf_teardown_cpu(unsigned int cpu, struct=
 hlist_node *node)
 	if (irq)
 		per_cpu(cpu_irq_ops, cpu)->disable_pmuirq(irq);
=20
-	per_cpu(cpu_armpmu, cpu) =3D NULL;
-
 	return 0;
 }
=20
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 69c5cc8..ca8d706 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1064,7 +1064,7 @@ static int armv8pmu_user_event_idx(struct perf_event *e=
vent)
 static void armv8pmu_sched_task(struct perf_event_pmu_context *pmu_ctx,
 				struct task_struct *task, bool sched_in)
 {
-	struct arm_pmu *armpmu =3D *this_cpu_ptr(&cpu_armpmu);
+	struct arm_pmu *armpmu =3D to_arm_pmu(pmu_ctx->pmu);
 	struct pmu_hw_events *hw_events =3D this_cpu_ptr(armpmu->hw_events);
=20
 	if (!hw_events->branch_users)
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 6690bd7..bab26a7 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -132,8 +132,6 @@ struct arm_pmu {
=20
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
=20
-DECLARE_PER_CPU(struct arm_pmu *, cpu_armpmu);
-
 u64 armpmu_event_update(struct perf_event *event);
=20
 int armpmu_event_set_period(struct perf_event *event);

