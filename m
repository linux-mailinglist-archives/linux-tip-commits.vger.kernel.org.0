Return-Path: <linux-tip-commits+bounces-6630-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152D7B57861
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBFBC16ECA0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46073307492;
	Mon, 15 Sep 2025 11:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qV6e6UB8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Vr0lDNI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAE306B1E;
	Mon, 15 Sep 2025 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935676; cv=none; b=kYhd6KGlfiRyAhC/xuReGYttSRm6RtqxVG8ZjNgfc6O1o3B4HedZJn/AMe2+p2V7KiuvlvtisIMNczVdA6L22+aZ5XmKqBQTR+AxL6BbNnkOHQVB4owxn1kZdGhVvtPT7NXMJmDgXNV1qm6LS0d2kajX1yZSkWMAQx3FDJEeqGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935676; c=relaxed/simple;
	bh=NofHdKSzOEzPcq2kwzqCF5KkhyoyeYKZIhSgZ0ZjIiI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ftxLAM/3KbVBi5wo2U3pMyClY3XmXZStFmEnQql6ayFZHpkuWKlAy7C7KjrnlJhbU2XcGJeRzK9lg8mA//hsns5oHcEbcoLOfPRzlMfaYNx+owjeYdFS8tgOphKLycS/1O3Q2ZSuWf5eGIS2IQ84A+mP5v14kn2D8djrTAvH1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qV6e6UB8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Vr0lDNI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toKsf2ut3hFxXU8OqIzr6u9858hho3A1z5xslzrRpL0=;
	b=qV6e6UB8VZvWLLe26fMi8LEEt+19jca9FVnb5LtiV9asxJRoA8bzPZ9IqMhFRf++nQ30Ff
	gAoC8WFd4YHhWFOwJoCMpFj+RXtSro/1Bsok86ejWbVJMnTW3gISuC5g4R13KPKVbHTACj
	IvUuBhLbT1n+aITQ/C/WzplKB/tFubR4RTOVHIYYNUtkr/NS+8HAGP8r8uRnb8RP2V/mEH
	NaPKOkGOfX8lLbGqQMV1A+EBNjJuMU3bD/aARvSWAo9dYmjkBQeQ2VQj7R+6sNDJFayRYg
	g4S/1ok10o6DofslVQJ+XGhn58zk2dhOr1Ugjmea+Gb8FXoi8F1v8PG5D2k3Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toKsf2ut3hFxXU8OqIzr6u9858hho3A1z5xslzrRpL0=;
	b=2Vr0lDNIBbppjpHW0bzFubNyIH/T1K5lw49qzvSNNosnczDswbroxMfEnxsnBIiswdDerl
	pZpx0R8rNQWkCdCw==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/cpufeatures: Add support for Assignable
 Bandwidth Monitoring Counters (ABMC)
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <08c0ad5eb21ab2b9a4378f43e59a095572e468d0.1757108044.git.babu.moger@amd.com>
References:
 <08c0ad5eb21ab2b9a4378f43e59a095572e468d0.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793567152.709179.5959198668986338073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     e19c06219985f2beb9d71959d80f56e318abf744
Gitweb:        https://git.kernel.org/tip/e19c06219985f2beb9d71959d80f56e318a=
bf744
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:04 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:04:15 +02:00

x86/cpufeatures: Add support for Assignable Bandwidth Monitoring Counters (AB=
MC)

Users can create as many monitor groups as RMIDs supported by the hardware.
However, the bandwidth monitoring feature on AMD only guarantees that RMIDs
currently assigned to a processor will be tracked by hardware. The counters of
any other RMIDs which are no longer being tracked will be reset to zero.

The MBM event counters return "Unavailable" for the RMIDs that are not tracked
by hardware. So, there can be only limited number of groups that can give
guaranteed monitoring numbers. With ever changing configurations there is no
way to definitely know which of these groups are being tracked during
a particular time. Users do not have the option to monitor a group or set of
groups for a certain period of time without worrying about RMID being reset in
between.

The ABMC feature allows users to assign a hardware counter to an RMID, event
pair and monitor bandwidth usage as long as it is assigned. The hardware
continues to track the assigned counter until it is explicitly unassigned by
the user. There is no need to worry about counters being reset during this
period. Additionally, the user can specify the type of memory transactions
(e.g., reads, writes) for the counter to track.

Without ABMC enabled, monitoring will work in current mode without assignment
option.

The Linux resctrl subsystem provides an interface that allows monitoring of up
to two memory bandwidth events per group, selected from a combination of
available total and local events. When ABMC is enabled, two events will be
assigned to each group by default, in line with the current interface design.
Users will also have the option to configure which types of memory
transactions are counted by these events.

Due to the limited number of available counters (32), users may quickly
exhaust the available counters. If the system runs out of assignable ABMC
counters, the kernel will report an error. In such cases, users will need to
unassign one or more active counters to free up counters for new assignments.
resctrl will provide options to assign or unassign events through the
group-specific interface file.

The feature is detected via CPUID_Fn80000020_EBX_x00 bit 5: ABMC (Assignable
Bandwidth Monitoring Counters).

The ABMC feature details are documented in APM [1] available from [2]. [1]
AMD64 Architecture Programmer's Manual Volume 2: System Programming
Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
Monitoring (ABMC).

  [ bp: Massage commit message, fixup enumeration due to VMSCAPE ]

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537 # [2]
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kernel/cpu/scattered.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufea=
tures.h
index 751ca35..b2a5622 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -496,6 +496,7 @@
 #define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L=
1 */
 #define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using V=
ERW before VMRUN */
 #define X86_FEATURE_IBPB_EXIT_TO_USER	(21*32+14) /* Use IBPB on exit-to-user=
space, see VMSCAPE bug */
+#define X86_FEATURE_ABMC		(21*32+15) /* Assignable Bandwidth Monitoring Coun=
ters */
=20
 /*
  * BUG word(s)
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 6b868af..4cee621 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -51,6 +51,7 @@ static const struct cpuid_bit cpuid_bits[] =3D {
 	{ X86_FEATURE_COHERENCY_SFW_NO,		CPUID_EBX, 31, 0x8000001f, 0 },
 	{ X86_FEATURE_SMBA,			CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,			CPUID_EBX,  3, 0x80000020, 0 },
+	{ X86_FEATURE_ABMC,			CPUID_EBX,  5, 0x80000020, 0 },
 	{ X86_FEATURE_TSA_SQ_NO,		CPUID_ECX,  1, 0x80000021, 0 },
 	{ X86_FEATURE_TSA_L1_NO,		CPUID_ECX,  2, 0x80000021, 0 },
 	{ X86_FEATURE_AMD_WORKLOAD_CLASS,	CPUID_EAX, 22, 0x80000021, 0 },

