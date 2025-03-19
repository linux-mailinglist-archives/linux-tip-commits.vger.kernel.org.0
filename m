Return-Path: <linux-tip-commits+bounces-4357-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE466A68ACE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 686C019C60FB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E225A332;
	Wed, 19 Mar 2025 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eU8Q4T/H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bpGwQ7n3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1E25A2DB;
	Wed, 19 Mar 2025 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382230; cv=none; b=su9JwLALdqg/OiYZ3ynzAyrhmAzB0SjHNUfH93ZitcgBOJg/BdNAAkm/Tqdq0Yj+dGCimrLZjsMCG1OgY0FR4lS/dEKzJifMwHwYCDKDd3o0h8X7Jyhrl8FkolL7cEGyaumQGUP7M+q/UNVmCgpGZm/ZAMTS/IqxgzciN7Sc1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382230; c=relaxed/simple;
	bh=pTor0/g4jS8sMY/M1jOBrGquupsbiAYwOIMOf0wkvOA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O89LzSGMEFeJhoiGecQSYgpnY9+emAP+aaGCCZVhLZ2pcfDIB/MKa4rhZhN9Uc9oX2JTE0a3rRfKeGvt8JCRdpVsRjwBdpFnnGSNpw0BpUp9j96nnKeozRZANVRGQcoxY5BT8Wqg3e1YDoim0I5NXaE0CaEIrqpZ7aYgS/DOOng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eU8Q4T/H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bpGwQ7n3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sszwDkQMndhlt63BkzvwYgW9eLjTApT7uKVGuQkOPIs=;
	b=eU8Q4T/HaQ28C5RZKlfIwGB3MJ20JG8hzfGK2UNuxzZNM+LtNtrT9i+5OROc+spSdKmlUM
	V3rxjdxZFzGBbf/APC+PU+wnkjdlJCUdrvjOSXX2oQ0XFkBfD0Sx4+aaFPS9k4i8sMHZB1
	uYWZzHKi8RbQS9ETVwwx+JWc/0sPlhot/KGSXCSaPshoej2zwvh9nM+6fbE7YBxVuyb50m
	kCy6AugowfFubySukcp8g2WkpWmG6uEBfWVJQuzm5ZBbRWYprIGlTZG5VyT0sYDeJtwq1d
	IXuBQZkCuQzLlC0m6cz1rsWT1WaO7uLVFfTs8M8siLEIYod8lYryXJ1nY4qqOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sszwDkQMndhlt63BkzvwYgW9eLjTApT7uKVGuQkOPIs=;
	b=bpGwQ7n3vcLRLmAXCI+Jo8Civ6CAn1JFDCX3bSlAwlMoJuh2LWRQ3gVJt5oA+kusW7EVR0
	cuH73UmXvzzf92Bw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpuid: Clean up <asm/cpuid/types.h>
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Cooper <andrew.cooper3@citrix.com>,
 "H. Peter Anvin" <hpa@zytor.com>, John Ogness <john.ogness@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317221824.3738853-3-mingo@kernel.org>
References: <20250317221824.3738853-3-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222644.14745.8295195482372933154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     04a1007004da767db5ad8ba01809a5052c3a7909
Gitweb:        https://git.kernel.org/tip/04a1007004da767db5ad8ba01809a5052c3a7909
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 23:18:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:23 +01:00

x86/cpuid: Clean up <asm/cpuid/types.h>

 - We have 0x0d, 0x9 and 0x1d as literals for the CPUID_LEAF definitions,
   pick a single, consistent style of 0xZZ literals.

 - Likewise, harmonize the style of the 'struct cpuid_regs' list of
   registers with that of 'enum cpuid_regs_idx'. Because while computers
   don't care about unnecessary visual noise, humans do.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250317221824.3738853-3-mingo@kernel.org
---
 arch/x86/include/asm/cpuid/types.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cpuid/types.h b/arch/x86/include/asm/cpuid/types.h
index 724002a..8582e27 100644
--- a/arch/x86/include/asm/cpuid/types.h
+++ b/arch/x86/include/asm/cpuid/types.h
@@ -5,11 +5,14 @@
 #include <linux/types.h>
 
 /*
- * Types for raw CPUID access
+ * Types for raw CPUID access:
  */
 
 struct cpuid_regs {
-	u32 eax, ebx, ecx, edx;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
 };
 
 enum cpuid_regs_idx {
@@ -19,8 +22,8 @@ enum cpuid_regs_idx {
 	CPUID_EDX,
 };
 
-#define CPUID_LEAF_MWAIT	0x5
-#define CPUID_LEAF_DCA		0x9
+#define CPUID_LEAF_MWAIT	0x05
+#define CPUID_LEAF_DCA		0x09
 #define CPUID_LEAF_XSTATE	0x0d
 #define CPUID_LEAF_TSC		0x15
 #define CPUID_LEAF_FREQ		0x16

