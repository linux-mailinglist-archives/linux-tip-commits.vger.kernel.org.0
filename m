Return-Path: <linux-tip-commits+bounces-8113-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPjRHkMsd2nacwEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8113-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 09:56:35 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 890FD85A9B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 09:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 023383001069
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 08:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9813090E0;
	Mon, 26 Jan 2026 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="msjTDTky";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gXRv2sNZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDE73090C1;
	Mon, 26 Jan 2026 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769417790; cv=none; b=hSVha8K8FaPeTbTTzv/H6EKiMgY8pm3UAsxs+1G46Hcc3IJUxNXE0Cob56fagCua6deZwi+TKzLlCb/K6RXjKT3/uBN9iigXXAhG5p3nGnXvIGDxREySh8O1J/VHFt03vivEG/OTDR+mv6RRoKMyEhIYd9Ro+fjmZcO2vA6yfZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769417790; c=relaxed/simple;
	bh=q3waURPNTZyOFu2VS+BLwRl1kpZ8nrEkC1WSxwHcihI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bQFAM3lBzzG3vd+9d3kDuVv26TCI0vnIucXnwhnZEiNgZ01UAELgvkqzOa5C2fhblGCigkg4vBZ6chLhRwbblKdVVg5p5hGKrH62IBS3kDPnBG9nAL5U2w4aEpDt/bc6Nr4rEM5SLdWYEej3QpHwp6xAdBwF0JN3qtiRrDyKrtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=msjTDTky; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gXRv2sNZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Jan 2026 08:56:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769417788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbOA970KGAygUBNOo2GlFDYIjWhsHkV8GNrut60JoIk=;
	b=msjTDTkyENTER6IJgBiRjmczLv23KFf0Xf0xbOQkJqBEUmJw7mlHzJUKI4DCfyqpJUPHkN
	Lq7MDJSJk3Bek2Th3L1zcsY8qx3vzQ59ULEWono1c797kBJVN8TgfzIYD0drQhnDaJn27C
	G9LAN/W2ps0DWcF8gcU+qTTNhGxjPkYhpHCSPyoWGmH991Sl60VaL26GGrHKELqAmjYbdS
	5YhOKlW8NTbgPjl27PqIP95gI4s+riLY+yMGsQd0LZclziBn/KLZ7EnjOcsMkRiPyawrQc
	nLhqFhGIcLx6JjfwPQezYJ8AZm+fDbLingNbtDYSBV9SU2lvjHokgvlahJkKGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769417788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NbOA970KGAygUBNOo2GlFDYIjWhsHkV8GNrut60JoIk=;
	b=gXRv2sNZbry3DGUvs/H4jpxZxbE+ZQbq6WHsRsb/+HN95uAVSG5ZtHxID1SEixH09qN7lA
	kB1Us96ezOVPlnDw==
From: "tip-bot2 for Haoxiang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Unmap MSI-X region on error
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260125144452.2103812-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260125144452.2103812-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176941778179.510.14598280314675299233.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8113-lists,linux-tip-commits=lfdr.de];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 890FD85A9B
X-Rspamd-Action: no action

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1a8d4c6ecb4c81261bcdf13556abd4a958eca202
Gitweb:        https://git.kernel.org/tip/1a8d4c6ecb4c81261bcdf13556abd4a958e=
ca202
Author:        Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
AuthorDate:    Sun, 25 Jan 2026 22:44:52 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 26 Jan 2026 09:46:48 +01:00

PCI/MSI: Unmap MSI-X region on error

msix_capability_init() fails to unmap the MSI-X region if
msix_setup_interrupts() fails.

Add the missing iounmap() for that error path.

[ tglx: Massaged change log ]

Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260125144452.2103812-1-lihaoxiang@isrc.iscas=
.ac.cn
---
 drivers/pci/msi/msi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 34d6641..e010ecd 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -737,7 +737,7 @@ static int msix_capability_init(struct pci_dev *dev, stru=
ct msix_entry *entries,
=20
 	ret =3D msix_setup_interrupts(dev, entries, nvec, affd);
 	if (ret)
-		goto out_disable;
+		goto out_unmap;
=20
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
@@ -758,6 +758,8 @@ static int msix_capability_init(struct pci_dev *dev, stru=
ct msix_entry *entries,
 	pcibios_free_irq(dev);
 	return 0;
=20
+out_unmap:
+	iounmap(dev->msix_base);
 out_disable:
 	dev->msix_enabled =3D 0;
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_EN=
ABLE, 0);

