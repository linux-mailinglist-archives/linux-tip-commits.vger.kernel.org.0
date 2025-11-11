Return-Path: <linux-tip-commits+bounces-7310-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D2C4FD2B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 22:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCF8C4E03FD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 21:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAC1254AE1;
	Tue, 11 Nov 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xpfDwdrZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fIA1Y6jz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB435CBB2;
	Tue, 11 Nov 2025 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895849; cv=none; b=GckZFicBuMWi5Rr4z/WBwqL4pOVMmBb1E8Eq1YLPZL7lYBxkYxOo+x0HpJm1QFTco1Trox3LRPWbr7QiRhSGkIuBK/MtAbZvRJrWzyw7yRm/xzK7JNUIgqGrUdJUOfvdJ4SkicRcsxCzllnxtEVgVzzwC8vS5ip1dvBcO1/gF/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895849; c=relaxed/simple;
	bh=/uVBZABgHVTrqR7kVdrsrNJf/22Ol5IasBeuiwMX3hU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VXbvHqMBio+/IsbOvyHAJXxopJHTcfCkX7FIiLVMW/QlYbXZJcmawUL1K46NRy3jX3Lf7qDnBtMlAPYw8JMRj58hASYxmEs3vIURYa8MVIF9/NuyFas9VynkpleEFOFKYk6XV8G8ZD6+ZshG18qU3zyc66hOGVDsYnUMUveaDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xpfDwdrZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fIA1Y6jz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 21:17:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762895845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+qEEpRD5YXoV4abLuqyeuEsY/E3CrbJ4Wh889GrvOM=;
	b=xpfDwdrZso5Lyop0XQ8c6eBkd3R4oGO9NFrBDC3ADuOUYeQq+pElqlb0DcEgVoewVmIMrF
	6/jPOMWnx9EfS0TDLvwa5xMZbwq2d0sQQD+1xWszkQ6RGmdMgrerawMDKoRQCVSJzjvvM0
	cgfR/Tf9hy8ha51VDU1lphBPsNUpQZN/0BtT3Nq4rDtzzY661GW1jPKR2Gkgu1To5oolLO
	lEw37OeBvr9075kEKWTNVEws+c6brTFBdmULHoTzEBouEoo+ovhg1UZhuyvRnUnL7QX+la
	Ravv7Dld7LPyN6Ho69dKQu5uDs+ayGhFMMO1j8FhZTY4md9uIChMUzsHRtRW6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762895845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+qEEpRD5YXoV4abLuqyeuEsY/E3CrbJ4Wh889GrvOM=;
	b=fIA1Y6jzLNqmXF/5iRIbqH2Wl4nLo2VfuxwpuieEYGREF0sQjeRNreu8aeNyM1rlB74fEY
	kH71A1vxhz0ub7Bg==
From: "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/irq-bcm7038-l1: Remove unused reg_mask_status()
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251106155200.337399-2-krzysztof.kozlowski@linaro.org>
References: <20251106155200.337399-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176289584386.498.14182977706933410056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     45cc441de72e61b92d5eed5a9851a0301a7469de
Gitweb:        https://git.kernel.org/tip/45cc441de72e61b92d5eed5a9851a0301a7=
469de
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Thu, 06 Nov 2025 16:52:01 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 11 Nov 2025 22:11:17 +01:00

irqchip/irq-bcm7038-l1: Remove unused reg_mask_status()

reg_mask_status() is not referenced anywhere leading to W=3D1 warning:

  irq-bcm7038-l1.c:85:28: error: unused function 'reg_mask_status' [-Werror,-=
Wunused-function]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://patch.msgid.link/20251106155200.337399-2-krzysztof.kozlowski@li=
naro.org
---
 drivers/irqchip/irq-bcm7038-l1.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l=
1.c
index 821b288..ea1446c 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -82,12 +82,6 @@ static inline unsigned int reg_status(struct bcm7038_l1_ch=
ip *intc,
 	return (0 * intc->n_words + word) * sizeof(u32);
 }
=20
-static inline unsigned int reg_mask_status(struct bcm7038_l1_chip *intc,
-					   unsigned int word)
-{
-	return (1 * intc->n_words + word) * sizeof(u32);
-}
-
 static inline unsigned int reg_mask_set(struct bcm7038_l1_chip *intc,
 					unsigned int word)
 {

