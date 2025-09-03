Return-Path: <linux-tip-commits+bounces-6431-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611B2B41E87
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 14:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33EAF54350E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3562E3B10;
	Wed,  3 Sep 2025 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2UEL+JkT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NCgOLSiU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0392C1786;
	Wed,  3 Sep 2025 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901650; cv=none; b=LQSKofVjckcV+w+9DVcXSkVvbOl8n+IeQuO3YGrZ/GJV+qTwKyY3vYojrOvnVDQxSvNSMtKAXhLTjh66gb3/5cu2bXHC2GgXWSijo7KqUWvHIDzlrHacq5fbZ+vwSUYlfOjl9kHard+dTlQoQaVrc+aGeUrUKw81ZbvcA1lZA58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901650; c=relaxed/simple;
	bh=8Pavtm8bA1ZV7bTahhj/jKAgy9uiekUbwKuGqW04zuI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rLZXLNkfG+Oj/zUcNQkVY3yBv8csva6h+Tm+fKhIfWnKHcbKfnn9jbE2blavMM4oT6foYv9QQMT1zkLvq9B1bDP19UFgLZBd4G9hfAayCYp/Kc5e2H0RyeDkcxgbRwI2dqXgVSXgWf0VvSIjbtDgnkpezVSrHqNG1ZIGY7Iz3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2UEL+JkT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NCgOLSiU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 12:14:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756901647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQWL3/yW09VPDdPBiJ6SQ/f7i7jSdRnwwhwvAyin058=;
	b=2UEL+JkTGlJxV+awhjeVBNyBLP6WsCcTXhYX9g6ZxY7N115xbAJ0f+JCFPwdJQjftM3tfs
	lay8vSTwTuJpjIbeG2AYz07AvZPlMiIP2PZ2idAQ6a3zL2cOR7nUzuiGIbxhWvsW/B+UVI
	cVttY+mJwS6IMnNTVpEOpe0ETtSzyik0hC+OAS2no/TS+O/5G9chYLabkTr8W+PdWkyBA2
	8sVTXxfDVXpYpyli5K2cin92CJG0ES+8fDMHNwMN1fyADh0xnh1F3jH5gZ06uI66a+tlJo
	O8f+3vSfJeJBox1zkWeVVII2ViNvaZPnO+y4lCDyFlyrKlNncaoG9fFdCrM0lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756901647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eQWL3/yW09VPDdPBiJ6SQ/f7i7jSdRnwwhwvAyin058=;
	b=NCgOLSiU4asDxasEcDyoTqQ463e9SYMfScDZadHNlNBAOFk46KueOifSkLO7E2HU9XLGHu
	94BAwozCF1WIi8Dw==
From: "tip-bot2 for Xichao Zhao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzg2l: Remove dev_err_probe() if
 error is -ENOMEM
Cc: Xichao Zhao <zhao.xichao@vivo.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250821093845.564496-1-zhao.xichao@vivo.com>
References: <20250821093845.564496-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175690164609.1920.13670374185462603404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     d36bf356068cdb5499b9bc458db9149c0fd938a2
Gitweb:        https://git.kernel.org/tip/d36bf356068cdb5499b9bc458db9149c0fd=
938a2
Author:        Xichao Zhao <zhao.xichao@vivo.com>
AuthorDate:    Thu, 21 Aug 2025 17:38:45 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 14:12:55 +02:00

irqchip/renesas-rzg2l: Remove dev_err_probe() if error is -ENOMEM

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.

Therefore, remove the useless call to dev_err_probe(), and just return the
value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250821093845.564496-1-zhao.xichao@vivo.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesa=
s-rzg2l.c
index 360d886..2a54ade 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -578,7 +578,7 @@ static int rzg2l_irqc_common_init(struct device_node *nod=
e, struct device_node *
 						 &rzg2l_irqc_domain_ops, rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
-		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
+		return -ENOMEM;
 	}
=20
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);

