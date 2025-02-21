Return-Path: <linux-tip-commits+bounces-3583-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A575FA3FA56
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 17:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B9B19E2CE0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC182153CF;
	Fri, 21 Feb 2025 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qzuVzjl7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T/Cr+VOp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400F6215172;
	Fri, 21 Feb 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153588; cv=none; b=Qis7etahk0Zi+5XDoAxamPQWxqPMUZwu4H+OkS9cP9bkT/zgvZl47VmTjSW8mApPcTiC/DVn/hUHDqtVekcuesL6bA17/963i1QT2JVnoR8+Ud9aTv6J32I6M+OGRjxO4Q8uNgpoaZsxYgDAOTv4w7Mj5vgTM6Axs2/CowuRsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153588; c=relaxed/simple;
	bh=cv2aE2ogqK6WiB8BoizF8HzO8Gnll38EidxSY7+yxso=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bpRfiRCIZDTuYuESRieGGkGdvMqtOI9BCuLWCHp7axLGzBUapbORiU0Sl3X9kOtYhuzEZ9vm2FUclljicFDRv8fumI3q/XUeAf8AOVBgr2N/7GEE1cqY2bXdH2sNuIs1avOzkPisu/w3mgjjd1gW6mOQILYZkb2tYeWhOAbCXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qzuVzjl7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T/Cr+VOp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 15:59:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740153585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGhvyAoD0GTAtdofD5O+7aLeYSHOcoxWpEIXqH8kzXs=;
	b=qzuVzjl7zeNdHXcRNmu594bZ1mMnhq97V5eoGJdwrAJ0uSAbBuiTSvxwHGq2GS8PN5hhKj
	LC1tSH5f46+5InClSB5O+0HxS/5/Dgv0wOMED9egZ/Ro35EicCFF78lHJl8794sEFn58lF
	jU+znSX5q2bAttmCwkydD3sqnjsBrOFaaD+xKWzfx0ZX17XpecG+TQ8dCurOzC/6H0yZO/
	bf3EsS0SbuVcimurNfbDMniuTaQ2qOIYQSFpgah59oCbTFGUOzvbuXco5fthdIrwZDDsh3
	8BF+IWKmr2YR7E7udzF/2aFdXbkJBiYzbB0eJJwD9yW2RvzbJq9NK5JfAZpR+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740153585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MGhvyAoD0GTAtdofD5O+7aLeYSHOcoxWpEIXqH8kzXs=;
	b=T/Cr+VOppnuWLliKvMfDl2FzBzMwS86qzCGDu3qH+ynS9K6kFDviMGz2GpA5WeCprDAO4f
	TRsUm5Jbk7meAzCw==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/apic: Use str_disabled_enabled() helper in
 print_ipi_mode()
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250209210333.5666-2-thorsten.blum@linux.dev>
References: <20250209210333.5666-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174015358396.10177.13576394441598085729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     0156338a18eba7ee229e59c8928c7056e9753c61
Gitweb:        https://git.kernel.org/tip/0156338a18eba7ee229e59c8928c7056e9753c61
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Sun, 09 Feb 2025 22:03:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 16:54:22 +01:00

x86/apic: Use str_disabled_enabled() helper in print_ipi_mode()

Remove hard-coded strings by using the str_disabled_enabled() helper.

No change in functionality intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250209210333.5666-2-thorsten.blum@linux.dev
---
 arch/x86/kernel/apic/ipi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/ipi.c b/arch/x86/kernel/apic/ipi.c
index 5da693d..942168d 100644
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -3,6 +3,7 @@
 #include <linux/cpumask.h>
 #include <linux/delay.h>
 #include <linux/smp.h>
+#include <linux/string_choices.h>
 
 #include <asm/io_apic.h>
 
@@ -23,7 +24,7 @@ __setup("no_ipi_broadcast=", apic_ipi_shorthand);
 static int __init print_ipi_mode(void)
 {
 	pr_info("IPI shorthand broadcast: %s\n",
-		apic_ipi_shorthand_off ? "disabled" : "enabled");
+		str_disabled_enabled(apic_ipi_shorthand_off));
 	return 0;
 }
 late_initcall(print_ipi_mode);

