Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A07A44EE4A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Nov 2021 22:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhKLVGB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Nov 2021 16:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbhKLVGB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Nov 2021 16:06:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20996C061766;
        Fri, 12 Nov 2021 13:03:10 -0800 (PST)
Date:   Fri, 12 Nov 2021 21:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636750988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+0eCd/uTf3OkYcn+N0cg5m3bti9dC+FFsLPssvtWEs=;
        b=gbUxfdcgQdG+fqoJurkdVJftSWAhEEsQFvxgA+PdNq7x71EjQedOUaVPpQz2sPmVOFVPaA
        pPoCZ32iWu/lAph5RPlvl5ytMBGTb0g1VsPPkKfa6xz/s5KMzPlCWV9vRyf+vzcFElfvZe
        GAyopuPqTSg/t3+mtAgeZvQAN9Ma4FLflmeuXQob9BlvxloSQBd1f4Eu4XVb1Hw791G8A9
        o2iOHwo42uVhc8XGkl1p2TxGBqd0HiP6kLMjQxfIJiIhB3LLpYO356AjuTtPg54ixhyHF/
        MWILE8LHEiM6X7gAGei9ZZj0EvPFuLY6hQfxfFcM5Lxx2fPSRV01dr4jlx8SUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636750988;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+0eCd/uTf3OkYcn+N0cg5m3bti9dC+FFsLPssvtWEs=;
        b=EQJf8Gl9Dn926bS8ssxY6wbvOltIRnsmEZt558NoDkQ2xx38mMeALRVO24CRXy8ebOPKAG
        OWC7bu/unOk3LmBA==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/cpu: Add Raptor Lake to Intel family
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211112182835.924977-1-tony.luck@intel.com>
References: <20211112182835.924977-1-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <163675098743.414.13524984324100742080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fbdb5e8f2926ae9636c9fa6f42c7426132ddeeb2
Gitweb:        https://git.kernel.org/tip/fbdb5e8f2926ae9636c9fa6f42c7426132ddeeb2
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 12 Nov 2021 10:28:35 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 12 Nov 2021 11:46:06 -08:00

x86/cpu: Add Raptor Lake to Intel family

Add model ID for Raptor Lake.

[ dhansen: These get added as soon as possible so that folks doing
  development can leverage them. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20211112182835.924977-1-tony.luck@intel.com
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 2715843..5a0bcf8 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -108,6 +108,8 @@
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 
+#define INTEL_FAM6_RAPTOR_LAKE		0xB7
+
 /* "Small Core" Processors (Atom) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
