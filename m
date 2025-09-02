Return-Path: <linux-tip-commits+bounces-6404-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31959B3FCB8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 12:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA58188DDA1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Sep 2025 10:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84062EE26D;
	Tue,  2 Sep 2025 10:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HYmVkPFL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDfmjCZU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31FD2F3C0A;
	Tue,  2 Sep 2025 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809400; cv=none; b=a5On2+06HBqKgAAPGPRRy25dBAvGAnEX2yQcR7816IEIP2En+DIQZiAZDR/hAy7vwt6GezciXJXeq+cEAo2sco3/mdBYJjVWlsxDxhPW25TXtLquINN/7hc2EH/K0tTlCYW4uVGX5cDZf3PydyJ+OTqnf+R9HRT961Nr05lJ6YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809400; c=relaxed/simple;
	bh=4bxBX8ZW8s+nBpfal9USgYnVEk+5uegd7HoihijEZXo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WDvt+rXoUuV7pbv7ujv0i6Ahts+NNc1OLyF3JyxxF6M6hP+6KLRDn7DpqWexqkK85xszYE16bI1pyjzgyFuOTAhCbCdWD8jfYvCfXtMWN7+3jfudelhu/Q55GHwmVP/OFsghOP+4smEv7XqcSBRhBwRNfVeCwlEevQmv1bKwDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HYmVkPFL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDfmjCZU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Sep 2025 10:36:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756809397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azWtokd9GMUYxFswYlrPx4kiF2ohPF0QImuyqI77+BU=;
	b=HYmVkPFLpP+bWtX9KnvYvcoziRl8jH2DkU+ft+O3O8ATTx3UxSHhRRH+NoT0dR0HsIs887
	BuPI/XIyf7MuiTTrVJ0bE2JpOrO3d40607HkRcTXDQNQ0rlxStOr3o5fr+AaF9Lm7sbu1R
	HjFoJVOgodBpZlmNJLsAjuWV/qZewurEwwoGPvH1dkR+N8nTlOyIJb7ehvBtGfuviwqeWD
	5raojL94hJVclmBvjs46rbHS2d2D9lrRH3lUn5yL8+jJSRtAdLxUsdIbqdw4T8DtJB7mPS
	ef4dmBjUeMWvDfe9mZMqMhRplmEe88KzzqtfDj6KCvFi/nRSYWz50pt3gqBhyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756809397;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=azWtokd9GMUYxFswYlrPx4kiF2ohPF0QImuyqI77+BU=;
	b=UDfmjCZUn6JkZ3WiL9V4E9gebBiGeGNCfmyVmbRJkmmFAzcW8HVqEVhG0YQc5cRL4Eyy4K
	VdxxwlNWq4sUQpBw==
From: "tip-bot2 for Neeraj Upadhyay" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Handle EOI writes for Secure AVIC guests
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tianyu Lan <tiala@microsoft.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828111654.208987-1-Neeraj.Upadhyay@amd.com>
References: <20250828111654.208987-1-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175680939603.1920.7657115283464017674.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     43b6687ac8777821973d790ff9e9565a84cf6b98
Gitweb:        https://git.kernel.org/tip/43b6687ac8777821973d790ff9e9565a84c=
f6b98
Author:        Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
AuthorDate:    Thu, 28 Aug 2025 16:46:54 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 01 Sep 2025 13:05:03 +02:00

x86/apic: Handle EOI writes for Secure AVIC guests

Secure AVIC accelerates the guest's EOI MSR writes for edge-triggered
interrupts.

For level-triggered interrupts, EOI MSR writes trigger a #VC exception with
an SVM_EXIT_AVIC_UNACCELERATED_ACCESS error code. To complete EOI handling,
the #VC exception handler would need to trigger a GHCB protocol MSR write
event to notify the hypervisor about completion of the level-triggered
interrupt.  Hypervisor notification is required for cases like emulated
IO-APIC, to complete and clear interrupt in the IO-APIC's interrupt state.

However, #VC exception handling adds extra performance overhead for APIC
register writes. In addition, for Secure AVIC, some unaccelerated APIC
register MSR writes are trapped, whereas others are faulted.

This results in additional complexity in #VC exception handling for
unaccelerated APIC MSR accesses. So, directly do a GHCB protocol based APIC
EOI MSR write from apic->eoi() callback for level-triggered interrupts.

Use WRMSR for edge-triggered interrupts, so that hardware re-evaluates any
pending interrupt which can be delivered to the guest vCPU. For
level-triggered interrupts, re-evaluation happens on return from VMGEXIT
corresponding to the GHCB event for APIC EOI MSR write.

Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Link: https://lore.kernel.org/20250828111654.208987-1-Neeraj.Upadhyay@amd.com
---
 arch/x86/kernel/apic/x2apic_savic.c | 31 +++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/x2apic_savic.c b/arch/x86/kernel/apic/x2api=
c_savic.c
index b6d6e7a..d76faea 100644
--- a/arch/x86/kernel/apic/x2apic_savic.c
+++ b/arch/x86/kernel/apic/x2apic_savic.c
@@ -301,6 +301,35 @@ static void savic_update_vector(unsigned int cpu, unsign=
ed int vector, bool set)
 	update_vector(cpu, SAVIC_ALLOWED_IRR, vector, set);
 }
=20
+static void savic_eoi(void)
+{
+	unsigned int cpu;
+	int vec;
+
+	cpu =3D raw_smp_processor_id();
+	vec =3D apic_find_highest_vector(get_reg_bitmap(cpu, APIC_ISR));
+	if (WARN_ONCE(vec =3D=3D -1, "EOI write while no active interrupt in APIC_I=
SR"))
+		return;
+
+	/* Is level-triggered interrupt? */
+	if (apic_test_vector(vec, get_reg_bitmap(cpu, APIC_TMR))) {
+		update_vector(cpu, APIC_ISR, vec, false);
+		/*
+		 * Propagate the EOI write to the hypervisor for level-triggered
+		 * interrupts. Return to the guest from GHCB protocol event takes
+		 * care of re-evaluating interrupt state.
+		 */
+		savic_ghcb_msr_write(APIC_EOI, 0);
+	} else {
+		/*
+		 * Hardware clears APIC_ISR and re-evaluates the interrupt state
+		 * to determine if there is any pending interrupt which can be
+		 * delivered to CPU.
+		 */
+		native_apic_msr_eoi();
+	}
+}
+
 static void savic_setup(void)
 {
 	void *ap =3D this_cpu_ptr(savic_page);
@@ -380,7 +409,7 @@ static struct apic apic_x2apic_savic __ro_after_init =3D {
=20
 	.read				=3D savic_read,
 	.write				=3D savic_write,
-	.eoi				=3D native_apic_msr_eoi,
+	.eoi				=3D savic_eoi,
 	.icr_read			=3D native_x2apic_icr_read,
 	.icr_write			=3D savic_icr_write,
=20

