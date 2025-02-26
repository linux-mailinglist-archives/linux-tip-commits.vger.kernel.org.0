Return-Path: <linux-tip-commits+bounces-3646-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E204FA45C78
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CD416E8A3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312B186607;
	Wed, 26 Feb 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F9qU4quS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kpNO8pIr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02C5748D;
	Wed, 26 Feb 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567841; cv=none; b=QvfME+yUVeV8mqFvMYAgH/q4w1p3KrXT1qCdtTYlwGZQIbCbC8AZ9lXPiMx8RNoZXCSRRuzsgfBeoxJ0IH4r3Uud6hkXdJJIcgv7PCcYqZMipes8JPi7ZK5xwNcxA98uv+uvBXccbBN5aDi5A6pGGm7BJTOMYItWUb0MSKmho8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567841; c=relaxed/simple;
	bh=hr07251wVy7tye18zoCp/tAzoWgPq2UA/zqPbsrhiXQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ssMBBcmo1fSOy9vgxe+otcofKGrditRJvI0QDKqVhGPdhOgK1fQGmL7XzXVsCwCdda+OAMBjbhf+KuEwSo7Kp24TcJcs9tA6aeBn+2d0B3PdrulktHU3z5vNnfTdD7ItmUxjQ26tL64n4GOj/o6Oacsd9lXEaJ4VeE2rMrrmpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F9qU4quS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kpNO8pIr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:03:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmKBoyBxLeWrCWLqrLx3kmsaIOa4z+hRNJ6tm3lVNE8=;
	b=F9qU4quSp86F4W1Wjkza2Zrk/4ehgfExxdErQuMYBEl1/ja8A/xQIFT9H00cLOkSJjP9Z6
	yJsQBlY3DjIX7CCL5ew2SlMRnqjgeQOwmxY/+q96wSWErjF8Qw/ANPFjZReq88I1ux9p8B
	zeZGKSZ+2DQtf3N0GbLOZ7As5kITL6f+rAVGbVMHMNU0CHSJmbJzCsHBV5RtjyBFjEOWug
	95eLyepcW9/R7mAwlk8Ii0yXX2pbnmB8eHidVRImAmnJf+UMU+dVXaKMtER+o5Kv6rq/jf
	qUdqraiPvpUBkMZo/hNbgnFwOZaJ2/x6kMSpHn+nLG0c6pl8YIiqaivJ1Mj1yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567838;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmKBoyBxLeWrCWLqrLx3kmsaIOa4z+hRNJ6tm3lVNE8=;
	b=kpNO8pIrIzzSvb+4yF8BoCNAZciOtSiwSPNeMKGs14F1jRMcAfQNub8GoRZD1NrOemuanq
	6v55isuWlsg459Aw==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Update macros
 ICU_TSSR_TSSEL_{MASK,PREP}
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-12-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-12-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056783756.10177.5053244649280730644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     e3a16c33db69ffd1369ebfdf93f93a93a785896a
Gitweb:        https://git.kernel.org/tip/e3a16c33db69ffd1369ebfdf93f93a93a785896a
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:27 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:50 +01:00

irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}

On RZ/G3E, TSSEL register field is 8 bits wide compared to 7 on RZ/V2H.
Also bits 8..14 is reserved on RZ/G3E and any writes on these reserved
bits is ignored.

Use bitmask GENMASK(field_width - 2, 0) on both SoCs for extracting TSSEL
and then update the macros ICU_TSSR_TSSEL_PREP and ICU_TSSR_TSSEL_MASK for
supporting both SoCs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-12-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 8d0bd4d..7bc4397 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -64,8 +64,13 @@
 #define ICU_TINT_LEVEL_HIGH			2
 #define ICU_TINT_LEVEL_LOW			3
 
-#define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
-#define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
+#define ICU_TSSR_TSSEL_PREP(tssel, n, field_width)	((tssel) << ((n) * (field_width)))
+#define ICU_TSSR_TSSEL_MASK(n, field_width)	\
+({\
+		typeof(field_width) (_field_width) = (field_width); \
+		ICU_TSSR_TSSEL_PREP((GENMASK(((_field_width) - 2), 0)), (n), _field_width); \
+})
+
 #define ICU_TSSR_TIEN(n, field_width)	\
 ({\
 		typeof(field_width) (_field_width) = (field_width); \
@@ -326,8 +331,8 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	guard(raw_spinlock)(&priv->lock);
 
 	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
-	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
-	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n);
+	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
+	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
 
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 

