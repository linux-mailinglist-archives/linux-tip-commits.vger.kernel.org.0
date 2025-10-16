Return-Path: <linux-tip-commits+bounces-6862-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685ABE286D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B86A4FEAA8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB3C31D399;
	Thu, 16 Oct 2025 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xtLOspjN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BW4+Jl5L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132C31AF00;
	Thu, 16 Oct 2025 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608337; cv=none; b=gE50ENn3mmCwxPYFs29ecQozO/fQ8VhL52Pfy6scnkYtS/mOpY2AQtLihYVPFOzEu4YLfkuWgHjuRnbOH2VleDizwPdnek6b+O9qnFfi8dfLQbeGXcuIsSFAhMe7na32vV+nB3ZpNViGoppeAZbxOxRmNbWKk10hAk//SMDA/A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608337; c=relaxed/simple;
	bh=CFcHfalifNfvzEqd/PCo3d5E7ZqJT+Cg+7tcTY6F+ik=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Qo+ouZT2TkCCOXT5gTrvZdPdzodChy7MNvHhOewXdH4KouKALlG+lBmsh0EqWKRxq6vs9YDfOSamFsZ5sWivMtwHwTtbwTRT4pt+5gNqcjbDvNXckMx419yBq26tFl+gqNHcuZ9jDM1Ri9pDyHj7SMfe7/7lMA/sxyzVDR0kTNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xtLOspjN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BW4+Jl5L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608295;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amdpzg3YwHcUCzkY/9mDJbrL9gRra5PHR712243WqoE=;
	b=xtLOspjNg5bZEChgMkb4la/MYUsPuCZfaCawVQyKO/CPwTQeRoMdFhymInqNLUqWaDDdzX
	YwRT3yb4Wrsh5kND3YRVMzn+/6RSDYHJrTE6zbJXpKplwoICWeFuDggHGnZQV1zJKgXq3Q
	New2isxPQJBW8GhR7DeLaK7htBneFnroQPFV353b+2dzx5I6LKkyea1fiG6W1puKLV900p
	CjC0d0ZY+IqZ4KrBd4d/FIhRVaCC9lVsg3OLtdYgh1G6Cgic7QPEkWlrWNhgMbjN9poURv
	Z7rlTR+LQZ4wfhg12XPvWMwez1G0oOziLlE1n24JCahlzpREI73q/AgxyNcMIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608295;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amdpzg3YwHcUCzkY/9mDJbrL9gRra5PHR712243WqoE=;
	b=BW4+Jl5LqWhp8Tx7oHfk2dBhTtM/cy8yOlOi/mokZBFmJ5AqsE+dNeSD4IFUrQJwGrOCMW
	2Mtuj++LWIR0llCg==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/qcom-irq-combiner: Fix section mismatch
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251013094611.11745-10-johan@kernel.org>
References: <20251013094611.11745-10-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060829427.709179.5588016256354126351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     9b685058ca936752285c5520d351b828312ac965
Gitweb:        https://git.kernel.org/tip/9b685058ca936752285c5520d351b828312=
ac965
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:46:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:30:38 +02:00

irqchip/qcom-irq-combiner: Fix section mismatch

Platform drivers can be probed after their init sections have been
discarded so the probe callback must not live in init.

Fixes: f20cc9b00c7b ("irqchip/qcom: Add IRQ combiner driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/qcom-irq-combiner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-c=
ombiner.c
index 18e696d..9308088 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -222,7 +222,7 @@ static int get_registers(struct platform_device *pdev, st=
ruct combiner *comb)
 	return 0;
 }
=20
-static int __init combiner_probe(struct platform_device *pdev)
+static int combiner_probe(struct platform_device *pdev)
 {
 	struct combiner *combiner;
 	int nregs;

