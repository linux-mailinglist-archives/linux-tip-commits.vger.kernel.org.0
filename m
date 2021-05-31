Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE4C395794
	for <lists+linux-tip-commits@lfdr.de>; Mon, 31 May 2021 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhEaI5c (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 31 May 2021 04:57:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhEaI5a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 31 May 2021 04:57:30 -0400
Date:   Mon, 31 May 2021 08:55:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622451349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OaXq7w/Q+KUtGPB7j8sfswDcr08nsePPn2APY7DbJQQ=;
        b=2jiW/AV6I3VQtFwhTEOS+0GHY6tj3EEiU0h4dIt6Lhl+Lz+00FN5rxzXZRh6+t6R7LaTWL
        SeKxTMvkwesva5BOsDaYGsLkoMw1bcg/sD9kiIZIn5eBOjzEamYIa/C6hex6uka8CtH1y9
        H26qVpU8stksTzwvLe1N/Obg9uefENONSN6PfCudXsnHPz7HxEN9Rp+h6MFF3sW1ZGlf6Y
        GYCnkgtahxWJ/NRN8geGdkRcvEu3K76d1K71MUeNhLsnvAMtrImkEWSmnxxsZs7rky5F2S
        idqYTvR8TMnXEDo/oi0atTbr49hINLCNc545ZIe39Xk1ROvJd3hf6HOc8igj/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622451349;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OaXq7w/Q+KUtGPB7j8sfswDcr08nsePPn2APY7DbJQQ=;
        b=oZNPuADqkZK3IMgBtYL2tEiz92qgeJOVER9MjeQ7wj90THfW9/ssyKICW5GR7exXJVX6gd
        GexiStCp6SciLyDA==
From:   "tip-bot2 for Pu Wen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cstate: Allow ACPI C1 FFH MWAIT use on Hygon systems
Cc:     Pu Wen <puwen@hygon.cn>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210528081417.31474-1-puwen@hygon.cn>
References: <20210528081417.31474-1-puwen@hygon.cn>
MIME-Version: 1.0
Message-ID: <162245134873.29796.1219713411989119535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     280b68a3b3b96b027fcdeb5a3916a8e2aaf84d03
Gitweb:        https://git.kernel.org/tip/280b68a3b3b96b027fcdeb5a3916a8e2aaf84d03
Author:        Pu Wen <puwen@hygon.cn>
AuthorDate:    Fri, 28 May 2021 16:14:17 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 31 May 2021 10:47:04 +02:00

x86/cstate: Allow ACPI C1 FFH MWAIT use on Hygon systems

Hygon systems support the MONITOR/MWAIT instructions and these can be
used for ACPI C1 in the same way as on AMD and Intel systems.

The BIOS declares a C1 state in _CST to use FFH and CPUID_Fn00000005_EDX
is non-zero on Hygon systems.

Allow ffh_cstate_init() to succeed on Hygon systems to default using FFH
MWAIT instead of HALT for ACPI C1.

Signed-off-by: Pu Wen <puwen@hygon.cn>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210528081417.31474-1-puwen@hygon.cn
---
 arch/x86/kernel/acpi/cstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 49ae4e1..7de599e 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -197,7 +197,8 @@ static int __init ffh_cstate_init(void)
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	if (c->x86_vendor != X86_VENDOR_INTEL &&
-	    c->x86_vendor != X86_VENDOR_AMD)
+	    c->x86_vendor != X86_VENDOR_AMD &&
+	    c->x86_vendor != X86_VENDOR_HYGON)
 		return -1;
 
 	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
