Return-Path: <linux-tip-commits+bounces-1988-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4819794AF78
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 20:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E791D1F22727
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Aug 2024 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4DD770E5;
	Wed,  7 Aug 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hEbtDLOP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MplMbMIc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651341097B;
	Wed,  7 Aug 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054617; cv=none; b=V3YxHYSVD+eLPrJghazGan/AWAH97hd0+5BaOvxuS5XRyD7YFd2eC53LagCvFWM3QO1Rweo1LQ0r6UZ6WAQ21tskIjxM1633nMyPJtc8iGE0KedR+EMfmvBqGYJavJt+pR40qolyYSFCWEkVuh9RI3BJjJSuL49TTWKBkYLYVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054617; c=relaxed/simple;
	bh=yROIA677TF/ptHCBZbQ8b2PKtK+5AvIjyvqIXIWKyVo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kmv20dRv+1kn07yABlHjC1TqVofUKJiwbD+CBiE1pIY4DKdBQjVyHG2ON34SSI8NJWc66m2hW+nOBbQtw9fq2YdbydOszPYZqm0+pUJRJX6362G9I8phEtV0MoJthu0thy/omrzbMyhlbvPrJo9EX4plpXd5vHBWfixanejKND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hEbtDLOP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MplMbMIc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 Aug 2024 18:16:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723054614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsx5wVhT3+i+fjxR8PZdNQ8s4YXnX0S5IV0PNFpN8gg=;
	b=hEbtDLOP9FvS7ipUoZ/kwf20PTfx+siuvNv/95KYVQmsmIy3yYJVyLn+3E64UtfkcplHPZ
	381e3PKsOiQI9tCkJE68mOyoXqmW088S977S6JaYBgtgLOUkxJkJ9uZdHeXYAJ5S6cw5oY
	UIB72uzBIG8HYKppEQjNQyJMd/qan/hMRlYBxMgF90xT2nA/CCQmBLWEeSUq0CCeXsyict
	AVcBbkLziR0+ys3teEnKQ3ep2Qj66//jgbVV6Fs8PRg0GTEKD4I6WqgVwF+B5I/arFrzNs
	22j50wcHmrY52pgYjdOL46gf6wHY1rKtq5KP1l54R0DQKpMErK3Dr9HO4nt4ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723054614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsx5wVhT3+i+fjxR8PZdNQ8s4YXnX0S5IV0PNFpN8gg=;
	b=MplMbMIc+hC08PxgO0iP5918GSKqGGx2R3yKn/pX/wGxFh1cjjhuDn1/uagvAcsR8UnEk4
	WaUsnpM0B8qiIsDA==
From: "tip-bot2 for Zhiquan Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/acpi: Remove __ro_after_init from acpi_mp_wake_mailbox
Cc: Zhiquan Li <zhiquan1.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240805103531.1230635-1-zhiquan1.li@intel.com>
References: <20240805103531.1230635-1-zhiquan1.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172305461432.2215.4437111892574627588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ab84ba647f2c94ac4d0c3fc6951c49f08aa1fcf7
Gitweb:        https://git.kernel.org/tip/ab84ba647f2c94ac4d0c3fc6951c49f08aa1fcf7
Author:        Zhiquan Li <zhiquan1.li@intel.com>
AuthorDate:    Mon, 05 Aug 2024 18:35:31 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 Aug 2024 20:04:38 +02:00

x86/acpi: Remove __ro_after_init from acpi_mp_wake_mailbox

On a platform using the "Multiprocessor Wakeup Structure"[1] to startup
secondary CPUs the control processor needs to memremap() the physical
address of the MP Wakeup Structure mailbox to the variable
acpi_mp_wake_mailbox, which holds the virtual address of mailbox.

To wake up the AP the control processor writes the APIC ID of AP, the
wakeup vector and the ACPI_MP_WAKE_COMMAND_WAKEUP command into the mailbox.

Current implementation doesn't consider the case which restricts boot time
CPU bringup to 1 with the kernel parameter "maxcpus=1" and brings other
CPUs online later from user space as it sets acpi_mp_wake_mailbox to
read-only after init.  So when the first AP is tried to brought online
after init, the attempt to update the variable results in a kernel panic.

The memremap() call that initializes the variable cannot be moved into
acpi_parse_mp_wake() because memremap() is not functional at that point in
the boot process. Also as the APs might never be brought up, keep the
memremap() call in acpi_wakeup_cpu() so that the operation only takes place
when needed.

Fixes: 24dd05da8c79 ("x86/apic: Mark acpi_mp_wake_* variables as __ro_after_init")
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20240805103531.1230635-1-zhiquan1.li@intel.com
---
 arch/x86/kernel/acpi/madt_wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6cfe762..d5ef621 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -19,7 +19,7 @@
 static u64 acpi_mp_wake_mailbox_paddr __ro_after_init;
 
 /* Virtual address of the Multiprocessor Wakeup Structure mailbox */
-static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox __ro_after_init;
+static struct acpi_madt_multiproc_wakeup_mailbox *acpi_mp_wake_mailbox;
 
 static u64 acpi_mp_pgd __ro_after_init;
 static u64 acpi_mp_reset_vector_paddr __ro_after_init;

