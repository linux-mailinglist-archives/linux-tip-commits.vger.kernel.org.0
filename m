Return-Path: <linux-tip-commits+bounces-5897-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8701AE733A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Jun 2025 01:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD9E5A0AEF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Jun 2025 23:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A43526C38D;
	Tue, 24 Jun 2025 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="th4euE7P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uIT7TDON"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A266626B771;
	Tue, 24 Jun 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750807864; cv=none; b=OvIfAbKFgrF+OEZFLBWkpHgG4g6fZGcsBbYdDj0Cd9JFn99M/yp8To/CDNgdUpwFHq82NGhUONxPHJX+tApuTEY6Dw8OdZn8kQtKmzV5DZG0wk2r/54q4h12Jm4SCQOOljlwI2frR+IGft+MHpE1gVizmPE2sCKBBf2Gx/X47Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750807864; c=relaxed/simple;
	bh=4O40vlPQ5FwPdi61inOO3M+s7yLVz8qJ++RB9q/Rnzw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=fhAaVnMvp4McqStOj2TkIh7hCfuw6JlKtHUaPIp+KACWXez+MP+ZeadouFrtJmU8iXwZcupaccntn61/XcFlG+n68hQhbinR8GcDjEcch+27XomQzFdA/yzlM7T+L7I+qcjv80SDgpz/Ue0F6vUmhLo7aagGm2pWULfksu+rfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=th4euE7P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uIT7TDON; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Jun 2025 23:30:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750807860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1a7xfKCc9RxGk/byw8ae5nKalQ1bFv0UaR7J8mFca7g=;
	b=th4euE7Px6FasBcfRKuXEOD98UkWhCMwmboTwh1KVDZ15uFbJdE08tBVNeNQF6fSvNiGMr
	by8+Up2ZRjmOfa6+irTvwoVX+Ow/7kF5lVMGYCVmNDiXX3G6Epq+b1rALT/uKSWZG0LYrF
	Hm5Jy1TB7MLm2qsN9DxD7yN/MXHiDUM7qKer0FcooiQu91ej4nzt71LBLRU5vOjSehwUVz
	8OVnNjzoDU3gElsgvgePRMCKR5bh2LMXoQOHz1PFjtd9wLLXBGJC3rDyoaKozPUU4lTu7c
	UO81PPgip5d9C+fmIm8aDvAA1wls+hIPCxJycXZuXrxFCzWDGVbwQLf/cW+m1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750807860;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1a7xfKCc9RxGk/byw8ae5nKalQ1bFv0UaR7J8mFca7g=;
	b=uIT7TDONVfwZw9NZI0X7CG7XvcA5vIdu9rqBlMR+H3182w0OkpA2b3oImg++5YPFZVlmdu
	OC9t3BA4Bxfo+HAw==
From: "tip-bot2 for Chao Gao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/fpu] x86/fpu: Initialize guest FPU permissions from guest defaults
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Chao Gao <chao.gao@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, John Allen <john.allen@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175080785981.406.5093475254017480218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     7c2c89364d9219f3a31a9a930476de5c154f13bd
Gitweb:        https://git.kernel.org/tip/7c2c89364d9219f3a31a9a930476de5c154f13bd
Author:        Chao Gao <chao.gao@intel.com>
AuthorDate:    Thu, 22 May 2025 08:10:05 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 24 Jun 2025 13:46:32 -07:00

x86/fpu: Initialize guest FPU permissions from guest defaults

Currently, fpu->guest_perm is copied from fpu->perm, which is derived from
fpu_kernel_cfg.default_features.

Guest defaults were introduced to differentiate the features and sizes of
host and guest FPUs. Copying guest FPU permissions from the host will lead
to inconsistencies between the guest default features and permissions.

Initialize guest FPU permissions from guest defaults instead of host
defaults. This ensures that any changes to guest default features are
automatically reflected in guest permissions, which in turn guarantees
that fpstate_realloc() allocates a correctly sized XSAVE buffer for guest
FPUs.

Suggested-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: John Allen <john.allen@amd.com>
Link: https://lore.kernel.org/all/20250522151031.426788-3-chao.gao%40intel.com
---
 arch/x86/kernel/fpu/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index aa72523..94706a5 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -562,8 +562,14 @@ void fpstate_reset(struct fpu *fpu)
 	fpu->perm.__state_perm		= fpu_kernel_cfg.default_features;
 	fpu->perm.__state_size		= fpu_kernel_cfg.default_size;
 	fpu->perm.__user_state_size	= fpu_user_cfg.default_size;
-	/* Same defaults for guests */
-	fpu->guest_perm = fpu->perm;
+
+	fpu->guest_perm.__state_perm	= guest_default_cfg.features;
+	fpu->guest_perm.__state_size	= guest_default_cfg.size;
+	/*
+	 * User features and sizes are always identical between host and
+	 * guest FPUs, which allows for common guest and userspace ABI.
+	 */
+	fpu->guest_perm.__user_state_size = fpu_user_cfg.default_size;
 }
 
 static inline void fpu_inherit_perms(struct fpu *dst_fpu)

