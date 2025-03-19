Return-Path: <linux-tip-commits+bounces-4362-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBF7A68AD1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7809168AE7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796D925CC80;
	Wed, 19 Mar 2025 11:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jZKc8PPB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SHQvqKMK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718E25525D;
	Wed, 19 Mar 2025 11:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382234; cv=none; b=Mz+GiL2Lqs/Uq54rgg1ASm1UUN+UQO23iRwNWn66xGwyWmY+ITTh2V9LpnJq2i9OB1O415By+crIChtzOfN+jAMiZW/E7RqoA4xy2LjMeQDsWFRLd7n6a7doK0Soya2y/0L9AUckzxmpAfb1//da0kCFEwlBPAh+oTzVbHyyGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382234; c=relaxed/simple;
	bh=UOi+ESBR6Dtom4AroO6OM3aEqepTVporXvwLO9GeBiQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M7O1l+W4M4zhHbfAbxwGmU2AJQGkOAKbXv5RhSm6j+GWF5drhfQvwrzdrv4DemBIZQzMV5Tgew+e/cY4VbE9PthTsR5Qk7ImqIXf96eJH+ORjv/WAQ0DwSP1+BOp2RezqYXsbV9pa8mAk6NOio42bpP0e9nq0g9CDQp9JtTKyuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jZKc8PPB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SHQvqKMK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXZZGPDlBYlKRsIFkgLf+nfzFt2s/T2lfOH0xtRxF8A=;
	b=jZKc8PPBnz5sX8mK/j5urdXkEZVMLGUjTWEAB4lRQcHSGU4+kgBkez0DnQY2tD8kbJQkZO
	sjo8vux0l0iWV1LkAZhT+lDxeXeJU6XXs6LSWb/QJuUQUwi25qFQl5eP/lwWcD42bZ1VG+
	ozIgKU+OhvH7cvATjNva3Jr657O9bKKTfhSHS/wlHrIG3nOU/rAR35FSzdjrqiMQjkBf/Q
	5/xoeUctAZFsLR2c75Rrx2G1t9PpXzNoDK5/MtLLsZP8FkBZCrgJ/uJc8k1it3vyqdBPtu
	m40EvdyLIM2ucECYAMZxXKi1YDGyRSxPi8jqvmqdiowEmZOtD3AyuIwOKO2TnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382228;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXZZGPDlBYlKRsIFkgLf+nfzFt2s/T2lfOH0xtRxF8A=;
	b=SHQvqKMKctabOd9qCXu9e7qxOH6aASFpCxtqR34ukA+D/Mt4RNVGP/CefNIFavAnUhixlZ
	9QyYk+6WB4lvy8BA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/syscall: Remove stray semicolons
Cc: Sohil Mehta <sohil.mehta@intel.com>, Brian Gerst <brgerst@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314151220.862768-7-brgerst@gmail.com>
References: <20250314151220.862768-7-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238222810.14745.14332700247939149457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     604939552231730c52b823b178e9080877b20851
Gitweb:        https://git.kernel.org/tip/604939552231730c52b823b178e9080877b20851
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:19 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:19:18 +01:00

x86/syscall: Remove stray semicolons

No functional change.

Suggested-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250314151220.862768-7-brgerst@gmail.com
---
 arch/x86/entry/syscall_32.c | 2 +-
 arch/x86/entry/syscall_64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 06b9df1..993d725 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -47,7 +47,7 @@ long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 	#include <asm/syscalls_32.h>
 	default: return __ia32_sys_ni_syscall(regs);
 	}
-};
+}
 
 static __always_inline int syscall_32_enter(struct pt_regs *regs)
 {
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index a05f7be..b6e68ea 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -38,7 +38,7 @@ long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 	#include <asm/syscalls_64.h>
 	default: return __x64_sys_ni_syscall(regs);
 	}
-};
+}
 
 #ifdef CONFIG_X86_X32_ABI
 long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
@@ -47,7 +47,7 @@ long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 	#include <asm/syscalls_x32.h>
 	default: return __x64_sys_ni_syscall(regs);
 	}
-};
+}
 #endif
 
 static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)

