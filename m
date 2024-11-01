Return-Path: <linux-tip-commits+bounces-2691-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9259B9A26
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 22:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23671F2167B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Nov 2024 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1161A256C;
	Fri,  1 Nov 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3qUshRB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R9cpcemk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947441E767B;
	Fri,  1 Nov 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730496263; cv=none; b=bVTWhsxJin2+TjtHItw39T9VhnXN9lhxF1Oo5r0t395Cx+vB7C9ZtgtBSXel0S6BVVva5hgSfxsiQGGM0o/LGZ/gc6n90jaLKV7zuk7smBtckAMFpg6az0//blBoDUn/2uHEJT00UuH4/vS6W1DyfmWfbrvJQGVlRskRCzOqAIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730496263; c=relaxed/simple;
	bh=xoMprPQaSSKMWgdHWx48W6aOHF+TNGJmi79Tqneg2ho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eWcf9H5q/2KwVFpye2HJnHP0geXe6XPc+T/lG7MT9PWorJPGarpd9JyIEpPdeKPBqIqsUCqpMHhYXE1GHN+QnSZPCEUisuW8B/0jcxMddJH+SlCHCLj8RLPR1QeiOZfqfblm7O2UoFqHBRZ4xvnlkK6kHLU7iQU7sVWO9WUVFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3qUshRB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R9cpcemk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 01 Nov 2024 21:24:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730496259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+r13MujLqSNEjcH1bpKNUfcUzgeLbw8f72uOt9h3fzg=;
	b=q3qUshRBX7ub4NCgSAWUvkyNTph7KLam2erOZqdr+oUzWcilS8GniOs3KYdXZ0EzbYmyJq
	tDg4u7XGp5MZxqYxdHQmj5YkvPcMhVSq0UsBhRVtPGdrilxDblvNqhsVf6jlRJ3piBqLwH
	L5dgIOwpbxc+3W62hYgzYF2LezMPlE6r7Q/435K8so1UNDvO00x3E5yWRWr0eWrI/Tel2R
	8andt0QKmaU0qG7sb7cUqthXB6ADC+18R6ot6IV2LW2aH/qXBfjbz35pXZmyAhbTaM+usg
	G+ZDefWqjh7Gv4M6LYoEco32LnSz3/DT3SZ6SzP+e3QA4Vhnwk8niq+YEAfEDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730496259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+r13MujLqSNEjcH1bpKNUfcUzgeLbw8f72uOt9h3fzg=;
	b=R9cpcemkEwzzZmg523tuYKj/+qjor+W+oKI5oxP6t62srJg90qSu6L/i3uNISIbbA452B1
	nFBgfQz9Muk3UJCw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mips-gic: Fix selection of
 GENERIC_IRQ_EFFECTIVE_AFF_MASK
Cc: Nathan Chancellor <nathan@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C20241101-mips-fix-generic=5Firq=5Feffective=5Faf?=
 =?utf-8?q?f=5Fmask-select-v1-1-d94db6e0de0d=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C20241101-mips-fix-generic=5Firq=5Feffective=5Faff?=
 =?utf-8?q?=5Fmask-select-v1-1-d94db6e0de0d=40kernel=2Eorg=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173049625781.3137.14071140647196208757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0053892ff7d4bab5efdb4def0fd211ec36e26f69
Gitweb:        https://git.kernel.org/tip/0053892ff7d4bab5efdb4def0fd211ec36e26f69
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 01 Nov 2024 09:33:05 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 01 Nov 2024 22:15:56 +01:00

irqchip/mips-gic: Fix selection of GENERIC_IRQ_EFFECTIVE_AFF_MASK

Without SMP enabled (such as in allnoconfig), there is a Kconfig warning
because CONFIG_IRQ_EFFECTIVE_AFF_MASK is unconditionally selected by
CONFIG_MIPS_GIC:

  WARNING: unmet direct dependencies detected for GENERIC_IRQ_EFFECTIVE_AFF_MASK
    Depends on [n]: SMP [=n]
    Selected by [y]:
    - MIPS_GIC [=y]

Add a dependency on SMP to the selection, which matches all other
selections of CONFIG_IRQ_EFFECTIVE_AFF_MASK.

Fixes: 322a90638768 ("irqchip/mips-gic: Multi-cluster support")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241101-mips-fix-generic_irq_effective_aff_mask-select-v1-1-d94db6e0de0d@kernel.org

---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f20adf7..ef0fa69 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -352,7 +352,7 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
-	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	select GENERIC_IRQ_IPI if SMP
 	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM

