Return-Path: <linux-tip-commits+bounces-3930-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DCA4E1AF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 15:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8863A640E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E130023A98F;
	Tue,  4 Mar 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S/W8bp7c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cKcZDKKf"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6607920ADEC
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098869; cv=pass; b=RWySKJ8sWArrIBpI4eULECI89dlNmwyyr69ruVkmTxb/Y9jKwL/u70oa2Lfyl5zYRrzgml7TG1QqK4Rl65KzxqUGwh82PDr5J/4W2YY/YEPHq+exm7fE0/HisLm9SHwuWk5/r5wnwT0gXEM4r9FTktDbBLVSEXmEvcn8pMVNeLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098869; c=relaxed/simple;
	bh=Y9LxNlsUM5B8RNuZ1u0khqioumHO6RHYAJPgVjskjlQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t5HWKSili9fbaKk6c+k8lAPt1gqXCMiocrb6k9lOdX/Qr60QkjqtRe1UBSPYveqTh0AhiPcisVjU5jKN52blNSqXPKntSPDVB/eagzhmrpRLEnySgL5nI+T0qolwvyFlUPKwZHSmFLfbVMxo//a8rR2NPE/iwrtLuzjF7BQpJug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S/W8bp7c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKcZDKKf; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id B254140D0B6C
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:34:26 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=S/W8bp7c;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=cKcZDKKf
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dSb0t0DzFwxc
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:32:47 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 7457842728; Tue,  4 Mar 2025 17:32:44 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S/W8bp7c;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKcZDKKf
X-Envelope-From: <linux-kernel+bounces-541331-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S/W8bp7c;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKcZDKKf
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 1C4AB43501
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:03:23 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id CC0B52DCED
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:03:22 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AFA3166F40
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791331F1931;
	Mon,  3 Mar 2025 10:03:01 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCC4C85;
	Mon,  3 Mar 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996178; cv=none; b=U8rkUL/Jr8tRlH6YesaQoTXB/ADLSUgIX2C/2HQesliOSNj3PoB67GyM23AScpL3CtA3INPMq99T92A+6whaKC270QBPM/ACDGVlmM3FJ8ucIofQ+ujtD4R7hHizc0seiVqxzwth9+1NB5yOaeHpTY1dfpgjEEW0GSaTxWcLB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996178; c=relaxed/simple;
	bh=Y9LxNlsUM5B8RNuZ1u0khqioumHO6RHYAJPgVjskjlQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=q9onT9pTn7SO7vOBY4qfv9rlvFB2nfajubOyziTmeES5GqukOSCWXy0XUZnjWKXb8VVUcX6k2X1Iqdd6W66bYgWLq9U1W3DGoKjM928uPMR6YfdznPE0Ne2RuJePlPjigQzmgPVNer3WVOAWUQKtNT2oKaGGsRkV6YNRr5KvikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S/W8bp7c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cKcZDKKf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:02:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740996175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgh2UvydaTwafIT1lV3r2kTKy4bqzJWHX041N4xlO8c=;
	b=S/W8bp7cojFlFwQ6mArPQBU6V/FHTSxRXujRE9W7bXko9CzHCNx4qCX0MJ58pIFyL24tib
	xs7AnVahPDMzBccTiRPpD4ZSSzWVHjSs98lXUGtVhBLcTRpsPmIjBs5UfvRp8FsLx/ycHR
	cD8kt53Je5cZnlFOq76FQC3KGanPAHw43vdVDci/dJB2ZqZRq1u76bkIgOfcOJtGzRrb3c
	pA5CtGLOsxIt+RLImd7OQTAVaXKaHL1Pg92aHySxRV7R0x4x/h90xA3DJ9495HhzD2wmaG
	tsKPvOU3UtkOzrJUtN3dNLTgHue5sFrQE3TCKGWbtSIj5oEa9h6oFydJl7OUtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740996175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgh2UvydaTwafIT1lV3r2kTKy4bqzJWHX041N4xlO8c=;
	b=cKcZDKKfJlM/ER6zLQD7Kc24wLVa7+H74dLWegGGurV/J1iNc4eYClHiLXXnYsBO7/4tjt
	jXAjGVCHuT4yCFBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n
Cc: kernel test robot <lkp@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303094911.GL5880@noisy.programming.kicks-ass.net>
References: <20250303094911.GL5880@noisy.programming.kicks-ass.net>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099617138.10177.206551254938966948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dSb0t0DzFwxc
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703585.27326@ryPnw9D0cs0q0nwNyB7o7Q
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     73e8079be9e7ae5ed197d074e0ba6c43674c52f7
Gitweb:        https://git.kernel.org/tip/73e8079be9e7ae5ed197d074e0ba6c43674c52f7
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 03 Mar 2025 10:21:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Mar 2025 10:54:11 +01:00

x86/ibt: Make cfi_bhi a constant for FINEIBT_BHI=n

Robot yielded a .config that tripped:

  vmlinux.o: warning: objtool: do_jit+0x276: relocation to !ENDBR: .noinstr.text+0x6a60

This is the result of using __bhi_args[1] in unreachable code; make
sure the compiler is able to determine this is unreachable and trigger
DCE.

Closes: https://lore.kernel.org/oe-kbuild-all/202503030704.H9KFysNS-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250303094911.GL5880@noisy.programming.kicks-ass.net
---
 arch/x86/include/asm/cfi.h    | 5 +++++
 arch/x86/kernel/alternative.c | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/cfi.h b/arch/x86/include/asm/cfi.h
index 2f6a01f..3e51ba4 100644
--- a/arch/x86/include/asm/cfi.h
+++ b/arch/x86/include/asm/cfi.h
@@ -100,7 +100,12 @@ enum cfi_mode {
 };
 
 extern enum cfi_mode cfi_mode;
+
+#ifdef CONFIG_FINEIBT_BHI
 extern bool cfi_bhi;
+#else
+#define cfi_bhi (0)
+#endif
 
 typedef u8 bhi_thunk[32];
 extern bhi_thunk __bhi_args[];
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 32e4b80..bf82c6f 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -936,7 +936,10 @@ void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 #endif
 
 enum cfi_mode cfi_mode __ro_after_init = __CFI_DEFAULT;
+
+#ifdef CONFIG_FINEIBT_BHI
 bool cfi_bhi __ro_after_init = false;
+#endif
 
 #ifdef CONFIG_CFI_CLANG
 struct bpf_insn;
@@ -1070,11 +1073,15 @@ static __init int cfi_parse_cmdline(char *str)
 				pr_err("Ignoring paranoid; depends on fineibt.\n");
 			}
 		} else if (!strcmp(str, "bhi")) {
+#ifdef CONFIG_FINEIBT_BHI
 			if (cfi_mode == CFI_FINEIBT) {
 				cfi_bhi = true;
 			} else {
 				pr_err("Ignoring bhi; depends on fineibt.\n");
 			}
+#else
+			pr_err("Ignoring bhi; depends on FINEIBT_BHI=y.\n");
+#endif
 		} else {
 			pr_err("Ignoring unknown cfi option (%s).", str);
 		}


