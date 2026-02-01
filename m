Return-Path: <linux-tip-commits+bounces-8166-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPIVKE6Kf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8166-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:58 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB9CC6AE2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 004AD302FABB
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FBD280A51;
	Sun,  1 Feb 2026 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6dA7WSM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eU05/wYf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434C927FB1E;
	Sun,  1 Feb 2026 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966023; cv=none; b=E5x01HQCt2X4xnHhD6TpYD1CcZPBfbw2gkseVh/q2MXqY/eoE1NBGCG++ovKQ+nk/yAvV3VvVHqgLgw32W6B49HjY/IngX+0K70CRSvwlAxrA1FtdOsQ6IzacvauafZTwnJM/yx5VhE2cKCk8qe0ZqTi9kjV6h6UjypxptxQEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966023; c=relaxed/simple;
	bh=7x2vWtRhLo5bW6TrP0zcmJMrX6V7euUbkf7A/lKIRZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G6A1swqWXRgwLtu0KnGF5TwpitSdltVlnkn1a0SnVn4/Mmj35NVpfBUhUlm58OX81mtsRQuyOVwIQKfvFPm+ZSgSNIfcmtye7cRcHEsdPlU3e43ZaaFpUu3JPGU782hd9Fnq/Jvnj88WACWrDfZwbZnT71gRab4L16WM/T0CLx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J6dA7WSM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eU05/wYf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ks8WfXs2v8lijH+ybLnWizSRitHJ19HyR6BDy6odscM=;
	b=J6dA7WSMXLmzVyULIxn06Rgs4eikhGXBsCl2tV58lP/FldOsE0QNUtcLEJLoNlZVPJErTE
	mfVwa5PYoHCYbAkn8csYFbuVcl2bOCycslghEDQrOWJt7FIi3v9NsredoGZgoUOuWpZ2d1
	n+1W7cN/vMzQNEirbqlg5VPeNwrxbV46Do18J+/WwjF2p1cpGBQnWm3gIjo1w9VssjksFy
	po9Kv5JD6iOMFYbk/A3L9xhzZ9h8kRIxZJbKPTwzz92sR5JXwGqj3Pvq7gnYF28PBRVVuy
	I9cdaQxGH5PkhaStNn2xGE8Kvl4zalMoBiwE7Jrz+rTPJYqASmPM+JzvIooyqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966020;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ks8WfXs2v8lijH+ybLnWizSRitHJ19HyR6BDy6odscM=;
	b=eU05/wYfuVRID9J8IcTXX+Kumq32pJO9WVFWqsrCPB2ZT/qOtjZkbWH9rBPZvKNCImdl3s
	wy7hBejvqNOlFUBg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] mfd: wm8350-core: Use IRQF_ONESHOT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-16-bigeasy@linutronix.de>
References: <20260128095540.863589-16-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996601936.2495410.10061491452514216506.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8166-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linutronix.de:email,linutronix.de:dkim,cirrus.com:email]
X-Rspamd-Queue-Id: 0BB9CC6AE2
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     553b4999cbe231b5011cb8db05a3092dec168aca
Gitweb:        https://git.kernel.org/tip/553b4999cbe231b5011cb8db05a3092dec1=
68aca
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:35 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:16 +01:00

mfd: wm8350-core: Use IRQF_ONESHOT

Using a threaded interrupt without a dedicated primary handler mandates
the IRQF_ONESHOT flag to mask the interrupt source while the threaded
handler is active. Otherwise the interrupt can fire again before the
threaded handler had a chance to run.

Mark explained that this should not happen with this hardware since it
is a slow irqchip which is behind an I2C/ SPI bus but the IRQ-core will
refuse to accept such a handler.

Set IRQF_ONESHOT so the interrupt source is masked until the secondary
handler is done.

Fixes: 1c6c69525b40e ("genirq: Reject bogus threaded irq requests")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://patch.msgid.link/20260128095540.863589-16-bigeasy@linutronix.de
---
 include/linux/mfd/wm8350/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/wm8350/core.h b/include/linux/mfd/wm8350/core.h
index 5f70d3b..097ef4d 100644
--- a/include/linux/mfd/wm8350/core.h
+++ b/include/linux/mfd/wm8350/core.h
@@ -667,7 +667,7 @@ static inline int wm8350_register_irq(struct wm8350 *wm83=
50, int irq,
 		return -ENODEV;
=20
 	return request_threaded_irq(irq + wm8350->irq_base, NULL,
-				    handler, flags, name, data);
+				    handler, flags | IRQF_ONESHOT, name, data);
 }
=20
 static inline void wm8350_free_irq(struct wm8350 *wm8350, int irq, void *dat=
a)

