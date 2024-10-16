Return-Path: <linux-tip-commits+bounces-2476-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5686D9A133A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887C91C2107F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23939218322;
	Wed, 16 Oct 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPmKzT/6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5UXOf2Cp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F18821830D;
	Wed, 16 Oct 2024 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109056; cv=none; b=Nu5pbHH5E2tpOh4q+kjb80pcpTtUgVho3QQMmfBoXFet2HPx8H1RU6Ul9JH4Rq//fLqYbaz/9F9Qwv1RullDNjQR+kJyxAcBt0qXE8azIMRo70GOEhOCZEKL9Jm2qR74kuRUeIyNzv2De4nC867socJCItEt9EOSfroxGFgDMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109056; c=relaxed/simple;
	bh=Wb8xtvQpkR/rdM8VaZutTd+4J8mUaPxQUL3WmiEPo+8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hx7cI1PTir10gCrQMszgJ1xR1QchwS3SSWuI6hOsbd5cU0lfaPTKEZu4/XiAks7ikhxBosXe52Fs1vLO68p4qbod9kqX3mR9yDidQY+BUBrXETw7l5v32bGcWZuLT59bsRnR2GcPemF59fJ00dqUnt1S/0IYEZ/GhNlEd6ZAgNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPmKzT/6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5UXOf2Cp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3/LzCja08J19a1ZyXbux/X82KRw7zYnArYZc3aa/uA=;
	b=mPmKzT/67T2660vwLP/004yTXmLLawMD7U4kti1nAyd+xtmLiCkCZYzQKZR5UyRoZ0NfaX
	q8UFyNIAOfFB2c4HhHxInFT1SDDkFjhc1E/QqdbMLGevji4YK6b18gr4rG1hrDPy/bSRbK
	9CcGgeXhZy+J1acKKEdPhB55PVSQscthQl1xLg9CM2dKBHbVpTvJIbfgvDOQBUb9UeZnLR
	KbD3uKVQ1uZxZ4MKHsp5FAZxqUBRlUUhsCL+5zlcPHw7J7+E09aEIFjdXDfzhx/BmZOw+Q
	KqDSepI7sBlhvMq6rPhrvKiY2piZ6IJSq3fY0WBxtYepMTt6sE3skzhyyvEzwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N3/LzCja08J19a1ZyXbux/X82KRw7zYnArYZc3aa/uA=;
	b=5UXOf2CpjIbDldOQxS7ylicV4AgaYDdM4QzVlt5SVl0+oNbEEaW+GM3r3ovAQUt7sQcVfa
	uq6DZFPBRsH+4ODQ==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] serial: cpm_uart: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-17-bvanassche@acm.org>
References: <20241015190953.1266194-17-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910905212.1442.14546664422853034729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b9b5df2986c1195504a0c8d1c44691ec099815df
Gitweb:        https://git.kernel.org/tip/b9b5df2986c1195504a0c8d1c44691ec099815df
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:47 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:58 +02:00

serial: cpm_uart: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-17-bvanassche@acm.org

---
 drivers/tty/serial/cpm_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
index a927478..6eb8625 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -631,7 +631,7 @@ static int cpm_uart_verify_port(struct uart_port *port,
 
 	if (ser->type != PORT_UNKNOWN && ser->type != PORT_CPM)
 		ret = -EINVAL;
-	if (ser->irq < 0 || ser->irq >= nr_irqs)
+	if (ser->irq < 0 || ser->irq >= irq_get_nr_irqs())
 		ret = -EINVAL;
 	if (ser->baud_base < 9600)
 		ret = -EINVAL;

