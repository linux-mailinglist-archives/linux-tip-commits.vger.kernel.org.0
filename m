Return-Path: <linux-tip-commits+bounces-4918-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A4A870F9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 10:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3641893A2B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 08:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538C146A60;
	Sun, 13 Apr 2025 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uo351E8i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oKmUkAn6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A564A18;
	Sun, 13 Apr 2025 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744531334; cv=none; b=GTS/DrBOLHi90/bXF0MU0Dg7yT/QDdDH2HWXHm3WTUJc+YvNGvFrdu2GB40xl28bFW0N7Um+DDfSUHZG2U7uKMhvpUwfdNPdmkh810QZNWQX7pizKaPZsHFn7BxyeDppc75i5SUcyjWjKewfORvhXZrUOFtEm/vyWW2Hmm4vWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744531334; c=relaxed/simple;
	bh=7LSnlRHg5ilP9y2wAV0fO+ZSSRH03VV0jIQxfm2QR+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o50xXhtIBxbMwyIK1HjWMMPnoIPn4sNPotn8FzoMmYbMTGuPrPfknsmHiaRl7Jilkp3Jph+PGQw+hS7+DKvw9vNZK/eb4O384Lwsy39oAaH1jNEhK1gCuKZvyHZWJwAQGONjZAMigg1m+tFU1u0WqkYXm27+A6640JQqbFAbMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uo351E8i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oKmUkAn6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 08:01:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744531330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eI8ndGTtErzBmqW0KvWPNzrVknbj7V9KlNoGoRqbe+s=;
	b=Uo351E8iWOSvnqBp8y4vQSpx1nU9EhCmdCi/XoCgIdV+zBU+GkJkrelB5PNymjmBglE1OB
	fZMe/PoiMzlP89gZHDOAxEikg6MkcGEUormDUi9gk44rDmGRr/RIg+0GQ/pOfKyLVWruoL
	7BxnA40pC8z3JlHeAPoloNZWGB2b+Oe8dUsMwn+KSrgeH0UdN2nWJAD0id5+SFOt7qBvSS
	JdK/VRDAptoenxwHTX8A1ZP6albfoUJqqSNPpwbAxfjwFcKB722n6M/7C0FxdTY4MX/T9a
	qH1muu1LOxPbbNVPESRbfza8MTVb1eZ4FewCI3vr8eQLNrmLWCiY6CkD1iJdSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744531330;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eI8ndGTtErzBmqW0KvWPNzrVknbj7V9KlNoGoRqbe+s=;
	b=oKmUkAn62wiy18oJjzZSJsGiSTI+AgZwyaMuXv7GjDruD+5b69NIKy2LDIbP7qB4w2YEaV
	HbVl+VtdDaz2ZCBQ==
From: "tip-bot2 for Uros Bizjak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/asm] x86/percpu: Refer __percpu_prefix to __force_percpu_prefix
Cc: Uros Bizjak <ubizjak@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411093130.81389-1-ubizjak@gmail.com>
References: <20250411093130.81389-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174453131877.31282.11281370109325866576.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     d51faee4bd63b3b02fa6f56210ec0d84c5ccb680
Gitweb:        https://git.kernel.org/tip/d51faee4bd63b3b02fa6f56210ec0d84c5ccb680
Author:        Uros Bizjak <ubizjak@gmail.com>
AuthorDate:    Fri, 11 Apr 2025 11:31:17 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 13 Apr 2025 09:48:24 +02:00

x86/percpu: Refer __percpu_prefix to __force_percpu_prefix

Refer __percpu_prefix to __force_percpu_prefix to avoid duplicate
definition. While there, slightly reorder definitions to a more
logical sequence, remove unneeded double quotes and move misplaced
comment to the right place.

No functional changes intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250411093130.81389-1-ubizjak@gmail.com
---
 arch/x86/include/asm/percpu.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 5fe314a..b0d03b6 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -29,6 +29,8 @@
 
 #ifdef CONFIG_SMP
 
+#define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
+
 #ifdef CONFIG_CC_HAS_NAMED_AS
 
 #ifdef __CHECKER__
@@ -36,23 +38,23 @@
 # define __seg_fs		__attribute__((address_space(__seg_fs)))
 #endif
 
+#define __percpu_prefix
 #define __percpu_seg_override	CONCATENATE(__seg_, __percpu_seg)
-#define __percpu_prefix		""
 
 #else /* !CONFIG_CC_HAS_NAMED_AS: */
 
+#define __percpu_prefix		__force_percpu_prefix
 #define __percpu_seg_override
-#define __percpu_prefix		"%%"__stringify(__percpu_seg)":"
 
 #endif /* CONFIG_CC_HAS_NAMED_AS */
 
-#define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
-#define __my_cpu_offset		this_cpu_read(this_cpu_off)
-
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
- *
+ */
+#define __my_cpu_offset		this_cpu_read(this_cpu_off)
+
+/*
  * arch_raw_cpu_ptr should not be used in 32-bit VDSO for a 64-bit
  * kernel, because games are played with CONFIG_X86_64 there and
  * sizeof(this_cpu_off) becames 4.
@@ -77,9 +79,9 @@
 
 #else /* !CONFIG_SMP: */
 
+#define __force_percpu_prefix
+#define __percpu_prefix
 #define __percpu_seg_override
-#define __percpu_prefix		""
-#define __force_percpu_prefix	""
 
 #define PER_CPU_VAR(var)	(var)__percpu_rel
 
@@ -97,8 +99,8 @@
 # define __my_cpu_var(var)	(*__my_cpu_ptr(&(var)))
 #endif
 
-#define __percpu_arg(x)		__percpu_prefix "%" #x
 #define __force_percpu_arg(x)	__force_percpu_prefix "%" #x
+#define __percpu_arg(x)		__percpu_prefix "%" #x
 
 /*
  * For arch-specific code, we can use direct single-insn ops (they

