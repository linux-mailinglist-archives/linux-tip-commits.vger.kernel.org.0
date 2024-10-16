Return-Path: <linux-tip-commits+bounces-2490-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456229A135C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD41C2113A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C56621C18C;
	Wed, 16 Oct 2024 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qv/MZYJ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8bbUbHUw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB721C16C;
	Wed, 16 Oct 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109072; cv=none; b=lCnNgVW9ZN0hwDEMFDsE2fGvBa3XPu/njILEkHHf3q6oiGujDjNLZD8J0SZV5MNhD3o6ur2SnFtjnU1t6SQMEbZdgoU3YMbH3ZtC5R01VyKI/4OLRKL+k0s/9mXO4DPKGm0FcGYeNCACouimobYkL+1an5wahzo7Bp9YXHqr3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109072; c=relaxed/simple;
	bh=IV3e4RBGpCNq2WsnHljpbvWgnjmKtNRMid4dhoYCCBA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bGJ6Fe9Lo8ELFZ6U1JtL7GNEUOCEcEBFC3AqhBTAeiYzlzR7ke01ksh4S6o1SNdHAaIwwBUaykkmhewjpnZWT3dyBfR/yl0kfM7h0PmNJwiU72lyqcNseZbpHhnWEgYM0vjvD0ERVveK4QDp3LaNd6/AiVODZEWXwhn/1szClLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qv/MZYJ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8bbUbHUw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvGiuQTRN8TTb62MKTwRanHTZjRfQzXM/TWKvhXrzSY=;
	b=qv/MZYJ5SPGWbon8pFg0By1lQkR/+P9eNW/jodFwsmNBR2bfJkr+ordmq8vpfiYHyF67Ja
	Rmwf6/P/REemI0ocxZ0fBlnKkWTZOBdX13biG2ZeXetFqVlVPH212GOE3mZ0IMa0HpLy/a
	X3CfKH+K8ou2mmIRdT4a9e4u3+x0buHyKC2SL/e6N86keOvqomBQxqbRKHd/CdlifazRSv
	3uuUlnltN+yqppm1lVzt889uz2q50M5RAx9GeSpzpK/su8zq1VGal9zIKNeidp83Bh/lQp
	p3eXGZqZmJRqJdJEeXVmCzHSuV+P/Q1oeqw+YmUpUPOu5bSH5jIIkvpLh0jSYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109069;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvGiuQTRN8TTb62MKTwRanHTZjRfQzXM/TWKvhXrzSY=;
	b=8bbUbHUwDC72zrNjau5GTHvr9UtFEV6i+aTqXduq5EEzCgM6e5S02uDeFJN+RVzo2O/9lS
	+MFJwdBp23OHvxAw==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] ARM: Switch to irq_get_nr_irqs() / irq_set_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-3-bvanassche@acm.org>
References: <20241015190953.1266194-3-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906847.1442.3187972354828688843.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     bc033158a0e691428b6acc9bc8ab16566651ec0c
Gitweb:        https://git.kernel.org/tip/bc033158a0e691428b6acc9bc8ab16566651ec0c
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:33 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:56 +02:00

ARM: Switch to irq_get_nr_irqs() / irq_set_nr_irqs()

Use the irq_get_nr_irqs() and irq_set_nr_irqs() functions instead of the
global variable 'nr_irqs'. Prepare for changing 'nr_irqs' from an
exported global variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-3-bvanassche@acm.org

---
 arch/arm/kernel/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index dab42d0..e1993e2 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -111,7 +111,7 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
 	 */
-	if (unlikely(!irq || irq >= nr_irqs))
+	if (unlikely(!irq || irq >= irq_get_nr_irqs()))
 		desc = NULL;
 	else
 		desc = irq_to_desc(irq);
@@ -151,7 +151,6 @@ void __init init_IRQ(void)
 #ifdef CONFIG_SPARSE_IRQ
 int __init arch_probe_nr_irqs(void)
 {
-	nr_irqs = machine_desc->nr_irqs ? machine_desc->nr_irqs : NR_IRQS;
-	return nr_irqs;
+	return irq_set_nr_irqs(machine_desc->nr_irqs ? : NR_IRQS);
 }
 #endif

