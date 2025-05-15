Return-Path: <linux-tip-commits+bounces-5551-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A9BAB8AA9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 17:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D626D4E0857
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34142219A70;
	Thu, 15 May 2025 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eVmo/bjt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nL600Lir"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792B621771C;
	Thu, 15 May 2025 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322880; cv=none; b=at2AMnWo3/8MrScsNMr5mvHwj7jijxteZxMmqm8bUKdd78LBCd+8h3paa0h2wPCm9cUK66uEtx6qHd+LfRabaCuqFpNFfVg+xBg74LOTv9Bqs8mznU6eNHknn0v1IA6pZ6cXwh1DVXIN944a5iLz/lLkp7j9xddaadvLKgLn0Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322880; c=relaxed/simple;
	bh=wTZNHAPIBGaDgxLqd/WHpqVk0k+ekpNN4VOQRq3Ly30=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QOfeOURy+oI518Fj+MMzgHd+sYatctEXA2veSY+nt0G2qhY02j0uqLn6WIVtQTwAw83OY69lGvW2jnWU7fcAkHt72e+NFitW9yf3iSbj5MjNJRkObutNoysJU5QLUe31apT/z7ZJFdN/LGVeojM/31XnPz3zEN0+rIAA1E53bcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eVmo/bjt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nL600Lir; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 15:27:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747322876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nqZUEpO6bQTGQYHmROULchkhjFS87xe8SLIPpBMN60=;
	b=eVmo/bjtFji4UdrUc7rq7JMlMM0f98O9ePYHSDnjPMgVVOusi+ifat5TeCvxYZVLjAzJSh
	LU4fWVDI6cl/sK7i2rpfWGCqY4UHWFmVWGph0YrUc0CvNgiFTsMgMtp/AH+FLlXawiMQka
	W+qH1Mu0c9apAm9KuTOnp8GoI60aWifrSZAbgnFJt5QUUPBH1hYuML1t/+7ulAhyB9AO/P
	NDvPQtEGzN6z9ypT1lHDvKTvFxud72yoxSVslLc1p0BJBHd7CkUdvvYvO+6nTy+eaXjmBh
	/wr/rYbmNjRKBVFza21lL+qRHNiUpCy1NFOLeSM1F3MP9t5oqiUenKTJyo/4iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747322876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nqZUEpO6bQTGQYHmROULchkhjFS87xe8SLIPpBMN60=;
	b=nL600LirlU4ekKpIosGm0ExBmBpoCtJX3bR/z6WQjLQVEf4MpSMyB7EY0HYMS2mAi44wNc
	rG/MVTpoDqZ9ijAg==
From: "tip-bot2 for Andrew Bresticker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/riscv-imsic: Start local sync timer on correct CPU
Cc: Andrew Bresticker <abrestic@rivosinc.com>,
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250514171320.3494917-1-abrestic@rivosinc.com>
References: <20250514171320.3494917-1-abrestic@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174732287558.406.10520781374596620014.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     08fb624802d8786253994d8ebdbbcdaa186f04f5
Gitweb:        https://git.kernel.org/tip/08fb624802d8786253994d8ebdbbcdaa186f04f5
Author:        Andrew Bresticker <abrestic@rivosinc.com>
AuthorDate:    Wed, 14 May 2025 10:13:20 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 May 2025 16:01:50 +02:00

irqchip/riscv-imsic: Start local sync timer on correct CPU

When starting the local sync timer to synchronize the state of a remote
CPU it should be added on the CPU to be synchronized, not the initiating
CPU. This results in interrupt delivery being delayed until the timer
eventually runs (due to another mask/unmask/migrate operation) on the
target CPU.

Fixes: 0f67911e821c ("irqchip/riscv-imsic: Separate next and previous pointers in IMSIC vector")
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Link: https://lore.kernel.org/all/20250514171320.3494917-1-abrestic@rivosinc.com

---
 drivers/irqchip/irq-riscv-imsic-state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index bdf5cd2..62f7695 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -208,17 +208,17 @@ skip:
 }
 
 #ifdef CONFIG_SMP
-static void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+static void __imsic_local_timer_start(struct imsic_local_priv *lpriv, unsigned int cpu)
 {
 	lockdep_assert_held(&lpriv->lock);
 
 	if (!timer_pending(&lpriv->timer)) {
 		lpriv->timer.expires = jiffies + 1;
-		add_timer_on(&lpriv->timer, smp_processor_id());
+		add_timer_on(&lpriv->timer, cpu);
 	}
 }
 #else
-static inline void __imsic_local_timer_start(struct imsic_local_priv *lpriv)
+static inline void __imsic_local_timer_start(struct imsic_local_priv *lpriv, unsigned int cpu)
 {
 }
 #endif
@@ -233,7 +233,7 @@ void imsic_local_sync_all(bool force_all)
 	if (force_all)
 		bitmap_fill(lpriv->dirty_bitmap, imsic->global.nr_ids + 1);
 	if (!__imsic_local_sync(lpriv))
-		__imsic_local_timer_start(lpriv);
+		__imsic_local_timer_start(lpriv, smp_processor_id());
 
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 }
@@ -278,7 +278,7 @@ static void __imsic_remote_sync(struct imsic_local_priv *lpriv, unsigned int cpu
 				return;
 		}
 
-		__imsic_local_timer_start(lpriv);
+		__imsic_local_timer_start(lpriv, cpu);
 	}
 }
 #else

