Return-Path: <linux-tip-commits+bounces-3796-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 629CAA4BE52
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 12:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA843B1FCF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A01F55EB;
	Mon,  3 Mar 2025 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWTf9sfz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cYqw6bHz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55E71F4161;
	Mon,  3 Mar 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741000375; cv=none; b=LWWC2pezbIHxGBFUBUxB9Sjjvd+RZO+WV4VCiqjfuVbQx9B6C+J0VwN6kAocpOtspaDC+/FqLamxIMKZt7ureBsIda07v5IX+PwNdCR0il6/A5umXvh/EAD+MIffoyW/HE9NHkwn3S3P6AINXkurEIbxeiDEcqjw27gXGCemo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741000375; c=relaxed/simple;
	bh=ctMIRammTqa0bLqyi+VU4HBlf8UnbSmLXmSUOG+B8FI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KnFpI6jIrcuIQ2jVYOZQSPyWUbaXaQ6bJwJS77MyVC/8kMXrVtdqzacjoXQgml0EN8wA3E37bKKzxIT2efB87WCVwCf0h4SrS4WUWAGinNA6rASeZk6bEn3MalyBYoqsj/aJUR75PP3J5yHoO/WMY4KNr3+9F0zCLDYhTW1VBtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWTf9sfz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cYqw6bHz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 11:12:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741000372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4eRrxeyr8NeLHXBvhx3UA2NZa+B3GFVuDlc+sYEecA=;
	b=nWTf9sfz0GDN7GHsCiIQ5sCgwkehkgLtVakrrAKJx0RsIp2RWo3ZV1oH2/ZgmRYhGW9W0c
	scI6vmUr1o4tkKXJboLnjJ+gqmdZuUXE3n1FxNJ+ZnP+Q/k5+rGGfigyEjojZTPTMQxOH6
	AuAb0bXw+BNlFe2MDlTsBD7X5CcfTpKHAhhQqND/uMRuom3TVC4VePj7au4tDL90kAgKph
	3nUytmvsXn0UkfoqQpNKpiDcGj9scnpKSyGKYabxkC0NfN4JxD70Xa3mTW2hhgO7to2/Sg
	T3DDaLu3DF+MXPXSOFXjAluGlqUqhUuMWV9BOyTJHmCRC/6fvwrmpQIuLK/SCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741000372;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4eRrxeyr8NeLHXBvhx3UA2NZa+B3GFVuDlc+sYEecA=;
	b=cYqw6bHz30IhuYi2HvIjnsrqXa/QOFgxorRAxdoDoGV4CBqJuL2g6fLaJ7SiRqv+FCefW3
	/SRoV74QHGWpzhCg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/smp: Fix mwait_play_dead() and
 acpi_processor_ffh_play_dead() noreturn behavior
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <e885c6fa9e96a61471b33e48c2162d28b15b14c5.1740962711.git.jpoimboe@kernel.org>
References:
 <e885c6fa9e96a61471b33e48c2162d28b15b14c5.1740962711.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174100037200.10177.2289565868501030311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     aa909169d8fbce74f77df1cc3e722673599fa945
Gitweb:        https://git.kernel.org/tip/aa909169d8fbce74f77df1cc3e722673599fa945
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Sun, 02 Mar 2025 16:48:51 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 03 Mar 2025 11:58:22 +01:00

x86/smp: Fix mwait_play_dead() and acpi_processor_ffh_play_dead() noreturn behavior

Fix some related issues (done in a single patch to avoid introducing
intermediate bisect warnings):

  1) The SMP version of mwait_play_dead() doesn't return, but its
     !SMP counterpart does.  Make its calling behavior consistent by
     resolving the !SMP version to a BUG().  It should never be called
     anyway, this just enforces that at runtime and enables its callers
     to be marked as __noreturn.

  2) While the SMP definition of mwait_play_dead() is annotated as
     __noreturn, the declaration isn't.  Nor is it listed in
     tools/objtool/noreturns.h.  Fix that.

  3) Similar to #1, the SMP version of acpi_processor_ffh_play_dead()
     doesn't return but its !SMP counterpart does.  Make the !SMP
     version a BUG().  It should never be called.

  4) acpi_processor_ffh_play_dead() doesn't return, but is lacking any
     __noreturn annotations.  Fix that.

This fixes the following objtool warnings:

  vmlinux.o: warning: objtool: acpi_processor_ffh_play_dead+0x67: mwait_play_dead() is missing a __noreturn annotation
  vmlinux.o: warning: objtool: acpi_idle_play_dead+0x3c: acpi_processor_ffh_play_dead() is missing a __noreturn annotation

Fixes: a7dd183f0b38 ("x86/smp: Allow calling mwait_play_dead with an arbitrary hint")
Fixes: 541ddf31e300 ("ACPI/processor_idle: Add FFH state handling")
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/e885c6fa9e96a61471b33e48c2162d28b15b14c5.1740962711.git.jpoimboe@kernel.org
---
 arch/x86/include/asm/smp.h    | 4 ++--
 arch/x86/kernel/acpi/cstate.c | 2 +-
 include/acpi/processor.h      | 6 +++---
 tools/objtool/noreturns.h     | 2 ++
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 80f8bfd..1d3b11e 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,7 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
-void mwait_play_dead(unsigned int eax_hint);
+void __noreturn mwait_play_dead(unsigned int eax_hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -166,7 +166,7 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 	return (struct cpumask *)cpumask_of(0);
 }
 
-static inline void mwait_play_dead(unsigned int eax_hint) { }
+static inline void __noreturn mwait_play_dead(unsigned int eax_hint) { BUG(); }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 86c87c0..d255842 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -206,7 +206,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 }
 EXPORT_SYMBOL_GPL(acpi_processor_ffh_cstate_probe);
 
-void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
 {
 	unsigned int cpu = smp_processor_id();
 	struct cstate_entry *percpu_entry;
diff --git a/include/acpi/processor.h b/include/acpi/processor.h
index 63a37e7..d0eccbd 100644
--- a/include/acpi/processor.h
+++ b/include/acpi/processor.h
@@ -280,7 +280,7 @@ int acpi_processor_ffh_cstate_probe(unsigned int cpu,
 				    struct acpi_processor_cx *cx,
 				    struct acpi_power_register *reg);
 void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx *cstate);
-void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
+void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx);
 #else
 static inline void acpi_processor_power_init_bm_check(struct
 						      acpi_processor_flags
@@ -301,9 +301,9 @@ static inline void acpi_processor_ffh_cstate_enter(struct acpi_processor_cx
 {
 	return;
 }
-static inline void acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
+static inline void __noreturn acpi_processor_ffh_play_dead(struct acpi_processor_cx *cx)
 {
-	return;
+	BUG();
 }
 #endif
 
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index b217489..5a4aec4 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -16,6 +16,7 @@ NORETURN(__tdx_hypercall_failed)
 NORETURN(__ubsan_handle_builtin_unreachable)
 NORETURN(__x64_sys_exit)
 NORETURN(__x64_sys_exit_group)
+NORETURN(acpi_processor_ffh_play_dead)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)
@@ -34,6 +35,7 @@ NORETURN(kunit_try_catch_throw)
 NORETURN(machine_real_restart)
 NORETURN(make_task_dead)
 NORETURN(mpt_halt_firmware)
+NORETURN(mwait_play_dead)
 NORETURN(nmi_panic_self_stop)
 NORETURN(panic)
 NORETURN(panic_smp_self_stop)

