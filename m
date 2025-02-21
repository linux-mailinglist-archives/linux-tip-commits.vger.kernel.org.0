Return-Path: <linux-tip-commits+bounces-3566-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B21A3F69B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38093A5EB3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 13:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B9320B7EC;
	Fri, 21 Feb 2025 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EDE2ptX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcfWQky1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D3192B74;
	Fri, 21 Feb 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740146207; cv=none; b=VefwxZvu74x9mVMbw0u4yRlvG2GXOADDLNFeqbiP5a6EuOTgKXUjF0cZ0aRxMXgKyy3Qe+JBQQnveysWK0gAK73ruFhQ+D4BuLH8gRvcDfu0wjGjFUfkGTWOBjwZZVPrg+kX8gPqisLNZc22Z2bl9Sw1C9B8ilztGWyHSmmTdGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740146207; c=relaxed/simple;
	bh=Ln4H4AgC3d1BbcFmxUrlI+YAh8M1LJdvEAzwO7atJQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N+NUj6svwF7RLcpfEPCROTrSaMe/cbFCEUBb0rME+PHXzj44u3sSfyp/3tjwmWE8mY9S6ZpAf/C+Tjo771YCCU+HuiMyP3fhA11txhgCI2g1fXCZCB6RNg+QFHhkl1z8LnxIokKfpvS+Jt5/P8uT2O+N0fbB9kwOOZrkJYNBSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EDE2ptX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcfWQky1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 13:56:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740146203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vrv108UnjZjLakYBFQOphHLJqO2fp7/j6+WdEbjwEXc=;
	b=2EDE2ptXSq8C+oKwt4jTlmyUUxhe6kXwSs4b6szNMe+7HUcvRqLU3SC5pNPZgAOwMQJN/6
	mHPsdJGT4xGrOHAnJ9F0HPreMCYbciVzHBqvcO2HIsp75xd+6t7Scr2ExCCqNjhmyI7pfA
	hT2xJjcAQ+lpRQ90MALFinApRhWGDvTcKsDBQvGLLfPoKfqnspsmYo0GclrQxF2hUtFbdo
	hkP+BVr6VVeSIue7zTVU2e0gtZLa+Iy1Xai8QWBBFjRBC/J2O1MpUgXmYnCgHsSKzcgHaN
	2I3ghr5XdInEvDNv/Hy9fEyavv7P25O0iVeJUj+N0XKvWIJvr4OGmtCb/wZmvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740146203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vrv108UnjZjLakYBFQOphHLJqO2fp7/j6+WdEbjwEXc=;
	b=CcfWQky1WDuod7fb/RPTHQZfkg76l/3UmDuKogk6rCv0ns60Me36OkZrwd6o30WpFhy6/X
	xzZAqsFQabW9KICw==
From: "tip-bot2 for Stanislav Spassov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Fix guest FPU state buffer allocation size
Cc: Stanislav Spassov <stanspas@amazon.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250218141045.85201-1-stanspas@amazon.de>
References: <20250218141045.85201-1-stanspas@amazon.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174014620007.10177.13346155405991854999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     1937e18cc3cf27e2b3ef70e8c161437051ab7608
Gitweb:        https://git.kernel.org/tip/1937e18cc3cf27e2b3ef70e8c161437051ab7608
Author:        Stanislav Spassov <stanspas@amazon.de>
AuthorDate:    Tue, 18 Feb 2025 14:10:45 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 21 Feb 2025 14:47:26 +01:00

x86/fpu: Fix guest FPU state buffer allocation size

Ongoing work on an optimization to batch-preallocate vCPU state buffers
for KVM revealed a mismatch between the allocation sizes used in
fpu_alloc_guest_fpstate() and fpstate_realloc(). While the former
allocates a buffer sized to fit the default set of XSAVE features
in UABI form (as per fpu_user_cfg), the latter uses its ksize argument
derived (for the requested set of features) in the same way as the sizes
found in fpu_kernel_cfg, i.e. using the compacted in-kernel
representation.

The correct size to use for guest FPU state should indeed be the
kernel one as seen in fpstate_realloc(). The original issue likely
went unnoticed through a combination of UABI size typically being
larger than or equal to kernel size, and/or both amounting to the
same number of allocated 4K pages.

Fixes: 69f6ed1d14c6 ("x86/fpu: Provide infrastructure for KVM FPU cleanup")
Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250218141045.85201-1-stanspas@amazon.de
---
 arch/x86/kernel/fpu/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 1209c7a..36df548 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -220,7 +220,7 @@ bool fpu_alloc_guest_fpstate(struct fpu_guest *gfpu)
 	struct fpstate *fpstate;
 	unsigned int size;
 
-	size = fpu_user_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
+	size = fpu_kernel_cfg.default_size + ALIGN(offsetof(struct fpstate, regs), 64);
 	fpstate = vzalloc(size);
 	if (!fpstate)
 		return false;

