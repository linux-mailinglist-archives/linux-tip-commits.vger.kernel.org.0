Return-Path: <linux-tip-commits+bounces-4482-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C086EA6EC38
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3408C16DB14
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151FD2566FC;
	Tue, 25 Mar 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LgMRehVL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dV7Me07y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0952528FC;
	Tue, 25 Mar 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893548; cv=none; b=sPrefNRxR8KL9rkF8OJBupjsBUL73AZ2tFl09fK3JyQ6SWG3sOVQ/U3JP7R8COPOvrAZukfvkNlkN78LtsOsTKVW9OwE9ZtqtFybnlyuevPIi0wZKuaFTBNlI3meH+Zug+46x3jgVj5aKH657z2NYlJbqUvSXwVLkSxEwB02/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893548; c=relaxed/simple;
	bh=WukMsmsZn1ycMI+kiX7tKyL3oNBC1ssLSKqTg0WpTX4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WF9K9hRydrY3IoWrTm9XVO+6vdC1yYkIUEFqKEMPp9TlnKwb11yMTNqmXSS5aehj68yJwaXDauRP7nlq1kfRJkQyLQ+FLeQx8Uusrw4QQjl/BAy/JaLIaPDvVOOLvxbCX97/yQVvfPa3f6zBqmIlDqRx9dO13I2R11y8cBqWmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LgMRehVL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dV7Me07y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+r/CTOZZ6RgClZkbS75+zSmcG2uC6CtVm787f/rIDo=;
	b=LgMRehVLlGojFi1JMTHO9MFc4YNG6bDVSccCYF/dhDZdP0trmgL1AL0GF/wxrohxsjDeA+
	aRBIEssly9hUBR3Dg5Dg4erdOzcVlMmwpCRGjYqvGQpFfnC9/BkJbvSCZNkKHxZ1geNIdr
	I9Mx2CjqgBlWajPzgWU2pYMHAQYoA3VVRY2d4wUGNS6qYr0uqoUuSO2CMimFsRiIiECWd2
	1/1fdPRxerlkDvKLYXlOKxzTt5J98Eu9mbJfzZh6eNTTq5oek3Zb1HLLSIRCOLpa60n+u5
	avvBszkxmrFCoAkX5a67CWsQ2SRY97qRzmyPpsrUd43evZlrLRuWQ/ksr0+oQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I+r/CTOZZ6RgClZkbS75+zSmcG2uC6CtVm787f/rIDo=;
	b=dV7Me07ylKu+rhOMMd7k1fbtI63TgRUSPt1wgE9hhUNiYV2oCVztY/INJHdPDaVLDHHD4a
	fHUvBYpEG9KEYhBA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Use C99-style for loops
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-10-darwi@linutronix.de>
References: <20250324142042.29010-10-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354238.14745.1979312224227532751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0a8f12ccd2e6edac89292af63c3a2050b4aac61b
Gitweb:        https://git.kernel.org/tip/0a8f12ccd2e6edac89292af63c3a2050b4aac61b
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:30 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:45 +01:00

tools/x86/kcpuid: Use C99-style for loops

Since commit e8c07082a810 ("Kbuild: move to -std=gnu11") and the kernel
allows C99-style variable declarations inside of a for() loop.

Adjust the kcpuid code accordingly.

Note, this helps readability as some of the kcpuid functions have a huge
list of variable declarations on top.

Note, remove the empty lines before cpuid() invocations as it is clearer
to have their parameter initialization and the actual call in one block.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-10-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 52 +++++++++++++--------------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 4fa768b..413e5da 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -172,13 +172,10 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 
 static void raw_dump_range(struct cpuid_range *range)
 {
-	u32 f;
-	int i;
-
 	printf("%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
 	printf("================\n");
 
-	for (f = 0; (int)f < range->nr; f++) {
+	for (u32 f = 0; (int)f < range->nr; f++) {
 		struct cpuid_func *func = &range->funcs[f];
 
 		/* Skip leaf without valid items */
@@ -186,7 +183,7 @@ static void raw_dump_range(struct cpuid_range *range)
 			continue;
 
 		/* First item is the main leaf, followed by all subleafs */
-		for (i = 0; i < func->nr; i++)
+		for (int i = 0; i < func->nr; i++)
 			leaf_print_raw(&func->leafs[i]);
 	}
 }
@@ -194,15 +191,14 @@ static void raw_dump_range(struct cpuid_range *range)
 #define MAX_SUBLEAF_NUM		64
 struct cpuid_range *setup_cpuid_range(u32 input_eax)
 {
-	u32 max_func, idx_func, subleaf, max_subleaf;
-	u32 eax, ebx, ecx, edx, f = input_eax;
 	struct cpuid_range *range;
-	bool allzero;
+	u32 max_func, idx_func;
+	u32 eax, ebx, ecx, edx;
 
 	eax = input_eax;
 	ebx = ecx = edx = 0;
-
 	cpuid(&eax, &ebx, &ecx, &edx);
+
 	max_func = eax;
 	idx_func = (max_func & 0xffff) + 1;
 
@@ -222,20 +218,21 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
 
-	for (; f <= max_func; f++) {
-		eax = f;
-		subleaf = ecx = 0;
+	for (u32 f = input_eax; f <= max_func; f++) {
+		u32 max_subleaf = MAX_SUBLEAF_NUM;
+		bool allzero;
 
+		eax = f;
+		ecx = 0;
 		cpuid(&eax, &ebx, &ecx, &edx);
-		allzero = cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
+
+		allzero = cpuid_store(range, f, 0, eax, ebx, ecx, edx);
 		if (allzero)
 			continue;
 
 		if (!has_subleafs(f))
 			continue;
 
-		max_subleaf = MAX_SUBLEAF_NUM;
-
 		/*
 		 * Some can provide the exact number of subleafs,
 		 * others have to be tried (0xf)
@@ -253,13 +250,12 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		if (f == 0x80000026)
 			max_subleaf = 5;
 
-		for (subleaf = 1; subleaf < max_subleaf; subleaf++) {
+		for (u32 subleaf = 1; subleaf < max_subleaf; subleaf++) {
 			eax = f;
 			ecx = subleaf;
-
 			cpuid(&eax, &ebx, &ecx, &edx);
-			allzero = cpuid_store(range, f, subleaf,
-						eax, ebx, ecx, edx);
+
+			allzero = cpuid_store(range, f, subleaf, eax, ebx, ecx, edx);
 			if (allzero)
 				continue;
 		}
@@ -280,12 +276,10 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 static void parse_line(char *line)
 {
 	char *str;
-	int i;
 	struct cpuid_range *range;
 	struct cpuid_func *func;
 	struct subleaf *leaf;
 	u32 index;
-	u32 sub;
 	char buffer[512];
 	char *buf;
 	/*
@@ -312,7 +306,7 @@ static void parse_line(char *line)
 	strncpy(buffer, line, 511);
 	buffer[511] = 0;
 	str = buffer;
-	for (i = 0; i < 5; i++) {
+	for (int i = 0; i < 5; i++) {
 		tokens[i] = strtok(str, ",");
 		if (!tokens[i])
 			goto err_exit;
@@ -378,7 +372,7 @@ static void parse_line(char *line)
 	bit_end = strtoul(end, NULL, 0);
 	bit_start = (start) ? strtoul(start, NULL, 0) : bit_end;
 
-	for (sub = subleaf_start; sub <= subleaf_end; sub++) {
+	for (u32 sub = subleaf_start; sub <= subleaf_end; sub++) {
 		leaf = &func->leafs[sub];
 		reg = &leaf->info[reg_index];
 		bdesc = &reg->descs[reg->nr++];
@@ -432,10 +426,10 @@ static void parse_text(void)
 static void show_reg(const struct reg_desc *rdesc, u32 value)
 {
 	const struct bits_desc *bdesc;
-	int start, end, i;
+	int start, end;
 	u32 mask;
 
-	for (i = 0; i < rdesc->nr; i++) {
+	for (int i = 0; i < rdesc->nr; i++) {
 		bdesc = &rdesc->descs[i];
 
 		start = bdesc->start;
@@ -487,17 +481,13 @@ static void show_leaf(struct subleaf *leaf)
 
 static void show_func(struct cpuid_func *func)
 {
-	int i;
-
-	for (i = 0; i < func->nr; i++)
+	for (int i = 0; i < func->nr; i++)
 		show_leaf(&func->leafs[i]);
 }
 
 static void show_range(struct cpuid_range *range)
 {
-	int i;
-
-	for (i = 0; i < range->nr; i++)
+	for (int i = 0; i < range->nr; i++)
 		show_func(&range->funcs[i]);
 }
 

