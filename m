Return-Path: <linux-tip-commits+bounces-4790-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE50EA823DA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BFA1B87712
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902B2620E4;
	Wed,  9 Apr 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uTuemDd+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bv3WdAk7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00A25EFB2;
	Wed,  9 Apr 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199071; cv=none; b=i1ER+SvUWHOqi3V12c3xDWUuLUiDhJ20I8KclgW/1loPt7TBnxCy17NA+J5z+AGvkg/69rwCvAlPZkLj8zsQEy4NZ7N57ialxYugDafBI/94YevRvIMiTYZr7HsynUhR8GRv51dCeZvgAX2xA7rjuIJXhhIZiahG57KPAn2KBXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199071; c=relaxed/simple;
	bh=gG0h0DYYiY5/F0mFY1uOl7OgnLBbSfvSMZsVvvp3RK4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OoV85w8aM+o/EKhsLamJpmA1KVfkDW07cQmjKXXO+m2CHa9xSFCAbu7gBgiVIhvq3HZjKlfYthUFyiUUbIqaRLETDiB14PKuZjH5uQeK5Ar2sc/ni/1N+2BYaEKcvM7ROLEfPwOuIFz4ufEMUMGw70YCHd1AFPzXUmbqulkxS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uTuemDd+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bv3WdAk7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:44:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744199067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLb12RdfUXFfWpJ/dnTaYv5AVVEebS4hUjZr+3tHWl4=;
	b=uTuemDd+9j8s6Um/CWrc2vsPuq9VQOUn7qYiJkX6PTDslPlOW1+lLbgzkLrkcMxUEe/He/
	UpDIFTqqwDQbJSAEx/mgCGTOL+GZfVrjraACPwQMw1t2HAaa+HDnhq1TdR/J/eElqmmxIf
	nm9NCn+/mGXZstbzw74eMKMFhPJBMAVcQrEIxNqKe880grhcSZYX5FP2x9V4DZfkkjY9rl
	uxQfbvmmO8UVnqjkZ7ogp10ShpY1m+WlkQe7oYoENpX18nN+Uww43vN9M6PVAno5MIYqkB
	7IO975hp8E+TmwppgPo/reVA25lh56ZeSz2obasw3AeaaJnkan7bSuRdRbuDoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744199067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLb12RdfUXFfWpJ/dnTaYv5AVVEebS4hUjZr+3tHWl4=;
	b=bv3WdAk7TSXtf2Z34pyTfPdnn6GU3sjHsQxCyViUJN2XhAN5F4Ghbf1q2E1h3XL/5ESkPv
	CsDogaYlH5w1UfBQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/early_printk: Use 'mmio32' for consistency, fix
 comments
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, Denis Mukhin <dmukhin@ford.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250407172214.792745-1-andriy.shevchenko@linux.intel.com>
References: <20250407172214.792745-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419906679.31282.16262283502465088009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     996457176bb7c64b3d30996592c754205ec4d3ea
Gitweb:        https://git.kernel.org/tip/996457176bb7c64b3d30996592c754205ec4d3ea
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 07 Apr 2025 20:22:14 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 12:27:08 +02:00

x86/early_printk: Use 'mmio32' for consistency, fix comments

First of all, using 'mmio' prevents proper implementation of 8-bit accessors.
Second, it's simply inconsistent with uart8250 set of options. Rename it to
'mmio32'. While at it, remove rather misleading comment in the documentation.
>From now on mmio32 is self-explanatory and pciserial supports not only 32-bit
MMIO accessors.

Also, while at it, fix the comment for the "pciserial" case. The comment
seems to be a copy'n'paste error when mentioning "serial" instead of
"pciserial" (with double quotes). Fix this.

With that, move it upper, so we don't calculate 'buf' twice.

Fixes: 3181424aeac2 ("x86/early_printk: Add support for MMIO-based UARTs")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Denis Mukhin <dmukhin@ford.com>
Link: https://lore.kernel.org/r/20250407172214.792745-1-andriy.shevchenko@linux.intel.com
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +----
 arch/x86/kernel/early_printk.c                  | 10 +++++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 76e538c..d9fd26b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1407,18 +1407,15 @@
 			earlyprintk=serial[,0x...[,baudrate]]
 			earlyprintk=ttySn[,baudrate]
 			earlyprintk=dbgp[debugController#]
+			earlyprintk=mmio32,membase[,{nocfg|baudrate}]
 			earlyprintk=pciserial[,force],bus:device.function[,{nocfg|baudrate}]
 			earlyprintk=xdbc[xhciController#]
 			earlyprintk=bios
-			earlyprintk=mmio,membase[,{nocfg|baudrate}]
 
 			earlyprintk is useful when the kernel crashes before
 			the normal console is initialized. It is not enabled by
 			default because it has some cosmetic problems.
 
-			Only 32-bit memory addresses are supported for "mmio"
-			and "pciserial" devices.
-
 			Use "nocfg" to skip UART configuration, assume
 			BIOS/firmware has configured UART correctly.
 
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 611f27e..3aad78b 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -389,10 +389,10 @@ static int __init setup_early_printk(char *buf)
 	keep = (strstr(buf, "keep") != NULL);
 
 	while (*buf != '\0') {
-		if (!strncmp(buf, "mmio", 4)) {
-			early_mmio_serial_init(buf + 4);
+		if (!strncmp(buf, "mmio32", 6)) {
+			buf += 6;
+			early_mmio_serial_init(buf);
 			early_console_register(&early_serial_console, keep);
-			buf += 4;
 		}
 		if (!strncmp(buf, "serial", 6)) {
 			buf += 6;
@@ -407,9 +407,9 @@ static int __init setup_early_printk(char *buf)
 		}
 #ifdef CONFIG_PCI
 		if (!strncmp(buf, "pciserial", 9)) {
-			early_pci_serial_init(buf + 9);
+			buf += 9; /* Keep from match the above "pciserial" */
+			early_pci_serial_init(buf);
 			early_console_register(&early_serial_console, keep);
-			buf += 9; /* Keep from match the above "serial" */
 		}
 #endif
 		if (!strncmp(buf, "vga", 3) &&

