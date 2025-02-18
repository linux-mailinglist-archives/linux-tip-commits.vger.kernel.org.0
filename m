Return-Path: <linux-tip-commits+bounces-3502-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B17A39BD5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 13:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A6D3A326A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8113E2417C9;
	Tue, 18 Feb 2025 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vt2cpswV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p3nhgO4G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA5F22FF40;
	Tue, 18 Feb 2025 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880705; cv=none; b=FRUOGlSf07wYIepMjWH0mpQonsTwQz8eswQGK6zo06A6gdreZTlQqfMPw4r0X7TIBwxzUc6794kQ0oYqPJJwyVC2xA1VKTkjSQYF6Q3t6zefSUBn6HAEBtEzrtRZE+dDFxaCauHVzOset64q9tN3Bc45tuOoyKgTmR7/LPOcoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880705; c=relaxed/simple;
	bh=PJJx10xdl1jH1NPfDZHWk9wf68inw16sjn9gfm98AZY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QtWDabgOmt8suHlqR9xlSlp9UXMXfv0A/m6VL0dbRTD30t1i/alVkVQ1sjWHfbnJ5e9Sk4rtZE8bWu7VIUoKtQYnKScaMwYzLuY+uZUYyTsZGQ8QDvJjzG/MHIGHHRt27HG1tDN1ZOYMgZ8vrfPcyzY8OboUgccfKt5gCNWQ0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vt2cpswV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p3nhgO4G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 12:11:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739880701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvN4pJOIuWPXbPcnwoJjzSTMKtHAd+smaQ8AaZS3MJ0=;
	b=Vt2cpswVC9b1S4CprUkKZjTqujNNRYcjKLRxDPSN2MjYxOD++Z47z2EDJRps5DChZ3ElXI
	/tN4I+4131timZaGWs6psUh2tul8Z1hBpho7cmU47i8aUUGClFyh1W+kJxHmmFrYDJXhwf
	I6eBoaeOXrn2hgldaXxrkRVc82ydW4qTLWSZsNnTmTyQWa+cX6hcwCEUsXEMtwjZUCTAsX
	dJDPFHWd602Mv/y0w8QIsT+f5PbMRpMZMaq/INDqAuLVEADhJ/rTDFB0jTVaSsjESy/qLQ
	/hkTbmeZYAddE7CcSdcf22z7bP/J+E02aOXhnFA50S7gQ88JwQQb2IuOvCBlaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739880701;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvN4pJOIuWPXbPcnwoJjzSTMKtHAd+smaQ8AaZS3MJ0=;
	b=p3nhgO4Ga+VhsLNG3BokMohdUAodgp5hXRflWXunWOfQDOX7AKGU6VYUAOtp/q33L4Gz0T
	Qq62hGcPWWMtZPCA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250123190747.745588-16-brgerst@gmail.com>
References: <20250123190747.745588-16-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173988069874.10177.16427686650654598414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     01157ddc58dc2fe428ec17dd5a18cc13f134639f
Gitweb:        https://git.kernel.org/tip/01157ddc58dc2fe428ec17dd5a18cc13f134639f
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 23 Jan 2025 14:07:47 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Feb 2025 10:16:04 +01:00

kallsyms: Remove KALLSYMS_ABSOLUTE_PERCPU

x86-64 was the only user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250123190747.745588-16-brgerst@gmail.com
---
 init/Kconfig            |  5 +---
 kernel/kallsyms.c       | 12 +------
 scripts/kallsyms.c      | 72 ++++++----------------------------------
 scripts/link-vmlinux.sh |  4 +--
 4 files changed, 14 insertions(+), 79 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index b5d9c0f..a0ea04c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1869,11 +1869,6 @@ config KALLSYMS_ALL
 
 	  Say N unless you really need all symbols, or kernel live patching.
 
-config KALLSYMS_ABSOLUTE_PERCPU
-	bool
-	depends on KALLSYMS
-	default n
-
 # end of the "standard kernel features (expert users)" menu
 
 config ARCH_HAS_MEMBARRIER_CALLBACKS
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index a9a0ca6..4198f30 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -148,16 +148,8 @@ static unsigned int get_symbol_offset(unsigned long pos)
 
 unsigned long kallsyms_sym_address(int idx)
 {
-	/* values are unsigned offsets if --absolute-percpu is not in effect */
-	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
-		return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
-
-	/* ...otherwise, positive offsets are absolute values */
-	if (kallsyms_offsets[idx] >= 0)
-		return kallsyms_offsets[idx];
-
-	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
-	return kallsyms_relative_base - 1 - kallsyms_offsets[idx];
+	/* values are unsigned offsets */
+	return kallsyms_relative_base + (u32)kallsyms_offsets[idx];
 }
 
 static unsigned int get_symbol_seq(int index)
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 03852da..4b0234e 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -5,7 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: kallsyms [--all-symbols] [--absolute-percpu]  in.map > out.S
+ * Usage: kallsyms [--all-symbols] in.map > out.S
  *
  *      Table compression uses all the unused char codes on the symbols and
  *  maps these to the most used substrings (tokens). For instance, it might
@@ -37,7 +37,6 @@ struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
 	unsigned int seq;
-	bool percpu_absolute;
 	unsigned char sym[];
 };
 
@@ -55,14 +54,9 @@ static struct addr_range text_ranges[] = {
 #define text_range_text     (&text_ranges[0])
 #define text_range_inittext (&text_ranges[1])
 
-static struct addr_range percpu_range = {
-	"__per_cpu_start", "__per_cpu_end", -1ULL, 0
-};
-
 static struct sym_entry **table;
 static unsigned int table_size, table_cnt;
 static int all_symbols;
-static int absolute_percpu;
 
 static int token_profit[0x10000];
 
@@ -73,7 +67,7 @@ static unsigned char best_table_len[256];
 
 static void usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] [--absolute-percpu] in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] in.map > out.S\n");
 	exit(1);
 }
 
@@ -164,7 +158,6 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 		return NULL;
 
 	check_symbol_range(name, addr, text_ranges, ARRAY_SIZE(text_ranges));
-	check_symbol_range(name, addr, &percpu_range, 1);
 
 	/* include the type field in the symbol name, so that it gets
 	 * compressed together */
@@ -175,7 +168,6 @@ static struct sym_entry *read_symbol(FILE *in, char **buf, size_t *buf_len)
 	sym->len = len;
 	sym->sym[0] = type;
 	strcpy(sym_name(sym), name);
-	sym->percpu_absolute = false;
 
 	return sym;
 }
@@ -319,11 +311,6 @@ static int expand_symbol(const unsigned char *data, int len, char *result)
 	return total;
 }
 
-static bool symbol_absolute(const struct sym_entry *s)
-{
-	return s->percpu_absolute;
-}
-
 static int compare_names(const void *a, const void *b)
 {
 	int ret;
@@ -455,22 +442,11 @@ static void write_src(void)
 		 */
 
 		long long offset;
-		bool overflow;
-
-		if (!absolute_percpu) {
-			offset = table[i]->addr - relative_base;
-			overflow = offset < 0 || offset > UINT_MAX;
-		} else if (symbol_absolute(table[i])) {
-			offset = table[i]->addr;
-			overflow = offset < 0 || offset > INT_MAX;
-		} else {
-			offset = relative_base - table[i]->addr - 1;
-			overflow = offset < INT_MIN || offset >= 0;
-		}
-		if (overflow) {
+
+		offset = table[i]->addr - relative_base;
+		if (offset < 0 || offset > UINT_MAX) {
 			fprintf(stderr, "kallsyms failure: "
-				"%s symbol value %#llx out of range in relative mode\n",
-				symbol_absolute(table[i]) ? "absolute" : "relative",
+				"relative symbol value %#llx out of range\n",
 				table[i]->addr);
 			exit(EXIT_FAILURE);
 		}
@@ -725,36 +701,15 @@ static void sort_symbols(void)
 	qsort(table, table_cnt, sizeof(table[0]), compare_symbols);
 }
 
-static void make_percpus_absolute(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (symbol_in_range(table[i], &percpu_range, 1)) {
-			/*
-			 * Keep the 'A' override for percpu symbols to
-			 * ensure consistent behavior compared to older
-			 * versions of this tool.
-			 */
-			table[i]->sym[0] = 'A';
-			table[i]->percpu_absolute = true;
-		}
-}
-
 /* find the minimum non-absolute symbol address */
 static void record_relative_base(void)
 {
-	unsigned int i;
-
-	for (i = 0; i < table_cnt; i++)
-		if (!symbol_absolute(table[i])) {
-			/*
-			 * The table is sorted by address.
-			 * Take the first non-absolute symbol value.
-			 */
-			relative_base = table[i]->addr;
-			return;
-		}
+	/*
+	 * The table is sorted by address.
+	 * Take the first symbol value.
+	 */
+	if (table_cnt)
+		relative_base = table[0]->addr;
 }
 
 int main(int argc, char **argv)
@@ -762,7 +717,6 @@ int main(int argc, char **argv)
 	while (1) {
 		static const struct option long_options[] = {
 			{"all-symbols",     no_argument, &all_symbols,     1},
-			{"absolute-percpu", no_argument, &absolute_percpu, 1},
 			{},
 		};
 
@@ -779,8 +733,6 @@ int main(int argc, char **argv)
 
 	read_map(argv[optind]);
 	shrink_table();
-	if (absolute_percpu)
-		make_percpus_absolute();
 	sort_symbols();
 	record_relative_base();
 	optimize_token_table();
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 56a077d..67e6633 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -144,10 +144,6 @@ kallsyms()
 		kallsymopt="${kallsymopt} --all-symbols"
 	fi
 
-	if is_enabled CONFIG_KALLSYMS_ABSOLUTE_PERCPU; then
-		kallsymopt="${kallsymopt} --absolute-percpu"
-	fi
-
 	info KSYMS "${2}.S"
 	scripts/kallsyms ${kallsymopt} "${1}" > "${2}.S"
 

