Return-Path: <linux-tip-commits+bounces-8144-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH59I2Lke2nBJAIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8144-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 23:51:14 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173CB5849
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 23:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07E5D300CFFD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Jan 2026 22:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D136BCCC;
	Thu, 29 Jan 2026 22:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u3f96PhB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmS3pFSG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55436B06F;
	Thu, 29 Jan 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769727072; cv=none; b=iGW5AuAVJ75Y2l/5eBTR9MJ/973n1rjh1cnW/QGgsDbAXK2Nq0w+Ym0YFTrkXX+KLp4L1J+GfGYMSVNcmzc9uorOfKzxpue0HDjnuZukQozKSkzV3Bro7t7Q351Wo+t1A9dqXU0Va1FlSv5hpE3HFtX/ipmAy3tKEekBEDhzcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769727072; c=relaxed/simple;
	bh=+tOErYCcXQ5nRqNWMCLdZXMnlG3WcGyTIHS2DzJRt8I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MZ0OY099/1WUn4dDvwtw2P5730Onfvmc5Ep8xQO3zs644KdcRiJOk+Vle97SMuoBcSoSS8fYW2wYiUqbJALo+yku0Mm7breWZsSlkyjOGvleXvEU3Wn5CWeABbbAq+fut+ANaiSIVp4gGA4ezfwDEAV17yFetylFxbCFQI/nICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u3f96PhB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AmS3pFSG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 29 Jan 2026 22:51:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769727068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJp1sDSSyDacZ+OWhsu87YCGmRruw+7MynmxkBysqvM=;
	b=u3f96PhBtYFH6S4MWAZGCp52ySJhpFKSWogdkOakv+OMlOn60ipgmMHY1IhvKBvaXW9JNJ
	XbFgkAFrFdkYh4Ui8Ypjph23V/rft4ymcuGIygi+oK8ZgvDnVm4TnHdjti+d1zx3FkIYcB
	hM/IOGQBlrzhpvQ21ebvPtPvmIpYyWe6hkxWxDsN5xTwU/jSTG/TY8fRWZ8jz7h5TD65S7
	zpIh9PANeHUGSZFIa0wfKmXfHCKQobJF78GX1OrbPFqalI9zxrDe8i5Uzx8St9EDsdc6c+
	oQrXJ9mE3PsqGrlU9Uqaw2VEwcSVy/ysD0lXC0VvAisj8pyawPN129VUuKWscQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769727068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJp1sDSSyDacZ+OWhsu87YCGmRruw+7MynmxkBysqvM=;
	b=AmS3pFSGYtEKJUARN807wYUxCcWqi/KND/nrykwTp1XiVy7W6JwkkBUXYw4pwQI79uomfy
	fS8BWlp3YDTK8RCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] genirq/redirect: Prevent writing MSI message on
 affinity change
Cc: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87tsw6aglz.ffs@tglx>
References: <87tsw6aglz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176972706654.2495410.11469395258189630227.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8144-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 1173CB5849
X-Rspamd-Action: no action

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     37f9d5026cd78fbe80a124edbbadab382b26545f
Gitweb:        https://git.kernel.org/tip/37f9d5026cd78fbe80a124edbbadab382b2=
6545f
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 27 Jan 2026 22:30:16 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 29 Jan 2026 23:49:55 +01:00

genirq/redirect: Prevent writing MSI message on affinity change

The interrupts which are handled by the redirection infrastructure provide
a irq_set_affinity() callback, which solely determines the target CPU for
redirection via irq_work and und updates the effective affinity mask.

Contrary to regular MSI interrupts this affinity setting does not change
the underlying interrupt message as the message is only created at setup
time to deliver to the demultiplexing interrupt.

Therefore the message write in msi_domain_set_affinity() is a pointless
exercise. In principle the write is harmless, but a Tegra system exposes a
full system hang during suspend due to that write.

It's unclear why the check for the PCI device state PCI_D0 in
pci_msi_domain_write_msg(), which prevents the actual hardware access if
a device is in powered down state, fails on this particular system, but
that's a different problem which needs to be investigated by the Tegra
experts.

The irq_set_affinity() callback can advise msi_domain_set_affinity() not to
write the MSI message by returning IRQ_SET_MASK_OK_DONE instead of
IRQ_SET_MASK_OK. Do exactly that.

Just to make it clear again:

This is not a correctness issue of the redirection code as returning
IRQ_SET_MASK_OK in that context is completely correct. From the core
code point of view this is solely a optimization to avoid an redundant
hardware write.

As a byproduct it papers over the underlying problem on the Tegra platform,
which fails to put the PCIe device[s] out of PCI_D0 despite the fact that
the devices and busses have been shut down. The redirect infrastructure
just unearthed the underlying issue, which is prone to happen in quite some
other code paths which use the PCI_D0 check to prevent hardware access to
powered down devices.

This therefore has neither a 'Fixes:' nor a 'Closes:' tag associated as the
underlying problem, which is outside the scope of the interrupt code, is
still unresolved.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/all/4e5b349c-6599-4871-9e3b-e10352ae0ca0@nvidia=
.com
Link: https://patch.msgid.link/87tsw6aglz.ffs@tglx
---
 kernel/irq/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 35bc17b..ccdc47a 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1495,7 +1495,7 @@ int irq_chip_redirect_set_affinity(struct irq_data *dat=
a, const struct cpumask *
 	WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
 	irq_data_update_effective_affinity(data, dest);
=20
-	return IRQ_SET_MASK_OK;
+	return IRQ_SET_MASK_OK_DONE;
 }
 EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);
 #endif

