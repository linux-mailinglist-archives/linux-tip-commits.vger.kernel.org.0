Return-Path: <linux-tip-commits+bounces-7311-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E021C4FD2F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 22:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B01154E45B7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 21:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6D2326929;
	Tue, 11 Nov 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LfbAkf1G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+pLvb7ex"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5035CBCF;
	Tue, 11 Nov 2025 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895849; cv=none; b=IFjMp6z0mWWO9xHh56VVrcJNzHsMfGEUG/coyLAmJ0voXWn1M+KJDJsZwZ7qwCj0LsymCPyk+BKPVR/EBU+Pa7H89s1Iz/n8TZFgn0wnhRb3TOjuryhoT7dJRZ6T3z0gKUwR5s7wiyDKT6GGtOblAJ6E6qvWz/Ye/3HN/ApJ7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895849; c=relaxed/simple;
	bh=iknSa/oex+29BP7bhzgQRewfyJpKmitaUhukCJuyM70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HmKK7DQ7t2ft3/gkyVzCBrfjrLwoJZptD3h7n0q6OU5f19ZrDEavGzhj6MFyq57TRlDLvoNNTRF9fHwG24TUMPyIThaSp6hdjcYR6XwD5eYE5W5Uc83sFdqUwWvGGwVs6szD9eyK4INRjv/Nf+a/tSESjXXBTWXsi/XIT4ECTpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LfbAkf1G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+pLvb7ex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 21:17:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762895846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qmY3nlXRVyGvDRaa7p/fgj+S/pBQndKeNhj8MiNxcU=;
	b=LfbAkf1GVg2BJTxEaNWLT4n+9sgi3FzwlLD/D9tGFZY9aWS+8aMchjQGzEuIw+v7F4FQOD
	f4J7Z0vpKhpsXgxTaIfAaYJQ1XMaaVTrtWm5zcjV733TR8YP/6IsJUFEvHbp0WYtn+KCTG
	/IursdVdLipCO8KnnQoiOmHULflx0RnE7ae6uAX/oXYOGrF9iC154aB9GZM+FroePGEtkc
	vbQz77YMX55fWHc+IbKF1LVY1444IB1IUqjFRXX5wDQVIh1paMjzXpjAO1Rb05wKC53vz/
	ipV6aTbC/1bwM5TWEpZcDmZvLI7XNVMw7SWA7QH2eyMHL53SDqn3u1T0hhNAqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762895846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qmY3nlXRVyGvDRaa7p/fgj+S/pBQndKeNhj8MiNxcU=;
	b=+pLvb7ex4ErK55XmClVqRxNJKp3CXch9rNfhklP+SGfe1rbUAFsc9JhvpV6jKbfKUbQJ7g
	HX2BPml8BtFv0XAQ==
From: "tip-bot2 for Charles Mirabile" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sifive-plic: Fix call to __plic_toggle()
 in M-Mode code path
Cc: kernel test robot <lkp@intel.com>, Charles Mirabile <cmirabil@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251103161813.2437427-1-cmirabil@redhat.com>
References: <20251103161813.2437427-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176289584492.498.4082561138383153410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a045359e72455c4fd178fbedbf398f8df7da97e7
Gitweb:        https://git.kernel.org/tip/a045359e72455c4fd178fbedbf398f8df7d=
a97e7
Author:        Charles Mirabile <cmirabil@redhat.com>
AuthorDate:    Mon, 03 Nov 2025 11:18:13 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 11 Nov 2025 22:11:16 +01:00

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
index c03340e..c5db7d6 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -679,12 +679,11 @@ static int plic_probe(struct fwnode_handle *fwnode)
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

