Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9AC43E23D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 28 Oct 2021 15:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhJ1NcE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 28 Oct 2021 09:32:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47736 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhJ1NcD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 28 Oct 2021 09:32:03 -0400
Date:   Thu, 28 Oct 2021 13:29:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635427775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPvrgO/sNpqfHzBG2lXnRtgDIXQoAnle2fHkvymLORk=;
        b=ICeOrV5bT+sET+jfo/6gasAd0BlCduPbeEEK2zk36cmIDODICCkUr3ZjM8QtntD5qAx/X8
        Fi4xNZzCLNPrLNJJnLh6Kz25Yze9IDNFTurW/JOww+UPrFv9rOk2VXHLpjEyfkJwacVN24
        w4SRCRn2qRpRA06pYBJwxIPeVoRFGIStroWAqjhLMCwtSosTSh7UewP3a5eLsOX5hnj6DM
        2b/nrO+tJpKyNEygbQM3WlMukIheFiyZVMe6NSC8DRgtoImZ4UxYZJX8xAdgKJLPzen6YY
        S+z/zdRRKaw5dq6BcKXZSqzv9JxbjCv/p5GuUklF/2xLOjSiOM6TnNuCPmzPGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635427775;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPvrgO/sNpqfHzBG2lXnRtgDIXQoAnle2fHkvymLORk=;
        b=qXYmtM8B6ELSn5yuQhQRmh+j0+o5ipX5F3xwi5XXGU0tGJI5a4qXqQODbocOWTLp9UUgsj
        omFPoClJ9/v29bBQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/boot: Allow a "silent" kaslr random byte fetch
Cc:     Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211013175742.1197608-3-keescook@chromium.org>
References: <20211013175742.1197608-3-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <163542777462.626.1639307537615391982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     0d054d4e82072bcfd5eb961536b09a9b3f5613fb
Gitweb:        https://git.kernel.org/tip/0d054d4e82072bcfd5eb961536b09a9b3f5613fb
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Wed, 13 Oct 2021 10:57:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 27 Oct 2021 11:07:58 +02:00

x86/boot: Allow a "silent" kaslr random byte fetch

Under earlyprintk, each RNG call produces a debug report line. To support
the future FGKASLR feature, which will fetch random bytes during function
shuffling, this is not useful information (each line is identical and
tells us nothing new), needlessly spamming the console. Instead, allow
for a NULL "purpose" to suppress the debug reporting.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/r/20211013175742.1197608-3-keescook@chromium.org
---
 arch/x86/lib/kaslr.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/lib/kaslr.c b/arch/x86/lib/kaslr.c
index a536651..2b3eb8c 100644
--- a/arch/x86/lib/kaslr.c
+++ b/arch/x86/lib/kaslr.c
@@ -56,11 +56,14 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	unsigned long raw, random = get_boot_seed();
 	bool use_i8254 = true;
 
-	debug_putstr(purpose);
-	debug_putstr(" KASLR using");
+	if (purpose) {
+		debug_putstr(purpose);
+		debug_putstr(" KASLR using");
+	}
 
 	if (has_cpuflag(X86_FEATURE_RDRAND)) {
-		debug_putstr(" RDRAND");
+		if (purpose)
+			debug_putstr(" RDRAND");
 		if (rdrand_long(&raw)) {
 			random ^= raw;
 			use_i8254 = false;
@@ -68,7 +71,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
 
 	if (has_cpuflag(X86_FEATURE_TSC)) {
-		debug_putstr(" RDTSC");
+		if (purpose)
+			debug_putstr(" RDTSC");
 		raw = rdtsc();
 
 		random ^= raw;
@@ -76,7 +80,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	}
 
 	if (use_i8254) {
-		debug_putstr(" i8254");
+		if (purpose)
+			debug_putstr(" i8254");
 		random ^= i8254();
 	}
 
@@ -86,7 +91,8 @@ unsigned long kaslr_get_random_long(const char *purpose)
 	    : "a" (random), "rm" (mix_const));
 	random += raw;
 
-	debug_putstr("...\n");
+	if (purpose)
+		debug_putstr("...\n");
 
 	return random;
 }
