Return-Path: <linux-tip-commits+bounces-4229-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A504A63520
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 12:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91CFC7A5777
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A21991C9;
	Sun, 16 Mar 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KoEw0mxr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7p5UsD69"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE68635E;
	Sun, 16 Mar 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122902; cv=none; b=mFolwM+5Hup8v1VVz2yuBXZl2tAP8FnCLMT5ChoR33SocLYNX/1Noy57rvFw/hNSE4uSs3J/7rirge2mLfCHvivp0qIka8i0kxJvqRmlJYHoK7Tk1Z3FpZvulrAL51PxmnAGq8yfuuYGRz2JiEmS7/+KIZ9c/CoH1e4jzWLGjZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122902; c=relaxed/simple;
	bh=xLRn5n1LY+JSwlZVj3GQ8yYtLgacqyQsIjLhTGVPog4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sfioy6mqGGn1kt58ThM90bCZ6pS1cnVxaYgmrF73W7mApWp9erzX8OkHXrZN4XG2/s8OBPj3+W+OeoQiIqw7Xy5AGSvkMToIp0W55Q04NbIeb40SXPMRtPyjVqoutSmKg+lFxogT9BuPnO1q7jpk4g9YjmSERLZl2F+ZVyPU/oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KoEw0mxr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7p5UsD69; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 16 Mar 2025 11:01:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742122898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IchD9oc6H8WTxmeEzjAnLwFB6Frfnb7NxTexTzA8Cj0=;
	b=KoEw0mxr5EeBpAKSOmZBEzVJSr6DE0kD6RIEsN11PLUl6b3Fw9AeL76vwz5RHgtfq0E5B2
	4+RR/rBkF7YrrK2Qe0MkyfIB/yR0axRq3SNgesbIlwm2kux1PSgxDOCwQYx2htfXLX/BP+
	8N4prT13owDtLP+zoybAJXq2P3a642VQmqp9EvdR32QcKVrwOttPS3a8BbpWiGiaeGykCQ
	p5vQcfMyrhymhClaPIf9AQbQQMlv332riIp0z6q+6/7K3vQuQODyVR5Ry9YZyb3oHxWmSZ
	89SjVDUZrZvn+8f5XPGib7QrNVXeoQIkxumKn9fKElIQBlpO6tDAmdbuNISpNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742122898;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IchD9oc6H8WTxmeEzjAnLwFB6Frfnb7NxTexTzA8Cj0=;
	b=7p5UsD69XB1lGHIE+KKT4PTooVWn40AXAcq3rPqFfV2gpnFHHwPre46LLRgzfHLAhAJrZm
	3OvI7n20ThNaPQBA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/syscall: Remove stray semicolons
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
Message-ID: <174212289800.14745.6655322569620510192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     11743519c8c82a8a08552337168bdc6561ea0165
Gitweb:        https://git.kernel.org/tip/11743519c8c82a8a08552337168bdc6561ea0165
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:19 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 16 Mar 2025 11:49:42 +01:00

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

