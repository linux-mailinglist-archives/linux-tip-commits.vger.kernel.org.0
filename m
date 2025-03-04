Return-Path: <linux-tip-commits+bounces-3901-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251FA4DA80
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1197C1650D8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB8202F7E;
	Tue,  4 Mar 2025 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lHJJy3Eh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OgBGxjR+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AF202974;
	Tue,  4 Mar 2025 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083986; cv=none; b=rOhjHTWGVmKWP57GZ+NPob6jySMfSeTP/jKyWQh+XnlB785YL7Em0uY8NYFKm7EKDytIQPeSJy0hwqKgDkGBfmuKQo81XdXtX0UEibqmm7T8a4hGXCYshzyfZ4ccXAYjwkM/Rhg37d4rGBWAXk2PTtpLYHBVqfvYMSQSFdIEAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083986; c=relaxed/simple;
	bh=T82aP7GmyH+RniyFUytrQqup2SD6/UW9EP6nYtVSWC4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GdqvIhFOK4aZ/fQ2HqzQ44EtqKrd8OcewJDCldbfjHfGNlu6Q5PXvXf189qjuT47PRhCF4a7WCQuMg8YOAv1RZlriusJgGtNGxt+UgXKsVe3nmPw8Yr4Eb7iQbl8c52lzmCgcXbwRWczK42W+MpWIGyScuOJjt5G0voOcR2uZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lHJJy3Eh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OgBGxjR+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45d8v7Z99bRlFygSZII8+9ICNasxHAy+9eeWa70DXho=;
	b=lHJJy3EhoJ5Zb42is9W2Bc71GNyyyee0JcyvIBRUoEDyFAGaSi+h8/6Oh++8UFpFn+fZ19
	fox2fkLTRQgYbh4fuZtAg6rvCvZrkIsKcRyxnkOua8LVT1+DOfkhBfXu3NZ2d3nHeWP4sP
	RLnpJT5tzYKisiH9U2NW5fYSsHe7fPX+rv672CbVCIUYL0TbfpFopWSErPhxnq+M25xgcG
	g0plz7g/hG583ar0htMH8FX9NWlszbTRwNAPHuZwgEe6aAyh7zVNKAeXTqYVorscDvHNKQ
	+OswojvFAiWT1smCzfifR+EhbBoYeZnUywOZKkvTKWw9ux1bAB7aJK5Ngx/unQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083982;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45d8v7Z99bRlFygSZII8+9ICNasxHAy+9eeWa70DXho=;
	b=OgBGxjR+QPU6lRE26o2Li5jR14nVKVSbQbqUZZP6wRIub28irx8C2Udi4UW1iGU5qb5Mm1
	CoXwS25jKNx1tuDw==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Log CPU flag cmdline hacks more verbosely
Cc: Peter Zijlstra <peterz@infradead.org>,
 Brendan Jackman <jackmanb@google.com>, Ingo Molnar <mingo@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-setcpuid-taint-louder-v1-3-8d255032cb4c@google.com>
References: <20250303-setcpuid-taint-louder-v1-3-8d255032cb4c@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108398196.14745.189474796391905137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d0ba9bcf001c7907e4755b0e498f5ff9d1a228ef
Gitweb:        https://git.kernel.org/tip/d0ba9bcf001c7907e4755b0e498f5ff9d1a228ef
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Mon, 03 Mar 2025 15:45:39 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:15:12 +01:00

x86/cpu: Log CPU flag cmdline hacks more verbosely

Since using these options is very dangerous, make details as visible as
possible:

- Instead of a single message for each of the cmdline options, print a
  separate pr_warn() for each individual flag.

- Say explicitly whether the flag is a "feature" or a "bug".

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20250303-setcpuid-taint-louder-v1-3-8d255032cb4c@google.com
---
 arch/x86/kernel/cpu/common.c | 39 ++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index c1ced31..8eba9ca 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1484,8 +1484,6 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 	char *opt;
 	int taint = 0;
 
-	pr_warn("%s CPUID bits:", set ? "Force-enabling" : "Clearing");
-
 	while (arg) {
 		bool found __maybe_unused = false;
 		unsigned int bit;
@@ -1500,16 +1498,19 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 		if (!kstrtouint(opt, 10, &bit)) {
 			if (bit < NCAPINTS * 32) {
 
+				if (set) {
+					pr_warn("setcpuid: force-enabling CPU feature flag:");
+					setup_force_cpu_cap(bit);
+				} else {
+					pr_warn("clearcpuid: force-disabling CPU feature flag:");
+					setup_clear_cpu_cap(bit);
+				}
 				/* empty-string, i.e., ""-defined feature flags */
 				if (!x86_cap_flags[bit])
-					pr_cont(" %d:%d", bit >> 5, bit & 31);
+					pr_cont(" %d:%d\n", bit >> 5, bit & 31);
 				else
-					pr_cont(" %s", x86_cap_flags[bit]);
+					pr_cont(" %s\n", x86_cap_flags[bit]);
 
-				if (set)
-					setup_force_cpu_cap(bit);
-				else
-					setup_clear_cpu_cap(bit);
 				taint++;
 			}
 			/*
@@ -1521,11 +1522,15 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 
 		for (bit = 0; bit < 32 * (NCAPINTS + NBUGINTS); bit++) {
 			const char *flag;
+			const char *kind;
 
-			if (bit < 32 * NCAPINTS)
+			if (bit < 32 * NCAPINTS) {
 				flag = x86_cap_flags[bit];
-			else
+				kind = "feature";
+			} else {
+				kind = "bug";
 				flag = x86_bug_flags[bit - (32 * NCAPINTS)];
+			}
 
 			if (!flag)
 				continue;
@@ -1533,22 +1538,24 @@ static inline bool parse_set_clear_cpuid(char *arg, bool set)
 			if (strcmp(flag, opt))
 				continue;
 
-			pr_cont(" %s", opt);
-			if (set)
+			if (set) {
+				pr_warn("setcpuid: force-enabling CPU %s flag: %s\n",
+					kind, flag);
 				setup_force_cpu_cap(bit);
-			else
+			} else {
+				pr_warn("clearcpuid: force-disabling CPU %s flag: %s\n",
+					kind, flag);
 				setup_clear_cpu_cap(bit);
+			}
 			taint++;
 			found = true;
 			break;
 		}
 
 		if (!found)
-			pr_cont(" (unknown: %s)", opt);
+			pr_warn("%s: unknown CPU flag: %s", set ? "setcpuid" : "clearcpuid", opt);
 	}
 
-	pr_cont("\n");
-
 	return taint;
 }
 

