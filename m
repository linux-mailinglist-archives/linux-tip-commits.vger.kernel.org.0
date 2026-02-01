Return-Path: <linux-tip-commits+bounces-8178-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJkjIByKf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8178-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:08 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E81C6AAD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9BF50300B1BB
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D686729BD85;
	Sun,  1 Feb 2026 17:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbQhMdby";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pt2VFK0U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BAC288C2F;
	Sun,  1 Feb 2026 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966038; cv=none; b=igm2zQJlwRc9hbZqRTlKfeTgEp3R9TJyd7SCzpogW+Pafus6i66ehjrbBkMB4TCplzfcPlFxRA72Ave1Uw5RNeKjU8JY+GfSIZnpBxaYANsxKHRSs/HqLi4G9fYBn9b65G1dGWxfF7+6TKNLpFU4TTpg5fa4KxmUgnvWKgWhxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966038; c=relaxed/simple;
	bh=4HqL010APS/LBKTjhOjbFLHvLKbu/oOz6rNA+g02c5w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X/Xj8LWixXuQEKyqqcn4Mq/sXVmGjRiGy+WKXb2ldTGmX3/G6HxvMKT3dTIXKbsFynKavBIvGOsxgdjk++dI6HaBSljqPLqF8N4cnWFkqicQ2OvrzhRWNBD/DwQmY3TUM+DOUXGVYn8XNMWwoQBzVSKI9RNNCrp0p4IWCq0gJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DbQhMdby; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pt2VFK0U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L25mcptcQATTc5GMO2SG3/du+52gZ8vgFVT7h2sWEno=;
	b=DbQhMdbyh0bhfixBY9m+nl3r3I4ecDHggWctk9NzOBpE/YNelGYFcjVyfbhvb1iozs0edS
	POJnyQD4J9DPEGy33bYesgB9tu2911uUWgzWImllfJkqG/REciRGMnVoAzyewy1gmWxkgf
	V2E51L7FyMZ4iUxU0C+GpFmfInSMrT8V28U2bqzv5AD4j5jJ1phV9XJ9BYZ1PkKddVUVr6
	e62DBKdhMCbYOtNOTzQD53tSu6NtgTH2OlkJ7BL7EarBcEGC0xpZZKyfyeGssRaRC3rnqz
	BE+49KvXbmCHPwj//wUommgFdtNbxrvUA1eqVtfueQs5o0rsib7KcZ59fyT+6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966034;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L25mcptcQATTc5GMO2SG3/du+52gZ8vgFVT7h2sWEno=;
	b=pt2VFK0UGo6JQhe+CmQCPPYtuzBZ60hDOc2pssr5Sz0bvKcq779K30CAXnMpelKjnNlHHG
	cyC9knOaqW+zjqBg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] genirq: Set IRQF_COND_ONESHOT in devm_request_irq().
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-2-bigeasy@linutronix.de>
References: <20260128095540.863589-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996603365.2495410.8723015625736549601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8178-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,linutronix.de:email,linutronix.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 31E81C6AAD
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     943b052ded21feb84f293d40b06af3181cd0d0d7
Gitweb:        https://git.kernel.org/tip/943b052ded21feb84f293d40b06af3181cd=
0d0d7
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:21 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:13 +01:00

genirq: Set IRQF_COND_ONESHOT in devm_request_irq().

The flag IRQF_COND_ONESHOT was already force-added to request_irq() because
the ACPI SCI interrupt handler is using the IRQF_ONESHOT flag which breaks
all shared handlers.

devm_request_irq() needs the same change since some users, such as
int0002_vgpio, are using this function instead.

Add IRQF_COND_ONESHOT to the flags passed to devm_request_irq().

Fixes: c37927a203fa2 ("genirq: Set IRQF_COND_ONESHOT in request_irq()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-2-bigeasy@linutronix.de
---
 include/linux/interrupt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 266f2b3..b2bb878 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -228,7 +228,7 @@ static inline int __must_check
 devm_request_irq(struct device *dev, unsigned int irq, irq_handler_t handler,
 		 unsigned long irqflags, const char *devname, void *dev_id)
 {
-	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags,
+	return devm_request_threaded_irq(dev, irq, handler, NULL, irqflags | IRQF_C=
OND_ONESHOT,
 					 devname, dev_id);
 }
=20

