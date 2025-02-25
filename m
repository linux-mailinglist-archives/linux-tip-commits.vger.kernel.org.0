Return-Path: <linux-tip-commits+bounces-3622-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C616A44EF7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 22:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8D73AECD6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D28213253;
	Tue, 25 Feb 2025 21:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TcbVNv61";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYR41XiJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DD7199396;
	Tue, 25 Feb 2025 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519165; cv=none; b=e2e+6Xbm8ydNvuAHuhRgTDvksUtCRi86EpAz6hT9VCOA1DO+Jj+cfLQ6xcFXWJ3F8hTDBkDXvB7No4pfsuWkUtsBm0tsu3pujQF7J8rE365xvxG4KoT8uJr3as2ksQezFGGBBQjtlIRoVuWAKmIDytJzM4HMg5gtbjZuX0j9csA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519165; c=relaxed/simple;
	bh=mExjt3Fje/qkDjrm9tH34TyfILRNA+LVuuVgrKvGgII=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dkJxuEH686qXaK659KA6mhUDGjFhC8WTNU6VvxpOnwjB354txm8ZsrXbkzYcsKlFNt/aZ2V8WoVRbKzhVbRaJfUgDcg/erdMdug66b0uOoSKQ1JRIyZDBbNMXAIJAWhOPdQuwwfzakTMSMo0WwrmGOFqyItGXiGpvXGDWIh4aFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TcbVNv61; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYR41XiJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 21:32:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740519160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YkQ/Y64ZwW2LRyLslBPWa8jJCmlfjKBW9PDDJuWqc8=;
	b=TcbVNv61+peZpIXLGb2BEVMvZnzrrj3Lyz/eglNQjBFwBi8PyfecIjPpRNIAvnxrBJsWwe
	HIvypKMGX1H5wbHHGwMHGXJLHhLztvph4IFV6HTZd8i5nwbbUWIorOgZVI9733PgRn2ZpT
	Z4D6YZc4HQkYgm29wA38OKsqT1xkwF0S+yVE+AzR4fvmvXmqRzdQhRxVv/B2fLfZEYzVzo
	R4uNSZTqBsY239mxxPbLC1rVMnr8YYvhxdfZxu/VhtRGvbBofTrB7xkUfKhYlaPHVCARwf
	mmLJJZGFn9lOA+H0UD2eej0EqEp9kMASlA/eaZ0jx3dc7CgGoT42HkoERLP8WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740519160;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YkQ/Y64ZwW2LRyLslBPWa8jJCmlfjKBW9PDDJuWqc8=;
	b=NYR41XiJCFYH5JSSBZZBKlFFxN1Y5ZOksURT4pj0ugYEabrP4yvxniJGg337UBs591dVD5
	jOyierIWaIrPwBBw==
From: "tip-bot2 for Dmytro Maluka" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/of: Don't use DTB for SMP setup if ACPI is enabled
Cc: Dmytro Maluka <dmaluka@chromium.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250105172741.3476758-2-dmaluka@chromium.org>
References: <20250105172741.3476758-2-dmaluka@chromium.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174051915678.10177.9988410980164906115.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     96f41f644c4885761b0d117fc36dc5dcf92e15ec
Gitweb:        https://git.kernel.org/tip/96f41f644c4885761b0d117fc36dc5dcf92e15ec
Author:        Dmytro Maluka <dmaluka@chromium.org>
AuthorDate:    Sun, 05 Jan 2025 17:27:40 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 22:13:02 +01:00

x86/of: Don't use DTB for SMP setup if ACPI is enabled

There are cases when it is useful to use both ACPI and DTB provided by
the bootloader, however in such cases we should make sure to prevent
conflicts between the two. Namely, don't try to use DTB for SMP setup
if ACPI is enabled.

Precisely, this prevents at least:

- incorrectly calling register_lapic_address(APIC_DEFAULT_PHYS_BASE)
  after the LAPIC was already successfully enumerated via ACPI, causing
  noisy kernel warnings and probably potential real issues as well

- failed IOAPIC setup in the case when IOAPIC is enumerated via mptable
  instead of ACPI (e.g. with acpi=noirq), due to
  mpparse_parse_smp_config() overridden by x86_dtb_parse_smp_config()

Signed-off-by: Dmytro Maluka <dmaluka@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250105172741.3476758-2-dmaluka@chromium.org
---
 arch/x86/kernel/devicetree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 59d23cd..dd8748c 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -2,6 +2,7 @@
 /*
  * Architecture specific OF callbacks.
  */
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -313,6 +314,6 @@ void __init x86_flattree_get_config(void)
 	if (initial_dtb)
 		early_memunmap(dt, map_len);
 #endif
-	if (of_have_populated_dt())
+	if (acpi_disabled && of_have_populated_dt())
 		x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
 }

