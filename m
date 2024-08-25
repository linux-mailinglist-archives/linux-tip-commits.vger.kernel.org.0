Return-Path: <linux-tip-commits+bounces-2116-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B69D95E490
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 19:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC6C1C2085C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 Aug 2024 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BB31684A5;
	Sun, 25 Aug 2024 17:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VYPgtJjN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AXffYE6P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8690155A34;
	Sun, 25 Aug 2024 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724606926; cv=none; b=PTuJDXwLOwiYUqr63a7s5tJ08VyBMA/6nCn+TlS0ImlvTwmIBsxQkjODsUhqKFk3Xl5O/XHF6GSvkWO4FfkPUhF29fDz7ODg6BGLqGh8WwN6c4RBSFP12DSGRJvYx/AkCbD+9TjeX4WJqMTOf4Wvno2zr+zyrJoM/y0ZR6W82N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724606926; c=relaxed/simple;
	bh=VOUnzlPF67OBwGiBKDLQ5UAM/LL+T4UlB7s7Hm/H8bE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YS9QuO4Xnc9Em4Xf4Q+AM5PxwryR/XSkFdTeyiNiyftXr6LiwX9+C+71srGNnNVUtFuo3p6yigHDSw16zTwtbJnl4GeD1BYuL9VvxY/tx2MlQnh2bHCuD3+9kpRLIfJU8sLV22hFs+L1XfxM4V5UgtlyXNCJYPIB8TepPY5IVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VYPgtJjN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AXffYE6P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 Aug 2024 17:28:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724606923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uwzYC4chufXEcAadNHlw+WuJaEpRyk442FrkI/UWP0=;
	b=VYPgtJjNHALnQUiAkfqsSpVsf+fdGcuPiWy4VR5O094h4njzVxnW/mnrUyA/NOdnLi7NI8
	cDDhroLz47g9MpPD0RX9FY5gRj3sSwvhNP6M1vph2ezvRz5dxjCi16b0bui61KBHqgQjbf
	pGp2yWz+LRdhqtgKngDjFRFtIMp6Z2wEC5EbXG+g3REHkbdwVWeMI18FU5jv7Kyy5dM0vF
	uJZP2CZsfNBylOylEak/0p9fkBzABdK8ZfnK1hnwue6OrLyksKMnwkVgfaDBwBA+3lPDVu
	LF7llO/D8pVpNxtqgLmqmrsDxIYQHJ5aqfDbYXY4KN1eCdP1BTmI0EPj3XiC2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724606923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5uwzYC4chufXEcAadNHlw+WuJaEpRyk442FrkI/UWP0=;
	b=AXffYE6PfAqIubTUho+rSaBDGUF1LkYSLSBVlhLhL0aRqrgOPDc9muAarDiPYdYquzSqAX
	AxVVQSD8nW7VHBCQ==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/entry: Test ti_work for zero before processing
 individual bits
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>, "Xin Li (Intel)" <xin@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240822073906.2176342-2-xin@zytor.com>
References: <20240822073906.2176342-2-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172460692290.2215.1751413671384786595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     0dfac6f267fa091aa348c6a6742b463c9e7c98e3
Gitweb:        https://git.kernel.org/tip/0dfac6f267fa091aa348c6a6742b463c9e7c98e3
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Thu, 22 Aug 2024 00:39:04 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 25 Aug 2024 19:23:00 +02:00

x86/entry: Test ti_work for zero before processing individual bits

In most cases, ti_work values passed to arch_exit_to_user_mode_prepare()
are zeros, e.g., 99% in kernel build tests.  So an obvious optimization is
to test ti_work for zero before processing individual bits in it.

Omit the optimization when FPU debugging is enabled, otherwise the
FPU consistency check is never executed.

Intel 0day tests did not find a perfermance regression with this change.

Suggested-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240822073906.2176342-2-xin@zytor.com

---
 arch/x86/include/asm/entry-common.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index fb2809b..db97082 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -44,8 +44,7 @@ static __always_inline void arch_enter_from_user_mode(struct pt_regs *regs)
 }
 #define arch_enter_from_user_mode arch_enter_from_user_mode
 
-static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
-						  unsigned long ti_work)
+static inline void arch_exit_work(unsigned long ti_work)
 {
 	if (ti_work & _TIF_USER_RETURN_NOTIFY)
 		fire_user_return_notifiers();
@@ -56,6 +55,13 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 	fpregs_assert_state_consistent();
 	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
 		switch_fpu_return();
+}
+
+static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
+						  unsigned long ti_work)
+{
+	if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) || unlikely(ti_work))
+		arch_exit_work(ti_work);
 
 #ifdef CONFIG_COMPAT
 	/*

