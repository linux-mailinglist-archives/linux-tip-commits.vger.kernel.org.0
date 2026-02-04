Return-Path: <linux-tip-commits+bounces-8204-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NamMxxlg2nAmAMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8204-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 16:26:20 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1DFE88E4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 16:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FFA314198B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Feb 2026 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4701E41B371;
	Wed,  4 Feb 2026 15:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NKOR7aQ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d32aVufT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F218859B;
	Wed,  4 Feb 2026 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218125; cv=none; b=nxFZFBYiXVSwOZTQZ5G0Xus5c7I53pD92TKFAQDDdrJurR/8NESqmXkQZz3uLZ0Vav0fiWLrC1IpQWq7imrBCraZJxknPc6FuqKqx8kdNFLeL5rOHefAooPtRmZZrAxzUiyAnMISTi6cpOs9lVs3zJaxLTazZ+Df0S9c8QWUDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218125; c=relaxed/simple;
	bh=k7EUO6bpC0Bj2rmWgpxqtgduyTE2+uU6C7T67zTXOvI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cybvtfGn9Ht9YWEKKVoltJwOj4oNGU7sr+gkQVRTsfyjtD9ywlSvev9IFl0s2N++3bv1BztfXIxTZ2Imzg3zM9HgbJD/Sjfv92mn5VRuMMvfhnVYfxV2xaCXL3AZlphnW1/mW+ZK9AzD0d+1//SRnU3yst9tyIDrrM4utmOGQsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NKOR7aQ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d32aVufT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Feb 2026 15:15:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770218122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJkOUa4S2GFoQf0Y6mAmJm8hNK42gzuWas8C6W61uKQ=;
	b=NKOR7aQ5G+IP2dOVY4y4LduhxQUM6HThgrb53BKhBanvXGAKoMXdjn2IarQOH/kvLTxLPy
	NrKcNfORclQZEPAKKQP7uielVG6TqBKSL6luxcm+Lq+/ApA2X3DIH6nlytOmnnDy2rPjBl
	QPdRhNWpQ4Y7CtAYFndRRlX1WRt3ZWq6p5V+1swDtQTtjyO88CwKzf7XqVKjljjtr0gpWw
	kiy3kVFxUctpUtots2vMAemncXRQJBrioX42/u8ZLfrkRCokQaVm7HSQzMhM+yqnP9T4zW
	TVM4GGHMjc/iiqnfLGbocZu4eQ3Ln/u93qhhXPKi0FZTZRAYtQ9l24nXiQFSZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770218122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJkOUa4S2GFoQf0Y6mAmJm8hNK42gzuWas8C6W61uKQ=;
	b=d32aVufTUd8DzF7iROiwWoe24KBUMZpFKOUaucXFx7t6y0FUXUZEysWRYh525hWTyxxGRZ
	pz3VV5GJ6IKTGVDA==
From: "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/gic-v5: Fix spelling mistake "ouside" -> "outside"
Cc: Colin Ian King <colin.i.king@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260203210735.5036-1-colin.i.king@gmail.com>
References: <20260203210735.5036-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177021812133.2495410.8166678242581864066.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8204-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,huawei.com,vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,vger.kernel.org:replyto,msgid.link:url]
X-Rspamd-Queue-Id: 5A1DFE88E4
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     6054b10c328813e88bca31ac0d02eaff06057db0
Gitweb:        https://git.kernel.org/tip/6054b10c328813e88bca31ac0d02eaff060=
57db0
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Tue, 03 Feb 2026 21:07:35=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 04 Feb 2026 16:12:49 +01:00

irqchip/gic-v5: Fix spelling mistake "ouside" -> "outside"

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Link: https://patch.msgid.link/20260203210735.5036-1-colin.i.king@gmail.com
---
 drivers/irqchip/irq-gic-v5-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 554485f..f410e17 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -900,7 +900,7 @@ static int gicv5_its_alloc_eventid(struct gicv5_its_dev *=
its_dev, msi_alloc_info
 		event_id_base =3D info->hwirq;
=20
 		if (event_id_base >=3D its_dev->num_events) {
-			pr_err("EventID ouside of ITT range; cannot allocate an ITT entry!\n");
+			pr_err("EventID outside of ITT range; cannot allocate an ITT entry!\n");
=20
 			return -EINVAL;
 		}

