Return-Path: <linux-tip-commits+bounces-8241-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFPbK7RSnWk2OgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8241-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:26:44 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14535183041
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCC52318082F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DDE366078;
	Tue, 24 Feb 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l70SopXP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y2CAVaB2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA3365A11;
	Tue, 24 Feb 2026 07:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917636; cv=none; b=sECEytys7Pk9F+Bdo/3etkwMicXYFbB1zrz+5bj9bzUd4tkSEJS1XvgyA4i57EjQpqZUswgNK5gwDb8Y1Uu9elm3C9ojJrLBj9c+v8w2xEZ94ovSFczFPtVMDbLhc2oSl5UqdPakGRa4xegZWWr0AXkXUjW5ZfNl5u/PR6gMbSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917636; c=relaxed/simple;
	bh=PnP5gMsK1S1EAZVZAhe+hcghYPcaeL2e34NxW7foNUM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ch/q5NEvKI6af3ZltkapcrS2PwWbtWVkSBqq3W1icLTKcz1b398+XyNBIipufCD7a848lQ1+++FI3vmQFo9KXk8K9aKN0lx+tTfCXEos0mH+Y5TioYFWS/GozLH2CUuB/U2A1GiMJNIz6L8hruhqkb3WLmFXYe61Ih1TGxy4c5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l70SopXP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y2CAVaB2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 07:20:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771917628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkYzT/cPO1nNVE8+tLot3N3EO8U/H5LB+NyERi4h+HM=;
	b=l70SopXPPAqqpKHdafRGE0RvlUz8NNblKe1XnVuQ14bdXDp5wj0j/L5E2WpW+i8+ppgp6P
	CLwT68/2Z7x85MUkJ+Px4QSmrmeVCCAfaSQeogrIXWSUm/IPjA05HugsN+no8nF12c+G+O
	XoXkJBmi3xes9Q+1cXwzc7ZKZdHg12V01s2eSCnt7pii3GlhiRBEUHHNI5DvVLTuGFufVY
	XzpNNdoFdmWtQueMSDR0vIFylDGizBtzijBs67CISbDzsp2WznEEbJkKNB0OY5mzZxCK/W
	Xb1wsrV+uaubTkmKqbEhdGTmnvAb73vM7jDyyLEILbFIiIB0s/9PuKNOZLBTKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771917628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkYzT/cPO1nNVE8+tLot3N3EO8U/H5LB+NyERi4h+HM=;
	b=y2CAVaB2Fy0OhRPue3kDjuaNWqS8AXh3RMWVJOEg8cikx3/qG4wFiTJmguI7vGfNymwcaB
	wpb+sm+oE8eig/BA==
From: "tip-bot2 for Brian Masney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-pic32-evic: Address warning related to
 wrong printf() formatter
Cc: Brian Masney <bmasney@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260222-irqchip-pic32-v1-1-37f50d1f14af@redhat.com>
References: <20260222-irqchip-pic32-v1-1-37f50d1f14af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177191762698.1647592.17514797558064592135.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8241-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 14535183041
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     86be659415b0ddefebc3120e309091aa215a9064
Gitweb:        https://git.kernel.org/tip/86be659415b0ddefebc3120e309091aa215=
a9064
Author:        Brian Masney <bmasney@redhat.com>
AuthorDate:    Sun, 22 Feb 2026 18:43:44 -05:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 08:15:43 +01:00

irqchip/irq-pic32-evic: Address warning related to wrong printf() formatter

This driver is currently only build on 32 bit MIPS systems. When building
it on x86_64, the following warning occurs:

    drivers/irqchip/irq-pic32-evic.c: In function =E2=80=98pic32_ext_irq_of_i=
nit=E2=80=99:
    ./include/linux/kern_levels.h:5:25: error: format =E2=80=98%d=E2=80=99 ex=
pects argument of type
     =E2=80=98int=E2=80=99, but argument 2 has type =E2=80=98long unsigned in=
t=E2=80=99 [-Werror=3Dformat=3D]

Update the printf() formatter in preparation for allowing this driver to
be compiled on all architectures.

Fixes: aaa8666ada780 ("IRQCHIP: irq-pic32-evic: Add support for PIC32 interru=
pt controller")
Signed-off-by: Brian Masney <bmasney@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260222-irqchip-pic32-v1-1-37f50d1f14af@redha=
t.com
---
 drivers/irqchip/irq-pic32-evic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evi=
c.c
index e85c3e3..325b97a 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -196,7 +196,7 @@ static void __init pic32_ext_irq_of_init(struct irq_domai=
n *domain)
=20
 	of_property_for_each_u32(node, pname, hwirq) {
 		if (i >=3D ARRAY_SIZE(priv->ext_irqs)) {
-			pr_warn("More than %d external irq, skip rest\n",
+			pr_warn("More than %zu external irq, skip rest\n",
 				ARRAY_SIZE(priv->ext_irqs));
 			break;
 		}

