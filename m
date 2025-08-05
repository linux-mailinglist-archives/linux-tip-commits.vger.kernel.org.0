Return-Path: <linux-tip-commits+bounces-6236-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80980B1B068
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 10:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EAF3A4ED2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Aug 2025 08:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB8F1991CA;
	Tue,  5 Aug 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B4EK0YKk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJD0lHFo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0A91D416C;
	Tue,  5 Aug 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754383713; cv=none; b=I7492WkCATbzGCvXWeXJirRlU4RY/wEV7AWe/n8ZX60BEr38tBqPRC5yNKTk+E7VF2C+lI7vNmXjIDukBHHAxqQrkdMZA6nXkReetWcNxmR+mxBWC1N6nAkV1ByD7bKePmA/vVjIZfqt9tFnQnpkkODhB0MDobvoUTThaOdsWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754383713; c=relaxed/simple;
	bh=kR3POUUU4d4HPr8hwi/vmkuPlpKXhBw4fX8kABTzNnA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EcxRPSwM5BoDwMmrb6E/97ax5zCBcSOS22agYRni15No6+wOK8HFJoz1MypuZ0lUkHWl0w05Qy9X8FqeWXBqljCXAKkmIJNpV5NZjz1JkRd5swJTIh+xo1LPSEMFOHxdNDt+rosQ+k5U3q+rox2S9Q46g2ttATOei9dhdNynRuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B4EK0YKk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJD0lHFo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 05 Aug 2025 08:48:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754383710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW9Hd6ucvyW3b8rgDuQsvfzIaH6OxIbwgRQzxdUwGV8=;
	b=B4EK0YKkVUEhVbOmWOGdUyTqEs3cdjVUI0xVJRB+q5E7anupm7hC8io7mabsdXslU0dmPJ
	txVg7wHexG+Yr3xp2iTx+q4RAS5YCs2g20sxLyVDZtao5+F5UEgplm0O1pFpRZ9PpXSTnO
	18rZChyYRf3bhWFx3ilLpeYPmXU2+vWw2BsIe+cRTewuh2fT4Jt+3z1/5y3tZtmOqnJQfl
	xQ0yhgu0FcAGNGX3IQ8bgXMqNrEGlWhggJqdb5gPewYI+u2oC5eOT+8jCyLqFiomJ4M5w1
	SSmckuoQmGllswuZY303PFR6ntyZZ+b+PJUpbj6bw0sZJKRZWM4k/YQ305Tn2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754383710;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SW9Hd6ucvyW3b8rgDuQsvfzIaH6OxIbwgRQzxdUwGV8=;
	b=yJD0lHFoYVaSyHjpHX/vV3X/d6r/YArNyTgEtIBxcnT3tg88t+6HjQFrLdikmz8t1QFWKP
	KGoPH0sF2F5u/qCA==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v5: Remove IRQD_RESEND_WHEN_IN_PROGRESS
 for ITS IRQs
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250801-gic-v5-fixes-6-17-v1-3-4fcedaccf9e6@kernel.org>
References: <20250801-gic-v5-fixes-6-17-v1-3-4fcedaccf9e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175438369835.1420.6891589793110362784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9ba0a63badc8e74ac0d490f9113300dda0ce2c19
Gitweb:        https://git.kernel.org/tip/9ba0a63badc8e74ac0d490f9113300dda0c=
e2c19
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Fri, 01 Aug 2025 09:58:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 05 Aug 2025 10:43:48 +02:00

irqchip/gic-v5: Remove IRQD_RESEND_WHEN_IN_PROGRESS for ITS IRQs

GICv5 LPI interrupts have an active state hence they cannot retrigger
while the interrupt is being handled.

Therefore, setting the IRQD_RESEND_WHEN_IN_PROGRESS flag on LPIs is
pointless, as the situation this flag caters for cannot happen.

Remove it.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250801-gic-v5-fixes-6-17-v1-3-4fcedaccf9e=
6@kernel.org

---
 drivers/irqchip/irq-gic-v5-its.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 340640f..9290ac7 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -973,7 +973,6 @@ static int gicv5_its_irq_domain_alloc(struct irq_domain *=
domain, unsigned int vi
 		irqd =3D irq_get_irq_data(virq + i);
 		irqd_set_single_target(irqd);
 		irqd_set_affinity_on_activate(irqd);
-		irqd_set_resend_when_in_progress(irqd);
 	}
=20
 	return 0;

