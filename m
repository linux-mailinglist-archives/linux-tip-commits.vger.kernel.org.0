Return-Path: <linux-tip-commits+bounces-3052-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA519ED6B4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Dec 2024 20:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BD2165CE5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Dec 2024 19:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882A01C548D;
	Wed, 11 Dec 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EqHKMMwi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nSKVcKY5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA64259491;
	Wed, 11 Dec 2024 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946159; cv=none; b=eSbvq55Pw7cYLxFiIlZ9puY56d6TVBnWNGATU4gEPecbjc7Ne4wAUU75qiNbbRHSzMXm/+/6/8pd/cjcabGdxjc91gxESe2spXSlT5NBQvSlzxg/GPvDY14mexBPFurTkWbKukSNgBUQBRXCZ5gjmSouqRimld6euJC0qGum3I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946159; c=relaxed/simple;
	bh=V7pqlPFAuMkOSWGryBxYZ4egg1HFD7erPXo/qfV3W/0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HyOrhdIqEkWwgA75NdG7uAbvjXTyqMqDV+8NXojMl10xMX6haGuTIrSu3AF4IkYkjQsaDHBLhdHgCYBJ8xBrSUaWp+ZqaVkFpKRuwZlOsgRIZDnG+g4gIMI9gM27wvuuSTURDBulPSWj3ws74sM/HOE+MqkAeuO8ODGnr2EQQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EqHKMMwi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nSKVcKY5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Dec 2024 19:42:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733946155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUfPboUKORYS//XydZSk0jP1cAo9ijrOAzOAh7ZbPvo=;
	b=EqHKMMwion/rR1kweOY42x7ARiP9aLq9lpY0i5G1PYI5wn+IE9EWFHWOMvWCPTFAFpYgvI
	99r7j8pR0RWdELXuLrKMk5rUHOlbnKzowfyWv5NuaSAiAQxYoQ4nx7tDRITw4mWFtrDzHU
	gmEtoxp6oeUwry6O6/Tfm795PxzTUPAkneiBIoKoAWpMKSS3iQQfNfce8D2WJ8bxF9AIcB
	gHp39wAwOiFlppLyIzMmLeu7VrFi9zesE/Vd+DtLSdDCza2lt91Qah9ikMh1IQ39lqQ8/P
	qiPhTcI1t9Go1irki6pah2ML0DI3/SUOwGLF8hGVd1ncmPYm8Ehit5DhXY9BAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733946155;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bUfPboUKORYS//XydZSk0jP1cAo9ijrOAzOAh7ZbPvo=;
	b=nSKVcKY5yzSzWxL1BKfnnGfxL7hmivvpP90W1T3MzoQhFb200RnLCr9ZUWvp/gfvNWQoEP
	I0zfnv2BkzyYJiAw==
From: "tip-bot2 for Eliav Farber" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/kexec: Prevent redundant IRQ masking by
 checking state before shutdown
Cc: Eliav Farber <farbere@amazon.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241204142003.32859-3-farbere@amazon.com>
References: <20241204142003.32859-3-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173394615478.412.4916928149680637989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b4706d814921cc2df7bb59ad8f9ee84855a4f0c4
Gitweb:        https://git.kernel.org/tip/b4706d814921cc2df7bb59ad8f9ee84855a4f0c4
Author:        Eliav Farber <farbere@amazon.com>
AuthorDate:    Wed, 04 Dec 2024 14:20:03 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 11 Dec 2024 20:32:34 +01:00

genirq/kexec: Prevent redundant IRQ masking by checking state before shutdown

During machine kexec, machine_kexec_mask_interrupts() is responsible for
disabling or masking all interrupts. While the irq_disable() is only
invoked when the interrupt is not yet disabled, it unconditionally invokes
the irq_mask() callback for every interrupt descriptor, even when the
interrupt is already masked or not even started up yet.

A specific issue was observed in the crash kernel flow after unbinding a
device (prior to kexec) that used a GPIO as an IRQ source. The warning was
triggered by the gpiochip_disable_irq() function, which attempts to clear
the FLAG_IRQ_IS_ENABLED flag when FLAG_USED_AS_IRQ was not set.

This issue surfaced after commit a8173820f441 ("gpio: gpiolib: Allow GPIO
IRQs to lazy disable") introduced lazy disablement for GPIO IRQs. It
replaced disable/enable hooks with mask/unmask hooks. Unlike the disable
hook, the mask hook doesn't handle already-masked IRQs.

When a GPIO-IRQ driver is unbound, the IRQ is released, triggering
__irq_disable() and irq_state_set_masked(). A subsequent call to
machine_kexec_mask_interrupts() re-invokes chip->irq_mask(). This results
in a call chain, including gpiochip_irq_mask() and gpiochip_disable_irq().
Since FLAG_USED_AS_IRQ was cleared earlier, the warning is triggered.

Replace the direct invocation of the irq_mask() and irq_disable() callbacks
invoking to irq_shutdown(), which handles the cases correct and avoid it
all together when the interrupt has never been started up.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241204142003.32859-3-farbere@amazon.com

---
 kernel/irq/kexec.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/kexec.c b/kernel/irq/kexec.c
index 0f9548c..1a3deff 100644
--- a/kernel/irq/kexec.c
+++ b/kernel/irq/kexec.c
@@ -17,7 +17,7 @@ void machine_kexec_mask_interrupts(void)
 		int check_eoi = 1;
 
 		chip = irq_desc_get_chip(desc);
-		if (!chip)
+		if (!chip || !irqd_is_started(&desc->irq_data))
 			continue;
 
 		if (IS_ENABLED(CONFIG_GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD)) {
@@ -31,10 +31,6 @@ void machine_kexec_mask_interrupts(void)
 		if (check_eoi && chip->irq_eoi && irqd_irq_inprogress(&desc->irq_data))
 			chip->irq_eoi(&desc->irq_data);
 
-		if (chip->irq_mask)
-			chip->irq_mask(&desc->irq_data);
-
-		if (chip->irq_disable && !irqd_irq_disabled(&desc->irq_data))
-			chip->irq_disable(&desc->irq_data);
+		irq_shutdown(desc);
 	}
 }

