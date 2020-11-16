Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA942B4B8D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 17:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgKPQo7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 11:44:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42256 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729645AbgKPQo7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 11:44:59 -0500
Date:   Mon, 16 Nov 2020 16:44:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605545097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0F9DWkx/uxEZH3vSu2wV0DsB7ElZv3L7hkTxeVg3vIY=;
        b=tB1cLbMiHUcbv50D03dt9djxXLpr3KJ0lzK3BTVFQo/7W2jy3zY0VCCptzX/m6sKw9aZfu
        XuVf03AItjcxdm4Rl+SaC8bbo/CDkize0zjkV6t/Wnb7HB/XKCWZHQWmLkvAWwoLbRz/gf
        13COpW3VWluLa+j7Aopf7OCc2GJmQUOKxGLVN6gPI48jmEcI6jvAwN1z9kb+PZkxUpERcV
        yxCtk236ELbraAeDH4iAU5NfuTDd7SI+MITS6ZyURj6pLQWWQhJkaoeYR5UqNhLefMudb9
        pwOXPh3Wzk+GJ81vc4RWxWMc++KbFkxLUftU19mLRZEEcrhudg/eacdJaXPPVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605545097;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0F9DWkx/uxEZH3vSu2wV0DsB7ElZv3L7hkTxeVg3vIY=;
        b=F/YPYk5/gB4SguXF2h9+nmj6wYRFVKAodTuD1HS5QRO/cDCPxwao96wwUbo3dDjzKewl0Y
        yH1JiZ1C0vZb0ZBQ==
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Use "safe" MSR functions when enabling
 additional error logging
Cc:     Qian Cai <cai@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201111003954.GA11878@agluck-desk2.amr.corp.intel.com>
References: <20201111003954.GA11878@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Message-ID: <160554509642.11244.15619784651926454924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     098416e6986127f7e4c8ce4fd6bbbd80e55b0386
Gitweb:        https://git.kernel.org/tip/098416e6986127f7e4c8ce4fd6bbbd80e55b0386
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Tue, 10 Nov 2020 16:39:54 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 16 Nov 2020 17:34:08 +01:00

x86/mce: Use "safe" MSR functions when enabling additional error logging

Booting as a guest under KVM results in error messages about
unchecked MSR access:

  unchecked MSR access error: RDMSR from 0x17f at rIP: 0xffffffff84483f16 (mce_intel_feature_init+0x156/0x270)

because KVM doesn't provide emulation for random model specific
registers.

Switch to using rdmsrl_safe()/wrmsrl_safe() to avoid the message.

Fixes: 68299a42f842 ("x86/mce: Enable additional error logging on certain Intel CPUs")
Reported-by: Qian Cai <cai@redhat.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20201111003954.GA11878@agluck-desk2.amr.corp.intel.com
---
 arch/x86/kernel/cpu/mce/intel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index b47883e..c2476fe 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -521,9 +521,10 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 	case INTEL_FAM6_SANDYBRIDGE_X:
 	case INTEL_FAM6_IVYBRIDGE_X:
 	case INTEL_FAM6_HASWELL_X:
-		rdmsrl(MSR_ERROR_CONTROL, error_control);
+		if (rdmsrl_safe(MSR_ERROR_CONTROL, &error_control))
+			return;
 		error_control |= 2;
-		wrmsrl(MSR_ERROR_CONTROL, error_control);
+		wrmsrl_safe(MSR_ERROR_CONTROL, error_control);
 		break;
 	}
 }
