Return-Path: <linux-tip-commits+bounces-7109-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 796B0C24AE5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 12:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A6A188A568
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Oct 2025 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A93446CA;
	Fri, 31 Oct 2025 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhpw+0lK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LHE/iJo8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84234403B;
	Fri, 31 Oct 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908651; cv=none; b=JdSVTqvwbfQJ6b1zxdJJaOgObw8wJzsllfe66gL0j/OvBmvnVo/lRFn+A3b4NAYjwjDp4a70W2x9EPMBH0w0d6wOH8nbeHjVeo0TUwadz25tfJ2ob89+j8EzGHyf+rmdqfJjdgRlQRWc0xBa52bxoy4jUdS6DgSUtvh8uzSx25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908651; c=relaxed/simple;
	bh=CBGi1UMk/AumzUUiFRsg6OuOvgSOteXUMKsE8i0QQT8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BwAFw3+XlFlJjo3afIN508Tqgx2O01qJ/EWv5QMPJAStVQ4RznauhnSpuoOpgqKVfAxuI1aWNqYOkBM7JA5dV08hmq/ip7urBRKYbZCCuohQaEs6E+9LihICNHCROXrY1jz9cDiqt4tUAmUOfLjcgLfit2OQ6JYAJDO+spR6jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhpw+0lK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LHE/iJo8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 Oct 2025 11:04:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761908647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3PTyrWaHkLXEYCDERRuYyDEGXNQRHg1rlU78uuTjBU=;
	b=rhpw+0lKiXih/wlgqHjmzgLEpme05BO0dTiDjHqWxTaeiubcqidUW/u8lBIy5S+s05q2ig
	cWALts1AIBpivia84DVDMCTBqhgl3A7OuaHe+2gSyAvv5SEKyCBivDBONDiJ+yLXRMC9Qf
	t2UvcTywYxSb2mB4yhyCfXh7CA94HTc97e9vgQq338UL/Ta3HzxRNNC6r0QD08L/vnGq8I
	c6caRptcZztVkK6uOh988i0sKpHd7QprCfKvWQW8DlBG8yFhjnkYeZZLxEkaViM7yVK9fh
	y94GTYIzY29XUMHummPqvG0SI/ywvwE1ySNqDspNcszR+1ZjTcYttvA3l3G1PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761908647;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R3PTyrWaHkLXEYCDERRuYyDEGXNQRHg1rlU78uuTjBU=;
	b=LHE/iJo8YHacj0JsgksV/AVas98KAp980nL5s25R9Gv1XOQ5dqany+p5NMdtOiwuzoq6XY
	OLuEUIVYdYaQc8AQ==
From: "tip-bot2 for Thorsten Blum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] x86/smpboot: Mark native_play_dead() as __noreturn
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027155107.183136-1-thorsten.blum@linux.dev>
References: <20251027155107.183136-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176190864582.2601451.2087277810097325517.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0ccf30fc64acca8e43a54a4f54fb3a4f155d4692
Gitweb:        https://git.kernel.org/tip/0ccf30fc64acca8e43a54a4f54fb3a4f155=
d4692
Author:        Thorsten Blum <thorsten.blum@linux.dev>
AuthorDate:    Mon, 27 Oct 2025 16:51:02 +01:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 30 Oct 2025 08:29:41 -07:00

x86/smpboot: Mark native_play_dead() as __noreturn

native_play_dead() ends by calling the non-returning function
hlt_play_dead() and therefore also never returns.

The !CONFIG_HOTPLUG_CPU stub version of native_play_dead()
unconditionally calls BUG() and does not return either.

Add the __noreturn attribute to both function definitions and their
declaration to document this behavior and to potentially improve
compiler optimizations.

Remove the obsolete comment, and add native_play_dead() to the objtool's
list of __noreturn functions.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20251027155107.183136-1-thorsten.blum@linux.dev
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/smp.h | 2 +-
 arch/x86/kernel/smpboot.c  | 8 ++------
 tools/objtool/noreturns.h  | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 22bfebe..8495157 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -109,7 +109,7 @@ int common_cpu_up(unsigned int cpunum, struct task_struct=
 *tidle);
 int native_kick_ap(unsigned int cpu, struct task_struct *tidle);
 int native_cpu_disable(void);
 void __noreturn hlt_play_dead(void);
-void native_play_dead(void);
+void __noreturn native_play_dead(void);
 void play_dead_common(void);
 void wbinvd_on_cpu(int cpu);
 void wbinvd_on_all_cpus(void);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index eb289ab..a4ba735 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1328,11 +1328,7 @@ void __noreturn hlt_play_dead(void)
 		native_halt();
 }
=20
-/*
- * native_play_dead() is essentially a __noreturn function, but it can't
- * be marked as such as the compiler may complain about it.
- */
-void native_play_dead(void)
+void __noreturn native_play_dead(void)
 {
 	if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS))
 		__update_spec_ctrl(0);
@@ -1351,7 +1347,7 @@ int native_cpu_disable(void)
 	return -ENOSYS;
 }
=20
-void native_play_dead(void)
+void __noreturn native_play_dead(void)
 {
 	BUG();
 }
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 802895f..14f8ab6 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -36,6 +36,7 @@ NORETURN(machine_real_restart)
 NORETURN(make_task_dead)
 NORETURN(mpt_halt_firmware)
 NORETURN(mwait_play_dead)
+NORETURN(native_play_dead)
 NORETURN(nmi_panic_self_stop)
 NORETURN(panic)
 NORETURN(vpanic)

