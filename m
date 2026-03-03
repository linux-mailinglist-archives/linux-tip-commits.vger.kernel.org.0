Return-Path: <linux-tip-commits+bounces-8344-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMtPOvJ1p2mehgAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8344-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 00:59:46 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F180C1F8964
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Mar 2026 00:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9C9B73028C2C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Mar 2026 23:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B352377ED6;
	Tue,  3 Mar 2026 23:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUDoKyfx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S33YjqmO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EEA375AB8;
	Tue,  3 Mar 2026 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582361; cv=none; b=f00dekO+rD1FE58r03g7DGAgDdqznBY6HHHIutM2dmEWyYG99NksKCpDPTy+9hiJzEFyDo8yAynA/jpBmY19eCQdC7kG4UFXrxNXvno/2XEIGy9PvjRTwiCIqlVCMsBc9HoUMRAdeFKlig9MEuaa+ie1lc5qmK4uQ2J/vYgEeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582361; c=relaxed/simple;
	bh=+KN/zL0WbuXnmLQmV/NsY1dSpXoCYyqvd+BnqQr5iqg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XsjdKXTj42V2P3Vrs39pLF3TLfo5vwPgxNWpN77ukACK2BQE/kb4qbnmb5WFO3/UmeFARtVhowk2tRTzvA4kJJ+qVQr7H5Qh3sgsylNpeA1P4sZTqzD+rbSi7VGi0o4sWBOK3YH4b4znDPrtnIDHGenoFWDRFxUYkur0tsWjP6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RUDoKyfx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S33YjqmO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Mar 2026 23:59:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772582356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TbbFZ6GsV8IwFQ5/m5bVmGlHmoYNZurSO4nE/GE2H0=;
	b=RUDoKyfxfaOWsMQ5/I0+A5yo5X/CCVvwjEnbTm7P3fwvVzgMxlf14fLHzmHfgEkAr9FyOG
	Me2B6A4D67sR6CHOmLPE1hZnDq0GBocZu4MYsGa2lFgyzqMWsjgpzm/ww3gYUz8Nz6l0/S
	uAwIWAMbtyZoVCM/FZy7LHigYG2EuVf3HnQrH98By4FLmjt2k4MBb6MB6VJA2GHKSXd48j
	Mo3tunAit/BQqWZAw7Rk0fHn5h32hKoHVxL3vV68Xv9nC5NRFGJNwkePGoUKSpkptKYb+m
	msBnoGGpxyTWp+TTlpT0+c1H/45TLHU9JwFsGL8d0SRzsi804b6hyopi7uFdEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772582356;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+TbbFZ6GsV8IwFQ5/m5bVmGlHmoYNZurSO4nE/GE2H0=;
	b=S33YjqmOXva/KGMGtVEDvh0LJ+RBZLxNlP2p2MbZrLmMSELqHTa1DpawnS/iJ3+5689oDT
	fJO3wGsCD/fjl+CA==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/efi: Disable LASS while executing runtime services
Cc: Sohil Mehta <sohil.mehta@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
 "Maciej Wieczor-Retman" <maciej.wieczor-retman@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260120234730.2215498-3-sohil.mehta@intel.com>
References: <20260120234730.2215498-3-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177258235549.1647592.3132668784413010515.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F180C1F8964
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8344-lists,linux-tip-commits=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Action: no action

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0021e71cfb96d7816e2027a76b813da6003c3a0c
Gitweb:        https://git.kernel.org/tip/0021e71cfb96d7816e2027a76b813da6003=
c3a0c
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Tue, 20 Jan 2026 15:47:29 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 03 Mar 2026 09:49:45 -08:00

x86/efi: Disable LASS while executing runtime services

Ideally, EFI runtime services should switch to kernel virtual addresses
after SetVirtualAddressMap(). However, firmware implementations are
known to be buggy in this regard and continue to access physical
addresses. The kernel maintains a 1:1 mapping of all runtime services
code and data regions to avoid breaking such firmware.

LASS enforcement relies on bit 63 of the virtual address, which would
block such accesses to the lower half. Unfortunately, not doing anything
could lead to #GP faults when users update to a kernel with LASS
enabled.

One option is to use a STAC/CLAC pair to temporarily disable LASS data
enforcement. However, there is no guarantee that the stray accesses
would only touch data and not perform instruction fetches. Also, relying
on the AC bit would depend on the runtime calls preserving RFLAGS, which
is highly unlikely in practice.

Instead, use the big hammer and switch off the entire LASS mechanism
temporarily by clearing CR4.LASS. Runtime services are called in the
context of efi_mm, which has explicitly unmapped any memory EFI isn't
allowed to touch (including userspace). So, do this right after
switching to efi_mm to avoid any security impact.

Some runtime services can be invoked during boot when LASS isn't active.
Use a global variable (similar to efi_mm) to save and restore the
correct CR4.LASS state. The runtime calls are serialized with the
efi_runtime_lock, so no concurrency issues are expected.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Link: https://patch.msgid.link/20260120234730.2215498-3-sohil.mehta@intel.com
---
 arch/x86/platform/efi/efi_64.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index b4409df..5861008 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -55,6 +55,7 @@
  */
 static u64 efi_va =3D EFI_VA_START;
 static struct mm_struct *efi_prev_mm;
+static unsigned long efi_cr4_lass;
=20
 /*
  * We need our own copy of the higher levels of the page tables
@@ -443,16 +444,50 @@ static void efi_leave_mm(void)
 	unuse_temporary_mm(efi_prev_mm);
 }
=20
+/*
+ * Toggle LASS to allow EFI to access any 1:1 mapped region in the lower
+ * half.
+ *
+ * Disable LASS only after switching to EFI-mm, as userspace is not
+ * mapped in it. Similar to EFI-mm, these rely on preemption being
+ * disabled and the calls being serialized.
+ */
+
+static void efi_disable_lass(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return;
+
+	lockdep_assert_preemption_disabled();
+
+	/* Save current CR4.LASS state */
+	efi_cr4_lass =3D cr4_read_shadow() & X86_CR4_LASS;
+	cr4_clear_bits(efi_cr4_lass);
+}
+
+static void efi_enable_lass(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_LASS))
+		return;
+
+	lockdep_assert_preemption_disabled();
+
+	/* Reprogram CR4.LASS only if it was set earlier */
+	cr4_set_bits(efi_cr4_lass);
+}
+
 void arch_efi_call_virt_setup(void)
 {
 	efi_sync_low_kernel_mappings();
 	efi_fpu_begin();
 	firmware_restrict_branch_speculation_start();
 	efi_enter_mm();
+	efi_disable_lass();
 }
=20
 void arch_efi_call_virt_teardown(void)
 {
+	efi_enable_lass();
 	efi_leave_mm();
 	firmware_restrict_branch_speculation_end();
 	efi_fpu_end();

