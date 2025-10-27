Return-Path: <linux-tip-commits+bounces-7018-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA3C0F596
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF6D1A23CBF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714B731AF09;
	Mon, 27 Oct 2025 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VkFU9MMP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fY/zp6aL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF16631A56D;
	Mon, 27 Oct 2025 16:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582677; cv=none; b=N8ipu12pLoVBIrEDcFIuNzpM3tsu2BbPRtJTUDPQzte67HSbV7oQOixMetZQMfQr6oePES/6gQsd4b7nj1Ipwd+xEsl4Zg58fmgbyApJ3XRMiGTI4DGjXT4jK/65rFf5nU773Vl5y2SfOm28G77v+av7iySNgnUDQobC56yaLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582677; c=relaxed/simple;
	bh=Un8ixpvmIzUJC2E8ArF/QwoMakKMYlnuwZ33rMcPKZg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=avXFTXZRlMORartT1M9W69GS9rDWTeYGL8qNe1L3U6P0GQZw1Z3YIu4Dd/lgZM043ULDNdNfp5tPm/N17B7g/qWIBNk/6HAU9Z9VHfmCIkYiCgHtJCgfKw/R0C75FPuaGGDZCOBePBxJw5u7I1a12kDr+xtFuYWQwZoyJAs+cT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VkFU9MMP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fY/zp6aL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjFStYwlkK1yr5duOqysqoV29jFL4CEKqJVJmq8wP00=;
	b=VkFU9MMP7J8D8WQ0HfXD0Ow7fWGm7mCE/Ru6OhvY+6LjMx/tse+nlrzgYCd9x114MCk6KN
	/gk3k8YqWl7zyBp+xSyKfpltQBgyBh8wIb1hb8Ut3jjO6WEllA9SF8g0WzcbZ+ZBXisWiT
	egZKonc48AJEj9kEZrFppatpGUg7r3jXteSPypnwsdvJOY8jBiKZWDGEdLdWhKCwCXPxPc
	PrC86eJlTZrlU08xArAJ0Za2TgMGR1Yz1XmgkS0AJEzKAH7Nzw2AH14Sv5NdhyXIRCfY1C
	3LaE9f7Va2ldV4Q7xyuXkWaKkh2drSVSbnjtWjgBrXrbTkkSn0nOMBbrR9N1uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjFStYwlkK1yr5duOqysqoV29jFL4CEKqJVJmq8wP00=;
	b=fY/zp6aLWHyyZa5BiT9eR4QrbJQ1x4Py9Fs2M9j/Niy/NGIlXelaXOR1uZCuSy2Hv/98yO
	uh0mM3Qkp2N2W8Cw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] perf: arm_spe_pmu: Convert to new interrupt affinity
 retrieval API
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-10-maz@kernel.org>
References: <20251020122944.3074811-10-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158267285.2601451.8456875105559362533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f6c8aced7c24e0c765d4283144d280c3f36e3906
Gitweb:        https://git.kernel.org/tip/f6c8aced7c24e0c765d4283144d280c3f36=
e3906
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:33 +01:00

perf: arm_spe_pmu: Convert to new interrupt affinity retrieval API

Now that the relevant interrupt controllers are equipped with a callback
returning the affinity of per-CPU interrupts, switch the ARM SPE driver
over to this new method.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>
Link: https://patch.msgid.link/20251020122944.3074811-10-maz@kernel.org
---
 drivers/perf/arm_spe_pmu.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index fa50645..1460b02 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -1287,8 +1287,10 @@ static void arm_spe_pmu_dev_teardown(struct arm_spe_pm=
u *spe_pmu)
 static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *spe_pmu)
 {
 	struct platform_device *pdev =3D spe_pmu->pdev;
-	int irq =3D platform_get_irq(pdev, 0);
+	const struct cpumask *affinity;
+	int irq;
=20
+	irq =3D platform_get_irq_affinity(pdev, 0, &affinity);
 	if (irq < 0)
 		return -ENXIO;
=20
@@ -1297,10 +1299,7 @@ static int arm_spe_pmu_irq_probe(struct arm_spe_pmu *s=
pe_pmu)
 		return -EINVAL;
 	}
=20
-	if (irq_get_percpu_devid_partition(irq, &spe_pmu->supported_cpus)) {
-		dev_err(&pdev->dev, "failed to get PPI partition (%d)\n", irq);
-		return -EINVAL;
-	}
+	cpumask_copy(&spe_pmu->supported_cpus, affinity);
=20
 	spe_pmu->irq =3D irq;
 	return 0;

