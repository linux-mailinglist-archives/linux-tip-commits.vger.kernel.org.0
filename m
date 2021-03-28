Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8393734BF59
	for <lists+linux-tip-commits@lfdr.de>; Sun, 28 Mar 2021 23:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhC1VdE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 28 Mar 2021 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhC1Vci (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 28 Mar 2021 17:32:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B375CC061756;
        Sun, 28 Mar 2021 14:32:38 -0700 (PDT)
Date:   Sun, 28 Mar 2021 21:32:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616967156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urgrEUl+T5taYfX5jS8od8HlfQHJDAG6faAvbnUyjSo=;
        b=1iD+q4GNpWjkLsBspgniQEwOA3SpIkQzw+69M0GgMb4rXfFlK0oWVtIKfnTIeYxWBFk0Qk
        ktXrNnt42TKjpZtsJc7cssMKsgmKk1e41joaeXwe8JFXHgD4k+vWe6LTCtzDaQ70OM/uKc
        JuPA0jKuKIZr97nHY9RgIo8u3TCZlinVwFNCYwItAuaa0rVsikDE6izVTy/iFonqOvYxXM
        gT9aEQNQmkL0GXhF8NrLp1aztkhgvwQamotemqI1WFdwTSnBgYquBWPKeCkHsXhRXRfN1b
        0B5snZdwS+oheITCnl5Ejqvw+B3cZU8U7Mpt1S2dVo4pTC3ggX/ruIwq4yLtuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616967156;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=urgrEUl+T5taYfX5jS8od8HlfQHJDAG6faAvbnUyjSo=;
        b=PtDeY5nBsZ4SZRfVI8tHN/Z08RXuZyPUmqWqxA4xh3P20c4csYIKGs5weHFydGBlzYdgp5
        V9W2+InmxHuu99BQ==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/splitlock] x86/cpufeatures: Enumerate #DB for bus lock detection
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210322135325.682257-2-fenghua.yu@intel.com>
References: <20210322135325.682257-2-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <161696715635.398.15688697788476965899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/splitlock branch of tip:

Commit-ID:     f21d4d3b97a8603567e5d4250bd75e8ebbd520af
Gitweb:        https://git.kernel.org/tip/f21d4d3b97a8603567e5d4250bd75e8ebbd520af
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 22 Mar 2021 13:53:23 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 28 Mar 2021 22:52:14 +02:00

x86/cpufeatures: Enumerate #DB for bus lock detection

A bus lock is acquired through either a split locked access to writeback
(WB) memory or any locked access to non-WB memory. This is typically >1000
cycles slower than an atomic operation within a cache line. It also
disrupts performance on other cores.

Some CPUs have the ability to notify the kernel by a #DB trap after a user
instruction acquires a bus lock and is executed. This allows the kernel to
enforce user application throttling or mitigation. Both breakpoint and bus
lock can trigger the #DB trap in the same instruction and the ordering of
handling them is the kernel #DB handler's choice.

The CPU feature flag to be shown in /proc/cpuinfo will be "bus_lock_detect".

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20210322135325.682257-2-fenghua.yu@intel.com

---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26..faec3d9 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -354,6 +354,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
