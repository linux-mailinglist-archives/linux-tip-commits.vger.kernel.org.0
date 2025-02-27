Return-Path: <linux-tip-commits+bounces-3715-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB70A47EB0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 14:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF76B16210C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CDD22F14C;
	Thu, 27 Feb 2025 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4JonLjEb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GR3c4Jmn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF89155322;
	Thu, 27 Feb 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740662119; cv=none; b=FQn5DOLw5NL/5WYUUOzSn2rvsjzlziPo+7Iqo3f5gzCfAGmGExzdz2jlURmJvA8EG+8EyaZcBNDiRrLAoNqU/Ek423RrOTs4Zs2WH2QCtbAMDhFRNHbnWFeFgS70ElKu+xxx7/gdziEMbzlx6BVyooIuE0RS1huCGaLuGZ8bG9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740662119; c=relaxed/simple;
	bh=HGf2KSoTvCCjGbvEOrZJxyB3ZX+wWAx2NqV7ZVt/We4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rxbwJH/g96ABHH8zHRjCm/+TUEJdoEeBV8zQ92hTxp7DbFw9zqzromhiJLwtQq+mavpIWK5vDIJePcnPa8yZBTNvfZKh22Bl5am1H4jtO7dFgeA2QjGEyYeqi7o/+TxgRPxMAibAAZIw+Gy3T+jYRm9Bviqpqb/2U7Ig5uQcoPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4JonLjEb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GR3c4Jmn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 13:15:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740662115;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIuW2sX+PWLfzEa4Ms8YVeI2RfOlwLqUfZtFxIRwx74=;
	b=4JonLjEbTUwwmIQh/hu+2B2iXHK+u16gEjUpPyjshqbyCNMcfP4hodx/WvGbCNJ02Htarz
	PwEP/OgYttEukqHaM1TZO/jm/8pEFqVSwgCrXYwQVI8oq7uutpq2+ani68w2R+aqKJATZg
	PmAhDT71JDD5wuuBoBo1hUIki5JwUf/S1FM4gNT2qg8QaAUAZ1/46AcV9xMabqpepdQpK0
	ozO86CKYJOUt2yy5dHiyNEXle1K+AV3QcXTAPaPKxl/1Zz90fAAp3RnNx7ieOI9l6UYnGT
	44v4OX5u3ubSFwfv5C/F5pLUra/3f3dn6QfpDJfT+Cz4kmH8AUvf8sJh9ukKnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740662115;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIuW2sX+PWLfzEa4Ms8YVeI2RfOlwLqUfZtFxIRwx74=;
	b=GR3c4JmnneR/kDdVTd0RfX4JmpOvKvMDuVctwnHGn26rAjNstPZjkoKNCYNCVIoJFMeTzL
	u25bU2gpSF3uJzDg==
From: "tip-bot2 for Kuan-Wei Chiu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/bootflag: Replace open-coded parity calculation
 with parity8()
Cc: "Yu-Chun Lin" <eleanor15x@gmail.com>,
 "Kuan-Wei Chiu" <visitorckw@gmail.com>, Uros Bizjak <ubizjak@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250227125616.2253774-1-ubizjak@gmail.com>
References: <20250227125616.2253774-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174066211374.10177.8948394435153413345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     9c94c14ca39577b6324c667d8450ffa19fc1e5c4
Gitweb:        https://git.kernel.org/tip/9c94c14ca39577b6324c667d8450ffa19fc1e5c4
Author:        Kuan-Wei Chiu <visitorckw@gmail.com>
AuthorDate:    Thu, 27 Feb 2025 13:55:45 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 14:00:30 +01:00

x86/bootflag: Replace open-coded parity calculation with parity8()

Refactor parity calculations to use the standard parity8() helper. This
change eliminates redundant implementations and improves code
efficiency.

[ ubizjak: Updated the patch to apply to the latest x86 tree. ]

Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250227125616.2253774-1-ubizjak@gmail.com
---
 arch/x86/kernel/bootflag.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/bootflag.c b/arch/x86/kernel/bootflag.c
index b935c3e..73274d7 100644
--- a/arch/x86/kernel/bootflag.c
+++ b/arch/x86/kernel/bootflag.c
@@ -8,6 +8,7 @@
 #include <linux/string.h>
 #include <linux/spinlock.h>
 #include <linux/acpi.h>
+#include <linux/bitops.h>
 #include <asm/io.h>
 
 #include <linux/mc146818rtc.h>
@@ -20,25 +21,12 @@
 
 int sbf_port __initdata = -1;	/* set via acpi_boot_init() */
 
-static bool __init parity(u8 v)
-{
-	int x = 0;
-	int i;
-
-	for (i = 0; i < 8; i++) {
-		x ^= (v & 1);
-		v >>= 1;
-	}
-
-	return !!x;
-}
-
 static void __init sbf_write(u8 v)
 {
 	unsigned long flags;
 
 	if (sbf_port != -1) {
-		if (!parity(v))
+		if (!parity8(v))
 			v ^= SBF_PARITY;
 
 		printk(KERN_INFO "Simple Boot Flag at 0x%x set to 0x%x\n",
@@ -69,7 +57,7 @@ static bool __init sbf_value_valid(u8 v)
 {
 	if (v & SBF_RESERVED)		/* Reserved bits */
 		return false;
-	if (!parity(v))
+	if (!parity8(v))
 		return false;
 
 	return true;

