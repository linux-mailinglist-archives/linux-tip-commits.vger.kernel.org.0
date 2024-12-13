Return-Path: <linux-tip-commits+bounces-3057-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CA39F137C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C613A16B1C9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 17:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D4E1E47C2;
	Fri, 13 Dec 2024 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kd+clPki";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFt8bZ4V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D1D1E3DED;
	Fri, 13 Dec 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734110433; cv=none; b=aj6oahPa8Zf5J51i2bdV8e0BC3uADdwdx/8dN8Wgu/eBGXgd/yrT4xcw9oX1MNIVKpS9AEJOflzNpNSSe/KqDMNRF6CxwMTzNK/4yR56wv/LMahYSdAjXEnpHJ50FG89lu3CKeye7qEv6obf1wnJ0+iq9UK/kFzygtyInbXmdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734110433; c=relaxed/simple;
	bh=dCfsnvX6RKHEn3QV4YPfdt+wPQP+yNv6b7bjNxVMFo0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mVm2P7sgDwq3QlFKxoDUNrBvyAPexgyfwfxYgaOstbtn4DgYdahezEnH3hOmAZvQwvF6g9XguTRqHsf16MR1m0KtEGpVAy8sxeHx687SYFfd718smDLuyBfQMMT1vHa6KA+2YhWu5L5y1cDLxyhtjUOE5V4o2+ggqOqNWKwcTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kd+clPki; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFt8bZ4V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 17:20:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734110430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTS4YNGdtGXiZQf4HooRQsqfIgM1IR3lMAx1KGy40E=;
	b=Kd+clPkisyonUQwq1dC4die3olLLIBMoD++y382/nlSgijsAcddF6AtZF38M04vehOw22U
	8/aqChdgvl/hDTMitUR6GniL6njYUN793RFUXRp3/emjqRs31tLV/yhZCh1MWeAm/96PMD
	QGR9nBJFGg8/ZJeURB5giPvH7RMR4SP4gsNqMjOG+HgCpyQFwBOx4ygSlBREeLh/xy2tZW
	+KqAUoAIvXY5bmBJgeJcpg/FojExVam3N3xYGH+fXlF76LT4AfwY5I0KJDOdk6OqDokva2
	LWsNve13sVO3Xa3MI22CcXICNO6JSqRSJF6MsygZNrDS9Y/DHlN9vqmOQRN8LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734110430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnTS4YNGdtGXiZQf4HooRQsqfIgM1IR3lMAx1KGy40E=;
	b=UFt8bZ4V0i4+6k6hbuV08Lgo+Ck/kBPgQwL05gblnta6q3YMvzwKCoVD+8jXYY/alGwGz7
	2jiyKyY2QQMvxUDw==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic: Correct declaration of *percpu_base
 pointer in union gic_base
Cc: Uros Bizjak <ubizjak@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241213145809.2918-2-ubizjak@gmail.com>
References: <20241213145809.2918-2-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173411042923.412.18183621936217013805.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     a1855f1b7c33642c9f7a01991fb763342a312e9b
Gitweb:        https://git.kernel.org/tip/a1855f1b7c33642c9f7a01991fb763342a312e9b
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 13 Dec 2024 15:57:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Dec 2024 18:11:52 +01:00

irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base

percpu_base is used in various percpu functions that expect variable in
__percpu address space. Correct the declaration of percpu_base to

void __iomem * __percpu *percpu_base;

to declare the variable as __percpu pointer.

The patch fixes several sparse warnings:

irq-gic.c:1172:44: warning: incorrect type in assignment (different address spaces)
irq-gic.c:1172:44:    expected void [noderef] __percpu *[noderef] __iomem *percpu_base
irq-gic.c:1172:44:    got void [noderef] __iomem *[noderef] __percpu *
...
irq-gic.c:1231:43: warning: incorrect type in argument 1 (different address spaces)
irq-gic.c:1231:43:    expected void [noderef] __percpu *__pdata
irq-gic.c:1231:43:    got void [noderef] __percpu *[noderef] __iomem *percpu_base

There were no changes in the resulting object files.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20241213145809.2918-2-ubizjak@gmail.com

---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 8fae6dc..6503573 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -64,7 +64,7 @@ static void gic_check_cpu_features(void)
 
 union gic_base {
 	void __iomem *common_base;
-	void __percpu * __iomem *percpu_base;
+	void __iomem * __percpu *percpu_base;
 };
 
 struct gic_chip_data {

