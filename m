Return-Path: <linux-tip-commits+bounces-3009-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070659E6BEF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 11:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D00288550
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8220D51F;
	Fri,  6 Dec 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qi1I/WG+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JINCbDiq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D820B81B;
	Fri,  6 Dec 2024 10:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480220; cv=none; b=apQHvgfC3LF40irylvgpYc6sFWr8eaD/m8sLsdrAJ640byYp1N98cOv9HZ8xg52zeG436UJbWD+2b7iJt3Vwp+Jj3VSexPMwv5YE+gJVN9e+imaywh29d6iLHSYV6WDa2JXwcspMtNgGojy13D7tk/7oF1JZ001LCpcq8UhkzIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480220; c=relaxed/simple;
	bh=TbgQlKzeETTZK9FP2u03cPRP9pZV5nEFzyipNaGfW0Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SRPYxZ4wu5MMA63W3ifWvd5218fpkhcTqucSjd4S2ES7hsf2Czc4JiSlmzhNmeAOPGAwphzg80bw1RpX3L3tIwbSnruScZ2SwKAvMCTG7thr+S6/pFsI11J14fMibW2zt+UAnZJo2S+SmhzO5OlLMWJlLnM0arOWjxy6m27G1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qi1I/WG+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JINCbDiq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 10:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733480216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f4ofpUJ6xxo8pc0fp/K3MB4dkOtv0a6Dq8uiOkd8fQk=;
	b=Qi1I/WG+sKMtRpgshSDB0o5eyl8xqh2dD8vhM021/PWHWs1oP0TEM7pf9+DMobMgNbtlq2
	X/b308VCZ4XjvL2WA8pR7zaBfudj2aHfldcZSlSsrggnFoGqlSj4aiC786ZbFuRo5eVe9P
	fT1gdxaK1fQk8g3xtqt1x4frwSxSogEJU08/CI9YbOqs+DCIG4W1CXHHe2U1gSYdH+6m8Q
	FWt7MBHCawWXT+d6XleQ1MutVBBWFD3PyvX+qtptqj5ftmYcoYEdW3R2r08a+ppHi8dWTR
	FXuqBV91ujAykLulK2/8OmjNTJFVvPUQxIeoItT/fea7iIvG0m84V+2l0cM+Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733480216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=f4ofpUJ6xxo8pc0fp/K3MB4dkOtv0a6Dq8uiOkd8fQk=;
	b=JINCbDiqkMiTZ7I3GQI+jtVkhdfNezj/CWG6OQmBpF21yOcApKucNbWQJfrtHKL/sVVIs4
	mQd58xbUTDdLM/AQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Free up unused feature bits
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173348021509.412.6713554902949596363.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     7a470e826d7521bec6af789deab31cfa4fd05af3
Gitweb:        https://git.kernel.org/tip/7a470e826d7521bec6af789deab31cfa4fd05af3
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 07 Nov 2024 23:30:00 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:57:44 +01:00

x86/cpufeatures: Free up unused feature bits

Linux defined feature bits X86_FEATURE_P3 and X86_FEATURE_P4 are not
used anywhere. Commit f31d731e4467 ("x86: use X86_FEATURE_NOPL in
alternatives") got rid of the last usage in 2008. Remove the related
mappings and code.

Just like all X86_FEATURE bits, the raw bit numbers can be exposed to
userspace via MODULE_DEVICE_TABLE(). There is a very small theoretical
chance of userspace getting confused if these bits got reassigned and
changed logical meaning.  But these bits were never used for a device
table, so it's highly unlikely this will ever happen in practice.

[ dhansen: clarify userspace visibility of these bits ]

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/all/20241107233000.2742619-1-sohil.mehta%40intel.com
---
 arch/x86/include/asm/cpufeatures.h | 4 ++--
 arch/x86/kernel/cpu/intel.c        | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 17b6590..f725ccc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -83,8 +83,8 @@
 #define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* "centaur_mcr" Centaur MCRs (= MTRRs) */
 #define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
 #define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitecture */
-#define X86_FEATURE_P3			( 3*32+ 6) /* P3 */
-#define X86_FEATURE_P4			( 3*32+ 7) /* P4 */
+/* Free                                 ( 3*32+ 6) */
+/* Free                                 ( 3*32+ 7) */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks at a constant rate */
 #define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
 #define X86_FEATURE_ART			( 3*32+10) /* "art" Always running timer (ART) */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d1de300..5a9fbe9 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -597,11 +597,6 @@ static void init_intel(struct cpuinfo_x86 *c)
 		if (p)
 			strcpy(c->x86_model_id, p);
 	}
-
-	if (c->x86 == 15)
-		set_cpu_cap(c, X86_FEATURE_P4);
-	if (c->x86 == 6)
-		set_cpu_cap(c, X86_FEATURE_P3);
 #endif
 
 	/* Work around errata */

