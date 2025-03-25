Return-Path: <linux-tip-commits+bounces-4487-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0DDA6EC40
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EEE3AD163
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA3D25742F;
	Tue, 25 Mar 2025 09:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1oy1KCW1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vf3mjM/L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E67256C6C;
	Tue, 25 Mar 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893550; cv=none; b=LSriF8EUao2boAKRcL9kAmHvTdmAAftvAiJ/mtAStua3wUSfnArJt5ucSloFZ4gclXR+7SGKAccPuTQAL/eqPScmvaZdf7Z1wXZvbD+ZF8XMiMhIF6Kkt+UwMzTebhNp2JJWOuzdH8kXXS+yQz3ra0Rhu/zwb9mjP4TSUojue8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893550; c=relaxed/simple;
	bh=7KcuXHrI8LPnPPUt0G/MUGGn4Pv1sgln2X8XjIBw2+Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VxNdCqu5d88vsdZzqmpE2yEp7t3PhZO7CggxrpYVkHgOaerxH9kw/HovmlwQHrs6R2/WdsJPCW0Gkww1ywbuDsl93kI1GTxHCukbG1TH+s4XaSMvrYDBIcl6e7rYpa+sMgRJzXg6s0smePLjIpcC1rgMQhxCc70usgdJaArxgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1oy1KCW1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vf3mjM/L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:05:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742893546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3DDaGELfMJH6d3yfzzMMebQJjGNmvVdzjAG0zpx4E8=;
	b=1oy1KCW14mo2gtN4jY5DhFXuzTxmOKUdhNB2TQbi24j6e75M6joXIIZ1d+h+uT7vixV3xe
	vkMIx2iDhcCsiDrFoUZUEGgilL15CECIaXxrZXgrAtRLIDzO+zxOSRVL9UHHZhrof+GExL
	gUBwBsl0tk12nEIKaymXemEkgtHBnS2d6jWNpBEHubHhEBEK5klRHJ9DTWAZI1Fz/R+nEW
	ZQWBhgHS4fz9uTHH5LddmRXo44yrruHzAiZjqewIZ3u94qcB5cpA4BzrQEsDxTqLR7Aeh9
	2WstwEBndmBzBmQOUrHYTaXWxmmJ/KdcAccJ0SkmKx9zICMw6W7XZLp6M+Nlig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742893546;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3DDaGELfMJH6d3yfzzMMebQJjGNmvVdzjAG0zpx4E8=;
	b=Vf3mjM/LC93uKKDTNUcQLClwouZYvZQLVyPQl8UZgy8uNJWF7ipkKQdvKGxcF8NhBXPQyu
	PRpg+B/3nBzLffBw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tools/x86/kcpuid: Simplify usage() handling
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324142042.29010-4-darwi@linutronix.de>
References: <20250324142042.29010-4-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289354597.14745.2248278160822769009.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     660c29fe53deeb3b3aef1d666ed3bde7608380bd
Gitweb:        https://git.kernel.org/tip/660c29fe53deeb3b3aef1d666ed3bde7608380bd
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 15:20:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:53:44 +01:00

tools/x86/kcpuid: Simplify usage() handling

Refactor usage() to accept an exit code parameter and exit the program
after usage output.  This streamlines its callers' code paths.

Remove the "Invalid option" error message since getopt_long(3) already
emits a similar message by default.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250324142042.29010-4-darwi@linutronix.de
---
 tools/arch/x86/kcpuid/kcpuid.c | 37 ++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/arch/x86/kcpuid/kcpuid.c b/tools/arch/x86/kcpuid/kcpuid.c
index 25b10fe..a90ac0b 100644
--- a/tools/arch/x86/kcpuid/kcpuid.c
+++ b/tools/arch/x86/kcpuid/kcpuid.c
@@ -10,6 +10,7 @@
 
 #define ARRAY_SIZE(x)	(sizeof(x) / sizeof((x)[0]))
 #define min(a, b)	(((a) < (b)) ? (a) : (b))
+#define __noreturn	__attribute__((__noreturn__))
 
 typedef unsigned int u32;
 typedef unsigned long long u64;
@@ -584,17 +585,17 @@ static void setup_platform_cpuid(void)
 	leafs_ext = setup_cpuid_range(0x80000000);
 }
 
-static void usage(void)
+static void __noreturn usage(int exit_code)
 {
-	warnx("kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
-	      "\t-a|--all             Show both bit flags and complex bit fields info\n"
-	      "\t-b|--bitflags        Show boolean flags only\n"
-	      "\t-d|--detail          Show details of the flag/fields (default)\n"
-	      "\t-f|--flags           Specify the CPUID CSV file\n"
-	      "\t-h|--help            Show usage info\n"
-	      "\t-l|--leaf=index      Specify the leaf you want to check\n"
-	      "\t-r|--raw             Show raw CPUID data\n"
-	      "\t-s|--subleaf=sub     Specify the subleaf you want to check"
+	errx(exit_code, "kcpuid [-abdfhr] [-l leaf] [-s subleaf]\n"
+	     "\t-a|--all             Show both bit flags and complex bit fields info\n"
+	     "\t-b|--bitflags        Show boolean flags only\n"
+	     "\t-d|--detail          Show details of the flag/fields (default)\n"
+	     "\t-f|--flags           Specify the CPUID CSV file\n"
+	     "\t-h|--help            Show usage info\n"
+	     "\t-l|--leaf=index      Specify the leaf you want to check\n"
+	     "\t-r|--raw             Show raw CPUID data\n"
+	     "\t-s|--subleaf=sub     Specify the subleaf you want to check"
 	);
 }
 
@@ -610,7 +611,7 @@ static struct option opts[] = {
 	{ NULL, 0, NULL, 0 }
 };
 
-static int parse_options(int argc, char *argv[])
+static void parse_options(int argc, char *argv[])
 {
 	int c;
 
@@ -630,9 +631,7 @@ static int parse_options(int argc, char *argv[])
 			user_csv = optarg;
 			break;
 		case 'h':
-			usage();
-			exit(1);
-			break;
+			usage(EXIT_SUCCESS);
 		case 'l':
 			/* main leaf */
 			user_index = strtoul(optarg, NULL, 0);
@@ -645,11 +644,8 @@ static int parse_options(int argc, char *argv[])
 			user_sub = strtoul(optarg, NULL, 0);
 			break;
 		default:
-			warnx("Invalid option '%c'", optopt);
-			return -1;
-	}
-
-	return 0;
+			usage(EXIT_FAILURE);
+		}
 }
 
 /*
@@ -662,8 +658,7 @@ static int parse_options(int argc, char *argv[])
  */
 int main(int argc, char *argv[])
 {
-	if (parse_options(argc, argv))
-		return -1;
+	parse_options(argc, argv);
 
 	/* Setup the cpuid leafs of current platform */
 	setup_platform_cpuid();

