Return-Path: <linux-tip-commits+bounces-4647-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01212A7A3D7
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 15:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AEAC3B7079
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F9E250BF8;
	Thu,  3 Apr 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1kEu4hzS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4uCljcYU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D424CEFD;
	Thu,  3 Apr 2025 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743687227; cv=none; b=soA4wy8yQISAb7XvIvGqAdib7omJFSVXXP6iB5ui+DaKBqMdd2aHCMGsGvyTojts11YyAWeLsIeUcTHKIffomyTiLusANSodGIYh9hP1qh5VvIMImC0eMqNwtqxoO8RwFWrJBYo749WQ+O8NguHxjnszBwWT7VFH97kQm7RJCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743687227; c=relaxed/simple;
	bh=4ryOs7+w3B0bc7UmRjHkHqLLwg/ZtnfyB8P+6MfMuCU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lURXJ9iMxXvD/AU8gp4Nl//pOgKwFdCMjwJq8dFKsYMe/dna/0idTYpyy5Djv6ueRJDGnL6c5vWg/52VON0XnCktQ/QtYjOxHFq5T+YjQ83UL00KA/U3EsnmK4SM3vWI6RfCwzdX6s5R4o5e0bMThChaD6SNC9WW23T39Eyj2K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1kEu4hzS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4uCljcYU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 13:33:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743687224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvTREFsQytXa3UXlBuevz1DVEQSfk6wLoJqcrSZH21s=;
	b=1kEu4hzSRtbBh8/kjMZJ4NHxkfv9q3MaAJp/LhUBteI7Hk1dFZmAWIcB5YnKelqqbmxFeI
	m1BG8rVd12FqBHPCxSnqgtA8LROKPZBSBm93JMDAK49xVGX+Vqt4ysCeQn1MnpQby4AQiR
	6IHxn6lC3Hx1OxVrhfiyFJUqF0xCKhbPXYWktEUbw9PlSAbxN0ryeLLGYjyWo3tdiJnIbM
	bMQ3Amshny39p7zYkp5BRRKGhZulHfApT+nOq2i20oB4iriyTqpr13pI37ja/a3K2z7yq8
	JkNlpnCiFfEIbl6tNq1yjy3TM0tENX4Mt1rMIXvQ1OM0IE8DD2xDpU19kooEXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743687224;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uvTREFsQytXa3UXlBuevz1DVEQSfk6wLoJqcrSZH21s=;
	b=4uCljcYUwYzSlMumcy+hKIZUcwCiDkwU13IQU/LS68CukeoF0CL6/YJFhNE/mJAeCFeqVJ
	aWBBx/sEnxFITSCQ==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/nmi] x86/nmi: Consolidate NMI panic variables
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Kai Huang <kai.huang@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Joel Granados <joel.granados@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327234629.3953536-3-sohil.mehta@intel.com>
References: <20250327234629.3953536-3-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174368722325.30396.2387319486878115024.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/nmi branch of tip:

Commit-ID:     78a0323506f01e8017a5826cd7e91951c13184fa
Gitweb:        https://git.kernel.org/tip/78a0323506f01e8017a5826cd7e91951c13184fa
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Thu, 27 Mar 2025 23:46:22 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 22:25:56 +02:00

x86/nmi: Consolidate NMI panic variables

Commit:

  c305a4e98378 ("x86: Move sysctls into arch/x86")

recently moved the sysctl handling of panic_on_unrecovered_nmi and
panic_on_io_nmi to x86-specific code. These variables no longer need to
be declared in the generic header file.

Relocate the variable definitions and declarations closer to where they
are used. This makes all the NMI panic options consistent and easier to
track.

[ mingo: Fixed up the SHA1 of the commit reference. ]

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Joel Granados <joel.granados@kernel.org>
Link: https://lore.kernel.org/r/20250327234629.3953536-3-sohil.mehta@intel.com
---
 arch/x86/include/asm/nmi.h  | 2 ++
 arch/x86/kernel/dumpstack.c | 2 --
 arch/x86/kernel/nmi.c       | 3 +++
 include/linux/panic.h       | 2 --
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 9cf96cc..f85aea7 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -17,6 +17,8 @@ extern void release_evntsel_nmi(unsigned int);
 #endif /* CONFIG_X86_LOCAL_APIC */
 
 extern int unknown_nmi_panic;
+extern int panic_on_unrecovered_nmi;
+extern int panic_on_io_nmi;
 
 #define NMI_FLAG_FIRST	1
 
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index c6fefd4..71ee201 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -23,8 +23,6 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-int panic_on_unrecovered_nmi;
-int panic_on_io_nmi;
 static int die_counter;
 
 static struct pt_regs exec_summary_regs;
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 9a95d00..671d846 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -91,6 +91,9 @@ static DEFINE_PER_CPU(struct nmi_stats, nmi_stats);
 static int ignore_nmis __read_mostly;
 
 int unknown_nmi_panic;
+int panic_on_unrecovered_nmi;
+int panic_on_io_nmi;
+
 /*
  * Prevent NMI reason port (0x61) being accessed simultaneously, can
  * only be used in NMI handler.
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 2494d51..4adc657 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -20,8 +20,6 @@ extern bool panic_triggering_all_cpu_backtrace;
 extern int panic_timeout;
 extern unsigned long panic_print;
 extern int panic_on_oops;
-extern int panic_on_unrecovered_nmi;
-extern int panic_on_io_nmi;
 extern int panic_on_warn;
 
 extern unsigned long panic_on_taint;

