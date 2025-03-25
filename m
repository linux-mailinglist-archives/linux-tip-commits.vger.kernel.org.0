Return-Path: <linux-tip-commits+bounces-4489-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E18A6EC46
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C583ACFF2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5D62580C8;
	Tue, 25 Mar 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UW13cuTk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qWyiANgD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D54D2571A4;
	Tue, 25 Mar 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893551; cv=none; b=lsETmVDtWqYmfo+PSeYRCNlCsrPT43/Cox18rdBvGtXuGkKAWlfUWtl1vd7/TYPdxgiS/kHuBGFHAOw/ttKcMLUbO/2l99tFizl2BW/hm4V8RyaGUqzNgf76EltiNDcp3K1ZZWrl1TPZ++qsPdj9yjK8uWl5spw6wGxvFf3soR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893551; c=relaxed/simple;
	bh=mXTtJit5ayNHYnOprag4zIkFgFarJaX/Kr4yZxgYzho=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fOhJj2yKGIUoUwa94rMrXhLA1ZGSw+qMEWGmKLADd9IxkBhZv+LuxdkV0OZu1+6GFxXSl4l3MQ5ORTxCS6q9089biwh86drgWGbBKUVvAQffYwoipE2AzpoMudYHKG+6naOVqbWUtx08pcm+aOeb9TTDQtZlxeGlQ0WvqDJix14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UW13cuTk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qWyiANgD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Rb2Ye4dqeBfYH67/zlBmy4Lrt7ZYqTBVesGlKdczU=;
	b=UW13cuTkvMiVFSfQpkWJaIKRFyB/xjKntqanfjKh8T4E/ZWcWd7fuRgpcz2oHOyFDcYOGu
	gd/tTcR5Elkp+3hAQClN5ZG57FfsYH2WPk4XAu3BP/wXD5Yttet40JJEiAILPHfCah0vIi
	8M9f4L+Op2ITlZnp19NeuiaesuUxJgaagvosJ5EJ55+yum/39nD66yoFBQr37O4yhPxVCb
	/4nqjD3ok36Ey9UqkZXTKYrF/b4fZWdeseIHQhZoWu76EZtTI6082JwJZKfTpSnqMdhTsJ
	0OufgjYD5YkZngHP7QKkyC7NqJuIYO8paQcuO2WNBrVc30vyOkwNGZTdZkglcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8Rb2Ye4dqeBfYH67/zlBmy4Lrt7ZYqTBVesGlKdczU=;
	b=qWyiANgDSfrHX6y+YVQFqdCsRZdg/L2OPkrLn8IosmMXIqKOlU5jyEeJixF2ju6uTDJsIh
	yn84z+Ai8opf5DCg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Fix error handling
Cc: Remington Brasga <rbrasga@uci.edu>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-2-darwi@linutronix.de>
References: <20250324142042.29010-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354711.14745.14180747703677923831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     116edfe173d0c59ec2aa87fb91f2f31d477b61b3
Gitweb:        https://git.kernel.org/tip/116edfe173d0c59ec2aa87fb91f2f31d477b61b3
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:43 +01:00

tools/x86/kcpuid: Fix error handling

Error handling in kcpuid is unreliable.  On malloc() failures, the code
prints an error then just goes on.  The error messages are also printed
to standard output instead of standard error.

Use err() and errx() from <err.h> to direct all error messages to
standard error and automatically exit the program.  Use err() to include
the errno information, and errx() otherwise.  Use warnx() for warnings.

While at it, alphabetically reorder the header includes.

[ mingo: Fix capitalization in the help text while at it. ]

Fixes: c6b2f240bf8d ("tools/x86: Add a kcpuid tool to show raw CPU features")
Reported-by: Remington Brasga <rbrasga@uci.edu>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-2-darwi@linutronix.de
Closes: https://lkml.kernel.org/r/20240926223557.2048-1-rbrasga@uci.edu
---
 tools/arch/x86/kcpuid/kcpuid.c | 47 ++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 1b25c0a..40a9e59 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
 
-#include <stdio.h>
+#include <err.h>
+#include <getopt.h>
 #include <stdbool.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <getopt.h>
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
@@ -145,14 +146,14 @@ static bool cpuid_store(struct cpuid_range *range, u32 f, int subleaf,
 	if (!func->leafs) {
 		func->leafs = malloc(sizeof(struct subleaf));
 		if (!func->leafs)
-			perror("malloc func leaf");
+			err(EXIT_FAILURE, NULL);
 
 		func->nr = 1;
 	} else {
 		s = func->nr;
 		func->leafs = realloc(func->leafs, (s + 1) * sizeof(*leaf));
 		if (!func->leafs)
-			perror("realloc f->leafs");
+			err(EXIT_FAILURE, NULL);
 
 		func->nr++;
 	}
@@ -211,7 +212,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 
 	range = malloc(sizeof(struct cpuid_range));
 	if (!range)
-		perror("malloc range");
+		err(EXIT_FAILURE, NULL);
 
 	if (input_eax & 0x80000000)
 		range->is_ext = true;
@@ -220,7 +221,7 @@ struct cpuid_range *setup_cpuid_range(u32 input_eax)
 
 	range->funcs = malloc(sizeof(struct cpuid_func) * idx_func);
 	if (!range->funcs)
-		perror("malloc range->funcs");
+		err(EXIT_FAILURE, NULL);
 
 	range->nr = idx_func;
 	memset(range->funcs, 0, sizeof(struct cpuid_func) * idx_func);
@@ -395,8 +396,8 @@ static int parse_line(char *line)
 	return 0;
 
 err_exit:
-	printf("Warning: wrong line format:\n");
-	printf("\tline[%d]: %s\n", flines, line);
+	warnx("Wrong line format:\n"
+	      "\tline[%d]: %s", flines, line);
 	return -1;
 }
 
@@ -418,10 +419,8 @@ static void parse_text(void)
 		file = fopen("./cpuid.csv", "r");
 	}
 
-	if (!file) {
-		printf("Fail to open '%s'\n", filename);
-		return;
-	}
+	if (!file)
+		err(EXIT_FAILURE, "%s", filename);
 
 	while (1) {
 		ret = getline(&line, &len, file);
@@ -530,7 +529,7 @@ static inline struct cpuid_func *index_to_func(u32 index)
 	func_idx = index & 0xffff;
 
 	if ((func_idx + 1) > (u32)range->nr) {
-		printf("ERR: invalid input index (0x%x)\n", index);
+		warnx("Invalid input index (0x%x)", index);
 		return NULL;
 	}
 	return &range->funcs[func_idx];
@@ -562,7 +561,7 @@ static void show_info(void)
 				return;
 			}
 
-			printf("ERR: invalid input subleaf (0x%x)\n", user_sub);
+			warnx("Invalid input subleaf (0x%x)", user_sub);
 		}
 
 		show_func(func);
@@ -593,15 +592,15 @@ static void setup_platform_cpuid(void)
 
 static void usage(void)
 {
-	printf("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
-		"\t-a|--all             Show both bit flags and complex bit fields info\n"
-		"\t-b|--bitflags        Show boolean flags only\n"
-		"\t-d|--detail          Show details of the flag/fields (default)\n"
-		"\t-f|--flags           Specify the cpuid csv file\n"
-		"\t-h|--help            Show usage info\n"
-		"\t-l|--leaf=index      Specify the leaf you want to check\n"
-		"\t-r|--raw             Show raw cpuid data\n"
-		"\t-s|--subleaf=sub     Specify the subleaf you want to check\n"
+	warnx("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+	      "\t-a|--all             Show both bit flags and complex bit fields info\n"
+	      "\t-b|--bitflags        Show boolean flags only\n"
+	      "\t-d|--detail          Show details of the flag/fields (default)\n"
+	      "\t-f|--flags           Specify the CPUID CSV file\n"
+	      "\t-h|--help            Show usage info\n"
+	      "\t-l|--leaf=index      Specify the leaf you want to check\n"
+	      "\t-r|--raw             Show raw CPUID data\n"
+	      "\t-s|--subleaf=sub     Specify the subleaf you want to check"
 	);
 }
 
@@ -652,7 +651,7 @@ static int parse_options(int argc, char *argv[])
 			user_sub = strtoul(optarg, NULL, 0);
 			break;
 		default:
-			printf("%s: Invalid option '%c'\n", argv[0], optopt);
+			warnx("Invalid option '%c'", optopt);
 			return -1;
 	}
 

