Return-Path: <linux-tip-commits+bounces-3388-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75AA394C6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 565423B2E9B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 08:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA8322C336;
	Tue, 18 Feb 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPqo8gve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fuggusK9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B121F416F;
	Tue, 18 Feb 2025 08:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866428; cv=none; b=FT0+yd6MaDs08IqA8oohKuUsVIj90vTmAmE2/iVFwkL8fLxDw1ItR9Px+2Ku+0kj++9meOEHe9PG+0u4vtG2U9FFbKWP7xaffrcjRL1OfX3HpE1gy3mSATBU2EYangV8OjHdiy5NionRlFhTNF9k5UI8jKwhHWGW5YM3BPNazdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866428; c=relaxed/simple;
	bh=QDsTkwB5gwNtZDVfboJNKA8M9l/0TN0szLQS6kL4GjQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eEtfs6MYFBZCqvIGsrDS2N2KBzY75LuX2j1ZA4qLu89jaJr9Rkoz3MGSHnUs2iks0izAycoPCxpIL2mP+TXb6jQPXgcpXcrL6BLjYMm6LpVfeaxHgZLoQlpBEqPZ3yBtsYgOCBkigCLvyXU/LqzHg4Bx+NEZnbDcDnQAXNCSrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPqo8gve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fuggusK9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 08:13:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhMgFyrMfn91H6ol08s6ww8XvaWtzw+x05Ls1P+RBUw=;
	b=CPqo8gveZ+drp4ThTgUKmj+cDstQZ/xdgclENb8H9F2q6F0aaQtgrjf8XmvdsMjkowddGX
	bHKp9xHvwTbYUfWgNezZo/eGCQ0gS/6GaUE0xTbEVTRAM0oFI8xMYh82zgeZkByPjU+ufz
	TyF/WmzsIVq2jsglAB8kET8SbjUCr013G5DoFtb623wrc7mkhsf68H7kdY+aQjEBFbR7qm
	4DqtyD7675nPxIHkYmoUN+If6NnJCCxCiknCiSxaIZjmyX47bG1MMDqdjU27M/m9PERY9P
	uM0xkhq0Cd7tpYmAhZnpRGk/pxbtUB4M0ffh1gxJL0jmLipPmBzCR3nyO82U9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhMgFyrMfn91H6ol08s6ww8XvaWtzw+x05Ls1P+RBUw=;
	b=fuggusK9K2CuZe1EZR99aYNLAsnOaYKxaTJGBaVueZiDHfUHqeJaeBuyp158ZsKoYawlhv
	MQTkxiKRCkEXHECw==
From: "tip-bot2 for Fabrizio Castro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzg2l: Remove pm_put label
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212182034.366167-5-fabrizio.castro.jz@renesas.com>
References: <20250212182034.366167-5-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986642462.10177.16516965437524323006.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bec8a3712943282fcac10647905c021335e27c2b
Gitweb:        https://git.kernel.org/tip/bec8a3712943282fcac10647905c021335e27c2b
Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
AuthorDate:    Wed, 12 Feb 2025 18:20:32 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:03:52 +01:00

irqchip/renesas-rzg2l: Remove pm_put label

No need to keep label `pm_put`, as it's only used once.
Call pm_runtime_put() directly from the error path.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/all/20250212182034.366167-5-fabrizio.castro.jz@renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index c024023..0f325ce 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -586,9 +586,9 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 					      node, &rzg2l_irqc_domain_ops,
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
+		pm_runtime_put(dev);
 		dev_err(dev, "failed to add irq domain\n");
-		ret = -ENOMEM;
-		goto pm_put;
+		return -ENOMEM;
 	}
 
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);
@@ -605,11 +605,6 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	dev = NULL;
 
 	return 0;
-
-pm_put:
-	pm_runtime_put(dev);
-
-	return ret;
 }
 
 static int __init rzg2l_irqc_init(struct device_node *node,

