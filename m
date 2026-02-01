Return-Path: <linux-tip-commits+bounces-8167-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJJQCH2Kf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8167-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:16:45 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F8CC6AF8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6065A303AB69
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9F9285C98;
	Sun,  1 Feb 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SuLKz6PA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTRGc0VI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B07285404;
	Sun,  1 Feb 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966025; cv=none; b=NT4UKYHGSi8SPbWsZvisXv/9dKMcYtVMNaIrrSwserDtf2ZBhk9ddMtRgfTUk1A0U5M6dnxEaNtz8/gNdCnctHWgaZj1RN5X1qFxlOnf0YF2ibrvaULM90RbbnhKk2NURIGOBieqkcsdK93OhfwTg2yHO4gIUB/f2TLMYKXeMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966025; c=relaxed/simple;
	bh=iaJga0aA1O2i4d79xtl6skicWQl0JPUtfgT1iaPNS/4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TYg7KQwG5YEwEPyjIB2XvRcLd+4vMRmTwrmBa/dRGO/NBMTcbH95BwEW2ozl7qrPtdElOYFo8FSCyuPCLYg+BM55N5jQ00KHNDU3ewyYcHIrrzroY1gxM1RNTxr587wCua9c49c8ZTrNp/Wxa966evqGSTWeMxDCln+XYXKmiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SuLKz6PA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTRGc0VI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CgQ+G8GOHZTGe0UKkDPLf8rR5/1xb7wfQ1WITX+v00=;
	b=SuLKz6PAnGICuJpEwwfzHxe7ADZHVCX9v7PphP13EEP2m9acNR/yRZxmbe3Puf5l7hGrmo
	ifv60D65xecf11jUN17UwNtKe8JgEUIuhG5kKPCQcLnA8ORoTwx8eKpU+ib4XvV1/GWM+a
	XmrkhxGRVFEQ0FpKRQ3zuV9D7+EGYqVUZvCdgl+gZc421ePReJX2moDMKVDc7LR+Rindoj
	QCsjQBZaJcTgTfDkb/E6V1DdTci5nkFO8T/4oHrMUaIZb5CFXlYqPMaqol0tGf6Q5KvoPH
	xVg8g3wY9EXw99vqeUb3bnqji3ia3C0d7PlFxbg3iZCc2cxh4A4bTcZ2VUv75w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966022;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2CgQ+G8GOHZTGe0UKkDPLf8rR5/1xb7wfQ1WITX+v00=;
	b=VTRGc0VIUpkm2oW45IXRIIvloH8cqX+YZX+aCnLDFWn9pTbWrR7Aq0YitP+yLiYU9nBNwP
	5eZncAxo9eDq1MAw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] rtc: amlogic-a4: Remove IRQF_ONESHOT
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Xianwei Zhao <xianwei.zhao@amlogic.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-13-bigeasy@linutronix.de>
References: <20260128095540.863589-13-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996602163.2495410.2392711766832841295.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8167-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:email,linutronix.de:dkim,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 75F8CC6AF8
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     18d28446231390e4ea3634fb16200865df2c6506
Gitweb:        https://git.kernel.org/tip/18d28446231390e4ea3634fb16200865df2=
c6506
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:32 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:16 +01:00

rtc: amlogic-a4: Remove IRQF_ONESHOT

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.

The flag also prevents force-threading of the primary handler and the
irq-core will warn about this.

Remove IRQF_ONESHOT from irqflags.

Fixes: c89ac9182ee29 ("rtc: support for the Amlogic on-chip RTC")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Link: https://patch.msgid.link/20260128095540.863589-13-bigeasy@linutronix.de
---
 drivers/rtc/rtc-amlogic-a4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-amlogic-a4.c b/drivers/rtc/rtc-amlogic-a4.c
index 123fb37..50938c3 100644
--- a/drivers/rtc/rtc-amlogic-a4.c
+++ b/drivers/rtc/rtc-amlogic-a4.c
@@ -369,7 +369,7 @@ static int aml_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(rtc->rtc_dev);
=20
 	ret =3D devm_request_irq(dev, rtc->irq, aml_rtc_handler,
-			       IRQF_ONESHOT, "aml-rtc alarm", rtc);
+			       0, "aml-rtc alarm", rtc);
 	if (ret) {
 		dev_err_probe(dev, ret, "IRQ%d request failed, ret =3D %d\n",
 			      rtc->irq, ret);

