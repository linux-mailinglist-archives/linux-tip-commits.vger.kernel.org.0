Return-Path: <linux-tip-commits+bounces-6897-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A270DBE29AC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE163E26C9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05EE3314A0;
	Thu, 16 Oct 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TlwotBtu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTBMpEn2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1731C561;
	Thu, 16 Oct 2025 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608387; cv=none; b=FZb5Z3tzMVQYiwu2LUtjMGbsvDwzdOrHr7vf3PiAsGo8ix7kGWayw5NYvf07mWvyqKAeHKXB99V7LJ78xOfeaP6mf3Tz87wIBQiZKbG0SIEFSSWkKt1/0S0e6S1qGccb1EpUqsXRWbRvo7bTNrTuBXlI/Jo2zL5CYdNhUfEamSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608387; c=relaxed/simple;
	bh=paTSuig4hZUJE5k81oYINvCg/8JJGA6QUb0Mt8s7u+c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DhUgW2AevNJ12dZLmma+24U0GFLywrTnGrHo4aDvdQCs1U4nvpkLRIbaJs3Q452Vb4o02SFcuzf8aUVWvyZz5R8tKdAaieLekUMQN+fY6qATsL8P/kNTag7p8fu3VCdRLYvQtnwbSe7nqaOS3qkFxoeyI4mOpPOAbCB/cI8SRqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TlwotBtu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTBMpEn2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fh8BHeM/g+IVzhA27AvxEDmPprhCFR4sLNl0ydK7dQw=;
	b=TlwotBtu6MHSU1PJTLyt9mgtJ+EpT7LHuBjuhukXin+thg2Qf8C2eGS/E2RxoGZEpQ4Yrs
	f5KdVpTthDyVIXe7pSMwf7mUBfHsD5VHuYpHNYx1cm5C5XB6LwmXeSSO7t7RacR53MBHHc
	GWDG+cxLwyuwaObyT/A2+GqH/dZYne2hIkHy7PIwt1GNakq0pnZj+mxIgQR15xA1BSREsb
	ixHJCPfeH0BCgm9BBCQwlYpKoNI4YKwIfkMBCDKTsWT/ZZSssEDKavm4NDrr1Ba6Xodhwf
	TQaF8BKSn7Ay1s9A/V4l72iZ2LpWLdZn6gzew96Tnzjr29XR9LcKlzbex5n8uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608300;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fh8BHeM/g+IVzhA27AvxEDmPprhCFR4sLNl0ydK7dQw=;
	b=oTBMpEn29I3XZDtlVPLrx2M/ESrleOfemPtnLPfrIGf6kjiCZAu/pzBc34i1/LlTmKdSdH
	+BwnJdzu6Gp8HXDg==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-brcmstb-l2: Fix section mismatch
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013094611.11745-6-johan@kernel.org>
References: <20251013094611.11745-6-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060829927.709179.13569055513100675809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bbe1775924478e95372c2f896064ab6446000713
Gitweb:        https://git.kernel.org/tip/bbe1775924478e95372c2f896064ab64460=
00713
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:46:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:30:37 +02:00

irqchip/irq-brcmstb-l2: Fix section mismatch

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callbacks must not live in init.

Fixes: 51d9db5c8fbb ("irqchip/irq-brcmstb-l2: Switch to IRQCHIP_PLATFORM_DRIV=
ER")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/irqchip/irq-brcmstb-l2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l=
2.c
index 1bec5b2..53e67c6 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -138,10 +138,8 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
 }
=20
-static int __init brcmstb_l2_intc_of_init(struct device_node *np,
-					  struct device_node *parent,
-					  const struct brcmstb_intc_init_params
-					  *init_params)
+static int brcmstb_l2_intc_of_init(struct device_node *np, struct device_nod=
e *parent,
+				   const struct brcmstb_intc_init_params *init_params)
 {
 	unsigned int clr =3D IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	unsigned int set =3D 0;
@@ -257,14 +255,12 @@ out_free:
 	return ret;
 }
=20
-static int __init brcmstb_l2_edge_intc_of_init(struct device_node *np,
-	struct device_node *parent)
+static int brcmstb_l2_edge_intc_of_init(struct device_node *np, struct devic=
e_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_edge_intc_init);
 }
=20
-static int __init brcmstb_l2_lvl_intc_of_init(struct device_node *np,
-	struct device_node *parent)
+static int brcmstb_l2_lvl_intc_of_init(struct device_node *np, struct device=
_node *parent)
 {
 	return brcmstb_l2_intc_of_init(np, parent, &l2_lvl_intc_init);
 }

