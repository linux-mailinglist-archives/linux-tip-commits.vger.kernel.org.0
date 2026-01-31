Return-Path: <linux-tip-commits+bounces-8157-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPH7H1pKfWlZRQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8157-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 01:18:34 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A5BF993
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 01:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD49930156F1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01632F745D;
	Sat, 31 Jan 2026 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3or3TYVi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TieKVLxD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260126ED25;
	Sat, 31 Jan 2026 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818702; cv=none; b=LB2Nvy92J7oQI8JX4WnmIce8Wgprfb94K5wOXn9YNvpz8yA9W8JXxwLtqcogxOYQw94pPx8VQmG+SlvE5kkQylBZHt+tsmzjhfcCSp7Y2ugg41wAH+xM+Hey4ZSFiK/A/9i0oXNZM2jlTTnZNRYcNAefJ9QSj4+JMRmfKoK5gFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818702; c=relaxed/simple;
	bh=yD3DRAWI88uLdPsLY0ccQ50SnXpLCQYi4Ibh/pIL7Vo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QXjzRX6D4k4q0hpYUdpgaxttt0yqtFBgqxS5Zp1WiBEU5sleNfobqoJw5Tgf/Iop8bhLatlR3knGRfMe1rS6ScsnSBS2EMy0vigSYh94K7h2mhLcXxi5oGdTZRW8wR6qU1HPmQByummlj+tfK7Xuy/PAqqzTNlGsQQx64CKUwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3or3TYVi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TieKVLxD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 31 Jan 2026 00:18:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769818696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlHC5Oc/wPfJ31HEj1ju7nH9g6ibBIbC1zhAHaSBltU=;
	b=3or3TYVicrO0EErAd8LbHUod53MYP+U9DcFLX5HS1f71/gH4fuLjtCjlp/N3EfrCj/s52/
	Eq0OyT3O56R9Rz8/LhNP+CqAXYqVqAu7STZt1rF6lHL3PhxYs/yB4LTI+IVPDYn1sDmTpn
	iQCkyildTiWqon4QpWTB9xRdAos1IkqW4RtDT70MgOwnXMcBx5lE1ziZ1hCxe1crihTjHC
	CofRs00Dd9H8uPhhAU5kDze6LH3p17rn6J6+ALrgGFL1eEb1P1ujDALqd6rH0YMuEm9ovt
	qf24CztAdNwf62XsBt8pHpsiegEQ2l8MIImi76hY9/SFEQGrT8p2Lw9MvXxiyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769818696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlHC5Oc/wPfJ31HEj1ju7nH9g6ibBIbC1zhAHaSBltU=;
	b=TieKVLxDFry2I7eQ2ZirgZg2/j3QMYO14gnjk5OkvEIt8hx5YOY56VaelO+nFoOyISsqJR
	ExoD2DevqKlo8JCA==
From: "tip-bot2 for Vivian Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] ALSA: hda/intel: Make MSI address limit based on the
 device DMA limit
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Thomas Gleixner <tglx@kernel.org>,
 Takashi Iwai <tiwai@suse.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260129-pci-msi-addr-mask-v4-4-70da998f2750@iscas.ac.cn>
References: <20260129-pci-msi-addr-mask-v4-4-70da998f2750@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981869456.2495410.17840609442257116657.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8157-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto,linutronix.de:dkim,msgid.link:url];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 247A5BF993
X-Rspamd-Action: no action

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     cb9b6f9d2be6bda1b0117b147df40f982ce06888
Gitweb:        https://git.kernel.org/tip/cb9b6f9d2be6bda1b0117b147df40f982ce=
06888
Author:        Vivian Wang <wangruikang@iscas.ac.cn>
AuthorDate:    Thu, 29 Jan 2026 09:56:09 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 31 Jan 2026 01:11:48 +01:00

ALSA: hda/intel: Make MSI address limit based on the device DMA limit

The hda/intel driver restricts the MSI message address for devices which do
not advertise full 64-bit DMA address space support to 32-bit due to the
former restrictions of the PCI/MSI code which only allowed either 32-bit or
a full 64-bit address range.

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
Acked-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260129-pci-msi-addr-mask-v4-4-70da998f2750@i=
scas.ac.cn
---
 sound/hda/controllers/intel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index c9542eb..a44de23 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -1903,11 +1903,6 @@ static int azx_first_init(struct azx *chip)
 		chip->gts_present =3D true;
 #endif
=20
-	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
-		dev_dbg(card->dev, "Disabling 64bit MSI\n");
-		pci->msi_addr_mask =3D DMA_BIT_MASK(32);
-	}
-
 	pci_set_master(pci);
=20
 	gcap =3D azx_readw(chip, GCAP);
@@ -1958,6 +1953,11 @@ static int azx_first_init(struct azx *chip)
 		dma_set_mask_and_coherent(&pci->dev, DMA_BIT_MASK(32));
 	dma_set_max_seg_size(&pci->dev, UINT_MAX);
=20
+	if (chip->msi && chip->driver_caps & AZX_DCAPS_NO_MSI64) {
+		dev_dbg(card->dev, "Restricting MSI to %u-bit\n", dma_bits);
+		pci->msi_addr_mask =3D DMA_BIT_MASK(dma_bits);
+	}
+
 	/* read number of streams from GCAP register instead of using
 	 * hardcoded value
 	 */

