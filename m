Return-Path: <linux-tip-commits+bounces-3389-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ABCA394DA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8401893C8A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099322CBC8;
	Tue, 18 Feb 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g6rfoQT+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7caGz7Ri"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6822B8B3;
	Tue, 18 Feb 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866429; cv=none; b=hBQx0ylQxRC+K2Wk8P96w0SZjq6wPp5H9Bc05tS2R29ivCI8qn05pamUR/M7HrPUOc7pI8GSN5m+utRSsj9BlmQsGE/7Kwd3rzQnHzrM81VdVmGJ/ZvDWhKYBaXu6DgOBvhaw6TCFs7+fvuB+0/W/HaDrYpDM7hW3KJZ6zA53vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866429; c=relaxed/simple;
	bh=no2IBOPh4R+e2682FM0wPV5cifQLztvVnySuZi+utX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QH8XEcW6OkcbRb/4+cltgWrJiK/zE0ztMQQ+dil4D0/+UBivFjepts/S/bTZBeQFDsjV3M/URW1ZwwUHuTTSE0UtG9jBBvVL6cIeIsXuGCrca0AZVXMiOBPjM73r5ZIV1cD2McoCOjE5lj0GrQdQT1x9xPpoFuwMHSd7j1RuqPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g6rfoQT+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7caGz7Ri; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 08:13:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjWxloDARNAMuCrvxT41m9grFhspNd7V3EnynaJ+yTY=;
	b=g6rfoQT+XGTtK+qfl6ptH8KaGUKizc6/fxI9JWePmAnitCfTplXxn1ZlGJNqcLWfGZogOD
	Xqprz+36SiG04rpmfGhyd/aEMDWGUfQc6tL06/t9kJ1t0W0s71ZilAGj4+ODkYufR4LUo3
	GaBGQcN6IBbwPZ4L3wZ62uLjvf1YVWB1FB/5dw7o74o+HTAnvZkHZFq9d7+n0BkB35ZZeI
	18wLkrZ5EIYTCkuwCus2TW+tBxmIxR74ueVO7mVFmG+N7rrkObgSBG7lPdjtA8tF1qagJC
	qUKhrRiCLR2k7ZxzZi8rwin0dlMUtfUyObKkXBwTJQqsuptYdHcjSJwMdMU87g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjWxloDARNAMuCrvxT41m9grFhspNd7V3EnynaJ+yTY=;
	b=7caGz7Ri6dLoQBg5ZcHN75mekyTnn4yRiQYzaXEK0DCpOzElWdJKgObwa0J8hqZMA3soVO
	8tzbwmSHZQ1xHuDQ==
From: "tip-bot2 for Fabrizio Castro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212182034.366167-4-fabrizio.castro.jz@renesas.com>
References: <20250212182034.366167-4-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986642539.10177.7865913835512564237.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7de11369ef3037feb8365a3b5e8c433652f5fdeb
Gitweb:        https://git.kernel.org/tip/7de11369ef3037feb8365a3b5e8c433652f5fdeb
Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
AuthorDate:    Wed, 12 Feb 2025 18:20:31 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:03:52 +01:00

irqchip/renesas-rzg2l: Use devm_pm_runtime_enable()

Simplify rzg2l_irqc_common_init() by using devm_pm_runtime_enable().

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250212182034.366167-4-fabrizio.castro.jz@renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index a29c404..c024023 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -568,11 +568,16 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 		return PTR_ERR(resetn);
 	}
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret < 0) {
+		dev_err(dev, "devm_pm_runtime_enable failed: %d\n", ret);
+		return ret;
+	}
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		goto pm_disable;
+		return ret;
 	}
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
@@ -603,8 +608,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 pm_put:
 	pm_runtime_put(dev);
-pm_disable:
-	pm_runtime_disable(dev);
+
 	return ret;
 }
 

