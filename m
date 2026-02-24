Return-Path: <linux-tip-commits+bounces-8239-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BR3Ka5SnWk2OgQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8239-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:26:38 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE3718303A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 08:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD8830ED0B2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57366364EBF;
	Tue, 24 Feb 2026 07:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oTMrNOkQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7MfAJB0p"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C303644DF;
	Tue, 24 Feb 2026 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917636; cv=none; b=kDrr8F8gV61l2apzCsdUq4Q0gly30OuF3URZ6QOJw8qnUXhQ2skiOXakHfjRrMdj2o/AKS8PFsenXtAAow+O9Kv0y80THaXLtuV0Vp8rorK4Nt6rl58d01suTirx+NPCOeTXAJCsasORE4j3y/1z9CXkc0M8TTBz4sCVunIGqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917636; c=relaxed/simple;
	bh=qMGNIXH177XLsfdZhp5BI0z01QVXm1dOqfYQD++ZvYI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l8/bSvB1YnqQZTMsU34IUc2FiSDXlNMylAlbvMbjNyg6HSrF07IRyQr3N5MT/gxPhxYx8jO+Ni1wuRZKA4WsYnYIygZZsx2g5Mqmm01sNF6y3yHmf554J89Fn20akYH9MQJkT/Kosmc0Q2S1CkLz3v1QRvp7iLYDXzdxRBifL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oTMrNOkQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7MfAJB0p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 07:20:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771917629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvmrTlxN8b6791yJSEo/rnmIRHPpbvnRLY/vy3kG6Lc=;
	b=oTMrNOkQOjZ+Q6EDh+kqTETrlVsPJd7rSbwzYdh/VjB/ncModfqiU8MdabJJuHsCdkssl2
	yAx2cBI1r1HpEURkuYoFr/o/RtcUyUU+VjzNSD8JjbX6Yv2Ebln9AxIlQ8bI6YMIFJ6h4M
	s6DnY6Cm8OmUD9E1TqYvJ7iPnol955EtwUu0KZc0enZIY5gbZeOKxQ2reYrn9c1U0SJUpH
	Q/Zb+HmTRILV/7h7UY+jn7qhdRznZagdI684AUd4T1KND3L0UZf5WhEB/Laxt/neFpujm+
	Wk+LRcEWs0Ad5+y+11YJXzvRv79T9oWpN/wmlBOBF26VqvnJeOR8YH6Wvr8B6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771917629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BvmrTlxN8b6791yJSEo/rnmIRHPpbvnRLY/vy3kG6Lc=;
	b=7MfAJB0pIqw2HP1xgtwhEgBuK0Khkr36pBfCc5CU7c+izZ0Z3xb91TCdhmd8X8p0cDHPSS
	mCTC7EYRC6cMukAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/msi-lib: Refuse initialization when
 irq_write_msi_msg() is missing
Cc: Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87a4xp35cn.ffs@tglx>
References: <87a4xp35cn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177191762812.1647592.14854863572392804354.tip-bot2@tip-bot2>
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
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8239-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: 0BE3718303A
X-Rspamd-Action: no action

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     aa80869b77e16d30ce69523528c63a2e2b050634
Gitweb:        https://git.kernel.org/tip/aa80869b77e16d30ce69523528c63a2e2b0=
50634
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 03 Feb 2026 22:05:44 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 24 Feb 2026 08:17:14 +01:00

irqchip/msi-lib: Refuse initialization when irq_write_msi_msg() is missing

MSI parent domains rely on the fact that the top level device domain
provides a irq_write_msi_msg() callback.

Check for that and if missing warn and refuse to initialize the device domain.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/87a4xp35cn.ffs@tglx
---
 drivers/irqchip/irq-msi-lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index d5eefc3..45e0ed3 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -48,6 +48,9 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct i=
rq_domain *domain,
 		return false;
 	}
=20
+	if (WARN_ON_ONCE(!chip->irq_write_msi_msg))
+		return false;
+
 	required_flags =3D pops->required_flags;
=20
 	/* Is the target domain bus token supported? */

