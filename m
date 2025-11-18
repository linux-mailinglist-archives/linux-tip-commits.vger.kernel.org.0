Return-Path: <linux-tip-commits+bounces-7395-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 843A3C6B719
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 20:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB15A35391C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 19:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045CC2E54AA;
	Tue, 18 Nov 2025 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jskU28Gh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7tuwzKGP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF062DF706;
	Tue, 18 Nov 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494121; cv=none; b=EDpuu0CsGV1dougNzTGK2Cl0akaWtd31X7nUUum20cOZ7HhuxbKFP/+EPc/VgtdlA+7/OR31S9AWJSevex4kI5z0zxZYA1AkwhpniuuXfN9AW+eUQpDtqUXSi/I6Y8Tdh5c38GAatebAjzQzeLnIuk5sufH+KcVZN9kgvPVl1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494121; c=relaxed/simple;
	bh=FQYjdl4j2URDscl80TeGZK9QEm0yxSYqOYkeC7M18Ss=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=NcUPsrNjD7exjXDw0WZqitZsRuLhVjngt+gOQy5gsJU/+VHtI8KEvMuJhzNYFxSqrTDDKP7QZkoEpGLdLPZGCevCJVqi6N0SX9/+Jlhq/YNq+H90/ttZuAp7O/LwPNzk2pbLqc75cs9R4G3uIW7bK7H/bHr3HlRvl7PDMUZhu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jskU28Gh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7tuwzKGP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 19:28:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763494117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6xfyGWXfV6SqKn7p+cblTfyCXjayoQWbZ2r5qDPLQxU=;
	b=jskU28GhIDdY2nyAnGK1P+2//xmiDvs7c3c/nzHwT5OF2XM1yWhMmx/hxGEZ3Kcb3xUrcI
	0Mhg3/8avVuHnRkBmcsAIOcTjkkU6P8/dcrLO1aIpeayDYb5sVyB2YE1zbcUllazJbFlRn
	3uHClnLvo8YyTkWmnB5VTzXHG9II9g/UeihkEFHdal/2BD7xn5LEPubbUXdwb/p4+Wi5Ts
	B99Ovowe+HE8nAZubeuqhuv0fC7IVq69vp7n+Wi7y930UDyU+xdzvL6u7GCEN78ZJqd52f
	tYWjndnplo9vfr8rZBpWNZJiJiMET8iDtwaMxlxtgwEbW5z8S62N/EGl1XrlZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763494117;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=6xfyGWXfV6SqKn7p+cblTfyCXjayoQWbZ2r5qDPLQxU=;
	b=7tuwzKGPBkJUWY3XMP8oTuWi4KwqGx84QY4ibbwJl9QKJTPjwo3/J1AxvGvkI8zobcmgJm
	hs/aTRUXy/m6xrCw==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Enable LASS during CPU initialization
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176349411641.498.2665749647200101855.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d5cb9574391cc0a4683c22944d00d0ad76a224d3
Gitweb:        https://git.kernel.org/tip/d5cb9574391cc0a4683c22944d00d0ad76a=
224d3
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 18 Nov 2025 10:29:10 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 18 Nov 2025 10:38:27 -08:00

x86/cpu: Enable LASS during CPU initialization

Linear Address Space Separation (LASS) mitigates a class of side-channel
attacks that rely on speculative access across the user/kernel boundary.
Enable LASS along with similar security features if the platform
supports it.

While at it, remove the comment above the SMAP/SMEP/UMIP/LASS setup
instead of updating it, as the whole sequence is quite self-explanatory.

Some EFI runtime and boot services may rely on 1:1 mappings in the lower
half during early boot and even after SetVirtualAddressMap(). To avoid
tripping LASS, the initial CR4 programming would need to be delayed
until EFI has completely finished entering virtual mode (including
efi_free_boot_services()). Also, LASS would need to be temporarily
disabled while switching to efi_mm to avoid potential faults on stray
runtime accesses.

Similarly, legacy vsyscall page accesses are flagged by LASS resulting
in a #GP (instead of a #PF). Without LASS, the #PF handler emulates the
accesses and returns the appropriate values. Equivalent emulation
support is required in the #GP handler with LASS enabled. In case of
vsyscall XONLY (execute only) mode, the faulting address is readily
available in the RIP which would make it easier to reuse the #PF
emulation logic.

For now, keep it simple and disable LASS if either of those are compiled
in. Though not ideal, this makes it easier to start testing LASS support
in some environments. In future, LASS support can easily be expanded to
support EFI and legacy vsyscalls.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20251118182911.2983253-9-sohil.mehta%40intel.c=
om
---
 arch/x86/kernel/cpu/common.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3ff9682..d01dd88 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -401,6 +401,28 @@ out:
 	cr4_clear_bits(X86_CR4_UMIP);
 }
=20
+static __always_inline void setup_lass(struct cpuinfo_x86 *c)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return;
+
+	/*
+	 * Legacy vsyscall page access causes a #GP when LASS is active.
+	 * Disable LASS because the #GP handler doesn't support vsyscall
+	 * emulation.
+	 *
+	 * Also disable LASS when running under EFI, as some runtime and
+	 * boot services rely on 1:1 mappings in the lower half.
+	 */
+	if (IS_ENABLED(CONFIG_X86_VSYSCALL_EMULATION) ||
+	    IS_ENABLED(CONFIG_EFI)) {
+		setup_clear_cpu_cap(X86_FEATURE_LASS);
+		return;
+	}
+
+	cr4_set_bits(X86_CR4_LASS);
+}
+
 /* These bits should not change their value after CPU init is finished. */
 static const unsigned long cr4_pinned_mask =3D X86_CR4_SMEP | X86_CR4_SMAP |=
 X86_CR4_UMIP |
 					     X86_CR4_FSGSBASE | X86_CR4_CET | X86_CR4_FRED;
@@ -2007,10 +2029,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	/* Disable the PN if appropriate */
 	squash_the_stupid_serial_number(c);
=20
-	/* Set up SMEP/SMAP/UMIP */
 	setup_smep(c);
 	setup_smap(c);
 	setup_umip(c);
+	setup_lass(c);
=20
 	/* Enable FSGSBASE instructions if available. */
 	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {

