Return-Path: <linux-tip-commits+bounces-7258-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EEEC2FDD4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0970D188880E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666832861E;
	Tue,  4 Nov 2025 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QHRjTY3F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="05JX/w6u"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BF2327208;
	Tue,  4 Nov 2025 08:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244276; cv=none; b=HtNKi5KfyP6bsKAN/D0t0oQQIGnf11fGq4kXGmDLOWPqaN8V9LHCGWZ/IVB01ycXP14SeMUmqrt2L3twByHGRl09ktubT4A9EvU/KKVCQaUD701SWD1tv8R5o8/DWht8H/AYoGhG/4F4TKdoDDzPiv/fEjKjRyevq1wN/FWgdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244276; c=relaxed/simple;
	bh=K+oLGJiS4AknUnk4/DMUUUDU5O4gin5nXWcmxNWrQ14=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ktCqnRImvGf059Zf6Gc/cYqJu0XswbejzPDdON6z2L96v22HOkvafSrBGOE7mk1q+gHyQo6LzBcqvdzbKE7bScl34NyO/93b3OdkeeI0Qp7dx/vxNQQFhBq/SrpGnXawOvHVTjgC6Fi7zfiB7EKRxuzSsL0U4al5zjo/dKbHoh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QHRjTY3F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=05JX/w6u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FuHERyq22ok2p2dWTPONsYdSLIX7umjI9m9cZm5ITY8=;
	b=QHRjTY3FisgaEAxxMajelPVNnn4GpYKNWSm4U+b/lYtjGhGpYPDu1GalMPi2F0LqgO7uoD
	rNKh/y40dsIkaT4a2kvu+eJeEyRo6jIjkl8OL6QnCqX0k3LBq9nTqayxNUfuBUdnmEcqyz
	It1nVpKjxcPbNTw3EWLB7JdGhetjZB1+W9qE5bN48ugFn5EiQ4X35sl7T8mzF7QmqPbD9o
	pWZSItwhwJH6+ecZ2UKZx9x0UARElG9lOCygxYhjZUoTwRAJo0/7vMK0Jt03XiOeiO7PY8
	BdxCEATHLwFnya/JvebdbNTttC7t82zNVDcTZIrzxIKwKjX0AUXZpzOlTOrEXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FuHERyq22ok2p2dWTPONsYdSLIX7umjI9m9cZm5ITY8=;
	b=05JX/w6u2/jqQ1mBprkLR7ipcflmI6A9wN6zAKdPWt2PD0oL3OTVZCWI+42UXIp3ebtwi/
	/JqrhyTaFRzvDhBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] arm64: uaccess: Use unsafe wrappers for ASM GOTO
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kernel test robot <lkp@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224427132.2601451.863881467711737162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     2db48d8bf87d3cb9d968e73623efc1c5a02523e7
Gitweb:        https://git.kernel.org/tip/2db48d8bf87d3cb9d968e73623efc1c5a02=
523e7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 31 Oct 2025 10:37:09 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:27:20 +01:00

arm64: uaccess: Use unsafe wrappers for ASM GOTO

Clang propagates a provided label, which is outside of a cleanup scope to
ASM GOTO despite the fact that __raw_get_mem() has a local label for that
purpose:

  "error: cannot jump from this asm goto statement to one of its possible tar=
gets"

Using the unsafe wrapper with the extra local label indirection cures that.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm64/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uacces=
s.h
index 1aa4ecb..6490930 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -422,9 +422,9 @@ static __must_check __always_inline bool user_access_begi=
n(const void __user *pt
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
 #define user_access_end()	uaccess_ttbr0_disable()
-#define unsafe_put_user(x, ptr, label) \
+#define arch_unsafe_put_user(x, ptr, label) \
 	__raw_put_mem("sttr", x, uaccess_mask_ptr(ptr), label, U)
-#define unsafe_get_user(x, ptr, label) \
+#define arch_unsafe_get_user(x, ptr, label) \
 	__raw_get_mem("ldtr", x, uaccess_mask_ptr(ptr), label, U)
=20
 /*

