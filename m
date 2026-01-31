Return-Path: <linux-tip-commits+bounces-8156-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KacKFJKfWlZRQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8156-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 01:18:26 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4865BBF97C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 01:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA9BE30022CC
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 00:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB852F5A3D;
	Sat, 31 Jan 2026 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E//o3Evu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NfRmePK6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B257D224249;
	Sat, 31 Jan 2026 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818702; cv=none; b=ekO98XApbwpw0hGv8Ra45b81v9NITpFAzJtI6hMZqVMB13gbqo3ZbFTH9DHWL5qZgoRmtKsRambDdrVKjA41SQtXw/3xZ6Ye1N/4wbAR+wL066O3oucTqWf/JHeed4pgQbZIb/g4QGwtpfwykfJYHibeb6joErfGT462k5G4qA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818702; c=relaxed/simple;
	bh=U56xa28Z1eeY0xClpFefsNjQaryEsPFrlQWxH4Trnh0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tYMGdqLdrX5AYH+ODW+4E2VI+Qz9DGU5Ij1oK2mHb3HkA8DEoSE8LSYBcGp/ekb1ih1JHy46gVuo5KwBK770q4gguqThCITAm2E8V7+z23LX7tjOcJddi7VgSJb6igP0KnQrK90nUf9mQJZt35AcIUElCO5mChFRltr1OCX4Ul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E//o3Evu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NfRmePK6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 31 Jan 2026 00:18:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769818697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dfKgyDaqZKafir2gtcHpIAbX1jTdshJd1NZxkEKIss=;
	b=E//o3EvuPo0UC3wngfpNQgJimqQhKZzIEjNq4hqyMjcs71ZVqSV+xtteO1SXC08Dh9ujb9
	xl/MEaYSoVbAMobj/CwBPpmdASf4gpEhYJEYXmKpUhHDl++FhNkfI3oEGY+SqOW0zgQNSF
	SJvSQLOl3eQhHRnm9m87TY6p3IHErxkmRNt/iyra7uWjRPUIlSQStyUZq9iJDz6/HhtCde
	cqm7Vo5VQoVMgu7JxSLBIP+qc0VXv594ScxN0S7R/NnXjFWLvD6LCPI3bOE59zTKEO7rR5
	z21IENWTu9pGy8c5oP1cSDqZiKKxylHR81gVOBu4F5vesVyCNHP+LMs2Ue+tfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769818697;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dfKgyDaqZKafir2gtcHpIAbX1jTdshJd1NZxkEKIss=;
	b=NfRmePK6ZbA7tgzDFclr1pefFOhFnXH83IsXARgSOP9zM3AFI8CJ2odio5gnTy0ROerPqM
	QtYADK44yb4jHxCw==
From: "tip-bot2 for Vivian Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] drm/radeon: Make MSI address limit based on the device
 DMA limit
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Thomas Gleixner <tglx@kernel.org>,
 christian.koenig@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260129-pci-msi-addr-mask-v4-3-70da998f2750@iscas.ac.cn>
References: <20260129-pci-msi-addr-mask-v4-3-70da998f2750@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981869569.2495410.10603060915971455685.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8156-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,amd.com:email,linutronix.de:dkim,vger.kernel.org:replyto];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 4865BBF97C
X-Rspamd-Action: no action

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     617562bbe12df796fc21df5fbf262eadf083a90f
Gitweb:        https://git.kernel.org/tip/617562bbe12df796fc21df5fbf262eadf08=
3a90f
Author:        Vivian Wang <wangruikang@iscas.ac.cn>
AuthorDate:    Thu, 29 Jan 2026 09:56:08 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 31 Jan 2026 01:11:48 +01:00

drm/radeon: Make MSI address limit based on the device DMA limit

The radeon driver restricts the MSI message address for devices older than
the BONAIR generation to 32-bit MSI addresses due to the former
restrictions of the PCI/MSI code which only allowed either 32-bit or full
64-bit address range.

This does not work on platforms which have a MSI doorbell address above the
32-bit boundary but do not support the full 64 bit address range.

The PCI/MSI core converted this binary decision to a DMA_BIT_MASK() based
decision, which allows to describe the device limitations precisely.

Convert the driver to provide the exact DMA address limitations to the
PCI/MSI core. That allows devices which do not support the full 64-bit
address space to work on platforms which have a MSI doorbell address above
the 32-bit limit as long as it is within the hardware's addressable range.

[ tglx: Massage changelog ]

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Link: https://patch.msgid.link/20260129-pci-msi-addr-mask-v4-3-70da998f2750@i=
scas.ac.cn
---
 drivers/gpu/drm/radeon/radeon_device.c  |  1 +
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/=
radeon_device.c
index 60afaa8..5faae03 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1374,6 +1374,7 @@ int radeon_device_init(struct radeon_device *rdev,
 		pr_warn("radeon: No suitable DMA available\n");
 		return r;
 	}
+	rdev->pdev->msi_addr_mask =3D DMA_BIT_MASK(dma_bits);
 	rdev->need_swiotlb =3D drm_need_swiotlb(dma_bits);
=20
 	/* Registers mapping */
diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon=
/radeon_irq_kms.c
index d550554..839d619 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -245,16 +245,6 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
 	if (rdev->flags & RADEON_IS_AGP)
 		return false;
=20
-	/*
-	 * Older chips have a HW limitation, they can only generate 40 bits
-	 * of address for "64-bit" MSIs which breaks on some platforms, notably
-	 * IBM POWER servers, so we limit them
-	 */
-	if (rdev->family < CHIP_BONAIRE) {
-		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
-		rdev->pdev->msi_addr_mask =3D DMA_BIT_MASK(32);
-	}
-
 	/* force MSI on */
 	if (radeon_msi =3D=3D 1)
 		return true;

