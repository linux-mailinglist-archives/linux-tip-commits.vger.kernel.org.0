Return-Path: <linux-tip-commits+bounces-8155-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPXsLVFKfWlZRQIAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8155-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 01:18:25 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AC9BF973
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 01:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8B0C300ECBD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 31 Jan 2026 00:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7C2F25E0;
	Sat, 31 Jan 2026 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h5RKqWh+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jdfbEpbp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B251E18027;
	Sat, 31 Jan 2026 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769818702; cv=none; b=YILlmIaZrkWHdoLo+ESyPfZsFmkJ+GJaKZ0gTHxx2Bsoo6BCPSqMTo/4gsH1+opmAE5xKSCoyqrC2OhDkYtDn5HS4QicGeMEyrLJsxrGQ/gAqSk/Zp+eEOoUCdIeV+C/GCnBPDLW1Wx/O1C2AZHkkWfLLTra7g0sVgJDkXsdZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769818702; c=relaxed/simple;
	bh=63C/7j06qlqWLjjPKhiNCnMG8tV3cCBbXOQF2XqDom4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s+hj0Y+M4xocq5yIOvAAPFatPG0mTEU6fb7EvreaZpotvuNvfijVeAHor+qGuV0ll0SfJ0FZe6xzAoFBPTJjk3bdb20so9u88o5Fm2+sXfNQJsZm4XxMOGpO7LM6C+h46uH80qMPQBV/a+vGNH8bY1iLU1f08adg/5unAkLDXGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h5RKqWh+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jdfbEpbp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 31 Jan 2026 00:18:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769818698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CrFJT7kf2qQqveRJB5NJnd+0QSCABnw66Wh8OozXZk=;
	b=h5RKqWh+bRTQ9RUs4AIw0GoIHbtzfeEQp5yaELL1jy07DisRVOuOx14lLYVGseaEvuNSf1
	m56xgFEy2EYuMadbumIvln7XpN9Nh7iJfIMe5pffFvHdtNlal4RxkfbjseDXGVbEAo3M1t
	n/hg5kOMPxfR0QhGtyNQX7+JIITVVRpAAHtTbtK/uoQD8yTT3f8+nvs1a22c6l2G5PMv7f
	0yhXtG6SOE2gS2FUAcYPtYJlW70RiQOPoqIoBuYA045VkEpzZ8EVPkuwvE1rioY/fxic39
	3+kF3Zb6e4y35Q3IsWg01H0fpA1QfrFFGq/EbxnDR2H3ydYo1+H7fIsRsMeHrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769818698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CrFJT7kf2qQqveRJB5NJnd+0QSCABnw66Wh8OozXZk=;
	b=jdfbEpbpihcb46bjamVPaTJ54pAbUTrpBeYCh1vlud+N5ogmtjZr6H3Ije3XawOOW3EO2C
	D4HKgQ3avFhBfhCg==
From: "tip-bot2 for Vivian Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] PCI/MSI: Check the device specific address mask in
 msi_verify_entries()
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260129-pci-msi-addr-mask-v4-2-70da998f2750@iscas.ac.cn>
References: <20260129-pci-msi-addr-mask-v4-2-70da998f2750@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176981869678.2495410.6070010419940519202.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8155-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linutronix.de:dkim];
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
X-Rspamd-Queue-Id: 10AC9BF973
X-Rspamd-Action: no action

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     52f0d862f595a2fa18ef44532619a080c24fe4cb
Gitweb:        https://git.kernel.org/tip/52f0d862f595a2fa18ef44532619a080c24=
fe4cb
Author:        Vivian Wang <wangruikang@iscas.ac.cn>
AuthorDate:    Thu, 29 Jan 2026 09:56:07 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sat, 31 Jan 2026 01:11:48 +01:00

PCI/MSI: Check the device specific address mask in msi_verify_entries()

Instead of a 32-bit/64-bit dichotomy, check the MSI address against
the device specific address mask.

This allows platforms with an MSI doorbell address above the 32-bit limit
to work with devices without full 64-bit MSI address support, as long as
the doorbell is within the addressable range of the device.

[ tglx: Massaged changelog ]

Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260129-pci-msi-addr-mask-v4-2-70da998f2750@i=
scas.ac.cn
---
 drivers/pci/msi/msi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index fb9a42b..e241217 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -321,14 +321,16 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int =
nvec,
 static int msi_verify_entries(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
+	u64 address;
=20
 	if (dev->msi_addr_mask =3D=3D DMA_BIT_MASK(64))
 		return 0;
=20
 	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
-		if (entry->msg.address_hi) {
-			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only su=
pports 32 bits\n",
-				entry->msg.address_hi, entry->msg.address_lo);
+		address =3D (u64)entry->msg.address_hi << 32 | entry->msg.address_lo;
+		if (address & ~dev->msi_addr_mask) {
+			pci_err(dev, "arch assigned 64-bit MSI address %#llx above device MSI add=
ress mask %#llx\n",
+				address, dev->msi_addr_mask);
 			break;
 		}
 	}

