Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE70B3B2323
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhFWWMW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39932 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFWWLn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:43 -0400
Date:   Wed, 23 Jun 2021 22:09:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486163;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0bX4XKuyETiRDyaBEz7xRhK0/3Kd8WT41hDsQB67JM=;
        b=lMStp3oK+74vlv4nRv4PdEtwV/6A8YOdkkrtnsyP6lxbmVtKZS0VQouhAJlBiSl2tBZY+l
        E9yUCxa9EPPOUp6i3tip7Vs1KYjfBu5cXvi/lkZojqo2BrGUViMeyCxHdxJ3NC1wf+7JM9
        xkXsGNtXr2uDSANBghFd8ZJXaokoMuk8s+9m5Df3aORgctwv4Ee8Gb46XfniVUG1wDLhck
        JRiSw5smY1bsISrrQXhEHkBOcyrjJA6QFf/ZC9UQLUNr7c2K6bItImv2LjKwS3PZvdeyk9
        1EktESSqf1nYXWhsetY1neQj5JYsPl6R+FrriVMnbXuRtwsdLgFSXtd5Ml/QpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486163;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0bX4XKuyETiRDyaBEz7xRhK0/3Kd8WT41hDsQB67JM=;
        b=Hz3t1adnf7iiV1Pt/BQzjpEzndS2ifVuWCdFjLdpVRld4+iWgNSZhrHSr/6OMspkZ8VkVl
        /7hcYpkurQJT+/DA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/math-emu: Rename frstor()
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.111665161@linutronix.de>
References: <20210623121454.111665161@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616263.395.11416020906576084204.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     872c65dbf669b3b471b3d8656391a6b4f736d22b
Gitweb:        https://git.kernel.org/tip/872c65dbf669b3b471b3d8656391a6b4f736d22b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:55 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:16:33 +02:00

x86/math-emu: Rename frstor()

This is in the way of renaming the low level hardware accessors to match
the instruction name. Prepend it with FPU_ which is consistent vs. the
rest of the emulation code.

No functional change.

  [ bp: Correct the Reported-by: ]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121454.111665161@linutronix.de
---
 arch/x86/math-emu/fpu_proto.h  | 2 +-
 arch/x86/math-emu/load_store.c | 2 +-
 arch/x86/math-emu/reg_ld_str.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/math-emu/fpu_proto.h b/arch/x86/math-emu/fpu_proto.h
index 70d35c2..94c4023 100644
--- a/arch/x86/math-emu/fpu_proto.h
+++ b/arch/x86/math-emu/fpu_proto.h
@@ -144,7 +144,7 @@ extern int FPU_store_int16(FPU_REG *st0_ptr, u_char st0_tag, short __user *d);
 extern int FPU_store_bcd(FPU_REG *st0_ptr, u_char st0_tag, u_char __user *d);
 extern int FPU_round_to_int(FPU_REG *r, u_char tag);
 extern u_char __user *fldenv(fpu_addr_modes addr_modes, u_char __user *s);
-extern void frstor(fpu_addr_modes addr_modes, u_char __user *data_address);
+extern void FPU_frstor(fpu_addr_modes addr_modes, u_char __user *data_address);
 extern u_char __user *fstenv(fpu_addr_modes addr_modes, u_char __user *d);
 extern void fsave(fpu_addr_modes addr_modes, u_char __user *data_address);
 extern int FPU_tagof(FPU_REG *ptr);
diff --git a/arch/x86/math-emu/load_store.c b/arch/x86/math-emu/load_store.c
index f15263e..4092df7 100644
--- a/arch/x86/math-emu/load_store.c
+++ b/arch/x86/math-emu/load_store.c
@@ -240,7 +240,7 @@ int FPU_load_store(u_char type, fpu_addr_modes addr_modes,
 		   fix-up operations. */
 		return 1;
 	case 022:		/* frstor m94/108byte */
-		frstor(addr_modes, (u_char __user *) data_address);
+		FPU_frstor(addr_modes, (u_char __user *) data_address);
 		/* Ensure that the values just loaded are not changed by
 		   fix-up operations. */
 		return 1;
diff --git a/arch/x86/math-emu/reg_ld_str.c b/arch/x86/math-emu/reg_ld_str.c
index 7ca6417..7e4521f 100644
--- a/arch/x86/math-emu/reg_ld_str.c
+++ b/arch/x86/math-emu/reg_ld_str.c
@@ -1117,7 +1117,7 @@ u_char __user *fldenv(fpu_addr_modes addr_modes, u_char __user *s)
 	return s;
 }
 
-void frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
+void FPU_frstor(fpu_addr_modes addr_modes, u_char __user *data_address)
 {
 	int i, regnr;
 	u_char __user *s = fldenv(addr_modes, data_address);
