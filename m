Return-Path: <linux-tip-commits+bounces-1255-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E58C2525
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2731C221E8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0371127B5F;
	Fri, 10 May 2024 12:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="11+hxzAx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sd3CLe9Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104445E099;
	Fri, 10 May 2024 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345852; cv=none; b=r4QOeIdPfdngmKGIBAgzNF56UhaaKpc05X0kGLPK5v8RjUZwSJuHRK30gJXLjXCeLSf9sCZqabda3WaaMMnOBjkxsUb5agQohh3pyk5kMveRQUuFzfExQn0gnDQH7zcCp/elkvmFXrkUi81W6hQJxpAG/gFBPVBRniaG5kJWJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345852; c=relaxed/simple;
	bh=ZGRVqTFEMWYBCz+Ogsc0s7+4yPBz33VrTkzZV0AjK+k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bc+hdaasplAQXA3QZIH6f1r9+lXNo5yKk3jskzJW9rN1ApvvcJYhebvz4vqcLrFeZ30ui3vxA8lgKTwzA+lVnTBQzvop3uzWORKBYiqW7tSt9hVNsOfod6PSTPdBYeDGFoUvNpKbmgUZVtrvx4Cpk4z5orApidp6dCwnDdDAsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=11+hxzAx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sd3CLe9Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 12:57:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715345843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klnU4Krnaqq3B9PMjPh3i/uHeBg3LoHeLkENz0/w5kk=;
	b=11+hxzAxWVdrF6/nX+xSY63TyH3sdTv2twrpXawf06MUssc1+0tpHGYE3Bmfm79joDOTHv
	m8qyfc3YEs++AuVNWXfxYTxfepsupotR7ybglQoI8areq6u/7orxLefHwdMo7gK7TOrexY
	y1b/EFAllwFrFX6EAP+/U0efLN728ChU7GRt2OQhSPWa134LNiRHbXbzKJ3KlNkn35dJ6s
	ipwCevn6QRf2InLbbuD3PS4m+v9xMZNIJZvNNGKuiHhDvwQ3YBckpDy4Qq5P0NqZg3wD6x
	B6nYvM4UzeFvyS/Xnct93jyuvNeeAkwoybYkKGcC5CGqP28dqpC0YsF/YmV5VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715345843;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=klnU4Krnaqq3B9PMjPh3i/uHeBg3LoHeLkENz0/w5kk=;
	b=Sd3CLe9Y55aIl6oREpdq0LdbNByMIgQecORg5GdS1l9tC8AHPJCFKXUFIxv5W3ZqB16mvm
	u2Ab03NsRk7EurBw==
From: "tip-bot2 for Shyam Sundar S K" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/amd_nb: Add new PCI IDs for AMD family 0x1a
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240510111829.969501-1-Shyam-sundar.S-k@amd.com>
References: <20240510111829.969501-1-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171534584246.10875.17807164319702422561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0e640f0a47d8426eab1fb9c03f0af898dfe810b8
Gitweb:        https://git.kernel.org/tip/0e640f0a47d8426eab1fb9c03f0af898dfe810b8
Author:        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
AuthorDate:    Fri, 10 May 2024 16:48:28 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 10 May 2024 14:52:46 +02:00

x86/amd_nb: Add new PCI IDs for AMD family 0x1a

Add the new PCI Device IDs to the MISC IDs list to support new
generation of AMD 1Ah family 70h Models of processors.

  [ bp: Massage commit message. ]

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240510111829.969501-1-Shyam-sundar.S-k@amd.com
---
 arch/x86/kernel/amd_nb.c | 1 +
 include/linux/pci_ids.h  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 5bf5f9f..3cf156f 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -95,6 +95,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
 	{}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a0c75e4..c547d1d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -580,6 +580,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_1AH_M00H_DF_F3 0x12c3
 #define PCI_DEVICE_ID_AMD_1AH_M20H_DF_F3 0x16fb
+#define PCI_DEVICE_ID_AMD_1AH_M70H_DF_F3 0x12bb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_VANGOGH_USB	0x163a

