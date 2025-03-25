Return-Path: <linux-tip-commits+bounces-4479-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A1AA6EC2C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7237B3B1DD3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214E92561AC;
	Tue, 25 Mar 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="33JlcD09";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDcdSlW8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B2254AFB;
	Tue, 25 Mar 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893545; cv=none; b=hAXrTLBdkbgxRiOj+eQzjizjXJdkUjyIDjZLIrwlEgMhzjjqDhQH9+ebe4TygrC3ad1hRrkC1A8LB9fgYy6PuFeHdmPZlkI7JibmmDPO6iooggBKQ48V+pfxthsJAZuvH8+8yKB5wSr7DxZavLXs3z04KjQryV1JYP0gZGGmWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893545; c=relaxed/simple;
	bh=wr+ntTPThOz4qXEAB1DbBlsqLYVvTxVNMX77DzfYGpY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uigsJzzsIJwlorFSSkqSWubhQZI26fXAeAbcWy5WcXm/4WxKNnRIB907xEJRUJqZDOpSarbX4HE3NLFNMlPQ7crYIeMevfnjd+eQlGHX2V89JfmALrPcVoy6/c5tURzV+srVSVS5DaRb81jXuWpQnJVUY0WgyZRuLfp6ODb3KEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=33JlcD09; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDcdSlW8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXrV9YxIh3pdmWNWc3HQ81C8dYXgy7FHgd/7smHT6qw=;
	b=33JlcD09PM08hU/zeR2RPIAXyXHygE4f5UBcqwpooCBrx3YVar6VUoS7qZHbE53OfUsYVq
	i5OE8EGOtu5tb3aT52CW5067lATViD9Iaoo24IR2zWpIB00o71iJFDG/R4QEHVykuFNhBX
	IiwYHR0QvWeulQ+dzG67RlmkwWSz2qublUhBAVydTOvUJ5qDY94q5b5+0UhYSwDMSbxBxJ
	tQ5l9cn3/d1RDM9zWHHdDpzLmG/fqDSRxhzR8jwOA66AfFOJF4AOVCFTBt8pJ31aAR/xsk
	VoEd/n7x6UEkLRL8FD8CTxyZEJ/3/+N35HDDs2BNHphV+qSp2u8a/LjF5+G66A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VXrV9YxIh3pdmWNWc3HQ81C8dYXgy7FHgd/7smHT6qw=;
	b=LDcdSlW8O7NZzl+AR5m7Pt7PkDVEb2JLYH4K+sxY5FEVUlLlcvlHGBzJCfxOay11TpN1+x
	xnlmQudpI0RWotAA==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Refactor CPUID range handling for
 future expansion
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-12-darwi@linutronix.de>
References: <20250324142042.29010-12-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354132.14745.6079798770917823402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     3151ec059dd1e71761f3beccc1e5f5c18fac4afa
Gitweb:        https://git.kernel.org/tip/3151ec059dd1e71761f3beccc1e5f5c18fac4afa
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:32 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:46 +01:00

tools/x86/kcpuid: Refactor CPUID range handling for future expansion

The kcpuid code assumes only two CPUID index ranges, standard (0x0...)
and extended (0x80000000...).

Since additional CPUID index ranges will be added in further commits,
replace the "is_ext" boolean with enumeration-based range classification.

Collect all CPUID ranges in a structured array and introduce helper
macros to iterate over it.  Use such helpers throughout the code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-12-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 100 ++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 41 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 25388a5..7790136 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -66,19 +66,50 @@ struct cpuid_func {
 	int nr;
 };
 
+enum range_index {
+	RANGE_STD = 0,			/* Standard */
+	RANGE_EXT = 0x80000000,		/* Extended */
+};
+
+#define CPUID_INDEX_MASK		0x80000000
+#define CPUID_FUNCTION_MASK		(~CPUID_INDEX_MASK)
+
 struct cpuid_range {
 	/* array of main leafs */
 	struct cpuid_func *funcs;
 	/* number of valid leafs */
 	int nr;
-	bool is_ext;
+	enum range_index index;
 };
 
-/*
- * basic:  basic functions range: [0... ]
- * ext:    extended functions range: [0x80000000... ]
- */
-struct cpuid_range *leafs_basic, *leafs_ext;
+static struct cpuid_range ranges[] = {
+	{	.index		= RANGE_STD,	},
+	{	.index		= RANGE_EXT,	},
+};
+
+static char *range_to_str(struct cpuid_range *range)
+{
+	switch (range->index) {
+	case RANGE_STD:		return "Standard";
+	case RANGE_EXT:		return "Extended";
+	default:		return NULL;
+	}
+}
+
+#define for_each_cpuid_range(range)		\
+	for (unsigned int i = 0; i < ARRAY_SIZE(ranges) && ((range) = &ranges[i]); i++)
+
+struct cpuid_range *index_to_cpuid_range(u32 index)
+{
+	struct cpuid_range *range;
+
+	for_each_cpuid_range(range) {
+		if (range->index == (index & CPUID_INDEX_MASK))
+			return range;
+	}
+
+	return NULL;
+}
 
 static bool show_details;
 static bool show_raw;
@@ -173,7 +204,7 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 
 static void raw_dump_range(struct cpuid_range *range)
 {
-	printf("%s Leafs :\n", range->is_ext ? "Extended" : "Basic");
+	printf("%s Leafs :\n", range_to_str(range));
 	printf("================\n");
 
 	for (u32 f = 0; (int)f < range->nr; f++) {
@@ -190,22 +221,12 @@ static void raw_dump_range(struct cpuid_range *range)
 }
 
 #define MAX_SUBLEAF_NUM		64
-struct cpuid_range *setup_cpuid_range(u32 input_eax)
+void setup_cpuid_range(struct cpuid_range *range)
 {
-	struct cpuid_range *range;
 	u32 max_func, idx_func;
 	u32 eax, ebx, ecx, edx;
 
-	cpuid(input_eax, max_func, ebx, ecx, edx);
-
-	range = malloc(sizeof(struct cpuid_range));
-	if (!range)
-		err(EXIT_FAILURE, NULL);
-
-	if (input_eax & 0x80000000)
-		range->is_ext = true;
-	else
-		range->is_ext = false;
+	cpuid(range->index, max_func, ebx, ecx, edx);
 
 	idx_func = (max_func & 0xffff) + 1;
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
@@ -215,7 +236,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
 
-	for (u32 f = input_eax; f <= max_func; f++) {
+	for (u32 f = range->index; f <= max_func; f++) {
 		u32 max_subleaf = MAX_SUBLEAF_NUM;
 		bool allzero;
 
@@ -254,8 +275,6 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 		}
 
 	}
-
-	return range;
 }
 
 /*
@@ -312,13 +331,13 @@ static void parse_line(char *line)
 	/* index/main-leaf */
 	index = strtoull(tokens[0], NULL, 0);
 
-	if (index & 0x80000000)
-		range = leafs_ext;
-	else
-		range = leafs_basic;
+	/* Skip line parsing if it's not covered by known ranges */
+	range = index_to_cpuid_range(index);
+	if (!range)
+		return;
 
 	/* Skip line parsing for non-existing indexes */
-	index &= 0x7FFFFFFF;
+	index &= CPUID_FUNCTION_MASK;
 	if ((int)index >= range->nr)
 		return;
 
@@ -489,9 +508,11 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	struct cpuid_range *range;
 	u32 func_idx;
 
-	range = (index & 0x80000000) ? leafs_ext : leafs_basic;
-	func_idx = index & 0xffff;
+	range = index_to_cpuid_range(index);
+	if (!range)
+		return NULL;
 
+	func_idx = index & 0xffff;
 	if ((func_idx + 1) > (u32)range->nr)
 		return NULL;
 
@@ -500,12 +521,13 @@ static inline struct cpuid_func *index_to_func(u32 index)
 
 static void show_info(void)
 {
+	struct cpuid_range *range;
 	struct cpuid_func *func;
 
 	if (show_raw) {
 		/* Show all of the raw output of 'cpuid' instr */
-		raw_dump_range(leafs_basic);
-		raw_dump_range(leafs_ext);
+		for_each_cpuid_range(range)
+			raw_dump_range(range);
 		return;
 	}
 
@@ -533,15 +555,8 @@ static void show_info(void)
 	}
 
 	printf("CPU features:\n=============\n\n");
-	show_range(leafs_basic);
-	show_range(leafs_ext);
-}
-
-static void setup_platform_cpuid(void)
-{
-	/* Setup leafs for the basic and extended range */
-	leafs_basic = setup_cpuid_range(0x0);
-	leafs_ext = setup_cpuid_range(0x80000000);
+	for_each_cpuid_range(range)
+		show_range(range);
 }
 
 static void __noreturn usage(int exit_code)
@@ -617,10 +632,13 @@ static void parse_options(int argc, char *argv[])
  */
 int main(int argc, char *argv[])
 {
+	struct cpuid_range *range;
+
 	parse_options(argc, argv);
 
 	/* Setup the cpuid leafs of current platform */
-	setup_platform_cpuid();
+	for_each_cpuid_range(range)
+		setup_cpuid_range(range);
 
 	/* Read and parse the 'cpuid.csv' */
 	parse_text();

