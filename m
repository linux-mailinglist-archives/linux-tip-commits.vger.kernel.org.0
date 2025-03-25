Return-Path: <linux-tip-commits+bounces-4435-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED687A6EAAC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2CED17047A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 07:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0516E2566CE;
	Tue, 25 Mar 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TXVpJFnp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2WDZhS3h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83A255227;
	Tue, 25 Mar 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742888178; cv=none; b=MjzVXkbNblmB6ZG2QZ78yFjIa75PuvPxI18D6/oNZ7l5XaQGc9G1gN1W1xbbdsUO9+0kyHkXnIQErbACYf7sfxapSIGruLccrDJLWMIHUD9fOs/Z4tEAng/alAmj1+suO+176nWyHZ9AGaezZ8BMxw+YK8euACsozYEawhbFjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742888178; c=relaxed/simple;
	bh=MmcnAFzHXevh32n9BW1uWquF4NS+vnEYXT1DXhrx5J0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dEkyZo0HCK/svCP9nllA7JHFKfPEiCQ3DKC6dg5v2X3cbxSfapCz0NhRvotbYbXPmVvH9/qVjBYBcVtAzK4MjoavY2IQomp5sqqDsHj+tAgYazP/KDfSDIxwjI3BrNVgiVS6GMlKdNfZc2eeEsJhnPPPSKmnVS/XJtnvxF66n34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TXVpJFnp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2WDZhS3h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 07:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742888173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1SvW+qatn7IBquxz7U8IF4287/5fX8L/kRjSvkhJ/I=;
	b=TXVpJFnpcKqBsj/iKDxNuQjY9Byq8qnBNy6qr4I2xdAoYWs3/4JeC6jwkBLYixNCTG6nHD
	2KNDJREBx8Yj9F91xEP5gW+iF1OhwvpOEdOvqMRPUYxq5181Up7w2r/82kXPm6gfPjKh4i
	4zsS0oTOQUWlMfx1TtfnmST7DNkF5T9oJ3iGmCs8BNWtammMQ18mO7iI3x3Pnr/FTT2wDD
	sSQKXNbF/WVLDzRjHCDvc+BQXKKz3RrMvzEla9noxEGbu8ALwwro5uvqZmi48bF2YqSwyt
	99p39BUxN7J6gPfLTNq3WLiod0AQU5OfgZTisd1mgC4/WLCctMKBsPsYJyZ5YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742888173;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q1SvW+qatn7IBquxz7U8IF4287/5fX8L/kRjSvkhJ/I=;
	b=2WDZhS3hDQ0xOzJ1EUFbNiRXUSHMbhJDjS0v/0nvSzTKnAZQyLwWNEASYkkSBK3J4l3h8J
	wgh8eE2mCN6v6QDQ==
From:
 tip-bot2 for Mateusz =?utf-8?q?Jo=C5=84czyk?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/Kconfig: Enable X86_X2APIC by default and
 improve help text
Cc: mat.jonczyk@o2.pl, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250321-x86_x2apic-v3-1-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-1-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174288817298.14745.6112984038376589742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     9232c49ff31c40fa5cf72acf74c4aa251ed4811c
Gitweb:        https://git.kernel.org/tip/9232c49ff31c40fa5cf72acf74c4aa251ed=
4811c
Author:        Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
AuthorDate:    Fri, 21 Mar 2025 21:48:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Mar 2025 08:02:16 +01:00

x86/Kconfig: Enable X86_X2APIC by default and improve help text

As many current platforms (most modern Intel CPUs and QEMU) have x2APIC
present, enable CONFIG_X86_X2APIC by default as it gives performance
and functionality benefits. Additionally, if the BIOS has already
switched APIC to x2APIC mode, but CONFIG_X86_X2APIC is disabled, the
kernel will panic in arch/x86/kernel/apic/apic.c .

Also improve the help text, which was confusing and really did not
describe what the feature is about.

Help text references and discussion:

Both Intel [1] and AMD [3] spell the name as "x2APIC", not "x2apic".

"It allows faster access to the local APIC"
        [2], chapter 2.1, page 15:
        "More efficient MSR interface to access APIC registers."

"x2APIC was introduced in Intel CPUs around 2008":
        I was unable to find specific information which Intel CPUs
        support x2APIC. Wikipedia claims it was "introduced with the
        Nehalem microarchitecture in November 2008", but I was not able
        to confirm this independently. At least some Nehalem CPUs do not
        support x2APIC [1].

        The documentation [2] is dated June 2008. Linux kernel also
        introduced x2APIC support in 2008, so the year seems to be
        right.

"and in AMD EPYC CPUs in 2019":
        [3], page 15:
        "AMD introduced an x2APIC in our EPYC 7002 Series processors for
        the first time."

"It is also frequently emulated in virtual machines, even when the host
CPU does not support it."
        [1]

"If this configuration option is disabled, the kernel will not boot on
some platforms that have x2APIC enabled."
        According to some BIOS documentation [4], the x2APIC may be
        "disabled", "enabled", or "force enabled" on this system.
        I think that "enabled" means "made available to the operating
        system, but not already turned on" and "force enabled" means
        "already switched to x2APIC mode when the OS boots". Only in the
        latter mode a kernel without CONFIG_X86_X2APIC will panic in
        validate_x2apic() in arch/x86/kernel/apic/apic.c .

	QEMU 4.2.1 and my Intel HP laptop (bought in 2019) use the
	"enabled" mode and the kernel does not panic.

[1] "Re: [Qemu-devel] [Question] why x2apic's set by default without host sup"
        https://lists.gnu.org/archive/html/qemu-devel/2013-07/msg03527.html

[2] Intel=C2=AE 64 Architecture x2APIC Specification,
        ( https://www.naic.edu/~phil/software/intel/318148.pdf )

[3] Workload Tuning Guide for AMD EPYC =E2=84=A2 7002 Series Processor Based
        Servers Application Note,
        https://developer.amd.com/wp-content/resources/56745_0.80.pdf

[4] UEFI System Utilities and Shell Command Mobile Help for HPE ProLiant
        Gen10, ProLiant Gen10 Plus Servers and HPE Synergy:
        Enabling or disabling Processor x2APIC Support
        https://techlibrary.hpe.com/docs/iss/proliant-gen10-uefi/s_enable_dis=
able_x2APIC_support.html

Signed-off-by: Mateusz Jo=C5=84czyk <mat.jonczyk@o2.pl>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250321-x86_x2apic-v3-1-b0cbaa6fa338@ixit.cz
---
 arch/x86/Kconfig | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 98bd493..08bc939 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -458,20 +458,27 @@ config SMP
 	  If you don't know what to do here, say N.
=20
 config X86_X2APIC
-	bool "Support x2apic"
+	bool "x2APIC interrupt controller architecture support"
 	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
+	default y
 	help
-	  This enables x2apic support on CPUs that have this feature.
+	  x2APIC is an interrupt controller architecture, a component of which
+	  (the local APIC) is present in the CPU. It allows faster access to
+	  the local APIC and supports a larger number of CPUs in the system
+	  than the predecessors.
=20
-	  This allows 32-bit apic IDs (so it can support very large systems),
-	  and accesses the local apic via MSRs not via mmio.
+	  x2APIC was introduced in Intel CPUs around 2008 and in AMD EPYC CPUs
+	  in 2019, but it can be disabled by the BIOS. It is also frequently
+	  emulated in virtual machines, even when the host CPU does not support
+	  it. Support in the CPU can be checked by executing
+		cat /proc/cpuinfo | grep x2apic
=20
-	  Some Intel systems circa 2022 and later are locked into x2APIC mode
-	  and can not fall back to the legacy APIC modes if SGX or TDX are
-	  enabled in the BIOS. They will boot with very reduced functionality
-	  without enabling this option.
+	  If this configuration option is disabled, the kernel will not boot on
+	  some platforms that have x2APIC enabled.
=20
-	  If you don't know what to do here, say N.
+	  Say N if you know that your platform does not have x2APIC.
+
+	  Otherwise, say Y.
=20
 config X86_POSTED_MSI
 	bool "Enable MSI and MSI-x delivery by posted interrupts"

