Return-Path: <linux-tip-commits+bounces-1698-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F5931599
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 15:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49680B22D7E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48318E74D;
	Mon, 15 Jul 2024 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UWv7h+mL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="48a0a6fq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6264718D4D0;
	Mon, 15 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049641; cv=none; b=nl4hrhIdZ0QX5txCBc3DI3WazYIhYGcEywlqXxjS52v5m6kmHbh4beaFe+srMP8NvJbQ/t8h+qBFsvAXxXgg/QbxRafqX7kexVxVr6r2M9Ay6yKZHDT44AoKZJ0avAgciQb8h3JE4pizaQhfqkSCoezwh/QAZSUPNCu93F5L00E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049641; c=relaxed/simple;
	bh=Lifx5WJ7hL5gvpeJ+sdBiUcQtn0B8uUWgz+juLBUHMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tZfsZO0yZpR6KeMHuuJR7Rgdu/TTn7Exh6dhkzP162vGXVjNOho0frUc5ATaGnaZJw062mI7lQ19Ib5HmFT/fIt8MgEjvVit7StLhXy5KWzG3LvyNAeQ3aosjlIbBN0TeeF1BBHrLUoTEr+CYYD21NSmqKTdUwJXuAFynPIe2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UWv7h+mL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=48a0a6fq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jul 2024 13:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721049637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30Jr9qhtcwDr1hYaMfxv5bU+HkIJz+AzBkGP9E6G5Hs=;
	b=UWv7h+mLqkUH22+MWFISSj0Xf7Lwmz4JKTHHTjV4vmxERZQyQmjGoyVsxt+rj97ePEp6xO
	TKnjwMbZ/Pq5nK3u92TLxbfIzGcSAQd8xtxEJMEjBVYWBardkypGBvzj3ntnKI/fpcAIHg
	B/MGVuV0c66aM1SiKGA12WC2BFRL9x8XkqzEiP3cBCNnoA2bfcBctI3TpWDjLN+mcxvTVS
	z3syscWftLYDMRDjeJ2SZl8V7nwL4OIHW0qKawu12SWev2T9BBRRR/O2FblaEGSMNGMGlN
	jj73tZJVddUMG9R8UM5hbZ/98zYqHkZo4QGK2+hfpF7Qwr6kRlAgCvVkmQgFHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=30Jr9qhtcwDr1hYaMfxv5bU+HkIJz+AzBkGP9E6G5Hs=;
	b=48a0a6fqcJNPYeT4oSTLdmcuByWvNYWBvq7K1/umkN8QYSEevdmX6CNxL1pcX6gUFTXpPO
	tJjXdH3Pmjt4hxDA==
From: "tip-bot2 for Rafael J. Wysocki" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Set IRQF_COND_ONESHOT in request_irq()
Cc: Stefan Seyfried <stefan.seyfried@googlemail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kerel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <5800834.DvuYhMxLoT@rjwysocki.net>
References: <5800834.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172104963697.2215.15979556367007656241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c37927a203fa283950f6045602b9f71328ad786c
Gitweb:        https://git.kernel.org/tip/c37927a203fa283950f6045602b9f71328ad786c
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Thu, 11 Jul 2024 12:20:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Jul 2024 15:13:56 +02:00

genirq: Set IRQF_COND_ONESHOT in request_irq()

The callers of request_irq() don't care about IRQF_ONESHOT because they
don't provide threaded handlers, but if they happen to share the IRQ with
the ACPI SCI, which has a threaded handler and sets IRQF_ONESHOT,
request_irq() will fail for them due to a flags mismatch.

Address this by making request_irq() add IRQF_COND_ONESHOT to the flags
passed to request_threaded_irq() for all of its callers.

Fixes: 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI")
Reported-by: Stefan Seyfried <stefan.seyfried@googlemail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: stable@vger.kerel.org
Link: https://lore.kernel.org/r/5800834.DvuYhMxLoT@rjwysocki.net
Closes: https://lore.kernel.org/lkml/205bd84a-fe8e-4963-968e-0763285f35ba@message-id.googlemail.com
---
 include/linux/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 5c9bdd3..dac7466 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -168,7 +168,7 @@ static inline int __must_check
 request_irq(unsigned int irq, irq_handler_t handler, unsigned long flags,
 	    const char *name, void *dev)
 {
-	return request_threaded_irq(irq, handler, NULL, flags, name, dev);
+	return request_threaded_irq(irq, handler, NULL, flags | IRQF_COND_ONESHOT, name, dev);
 }
 
 extern int __must_check

