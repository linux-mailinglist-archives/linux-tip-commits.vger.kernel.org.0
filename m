Return-Path: <linux-tip-commits+bounces-3390-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1DDA394DC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 050211890890
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 08:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBB822B5A6;
	Tue, 18 Feb 2025 08:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gbCmh/rE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQVVOASK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7492C22B8D2;
	Tue, 18 Feb 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866430; cv=none; b=NX4jQn93OBDRPy9c164XigKojyr+W5AJpBT7UTGjBjWiVUjU7BmJuMmPBta6mv2ywYYGxCiI6hMw0nWNdbX8/fygwz0dV8gaVIwiven+jF4sLIAwvQjkxsZqQR3WUhD8JEaX1SoTHVZvmStn+E8SGuuHayUNqhVit2qRciulAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866430; c=relaxed/simple;
	bh=5vFeua4iCH0nizEQdezH0l25VowR5bMw38f13bPexWU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SAiHsd1KAuYEdMqIGPMdsyOOE9kZPRwgqqlZvLQKPS6n8qY/3rDqqIH1XzfAfY16i2xwfMg8oWnQ+Vg2nBN7ca3YdFwc0PvzUjx7fSiVMkjT2KAzhWI6+WYUZwk5qAf7vggpcsnoyXKucidx/HdJUjJl6vCPViSUfuau+/XO6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gbCmh/rE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQVVOASK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 08:13:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H1+KF8axttqQ4nnRIAbl6xfjoOs3jnyU8lOB6oLP9s=;
	b=gbCmh/rE7s/19Cd0n+2E3zUOPzBU8tpuMc8r5DADRIDF+21vAqzFrYNCxAaBEyw5eDRu+q
	OHF/AoePL/HHOvgXyj7S0MVsI9pCTrhB9tW1lvTGHSKRzaQO8FVFa6xcFanyvZZCxkItG3
	jXEm38qG2n1W7jrlAC7HpSCZxWSNuLjerUYzeUYcXmN03TzkuZPf2nvipUoFygPepTNNBe
	fcULdFnKexha/f+/6QBwEnkkXoi6aczva2Mk9mvXS7eFm4dH6iAEU2sGRVwtWMYR0Q5xbY
	pQpduegLU2LjWDA4UJYNAa5F46O1XRkypsY1PW+GQ+OcPDcrh86p3Ak+69n2qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1H1+KF8axttqQ4nnRIAbl6xfjoOs3jnyU8lOB6oLP9s=;
	b=rQVVOASK8ysNhbu+O00LUeOLOnYdAC5hE8AODTXY/s0mriZyTMwVd1Jc/FalNOP2RAnjCa
	gnyEtNhs1ByKeTAQ==
From: "tip-bot2 for Fabrizio Castro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzg2l: Use
 devm_reset_control_get_exclusive_deasserted()
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, Philipp Zabel <p.zabel@pengutronix.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212182034.366167-3-fabrizio.castro.jz@renesas.com>
References: <20250212182034.366167-3-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986642599.10177.14771765271968084890.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     78f384dad082af13a9399b14ff23c5ea02b0a407
Gitweb:        https://git.kernel.org/tip/78f384dad082af13a9399b14ff23c5ea02b0a407
Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
AuthorDate:    Wed, 12 Feb 2025 18:20:30 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:03:52 +01:00

irqchip/renesas-rzg2l: Use devm_reset_control_get_exclusive_deasserted()

Use devm_reset_control_get_exclusive_deasserted() to simplify
rzg2l_irqc_common_init().

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/all/20250212182034.366167-3-fabrizio.castro.jz@renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index a7c3a3c..a29c404 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -562,14 +562,10 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 		return ret;
 	}
 
-	resetn = devm_reset_control_get_exclusive(dev, NULL);
-	if (IS_ERR(resetn))
+	resetn = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(resetn)) {
+		dev_err(dev, "failed to acquire deasserted reset: %d\n", ret);
 		return PTR_ERR(resetn);
-
-	ret = reset_control_deassert(resetn);
-	if (ret) {
-		dev_err(dev, "failed to deassert resetn pin, %d\n", ret);
-		return ret;
 	}
 
 	pm_runtime_enable(dev);
@@ -609,7 +605,6 @@ pm_put:
 	pm_runtime_put(dev);
 pm_disable:
 	pm_runtime_disable(dev);
-	reset_control_assert(resetn);
 	return ret;
 }
 

