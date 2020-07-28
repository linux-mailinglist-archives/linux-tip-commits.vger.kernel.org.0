Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0877230A06
	for <lists+linux-tip-commits@lfdr.de>; Tue, 28 Jul 2020 14:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgG1M3J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 28 Jul 2020 08:29:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34314 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgG1M3I (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 28 Jul 2020 08:29:08 -0400
Date:   Tue, 28 Jul 2020 12:29:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595939346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2dW8clZS1g94ais6wvu0XRIVao5VKKeDyjpkytvs4Dg=;
        b=OxEfyRKtUS1FC5b88Zrl0qpiezf6Sb/JovXzrPadDt6AsyEcaflX4w5L44Fq+diRiA02fh
        QVkc27WReGuynkSjHIQZRRqoUslqZTjdmLNZjkvLRAbmz4dzLfT5Gq7xEhh3ZQngdIPN4b
        s+Kwi3TcTLdJFmIw9ZaK49hC8jxhXIokePHcdPxMOI0EyI3k8lzGVrbEU5QE5xk4hL1f1e
        52WqRPdAZ37oCQ79OtBXJL1jjsZz3o98G6ydkKqUHoLXkyFxpiStvOvUMGJauCMjRUqWvU
        gXTnyUZuR43/JdGqzi+XYQIJY6VFuLGlESak+xC9W0pfv1VL6rK9FoHHlnNaSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595939346;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2dW8clZS1g94ais6wvu0XRIVao5VKKeDyjpkytvs4Dg=;
        b=7B+2pdI5hveWCFLKxfOWln4BOSIfwBlez5AYD8KD6ByX7vwj/AYgUhMMpudX+rfMd+VH0U
        s0a/j0qmHPkOtoAw==
From:   "tip-bot2 for Pu Wen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Add Hygon Fam18h RAPL support
Cc:     Pu Wen <puwen@hygon.cn>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720082205.1307-1-puwen@hygon.cn>
References: <20200720082205.1307-1-puwen@hygon.cn>
MIME-Version: 1.0
Message-ID: <159593934554.4006.16034988515761128072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d903b6d029d66e6478562d75ea18d89098f7b7e8
Gitweb:        https://git.kernel.org/tip/d903b6d029d66e6478562d75ea18d89098f7b7e8
Author:        Pu Wen <puwen@hygon.cn>
AuthorDate:    Mon, 20 Jul 2020 16:22:05 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 28 Jul 2020 13:34:20 +02:00

perf/x86/rapl: Add Hygon Fam18h RAPL support

Hygon Family 18h(Dhyana) support RAPL in bit 14 of CPUID 0x80000007 EDX,
and has MSRs RAPL_PWR_UNIT/CORE_ENERGY_STAT/PKG_ENERGY_STAT. So add Hygon
Dhyana Family 18h support for RAPL.

The output is available via the energy-pkg pseudo event:

  $ perf stat -a -I 1000 --per-socket -e power/energy-pkg/

[ mingo: Tidied up the initializers. ]

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200720082205.1307-1-puwen@hygon.cn
---
 arch/x86/events/rapl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 0f2bf59..68b3882 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -787,7 +787,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
-	X86_MATCH_VENDOR_FAM(AMD, 0x17, &model_amd_fam17h),
+	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
+	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
