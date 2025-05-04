Return-Path: <linux-tip-commits+bounces-5213-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AE5AA84E1
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 10:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA83A3B8F11
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E7618C322;
	Sun,  4 May 2025 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AFbBFJAa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xDCg5uSI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E1841C7F;
	Sun,  4 May 2025 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746348867; cv=none; b=LKrlKr3WFRiaB3hVFvagq5n3YJblLvMr6PbN02QVkkxhtvCnH2Rp6VvKPzCbrf1xtQQNLl20GBPn1cQpS3u1QqbaHypQiPBIgV6pjP6DAXc9ETWiZc58+32htd3A1rKV84iK+iaZsiI9jKa3rszttHJHU9BOKsibrr/onNX/UUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746348867; c=relaxed/simple;
	bh=FaPHSfpeS/VKfTQ96ytnifgQJRelrXudnTNIfRrmk10=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lKpDWf3Xwn8vhN2fqH/i0cEnrF1xgyTOGc0kT9Zq4WA+R4LxDAAbakemcOmBCJER0Sqqi2QFFI2lBvVT+W+b22P+z0dmePallL/kpSKNpAjNrI5ytf0z41aVO5yM3kLxYzH7/gCLOlPpzYqTmH32YgfdS+eBXTEJK81O/L0FPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AFbBFJAa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xDCg5uSI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 04 May 2025 08:54:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746348863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76mCQ80O10NdR7Wus0DBp50aRGpQKOSRwjtzOp2n3UI=;
	b=AFbBFJAaQkSgnGlNJlleAcEW200UtSzoc7erAoErsfzUIFrNKXu4YsApVHB9C+U20/i9bF
	PP3+1JHlx0uyvTUtSZWwiDhrf3jJnEyyunMWv9UJD2maYqa8CV0ccERlOvVtWj99lw/YBV
	Il7rQw5L5DosOmD9PDu4dFBbSWDRjyhkex84nw2eM4URE4ZdFDSuMQc0+TgFZLBw5rP66h
	DvmIlWpF6gcDLOyLb9qnl3AGu8wdvH9Nvalfqjg/9wFW+Y2nQygNBP9WFFF/XVNZiMmCY+
	X2gcVuDjB+ymNpj4mITg+eB8FDo67fkbvRAC/mQ2To/pbR5jQv6WQlVDWns77A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746348863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76mCQ80O10NdR7Wus0DBp50aRGpQKOSRwjtzOp2n3UI=;
	b=xDCg5uSIQRs85T+tQCed491ayAwL8ELtYpCijpwQZa5sujn29qo424Qd7C15xTPyzMB2Xz
	BUmWNwqOhSS15dBA==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Shift fpregs_assert_state_consistent() from
 arch_exit_work() to its caller
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 "Chang S . Bae" <chang.seok.bae@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250503143902.GA9012@redhat.com>
References: <20250503143902.GA9012@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174634885768.22196.8535762687259029868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     46c158e3ad0fc633007802c338c409c188ec0a12
Gitweb:        https://git.kernel.org/tip/46c158e3ad0fc633007802c338c409c188ec0a12
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sat, 03 May 2025 16:39:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 04 May 2025 10:29:25 +02:00

x86/fpu: Shift fpregs_assert_state_consistent() from arch_exit_work() to its caller

If CONFIG_X86_DEBUG_FPU=Y, arch_exit_to_user_mode_prepare() calls
arch_exit_work() even if ti_work == 0. There only reason is that we
want to call fpregs_assert_state_consistent() if TIF_NEED_FPU_LOAD
is not set.

This looks confusing. arch_exit_to_user_mode_prepare() can just call
fpregs_assert_state_consistent() unconditionally, it depends on
CONFIG_X86_DEBUG_FPU and checks TIF_NEED_FPU_LOAD itself.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Chang S . Bae <chang.seok.bae@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250503143902.GA9012@redhat.com
---
 arch/x86/include/asm/entry-common.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 77d2055..d535a97 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -53,7 +53,6 @@ static inline void arch_exit_work(unsigned long ti_work)
 	if (unlikely(ti_work & _TIF_IO_BITMAP))
 		tss_update_io_bitmap();
 
-	fpregs_assert_state_consistent();
 	if (unlikely(ti_work & _TIF_NEED_FPU_LOAD))
 		switch_fpu_return();
 }
@@ -61,7 +60,9 @@ static inline void arch_exit_work(unsigned long ti_work)
 static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 						  unsigned long ti_work)
 {
-	if (IS_ENABLED(CONFIG_X86_DEBUG_FPU) || unlikely(ti_work))
+	fpregs_assert_state_consistent();
+
+	if (unlikely(ti_work))
 		arch_exit_work(ti_work);
 
 	fred_update_rsp0();

