Return-Path: <linux-tip-commits+bounces-8173-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMNFIAyLf2kKtQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8173-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:19:08 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5330C6B43
	for <lists+linux-tip-commits@lfdr.de>; Sun, 01 Feb 2026 18:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D7C8300D964
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Feb 2026 17:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08B5287268;
	Sun,  1 Feb 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PcfHUL81";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="htfi/glH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8F27FB3A;
	Sun,  1 Feb 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966035; cv=none; b=GhF7fsbeT0u2pnI5LJSVySgUJo7W7erD+fHzV5Te1ceWQHsNCcJjTuZDi6be+gpESFWWTMoKmcJZiPyPhWMYEChIs8+YFi3npu8qTaizLo9ufHeAT02eXfGMtzyrKt9glc5glxWLBdjl4Yw+Obvwli+ktXcIpQTaqzGhf4T3kBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966035; c=relaxed/simple;
	bh=C2Pzx/W1aa1Ituj+NJhIL/R/Im+BCSRUqJbJzAlbyHQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TVUODMi1ruNdewzLaOXe+BmrCraw7hWWXjBIypnwpwbqdsFq4Udb6XWNbOph8iaQRTMt5Au+KOrQv5MGDS+IOSyw2C1K3Y6eRu6Oo9imfE2q8nTDOT3AtzQFZEgFf4kqLNTNa36wtgQQRzfVpXljSI6XEhUMetQFBBJY5s3d6EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PcfHUL81; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=htfi/glH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 01 Feb 2026 17:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769966029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hs91kVafEUus2dgu7C42dw79lNH15DXYWepo2TH15wk=;
	b=PcfHUL81cCO1n9YpB4aHxOgxAHp6UJxpWXeyFTKbukwJEiuLzmjzIIjC/JxGLlAHGhHa+N
	rUlLqP4xo0MtgWsThGMDtZwCtiC1TQmw0OFKRMNg9Gm7wvnrpyLln1BwmQQVBeGGK0+6n5
	hX9SwudPASBvi29X4Gl5Bv93IxOxcxfw2x739XMaizy8b9qzBmDGqnvJsg1XXirikjAS9/
	e7MW9wjMwKWMKYqp7WjcpggSupOYZJ1tkZSPG6fjGqwziQTnpNnhUgKffcJCprT3iUPwkF
	XtTI8H/xA3OTysbJ0bkx8JmgsE1lzsXeokzlJbaGf7ayAbQwAmFNRTiJoOM9Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769966029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hs91kVafEUus2dgu7C42dw79lNH15DXYWepo2TH15wk=;
	b=htfi/glHTIHc5ubUmw5UTb+UAtYkOb9BDNgdS+R8TIYaRiQ2xbcrG3DW/rz+4l1NrDZ2uJ
	XPxRjyT68mBIKDDg==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] Bluetooth: btintel_pcie: Use IRQF_ONESHOT and
 default primary handler
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260128095540.863589-7-bigeasy@linutronix.de>
References: <20260128095540.863589-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176996602834.2495410.11609340196436689881.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8173-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,linutronix.de:dkim,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: D5330C6B43
X-Rspamd-Action: no action

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     28abed6569c87eab9071ab56c64433c2f0d9ce51
Gitweb:        https://git.kernel.org/tip/28abed6569c87eab9071ab56c64433c2f0d=
9ce51
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 28 Jan 2026 10:55:26 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 01 Feb 2026 17:37:14 +01:00

Bluetooth: btintel_pcie: Use IRQF_ONESHOT and default primary handler

There is no added value in btintel_pcie_msix_isr() compared to
irq_default_primary_handler().

Using a threaded interrupt without a dedicated primary handler mandates
the IRQF_ONESHOT flag to mask the interrupt source while the threaded
handler is active. Otherwise the interrupt can fire again before the
threaded handler had a chance to run.

Use the default primary interrupt handler by specifying NULL and set
IRQF_ONESHOT so the interrupt source is masked until the secondary
handler is done.

Fixes: c2b636b3f788d ("Bluetooth: btintel_pcie: Add support for PCIe transpor=
t")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260128095540.863589-7-bigeasy@linutronix.de
---
 drivers/bluetooth/btintel_pcie.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pci=
e.c
index 2936b53..704767b 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -1431,11 +1431,6 @@ static void btintel_pcie_msix_rx_handle(struct btintel=
_pcie_data *data)
 	}
 }
=20
-static irqreturn_t btintel_pcie_msix_isr(int irq, void *data)
-{
-	return IRQ_WAKE_THREAD;
-}
-
 static inline bool btintel_pcie_is_rxq_empty(struct btintel_pcie_data *data)
 {
 	return data->ia.cr_hia[BTINTEL_PCIE_RXQ_NUM] =3D=3D data->ia.cr_tia[BTINTEL=
_PCIE_RXQ_NUM];
@@ -1537,9 +1532,9 @@ static int btintel_pcie_setup_irq(struct btintel_pcie_d=
ata *data)
=20
 		err =3D devm_request_threaded_irq(&data->pdev->dev,
 						msix_entry->vector,
-						btintel_pcie_msix_isr,
+						NULL,
 						btintel_pcie_irq_msix_handler,
-						IRQF_SHARED,
+						IRQF_ONESHOT | IRQF_SHARED,
 						KBUILD_MODNAME,
 						msix_entry);
 		if (err) {

