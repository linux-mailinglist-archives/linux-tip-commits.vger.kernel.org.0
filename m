Return-Path: <linux-tip-commits+bounces-1494-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D899913C64
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9674281F28
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B311836C4;
	Sun, 23 Jun 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CibfU1H0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LdS6f3Jf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98450183063;
	Sun, 23 Jun 2024 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719156635; cv=none; b=ALlT6oraUKLrNjQgyvAYgFRnrGsz1Bzh+sj3GN862L/mCh6tGaMnheUiuXBY6iuI6Quvgsw0mxEFN+GMZo0SHlGj3iXoTur04wfyyuw62e0oOSR3CJhyY4PTJKrdV7aaqz5dngldqAT4qHEd2ERy9ICIQ7GytNGRcLJEew8S6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719156635; c=relaxed/simple;
	bh=06J0XButcTFwg9boZJLD8o6CIWK5rrPcdc0IxZRsHvk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oFoWmIOQIh+fK/4YihZb3gKmT7OJg66VhX7jlodOFFWw8ntbrOTdDewK4N8a+gTcwXtiosikiAYPM+esiihviYxBU2W4ql3thWytkYw2PD41e4GtbDe7Vf1b+RqGKbzJyW65asBw+gb0WgG1ZUbwSpYO374UY+Prb+rpoKYLfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CibfU1H0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LdS6f3Jf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 15:30:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719156630;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drTKFvo2zzFTkjI/M806bhYKKreeVDwfJ4TqHcuKHcA=;
	b=CibfU1H01Aqu49A1u9tS21Jcf3kQ6roHZgOxqeOYSLEPuwJE7nmXMQc1NX3I/55ArluKKY
	ga2CvMvyh6ywAPbeLgUzUoCzD/zjI6GMPdIyL4ElonHxS1jdh/3AzEdJ0ihRpbGZPvHJTu
	1nmApGOyG+IHZ+DaI/teIUwQFNHRHQu19avTk6vtrlIIz6/0dfe/0vUkJgrtnEXFAd/70I
	ewPOCCOIAqyCLoUA6fZTk02lHI8W5ZXHs5cAilGzyRbDAfSEM4HETOHGtrIVEhOr9UhHpD
	Kdyz1f+tHazJ//MtOpI94AspW9LfJcE24Otr7pK+ZZKpG2Upb7qf0T9Xl9Xu7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719156630;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=drTKFvo2zzFTkjI/M806bhYKKreeVDwfJ4TqHcuKHcA=;
	b=LdS6f3JfktshVxpxb31rT15Ygm7CYkTmKwpdMeEgzheodJriyyGi6hHq34CELVXX6Tc8l1
	jwgKz6mIXh8yeTDw==
From: "tip-bot2 for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Reorder function calls in
 rzg2l_irqc_irq_disable()
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240606194813.676823-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240606194813.676823-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171915662969.10875.494491471556789291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     492eee82574b163fbb3f099c74ce3b4322d0af28
Gitweb:        https://git.kernel.org/tip/492eee82574b163fbb3f099c74ce3b4322d0af28
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 06 Jun 2024 20:48:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 17:23:08 +02:00

irqchip/renesas-rzg2l: Reorder function calls in rzg2l_irqc_irq_disable()

The order of function calls in the disable operation should be the reverse
of that in the enable operation. Thus, reorder the function calls to first
disable the parent IRQ chip before disabling the TINT IRQ.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240606194813.676823-1-prabhakar.mahadev-lad.rj@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 861a0e5..693ff28 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -271,8 +271,8 @@ static void rzg2l_tint_irq_endisable(struct irq_data *d, bool enable)
 
 static void rzg2l_irqc_irq_disable(struct irq_data *d)
 {
-	rzg2l_tint_irq_endisable(d, false);
 	irq_chip_disable_parent(d);
+	rzg2l_tint_irq_endisable(d, false);
 }
 
 static void rzg2l_irqc_irq_enable(struct irq_data *d)

