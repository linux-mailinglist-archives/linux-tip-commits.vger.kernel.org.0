Return-Path: <linux-tip-commits+bounces-7219-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 16110C2E3D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 23:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4A304E100B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 22:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C427B4EE;
	Mon,  3 Nov 2025 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bF67dVHn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EkGbKN88"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C1719A288;
	Mon,  3 Nov 2025 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208220; cv=none; b=kSkOJ4g0B6ez0dZev4C+WBDxuryUDqYKCKVtDVGbCbCCkicK102UXaw62bsJ2GRAaRQJfnkpbdGtdFAgk0opTsKcBjOsknLk214rc6KMvPocr9b3pNB8fwLLhFzseQ49myQ18fn4sY6jyVUNbC2Ea94atqwhLTbY3FA5Zl9ftW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208220; c=relaxed/simple;
	bh=DuTtEh5xzYR0OUk5WXwUeF168GGdEmVfFmnjCIekhOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QXNrkrgpgGleCWfDCT3J1xWP2UWS+yISB7z3bqO1r1Qy3x8iNEn+LeeoXR2jBrR8Xetr+U0Nq4iUjyc4pAGFLRpOqKrzZD/EdZT1Xov9fdfBve57tRCd+Vffob5YF59YYpj1FpibIJFKauEIMjHKOTJNloeKex5BLN99QW8eeaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bF67dVHn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EkGbKN88; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 22:16:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762208216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgflDN3an8aadkJVzahJTSIJwwYhr16PJ1o+03mDsmk=;
	b=bF67dVHnCOWcICi0FJNM+HYSWWBL1rRNl6C4Quo1VOE7RBkl/yAZV0Nc4WVxE5J6QX6JdS
	xM24bOXLpDpwyuCvPU9GGiet0k/eM+zSJRGymMatHRCwrGq7fJ9Pmb8N7oO/9xgtRR7AqX
	GS9rA5mv1QsmPIlWNq+v9w1UsPa64rG4TfjVmuFDh4iSong8KenWOeKS8UWK7VgfMYonua
	Mz/3e7q6gHvdJ9T9h2FU/u6moCSO5zbLmMtzT3LQ/vLcbWYfrCY+Y5F1I3d4EO8zzW+IAj
	Fg1b8jAhKdzw/I0NX1Uf2w2HpSXdVugeb16xZZXo5Ak1qof9hJg6cR5wBdX/jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762208216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgflDN3an8aadkJVzahJTSIJwwYhr16PJ1o+03mDsmk=;
	b=EkGbKN88gGMJRu5WLl4yCQbWtlpcHdlyxpsfTA+5f3yRY2tSDYm2PalCu0DLDir5U5AJQz
	YT5Z/uRGDv0COYCw==
From: "tip-bot2 for Charles Mirabile" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/sifive-plic: Fix call to __plic_toggle() in
 M-Mode code path
Cc: kernel test robot <lkp@intel.com>, Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20251103161813.2437427-1-cmirabil@redhat.com>
References: <20251103161813.2437427-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176220821193.2601451.18003408663076885327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3d02464f7b12d3244f2fbc210afcdd0cdb7da4f7
Gitweb:        https://git.kernel.org/tip/3d02464f7b12d3244f2fbc210afcdd0cdb7=
da4f7
Author:        Charles Mirabile <cmirabil@redhat.com>
AuthorDate:    Mon, 03 Nov 2025 11:18:13 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Nov 2025 23:15:04 +01:00

irqchip/sifive-plic: Fix call to __plic_toggle() in M-Mode code path

The code path for M-Mode linux that disables interrupts for other contexts
was missed when refactoring __plic_toggle().

Since the new version caches updates to the state for the primary context,
its use in this codepath is no longer desireable even if it could be made
correct.

Replace the calls to __plic_toggle() with a loop that simply disables all
of the interrupts in groups of 32 with a direct mmio write.

Fixes: 14ff9e54dd14 ("irqchip/sifive-plic: Cache the interrupt enable state")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251103161813.2437427-1-cmirabil@redhat.com
Closes: https://lore.kernel.org/oe-kbuild-all/202510271316.AQM7gCCy-lkp@intel=
.com/
---
 drivers/irqchip/irq-sifive-plic.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index cbd7697..39ea044 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -592,12 +592,11 @@ static int plic_probe(struct fwnode_handle *fwnode)
 		if (parent_hwirq !=3D RV_IRQ_EXT) {
 			/* Disable S-mode enable bits if running in M-mode. */
 			if (IS_ENABLED(CONFIG_RISCV_M_MODE)) {
-				void __iomem *enable_base =3D priv->regs +
-					CONTEXT_ENABLE_BASE +
-					i * CONTEXT_ENABLE_SIZE;
+				u32 __iomem *enable_base =3D priv->regs +	CONTEXT_ENABLE_BASE +
+							   i * CONTEXT_ENABLE_SIZE;
=20
-				for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++)
-					__plic_toggle(enable_base, hwirq, 0);
+				for (int j =3D 0; j <=3D nr_irqs / 32; j++)
+					writel(0, enable_base + j);
 			}
 			continue;
 		}

