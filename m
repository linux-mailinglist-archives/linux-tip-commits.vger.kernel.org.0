Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8B13656A4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhDTKr3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhDTKrX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEBEC06138B;
        Tue, 20 Apr 2021 03:46:51 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AO491vXjjhMrfVxs56pfRXYQCcaVRfRKiiKdFva/ObU=;
        b=0YhTRZDg2lkxdZZ3CYoWhVo4wuB5wqJManz3rO0f5dpnzPKxzcwthi1VDJ6UpOCTGsrqZD
        ZnnddK31BZjt1D/Cpu4K9Ibr7MJVbbnlgPJt3UeNFpFV7djtiHMg/lvOmdFXml22pYSyxZ
        KT+6KxnHbhfBMPAjRJXhXPChyC6m9sRdjx8e1OnEJdZZejNJP7UlMh4Fr8MmGtJw97BKMM
        gPxyxDs5LXiWZsrtmdjz1VK+QX7kPyyeexpoYkJyVJLr98MAVSAfrxqYsa4u/FtmI10iOO
        A8IEBghYVJwuvgfYplr3TLqLZDtYv3k234bJv6UKjH69rGNxnZAkfZ6gEYY+3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AO491vXjjhMrfVxs56pfRXYQCcaVRfRKiiKdFva/ObU=;
        b=FoXZ6COLCNgviuhLfQ5aXZ3O+lEpA5iI2s5Ol+4VenYq+HeJi2I8XdhqqXpXHTmY37q4Z8
        iJPC03W6sh5MZEDA==
From:   "tip-bot2 for Ricardo Neri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpufeatures: Enumerate Intel Hybrid Technology
 feature bit
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Len Brown <len.brown@intel.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-2-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560991.29796.2281635989443029592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a161545ab53b174c016b0eb63c2895266665d2f6
Gitweb:        https://git.kernel.org/tip/a161545ab53b174c016b0eb63c2895266665d2f6
Author:        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:41 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:23 +02:00

x86/cpufeatures: Enumerate Intel Hybrid Technology feature bit

Add feature enumeration to identify a processor with Intel Hybrid
Technology: one in which CPUs of more than one type are the same package.
On a hybrid processor, all CPUs support the same homogeneous (i.e.,
symmetric) instruction set. All CPUs enumerate the same features in CPUID.
Thus, software (user space and kernel) can run and migrate to any CPU in
the system as well as utilize any of the enumerated features without any
change or special provisions. The main difference among CPUs in a hybrid
processor are power and performance properties.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1618237865-33448-2-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26..1ba4a6e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -374,6 +374,7 @@
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
+#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of more than one type */
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
