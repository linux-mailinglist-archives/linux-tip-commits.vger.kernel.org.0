Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53743B6CB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 26 Oct 2021 18:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbhJZQTJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 26 Oct 2021 12:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbhJZQTG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 26 Oct 2021 12:19:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA84C061745;
        Tue, 26 Oct 2021 09:16:42 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:16:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635265001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlvrxUu6IIiD5MlvAZcm0piFntGYxoWLlbxvaEZWE5o=;
        b=xkFyC10w76D13svuLH0FRBuheFG3pX8TMG6PMjVmvc2hEnDXP7sTJ3wYj5kFjgPD4liDdR
        eQTRrj1CynQKw8pDE62jnItESKCH5VTmaPmz3WhhjliQy6oMCrb0HfIf+AegIqxVyQmD1L
        bcvxc78CdNFlsq1JMUUL3+vaohsYNKHAhzll4f17ijqvu28K5n4vhaDVa7F86KDnVXuMZN
        37yxa/DMR4C49d05DtOdDBYbGbIc6hWHBLD+pm7jPY7PCtVWqJeNOqXfVXdxSTxl6W5wsN
        Eh9r6NXYPyxkmSmglgumCUYg6EYQrdMfnPKOKqHuW+aaJHmLNdve2YzRxJwnLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635265001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlvrxUu6IIiD5MlvAZcm0piFntGYxoWLlbxvaEZWE5o=;
        b=wFlADc5aJvKcbATYT53RbmWckq1yUJgCn3flA2LPcy12lB1DKQWxAkOI1mntPqfH0P8PDJ
        tOf/E7axJmpincBQ==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/msr-index: Add MSRs for XFD
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211021225527.10184-14-chang.seok.bae@intel.com>
References: <20211021225527.10184-14-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <163526500059.626.2379111553914327176.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     dae1bd58389615d401a84aedc38fa075ef8f7de6
Gitweb:        https://git.kernel.org/tip/dae1bd58389615d401a84aedc38fa075ef8f7de6
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Thu, 21 Oct 2021 15:55:17 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 26 Oct 2021 10:18:09 +02:00

x86/msr-index: Add MSRs for XFD

XFD introduces two MSRs:

    - IA32_XFD to enable/disable a feature controlled by XFD

    - IA32_XFD_ERR to expose to the #NM trap handler which feature
      was tried to be used for the first time.

Both use the same xstate-component bitmap format, used by XCR0.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211021225527.10184-14-chang.seok.bae@intel.com
---
 arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index a7c4134..01e2650 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -625,6 +625,8 @@
 
 #define MSR_IA32_BNDCFGS_RSVD		0x00000ffc
 
+#define MSR_IA32_XFD			0x000001c4
+#define MSR_IA32_XFD_ERR		0x000001c5
 #define MSR_IA32_XSS			0x00000da0
 
 #define MSR_IA32_APICBASE		0x0000001b
