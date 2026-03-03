Return-Path: <linux-tip-commits+bounces-8343-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJmuOq12p2nyhgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8343-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:02:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351F1F89F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 01:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C27A3155A51
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Mar 2026 23:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A597377EB4;
	Tue,  3 Mar 2026 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pEg+QUjE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eQxrX+71"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DCB25A645;
	Tue,  3 Mar 2026 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582361; cv=none; b=qkeA/swSvJdwQx462juEaClC+SNNNNxWwMQ4gGW/I+8HfAgOiuWcUmFPKkWcHMq4SvdL1ZthJdzRc/YShJcYQSUUqhZgBF75CZjb9Jkhf34mCPDqXyi60jOl5UDU2WgxbnV6Xsk8ry0HzJcLajHXduMTKMVZfX1Ps7jTOh504+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582361; c=relaxed/simple;
	bh=AnfsRfS0oAyDgiIbyNBI4rFFX1CQSr0LDNhoHiPlbN4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P7ww/qf4ReudTr81LppSU9NMwsRaEnxdrz83MPF49WgwyEw/X4FvMbGcVUgs3Et3oD6f/u0uKnyjAhKvF7K55DGdthfrqGAqBbcr/TPlurCmD/6xE1UzDfynj+MOahNnNUtwAj8n9oUk//aQNwYAE2V0HVtFOveaGXXLnUBebkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pEg+QUjE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eQxrX+71; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Mar 2026 23:59:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772582357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MCGU5+GjnkfOl5W1uhSF/StfjY+oXsC0Ze7KMfzb9Q=;
	b=pEg+QUjEvu+4CIihYMpMsX0cS4//iir2zJjxz/c8Mvq81lGGkcJjiPtmZe77QTawklIulb
	bXazRBHPLXAfD2f35+xKqRcUpyE+SxGzFMluSw57+nlJGURtHSM31S4IQNW5M2oypUxYE6
	ApIpFsHOjM2rL2xFKD35Dco3rNGGe+gGwkOpUdvYD2JpVzzgZai0xPRVi7ye9Nh9i7YaQ9
	6c1WF0HnND+HtLKpPwN01ka4WK+X0aiX5tykTJP+f6BZQW+55BOxHM4XgtWontfCdTAqiQ
	Fcyijpx7bnkgpNml1nIuYVEojXGtrLbz8bU6xVu3MbK5WvJ8v+EHOAta81gaTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772582357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+MCGU5+GjnkfOl5W1uhSF/StfjY+oXsC0Ze7KMfzb9Q=;
	b=eQxrX+71aaqUEMI8gC5i4Ao7afLzLoj5hpuC40d+e7URwBUgYJuhUelct/vrxMMw4b6Kly
	0zYOCzy4fmv6CuBw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Defer LASS enabling until userspace comes up
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
 "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260120234730.2215498-2-sohil.mehta@intel.com>
References: <20260120234730.2215498-2-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177258235654.1647592.8186200667919618122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5351F1F89F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8343-lists,linux-tip-commits=lfdr.de];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b3226af5ad7bbfcba79d26f547fe6582baf20ce9
Gitweb:        https://git.kernel.org/tip/b3226af5ad7bbfcba79d26f547fe6582baf=
20ce9
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 20 Jan 2026 15:47:28 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 03 Mar 2026 09:49:44 -08:00

x86/cpu: Defer LASS enabling until userspace comes up

LASS blocks any kernel access to the lower half of the virtual address
space. Unfortunately, some EFI accesses happen during boot with bit 63
cleared, which causes a #GP fault when LASS is enabled.

Notably, the SetVirtualAddressMap() call can only happen in EFI physical
mode. Also, EFI_BOOT_SERVICES_CODE/_DATA could be accessed even after
ExitBootServices(). The boot services memory is truly freed during
efi_free_boot_services() after SVAM has completed.

To prevent EFI from tripping LASS, at a minimum, LASS enabling must be
deferred until EFI has completely finished entering virtual mode
(including freeing boot services memory). Moving setup_lass() to
arch_cpu_finalize_init() would do the trick, but that would make the
implementation very fragile. Something else might come in the future
that would need the LASS enabling to be moved again.

In general, security features such as LASS provide limited value before
userspace is up. They aren't necessary during early boot while only
trusted ring0 code is executing. Introduce a generic late initcall to
defer activating some CPU features until userspace is enabled.

For now, only move the LASS CR4 programming to this initcall. As APs are
already up by the time late initcalls run, some extra steps are needed
to enable LASS on all CPUs. Use a CPU hotplug callback instead of
on_each_cpu() or smp_call_function(). This ensures that LASS is enabled
on every CPU that is currently online as well as any future CPUs that
come online later. Note, even though hotplug callbacks run with
preemption enabled, cr4_set_bits() would disable interrupts while
updating CR4.

Keep the existing logic in place to clear the LASS feature bits early.
setup_clear_cpu_cap() must be called before boot_cpu_data is finalized
and alternatives are patched. Eventually, the entire setup_lass() logic
can go away once the restrictions based on vsyscall emulation and EFI
are removed.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Link: https://patch.msgid.link/20260120234730.2215498-2-sohil.mehta@intel.com
---
 arch/x86/kernel/cpu/common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 1c3261c..8c56d59 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -422,11 +422,32 @@ static __always_inline void setup_lass(struct cpuinfo_x=
86 *c)
 	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION) ||
 	    IS_ENABLED(CONFIG_EFI)) {
 		setup_clear_cpu_cap(X86_FEATURE_LASS);
-		return;
 	}
+}
=20
+static int enable_lass(unsigned int cpu)
+{
 	cr4_set_bits(X86_CR4_LASS);
+
+	return 0;
+}
+
+/*
+ * Finalize features that need to be enabled just before entering
+ * userspace. Note that this only runs on a single CPU. Use appropriate
+ * callbacks if all the CPUs need to reflect the same change.
+ */
+static int cpu_finalize_pre_userspace(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return 0;
+
+	/* Runs on all online CPUs and future CPUs that come online. */
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/lass:enable", enable_lass, NULL=
);
+
+	return 0;
 }
+late_initcall(cpu_finalize_pre_userspace);
=20
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =3D X86_CR4_SMEP | X86_CR4_SMAP |=
 X86_CR4_UMIP |

