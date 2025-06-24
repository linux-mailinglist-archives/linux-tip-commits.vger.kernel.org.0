Return-Path: <linux-tip-commits+bounces-5895-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C8AE7334
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 01:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804731BC2ABC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9CD26B768;
	Tue, 24 Jun 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ldRC1JfU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0favyQSR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8B2253EA;
	Tue, 24 Jun 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807862; cv=none; b=G4xJd2sH8uQaoRCQ3Iu9d7oZvdTisJ/4BPkcRHAaMNNf/JocwJvR4jjYR7okJJN8Y0NsZfJUaHvB+BynuLWhL4ynk3RtoIy6gF5kgBdJSFoifp1Y6K0aoTYeL167DQ7JngX373pdhqslEA2rMpqE4Ol7ETO6+iru8VZAxt8w/RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807862; c=relaxed/simple;
	bh=Hvq02NZ7AQM//u5hZten7ikyJfmTtJjuuqkSklyINPI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=kyolQ71T6nQazWG+GX3u3ydQONf8NVoZ6HwVrU/8gp1sP9MTOXaCkB/m5dtjfyhRh9bdlK6Re6IFzJf9eZqw2ceVvzs4epv6N2aIK+Wh9G7N6/sfSqe96ZAM9Dkaa56/60pxn7xirPDANzb9O7lZey6zDYqfzrPej5y2TWIv6OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ldRC1JfU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0favyQSR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 23:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750807858;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8kqLHpe4AO4EEqTPgBATXLb/SQlj25iyEeHuGRNQ9Yk=;
	b=ldRC1JfUG7uGvTt0rlnBI2BcRvN7UnTibb+oE96RhiIcASvida1I10fsOfx6OZI1D0D8oZ
	u+0aheM98z+CdOaqLZJWBwdTK3RuIHenpgXrzr0FIyFLY4xFqVIz2gTv7l4/L4UDENf9t4
	4sE5VblHawZfL0sUiKbeTB80UfYjoMJ1/5IdFare0rPHy1XoI2Rhba/+SDAPL2cghIxHJN
	VdazaaMEzypj+45DPQvha4p5jjhombYmUpgjuWmkVMZZIaLPdZZd9Mb5e98+PbyNXZThX4
	th0kPOo0WSXd2a9JC9+rqwMGtkhHmlO43wVOZ1tfe4Bwd4PmOB2bzx8MIyAeOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750807858;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8kqLHpe4AO4EEqTPgBATXLb/SQlj25iyEeHuGRNQ9Yk=;
	b=0favyQSRRLKu8/HTEL5zr/UmzIarhRQm8yQnvPUlTIPg2JuQL+SJjUltwTo4jEUBigUpm/
	LQMKQjn5rwiPfECw==
From: "tip-bot2 for Chao Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove xfd argument from __fpstate_reset()
Cc: Sean Christopherson <seanjc@google.com>, Chao Gao <chao.gao@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, John Allen <john.allen@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175080785791.406.7237637688812808937.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     fafb29e18db2eef75edafd4240fcde8b5da2c948
Gitweb:        https://git.kernel.org/tip/fafb29e18db2eef75edafd4240fcde8b5da2c948
Author:        Chao Gao <chao.gao@intel.com>
AuthorDate:    Thu, 22 May 2025 08:10:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Jun 2025 13:46:32 -07:00

x86/fpu: Remove xfd argument from __fpstate_reset()

The initial values for fpstate::xfd differ between guest and host fpstates.
Currently, the initial values are passed as an argument to
__fpstate_reset(). But, __fpstate_reset() already assigns different default
features and sizes based on the type of fpstates (i.e., guest or host). So,
handle fpstate::xfd in a similar way to highlight the differences in the
initial xfd value between guest and host fpstates

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: John Allen <john.allen@amd.com>
Link: https://lore.kernel.org/all/aBuf7wiiDT0Wflhk@google.com/
Link: https://lore.kernel.org/all/20250522151031.426788-5-chao.gao%40intel.com
---
 arch/x86/kernel/fpu/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index e027051..aefd412 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -218,7 +218,7 @@ void fpu_reset_from_exception_fixup(void)
 }
 
 #if IS_ENABLED(CONFIG_KVM)
-static void __fpstate_reset(struct fpstate *fpstate, u64 xfd);
+static void __fpstate_reset(struct fpstate *fpstate);
 
 static void fpu_lock_guest_permissions(void)
 {
@@ -253,8 +253,7 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	fpstate->is_valloc	= true;
 	fpstate->is_guest	= true;
 
-	/* Leave xfd to 0 (the reset value defined by spec) */
-	__fpstate_reset(fpstate, 0);
+	__fpstate_reset(fpstate);
 	fpstate_init_user(fpstate);
 
 	gfpu->fpstate		= fpstate;
@@ -545,7 +544,7 @@ void fpstate_init_user(struct fpstate *fpstate)
 		fpstate_init_fstate(fpstate);
 }
 
-static void __fpstate_reset(struct fpstate *fpstate, u64 xfd)
+static void __fpstate_reset(struct fpstate *fpstate)
 {
 	/*
 	 * Supervisor features (and thus sizes) may diverge between guest
@@ -553,25 +552,29 @@ static void __fpstate_reset(struct fpstate *fpstate, u64 xfd)
 	 * for guests despite not being utilized by the host. User
 	 * features and sizes are always identical, which allows for
 	 * common guest and userspace ABI.
+	 *
+	 * For the host, set XFD to the kernel's desired initialization
+	 * value. For guests, set XFD to its architectural RESET value.
 	 */
 	if (fpstate->is_guest) {
 		fpstate->size		= guest_default_cfg.size;
 		fpstate->xfeatures	= guest_default_cfg.features;
+		fpstate->xfd		= 0;
 	} else {
 		fpstate->size		= fpu_kernel_cfg.default_size;
 		fpstate->xfeatures	= fpu_kernel_cfg.default_features;
+		fpstate->xfd		= init_fpstate.xfd;
 	}
 
 	fpstate->user_size	= fpu_user_cfg.default_size;
 	fpstate->user_xfeatures	= fpu_user_cfg.default_features;
-	fpstate->xfd		= xfd;
 }
 
 void fpstate_reset(struct fpu *fpu)
 {
 	/* Set the fpstate pointer to the default fpstate */
 	fpu->fpstate = &fpu->__fpstate;
-	__fpstate_reset(fpu->fpstate, init_fpstate.xfd);
+	__fpstate_reset(fpu->fpstate);
 
 	/* Initialize the permission related info in fpu */
 	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;

