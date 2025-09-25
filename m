Return-Path: <linux-tip-commits+bounces-6734-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2DCBA18FE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100D11C25FC3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5032254B;
	Thu, 25 Sep 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OnsCFCMw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O6T2EGtJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088A8321F3E;
	Thu, 25 Sep 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835994; cv=none; b=D2uo8+ITKnt2jl2KZ4AjLgQ1iuBH/zRkVeZZLdoGpMtvz7WMGDYhsKwBBJ/Ys2KDAy88B2O+IxBmmZyoEhNS1Wt4/q5bOzeaiD3i512OAbskDf/eR/FuBJT7txU8yhL0lvEAYD9F4p7e/cskK1sN+wpHVo6soe6uXPGrerHKD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835994; c=relaxed/simple;
	bh=lLV27OB8UA3DiHHacQosPEUsot/Rl+iSXrXHWrs2cME=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ETGiMfeeSANvfshNiC53ElISawXa/NiRfcPoGedthMbwQUdXs9a1X+nQT8/Gb1sPQ+sAa8zCZlyz2OYiIj17O3dQMCP+NarxienbZ9xcNNHOO19mvUqI7f0F/Q4xNZk8rk/sjCUXlNMtJhjKamGbdFdVVGwYpkF5p9Hq/JiM5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OnsCFCMw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O6T2EGtJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758835990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hXpozGTPm1E5yDT9miJoNCi7BGaBbXgOWqFBruVaaaw=;
	b=OnsCFCMwv7qrN5pQqfUY1MpxOlgHploXCV2SelRvOM10RheTr4d+4V9p0IB2Os8DwBofzo
	+V2ZitkQJg+pmXRodf2w0SCCQLIAix3LBKY7+KOPBVojvzuf8Q1hZOq1UJTS/4R4GPBXGs
	GMr/CvnrakU+QZTrzrjF/wnw574BJ5SrG/E6bpMvajFK9f0hQsdJXFE2jUNJjbLkPDMotp
	iuqpRROmkVyfXTMGEtmOqo6CZgHt6q7OCRCqpDo3IcC7caBCXE+PdQVQTPdh5YcSz8evIW
	owLWasXGJaIZ1oKN//uKs9ghDmWQVfyRufhYDIvmIHNVUEKk0juzv9HYIJNIrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758835990;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hXpozGTPm1E5yDT9miJoNCi7BGaBbXgOWqFBruVaaaw=;
	b=O6T2EGtJrFlY6bWT5aCt6LfSuuCnXjkQoIYvUgR5+LhtoPeyTKo25QDxhtcOUlK+vSQJ13
	/lHosBzRDQAr8ZBQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/arm_arch_timer_mmio:
 Add MMIO clocksource
Cc: Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Sudeep Holla <sudeep.holla@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883598912.709179.92952336985246107.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     4e9bfe6969a768ef40c669fd100c9be70fb78a1f
Gitweb:        https://git.kernel.org/tip/4e9bfe6969a768ef40c669fd100c9be70fb=
78a1f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 16:46:22 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:32:08 +02:00

clocksource/drivers/arm_arch_timer_mmio: Add MMIO clocksource

The MMIO driver can also double as a clocksource, something that was
missing in its previous incarnation. Add it for completeness.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://lore.kernel.org/r/20250814154622.10193-5-maz@kernel.org
---
 drivers/clocksource/arm_arch_timer_mmio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/=
arm_arch_timer_mmio.c
index 3522d1d..ebe1987 100644
--- a/drivers/clocksource/arm_arch_timer_mmio.c
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -45,6 +45,7 @@ enum arch_timer_access {
=20
 struct arch_timer {
 	struct clock_event_device	evt;
+	struct clocksource		cs;
 	struct arch_timer_mem		*gt_block;
 	void __iomem			*base;
 	enum arch_timer_access		access;
@@ -52,6 +53,7 @@ struct arch_timer {
 };
=20
 #define evt_to_arch_timer(e) container_of(e, struct arch_timer, evt)
+#define cs_to_arch_timer(c) container_of(c, struct arch_timer, cs)
=20
 static void arch_timer_mmio_write(struct arch_timer *timer,
 				  enum arch_timer_reg reg, u64 val)
@@ -128,6 +130,13 @@ static noinstr u64 arch_counter_mmio_get_cnt(struct arch=
_timer *t)
 	return ((u64) cnt_hi << 32) | cnt_lo;
 }
=20
+static u64 arch_mmio_counter_read(struct clocksource *cs)
+{
+	struct arch_timer *at =3D cs_to_arch_timer(cs);
+
+	return arch_counter_mmio_get_cnt(at);
+}
+
 static int arch_timer_mmio_shutdown(struct clock_event_device *clk)
 {
 	struct arch_timer *at =3D evt_to_arch_timer(clk);
@@ -256,6 +265,16 @@ static void arch_timer_mmio_setup(struct arch_timer *at,=
 int irq)
 					(unsigned long)CLOCKSOURCE_MASK(56));
=20
 	enable_irq(at->evt.irq);
+
+	at->cs =3D (struct clocksource) {
+		.name	=3D "arch_mmio_counter",
+		.rating	=3D 300,
+		.read	=3D arch_mmio_counter_read,
+		.mask	=3D CLOCKSOURCE_MASK(56),
+		.flags	=3D CLOCK_SOURCE_IS_CONTINUOUS,
+	};
+
+	clocksource_register_hz(&at->cs, at->rate);
 }
=20
 static int arch_timer_mmio_frame_register(struct platform_device *pdev,

