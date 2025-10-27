Return-Path: <linux-tip-commits+bounces-7019-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39817C0F569
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54A234F79E3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338DF31B108;
	Mon, 27 Oct 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rfYpJ9T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9SB7qpg8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179331A808;
	Mon, 27 Oct 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582678; cv=none; b=s/NBNJQqTGfjDQGj+sJlhoDE0rvJoFALRWoKzotSuEd8xAAv6K2HYtPzG5SPJsiI1lvJ4wRG4WgE41B2P8eenIvgt9JeGSGhZ7n1tjblqCHIncddoBLs3pagQSbiCsS8+eAllHFBNKcvFbmUUZlhWKsomopX9aagOdVhY4rlYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582678; c=relaxed/simple;
	bh=ZxZSa1ZfylznLU4VN2D/2jy69nmfrh3nwUBzsH6/JYE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gyUNc5O8s6okEXGZIPh+tdcesj3arO8Gjhe6R6SBlsQLWFuRIHXfTzgUZ44NwmOebJQ4aR58pidbDcPCBC+0sGbjmLD4fhYcNHVy9gZU5OviRFAoJD0+24NTq8ozUVBnS3r6F9wcVOTQRjYpr4VjDW6SmW9SKW8Tey4z8b5tjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rfYpJ9T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9SB7qpg8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcMffBziDFA9yLxG2c9VbIxKK28QFQmTqIwccxxOoII=;
	b=0rfYpJ9TxGrwiD9LXKPEXkfCDBlZznYc4kkf1mlLGdHIoK8ENxhF4KQzb936dmYMM6IPt5
	OgzetEfDFKk0wQmah6HnjB3sa5+TeOZhvs5C9CuMRP+KxRytT0c618Xb3gXLHj31IxgGaT
	bb/qgen4bvPn8gFGsEB9Z/Ty19OMTmbC8CkDBbBDf/4DVyBNh72QU/UQFyAEiyx3IRLYF1
	MuXLjC+0SSe5lHA6k7SlZYAJgqZtXbbF5ImXfYINd4P8zqeI14gAW8DYzVm+M8S+JB2Wd4
	BMsP3hTHV3NAK64XKRC36Zmh4elCTmuzA4buMld92yJg7GKmbZ3C6DmDUV7TPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcMffBziDFA9yLxG2c9VbIxKK28QFQmTqIwccxxOoII=;
	b=9SB7qpg8CLdtj7wez0jYjmJR1SPIrmftgRwWe3ArDnXiu7sWLO0XI3p0yajdMFjTLaZ4xE
	xWPpU/Sad2HiO4AA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] perf: arm_pmu: Convert to the new interrupt affinity
 retrieval API
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-9-maz@kernel.org>
References: <20251020122944.3074811-9-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158267407.2601451.3943491086976905751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     663783e0013e97e18cc167139ab4319bbeaea399
Gitweb:        https://git.kernel.org/tip/663783e0013e97e18cc167139ab4319bbea=
ea399
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:33 +01:00

perf: arm_pmu: Convert to the new interrupt affinity retrieval API

Now that the relevant interrupt controllers are equipped with a callback
returning the affinity of per-CPU interrupts, switch the OF side of the ARM
PMU driver over to this new method.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20251020122944.3074811-9-maz@kernel.org
---
 drivers/perf/arm_pmu_platform.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 118170a..9c0494d 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -42,14 +42,13 @@ static int probe_current_pmu(struct arm_pmu *pmu,
 	return ret;
 }
=20
-static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq)
+static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq,
+				const struct cpumask *affinity)
 {
-	int cpu, ret;
 	struct pmu_hw_events __percpu *hw_events =3D pmu->hw_events;
+	int cpu;
=20
-	ret =3D irq_get_percpu_devid_partition(irq, &pmu->supported_cpus);
-	if (ret)
-		return ret;
+	cpumask_copy(&pmu->supported_cpus, affinity);
=20
 	for_each_cpu(cpu, &pmu->supported_cpus)
 		per_cpu(hw_events->irq, cpu) =3D irq;
@@ -115,9 +114,12 @@ static int pmu_parse_irqs(struct arm_pmu *pmu)
 	}
=20
 	if (num_irqs =3D=3D 1) {
-		int irq =3D platform_get_irq(pdev, 0);
+		const struct cpumask *affinity;
+		int irq;
+
+		irq =3D platform_get_irq_affinity(pdev, 0, &affinity);
 		if ((irq > 0) && irq_is_percpu_devid(irq))
-			return pmu_parse_percpu_irq(pmu, irq);
+			return pmu_parse_percpu_irq(pmu, irq, affinity);
 	}
=20
 	if (nr_cpu_ids !=3D 1 && !pmu_has_irq_affinity(dev->of_node))

