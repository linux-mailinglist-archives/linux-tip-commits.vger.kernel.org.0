Return-Path: <linux-tip-commits+bounces-6161-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3486CB0DA04
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 14:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C271896E35
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E220B2E9EDA;
	Tue, 22 Jul 2025 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKre67xC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mDC8h4yr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230B2E8E0F;
	Tue, 22 Jul 2025 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188359; cv=none; b=CF4Fw31uDJZlXgV1zLHDAQqd7T+0R1qwtT67U9a+62PJzCZp5V1n2UiunIA1njRME6rTFMQkeV5j2iklXW6HLtONS+LopLl8tlZLnQTggVDfODPSWU1KpNDYcirl0BTzjkzBb8yjsfsoPkv/V6uU6d9mYmQ1tHz+AQJ8cSDJ5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188359; c=relaxed/simple;
	bh=qStlvWLM2hIqJ/wEQCQ+V+MNiUG4Ey29IvPSw3oR3Uk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e/KGI0N1jMvqkjioGVRbQazpY8ENdekhe2ts7RA0Puqf8Qkm3Of4d/E0bJkwMjH5EiusBmmlQdC9sSun/QHPkRWM8I86X5LupR2bGv08Xfb9Kfp6GCYgdqPqv3vDcOe0p5e0mQ4jlZNb9h5IjpaG37wX6AishMwSPF16Erbtlkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKre67xC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mDC8h4yr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 12:45:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753188356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thAZEc3odJwAbONuk5PN0IbzLNvdZTax1/r6EPT+2g0=;
	b=pKre67xCL17SWVXOr2zvkboapt4BsnjDIzqlMrYkEx8N/UrVjTO4euGuE+Zad+AwBnpN/t
	hknFeSaJGkMx3Vvo6bSteLcX9O0wPpcjw+VnHBKcH/Uqz9eGY2X66lZzSJBrtSaJD714o5
	pvtdHWCkJDE+hO+dYXpn8/C1znGaJfgRiW32wc/oDgN0Pgu2evCKIzqUXm8xHETl8rEuwH
	+O44y6r3H1bgsTKMT0f5NjB1EneQMeHyDwaMR5H/mq72DbWjndk/EnP+yWswjsGeD2na/y
	pf5z1XZCEx9cda2H2VPIE+NBoKQpbvTJx4CHkFi2tKgcOg8uiY/PWP7NnIESxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753188356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=thAZEc3odJwAbONuk5PN0IbzLNvdZTax1/r6EPT+2g0=;
	b=mDC8h4yreLJMvgWZEFEvzDQbW8CWyZgWSm4F5k8P1vt+Jk8zjKZbgOZWzA+94xwNfNKW9d
	c9o6Wz7KEt31PwDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove pointless local variable
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Liangyan <liangyan.peng@bytedance.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250718185311.884314473@linutronix.de>
References: <20250718185311.884314473@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175318835530.1420.17195036767570610359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     46958a7bac2d32fda43fd7cd1858aa414640fbd1
Gitweb:        https://git.kernel.org/tip/46958a7bac2d32fda43fd7cd1858aa41464=
0fbd1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 18 Jul 2025 20:54:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jul 2025 14:30:42 +02:00

genirq: Remove pointless local variable

The variable is only used at one place, which can simply take the constant
as function argument.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Liangyan <liangyan.peng@bytedance.com>
Link: https://lore.kernel.org/all/20250718185311.884314473@linutronix.de

---
 kernel/irq/chip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 2b27400..5bb26fc 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -466,13 +466,11 @@ static bool irq_check_poll(struct irq_desc *desc)
=20
 static bool irq_can_handle_pm(struct irq_desc *desc)
 {
-	unsigned int mask =3D IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
-
 	/*
 	 * If the interrupt is not in progress and is not an armed
 	 * wakeup interrupt, proceed.
 	 */
-	if (!irqd_has_set(&desc->irq_data, mask))
+	if (!irqd_has_set(&desc->irq_data, IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED))
 		return true;
=20
 	/*

