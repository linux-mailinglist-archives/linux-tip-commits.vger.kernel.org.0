Return-Path: <linux-tip-commits+bounces-5415-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D84FAADBB2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EB8468775
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95F372603;
	Wed,  7 May 2025 09:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pZumkGex";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGRkI0K9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243441F417E;
	Wed,  7 May 2025 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610980; cv=none; b=odNIeLobOFuRg2L34r/Dr5dxNlu8Qq4CiFGUuJiNHVlqzBkTXVqoSYonrPtjoy8sBnrFygX3kxZecP2jCtGH5cM+x53zCERcUZoBaMpc290DRfHqTpLHuPXsT7qqy6TzsRojzKDLOkuT5UTJmKuZMIofuZh85ag9jfkTP+SR/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610980; c=relaxed/simple;
	bh=Zb8I9qtamOQr3WdX5JmtEZHYIpXXR96B8CTCp2sKA7U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zr/cByiIhng794SZ07B/o5Ph7b3SyUda5qTmQW7Rs5SX3t8WInleijlvFAK9anexlkYWpp0vEWaJTng3BCD7xGKFJD++1Audsdc3u2ca0V0cjdGg68N2s0f5OtnRzK6lV8BNQc2TiMxxJ5rQsa5MvfwS2urf+XUMKL7DManbj+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pZumkGex; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGRkI0K9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:42:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746610977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGXHfwkgpXaboFO6Ctes8RC8fmaMUju9m2NKietbmpA=;
	b=pZumkGexVx+zbQHc3U7Vo1z7mCmNOJZ7pT/PWji+3B+dQX0qGpV81RQMdGxSnaWJVxdc1i
	vV49NeaE0y0hfVVRfJUPND7ly5zpThn+w3Nla8JVl13Rj/kUMZAhfbHoOrJwHmhA6ly8Lf
	paBwHAv7KocrrwLXY6uhYI6Jxz3T0QVStmN4DPGEudF8+iB1KgF4hoThhl+hGfLGGp76OZ
	36hVvuvwj39Ixw7uI0oSFePQUwFv7FlofXrCPbNTwtVLuDMyAlbxbbVryupiQOoG7FuX5N
	4jx7mRPEPPkeN4y+ucfXfjbn+QP/i4zBvESb2xNJrk6H25mwiCkLkwh0LWZj3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746610977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGXHfwkgpXaboFO6Ctes8RC8fmaMUju9m2NKietbmpA=;
	b=dGRkI0K9HkwrNbNtCffX5KOqZ7DBFRYqCvyacfImVfdzjEf/YRCzoPcHCbMkU6a061oEp7
	EAjRvsalGTq1V0Dg==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove unused remove_percpu_irq()
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250420164656.112641-1-linux@treblig.org>
References: <20250420164656.112641-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174661097644.406.372511720519590403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     aefc11550ebd08eadee6d643792c9092de2e472f
Gitweb:        https://git.kernel.org/tip/aefc11550ebd08eadee6d643792c9092de2e472f
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Sun, 20 Apr 2025 17:46:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 11:35:41 +02:00

genirq: Remove unused remove_percpu_irq()

remove_percpu_irq() has been unused since it was added in 2011 by
commit 31d9d9b6d830 ("genirq: Add support for per-cpu dev_id interrupts")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250420164656.112641-1-linux@treblig.org

---
 include/linux/irq.h |  1 -
 kernel/irq/manage.c | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index df93b23..810e44e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -597,7 +597,6 @@ enum {
 
 struct irqaction;
 extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
-extern void remove_percpu_irq(unsigned int irq, struct irqaction *act);
 
 #ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 extern void irq_cpu_online(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 827edc8..e6c6c0a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2378,21 +2378,6 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 }
 
 /**
- * remove_percpu_irq - free a per-cpu interrupt
- * @irq:	Interrupt line to free
- * @act:	irqaction for the interrupt
- *
- * Used to remove interrupts statically setup by the early boot process.
- */
-void remove_percpu_irq(unsigned int irq, struct irqaction *act)
-{
-	struct irq_desc *desc = irq_to_desc(irq);
-
-	if (desc && irq_settings_is_per_cpu_devid(desc))
-		__free_percpu_irq(irq, act->percpu_dev_id);
-}
-
-/**
  * free_percpu_irq - free an interrupt allocated with request_percpu_irq
  * @irq:	Interrupt line to free
  * @dev_id:	Device identity to free

