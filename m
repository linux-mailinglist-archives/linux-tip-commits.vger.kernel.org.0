Return-Path: <linux-tip-commits+bounces-7020-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACFDC0F572
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42F2D4F8429
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D731B824;
	Mon, 27 Oct 2025 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I12epk6u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7e8YCYhw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01E31AF34;
	Mon, 27 Oct 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582679; cv=none; b=D8vSsgvECZKeifDcsSTJ1D9XsvFyzQvIwjqfw6qBCq/w6SrNtGJthuiByidiG48fRqMb+TsNfpvu1jJCWup4CRRBgquJt6Yu66VJoK492RLXY8DoRPQnydTgQZDhxW8HxG8BWIq2rQwSPunzknYUKAAfceSHffyOAj7W9cfhRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582679; c=relaxed/simple;
	bh=zjgrX62ffPrMfWjFtLNrAODRymX0+1YdfY+MMR82aQU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UFrLRdYXD5r54B3kuYojmD0KtLUY30j/PJ2/asmPLYLYU6q69l7NCT6jvZgbUYOOy7wl3rX5mNOqE4pccPPGn939HUf6BpGIFQnKr+xGnlQQiTk7W7qlcLJk6ECyURPBziirzN9RoVI04ijlkxCW6/RUlvgu2IRGPCdzx6y3qK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I12epk6u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7e8YCYhw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoVf1AP0n8+UpCp6Li6QkT0p7+kLQ2OFlxBhQ3WqL6s=;
	b=I12epk6unp/KQ+lkPa+HYf9pcEq7nLWq7LEP27EFk6IOEAPZore3R+nwuN1DrRu2K1Dmle
	0MvoJdg46Ps4iogK0sa1R7OM2mCwwW9ZaGSu5OdLh2WRK7XaSxPKsLlC15MrGueR9kP8zZ
	FPj2fmvE8+alhQhFsZO8xLT9mcPMyCzkdbji6FSpPtcLerVWH+ilQL7bnRvEHs1nXNMt0i
	2ubwHz6KMCAMuK2EGHjHJn4PMW/Jc+h8NwdW20QgW8A72/VmCEUHbNlkGWWe28xrktnvtV
	VbHcYqGgNDw+dRp610VZ2KpKiGQQbXhLrjX08fnik9CJhEpSxFG8mmKybcUDCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582676;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoVf1AP0n8+UpCp6Li6QkT0p7+kLQ2OFlxBhQ3WqL6s=;
	b=7e8YCYhwUnOVsPU7OS3KW9c0aW+MVOUvJC1SKi2pKIZkdBB+cgvw4rnBNfugTZ8WvJ7FVd
	aES5vJ4Ru6i2Z4AQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] coresight: trbe: Convert to the new interrupt
 affinity retrieval API
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-8-maz@kernel.org>
References: <20251020122944.3074811-8-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158267527.2601451.15391948947877379464.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     541454dd204b66c9f03761e00a28ad9702b24829
Gitweb:        https://git.kernel.org/tip/541454dd204b66c9f03761e00a28ad9702b=
24829
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:33 +01:00

coresight: trbe: Convert to the new interrupt affinity retrieval API

Now that the relevant interrupt controllers are equipped with a callback
returning the affinity of per-CPU interrupts, switch the TRBE driver over
to this new method.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://patch.msgid.link/20251020122944.3074811-8-maz@kernel.org
---
 drivers/hwtracing/coresight/coresight-trbe.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing=
/coresight/coresight-trbe.c
index 43643d2..8f17160 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1474,9 +1474,10 @@ static void arm_trbe_remove_cpuhp(struct trbe_drvdata =
*drvdata)
 static int arm_trbe_probe_irq(struct platform_device *pdev,
 			      struct trbe_drvdata *drvdata)
 {
+	const struct cpumask *affinity;
 	int ret;
=20
-	drvdata->irq =3D platform_get_irq(pdev, 0);
+	drvdata->irq =3D platform_get_irq_affinity(pdev, 0, &affinity);
 	if (drvdata->irq < 0) {
 		pr_err("IRQ not found for the platform device\n");
 		return drvdata->irq;
@@ -1487,8 +1488,7 @@ static int arm_trbe_probe_irq(struct platform_device *p=
dev,
 		return -EINVAL;
 	}
=20
-	if (irq_get_percpu_devid_partition(drvdata->irq, &drvdata->supported_cpus))
-		return -EINVAL;
+	cpumask_copy(&drvdata->supported_cpus, affinity);
=20
 	drvdata->handle =3D alloc_percpu(struct perf_output_handle *);
 	if (!drvdata->handle)

