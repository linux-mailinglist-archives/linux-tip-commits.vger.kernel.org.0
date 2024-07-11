Return-Path: <linux-tip-commits+bounces-1683-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71B792F09F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Jul 2024 23:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D128BB20B05
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Jul 2024 21:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7912836A;
	Thu, 11 Jul 2024 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cZZ5XXhH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vdszvLBE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4371A19EEA5;
	Thu, 11 Jul 2024 21:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731879; cv=none; b=FvPb+zAex4mAFV5GdhnIgS8r4QtQy0next0tIGVFvqfbRCw8tPHgCHfC6ShohqRe6jdx2xDq1H0JyZOZmMQt5YBCbVBeuoHjQ1AUFX282nbq+ZmSz5djxvFd3MrPCAdB/hSOWJ+1XoH3HFYgtol8jBBdmNgLCVJm7AaIu1C4fig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731879; c=relaxed/simple;
	bh=gcvJF9WJADV/kqH8/tUOgKOogbbHHHt27DNA51uE8fw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L6NlWWT4BlwepdKioIRtUoFTic3BfIzWBuajGQdhXAJThcdO7/FNL7vZzpyivdpHmy6oratIOVPeI9hD5fZjn1w0Hmb8J5DrcTagHtDb7aIGUILjmRgIgCzYTOB1xv2U5JLp928exo4BujY5dncsokbbs+BN44JI3ta39Z1uAq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cZZ5XXhH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vdszvLBE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Jul 2024 21:04:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720731876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=js/uULBd3xZy3TY6gRNrMTFha54wR+TNBNlgNWJcFSE=;
	b=cZZ5XXhHTzzzhwwm7mSvxSfb09op01HEeUvuWW/4+NcpnXVwkt9Xng+1BdLu/+dDO8IiGP
	m6e+nJ6AjbXgaxfu//hEUZOrin64VyydwdZhBudWpa45NqRBMnNL9Mu6DJdeg3KyeNZyS+
	B11zKGqDbYNg1Gf8nOsa/509h7NnoFtwAQg8chbL3WdgHl8iqByjWKr/g+L9ekx8zcFMZ2
	QlumdEHl9cTApqQMYvMgEjuca0GDIJ6KwQGcsS6AHTgZcgc2reqUPBSARUgQuDbSUWvKs1
	ykWRnM1BEqoDAh+mgwNwvVZW4yj8LwtYZVz0VFZL9GyA9APKoEOr4EseTCPnbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720731876;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=js/uULBd3xZy3TY6gRNrMTFha54wR+TNBNlgNWJcFSE=;
	b=vdszvLBES1zWOuLnmdXYxTwBQnjqnmg2n+BnUjaAaJD3/1XBqch36wpgptvmy/datj1BYA
	RMsxpzqhT7apmLCg==
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
Message-ID: <172073187601.2215.10067243809116446863.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     513fbe762f644872cc2ff47407cbc24422a33fb5
Gitweb:        https://git.kernel.org/tip/513fbe762f644872cc2ff47407cbc24422a33fb5
Author:        Rafael J. Wysocki <rafael.j.wysocki@intel.com>
AuthorDate:    Thu, 11 Jul 2024 12:20:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Jul 2024 22:59:33 +02:00

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

