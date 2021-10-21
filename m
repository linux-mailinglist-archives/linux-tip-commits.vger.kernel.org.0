Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B0543656C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhJUPPB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJUPOx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D575C061227;
        Thu, 21 Oct 2021 08:12:36 -0700 (PDT)
Date:   Thu, 21 Oct 2021 15:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8KkREi01Se7H2PPBvalT0CivTHMt/XBve/a9sb1RyU=;
        b=SlEMxyomzovu0H4rh5Wl9JxU5bnW8rXyYC7vsORLYE2P6/KVR9JYg5u/wbvqdf1RkD8jqp
        jJ+P8sH2a2sqOMS/Xqs4qQZoraIDcV4esKbzKyDg7bu5JTIrgeIk8d3V7VqeBKh17VqBge
        XF6uquQqJ1Scc/Xe+aO1sv2zxzgCe6+oadt44KVfoe7INuS20FKcnV5aHojZSAQZmTqWQc
        8xhvWGxZm41EmPB4RX/83SVSa5mm/GpAtic1t8EmXc0m6YP6byGq8KrWnkfYa5zbmQmI5+
        Iwdg0DMci0dfqxwk2aIPXFwWRcqNWv5TT7/f69j3nc3bb0hvnfWlM9VLRr35Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o8KkREi01Se7H2PPBvalT0CivTHMt/XBve/a9sb1RyU=;
        b=bsu8RijrghU50Zis2Kq1CZZIPntKoFw7fPRUdR14Y0d0oxG567owygu3WBFpGLVUR8ynNs
        YNypqMZZSvtESXAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Convert tracing to fpstate
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.503327333@linutronix.de>
References: <20211013145322.503327333@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482915408.25758.4947021696478772290.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     cceb496420fa11a6e11989abc68b8e7564dc40f9
Gitweb:        https://git.kernel.org/tip/cceb496420fa11a6e11989abc68b8e7564dc40f9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:34 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 22:35:04 +02:00

x86/fpu: Convert tracing to fpstate

Convert FPU tracing code to the new register storage mechanism in
preparation for dynamically sized buffers.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.503327333@linutronix.de
---
 arch/x86/include/asm/trace/fpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/trace/fpu.h b/arch/x86/include/asm/trace/fpu.h
index 879b777..4645a63 100644
--- a/arch/x86/include/asm/trace/fpu.h
+++ b/arch/x86/include/asm/trace/fpu.h
@@ -22,8 +22,8 @@ DECLARE_EVENT_CLASS(x86_fpu,
 		__entry->fpu		= fpu;
 		__entry->load_fpu	= test_thread_flag(TIF_NEED_FPU_LOAD);
 		if (boot_cpu_has(X86_FEATURE_OSXSAVE)) {
-			__entry->xfeatures = fpu->state.xsave.header.xfeatures;
-			__entry->xcomp_bv  = fpu->state.xsave.header.xcomp_bv;
+			__entry->xfeatures = fpu->fpstate->regs.xsave.header.xfeatures;
+			__entry->xcomp_bv  = fpu->fpstate->regs.xsave.header.xcomp_bv;
 		}
 	),
 	TP_printk("x86/fpu: %p load: %d xfeatures: %llx xcomp_bv: %llx",
