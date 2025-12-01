Return-Path: <linux-tip-commits+bounces-7570-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C78C99223
	for <lists+linux-tip-commits@lfdr.de>; Mon, 01 Dec 2025 22:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C5414E1E0D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Dec 2025 21:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE62080C8;
	Mon,  1 Dec 2025 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YBjG/KaF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UU7BEZFW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826B7E110;
	Mon,  1 Dec 2025 21:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764623144; cv=none; b=a2xb/Y5SxbM3G7v9oyf5OpUaseSi7gsL8tBzCkEI2izfwoSXj8g07PiOUhipsNJaMxImAGbGLllQv407v5Cw7hfoZyo7T1+q5a2STpvNBlHn2ehpSxLGwCqT/rBJ+2tShdijLye3XEJpJFTdcRA5smktRDFSHdNWL7ydgrcXNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764623144; c=relaxed/simple;
	bh=zLgrK2X5NbLnB7HjCS+91657gz2jEu8YhiYPj9I9oZk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uHpNrvbqAiL3CqaqI/8r1bG0Od4VDA+acXF4fNY7F+3jNaCDBVSy0U/bpgcaapr6LW08S/kqFX4Vp8aZchyNL1Fre8DIdjfGllD2w7tsKSJ91kA/SuYP36Vzr/8gtTXDH0STNAB19iOs49cT7oB059dPjVRsR7QmiXZmsI3QET4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YBjG/KaF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UU7BEZFW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Dec 2025 21:05:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764623140;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWCFRb6dxUp0REvaNMPjTp8tzmXNb48jEuNIDvPCVd4=;
	b=YBjG/KaFGkcpdP4xDPBQ1a1UeEnp+mtmrM4LVcAZD8otiUSRPYtu9zzgS16jSTnASdlHcL
	jBFVvc7nyhFJ3leV4oQqxdwEH4+nSDGfW2hyWCLTxhwVQ483d89mFd/sjBe6bUDShpNbRs
	vqa+XtimyM19SkIkOusbFVSb3BDjE85rIIiTQ+wA7aMMbd9a0ICpcJB08kOEzcjBnNy/Am
	+8B2uMNOwKLrTzUWxG8Lsbd4rgSGoGN3zxWIXE6VivWvjvpjfhFmhH6QLQwIJqd407h3Vc
	3SYlf7devSDThr0SBfZ0bW7edyJPPsFcM6Dd49Kii7X0ke3Pt3omQ4UrUaBJAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764623140;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OWCFRb6dxUp0REvaNMPjTp8tzmXNb48jEuNIDvPCVd4=;
	b=UU7BEZFWw9y6oe3x65MIcG7y4+Gp9/FogBD9FzPibznh4zurKsZAVdrUg92PeMlBD3ba75
	HpscPb2LZQKl71Bg==
From: "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/platform: Fix and extend kernel-doc comments in
 <asm/x86_init.h>
Cc: Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251129002524.1196500-1-rdunlap@infradead.org>
References: <20251129002524.1196500-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176462313834.498.5181838930528192494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     33b4c26d4d3ccd24d9721a577671f2c73c1a7cd9
Gitweb:        https://git.kernel.org/tip/33b4c26d4d3ccd24d9721a577671f2c73c1=
a7cd9
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Fri, 28 Nov 2025 16:25:24 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Dec 2025 21:57:16 +01:00

x86/platform: Fix and extend kernel-doc comments in <asm/x86_init.h>

Fix most (17) kernel-doc warnings in x86_init.h (except for struct
x86_init_ops). The changes are:

- fix struct member name typos
- add ending ':' to struct member names
- add some missing struct member descriptions

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251129002524.1196500-1-rdunlap@infradead.org
---
 arch/x86/include/asm/x86_init.h | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 36698cc..6c8a6ea 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -79,7 +79,7 @@ struct x86_init_paging {
=20
 /**
  * struct x86_init_timers - platform specific timer setup
- * @setup_perpcu_clockev:	set up the per cpu clock event device for the
+ * @setup_percpu_clockev:	set up the per cpu clock event device for the
  *				boot cpu
  * @timer_init:			initialize the platform timer (default PIT/HPET)
  * @wallclock_init:		init the wallclock device
@@ -132,7 +132,7 @@ struct x86_hyper_init {
=20
 /**
  * struct x86_init_acpi - x86 ACPI init functions
- * @set_root_poitner:		set RSDP address
+ * @set_root_pointer:		set RSDP address
  * @get_root_pointer:		get RSDP address
  * @reduced_hw_early_init:	hardware reduced platform early init
  */
@@ -145,14 +145,14 @@ struct x86_init_acpi {
 /**
  * struct x86_guest - Functions used by misc guest incarnations like SEV, TD=
X, etc.
  *
- * @enc_status_change_prepare	Notify HV before the encryption status of a ra=
nge is changed
- * @enc_status_change_finish	Notify HV after the encryption status of a rang=
e is changed
- * @enc_tlb_flush_required	Returns true if a TLB flush is needed before chan=
ging page encryption status
- * @enc_cache_flush_required	Returns true if a cache flush is needed before =
changing page encryption status
- * @enc_kexec_begin		Begin the two-step process of converting shared memory =
back
+ * @enc_status_change_prepare:	Notify HV before the encryption status of a r=
ange is changed
+ * @enc_status_change_finish:	Notify HV after the encryption status of a ran=
ge is changed
+ * @enc_tlb_flush_required:	Returns true if a TLB flush is needed before cha=
nging page encryption status
+ * @enc_cache_flush_required:	Returns true if a cache flush is needed before=
 changing page encryption status
+ * @enc_kexec_begin:		Begin the two-step process of converting shared memory=
 back
  *				to private. It stops the new conversions from being started
  *				and waits in-flight conversions to finish, if possible.
- * @enc_kexec_finish		Finish the two-step process of converting shared memor=
y to
+ * @enc_kexec_finish:		Finish the two-step process of converting shared memo=
ry to
  *				private. All memory is private after the call when
  *				the function returns.
  *				It is called on only one CPU while the others are shut down
@@ -229,7 +229,7 @@ struct x86_legacy_devices {
  *	given platform/subarch.
  * @X86_LEGACY_I8042_FIRMWARE_ABSENT: firmware reports that the controller
  *	is absent.
- * @X86_LEGACY_i8042_EXPECTED_PRESENT: the controller is likely to be
+ * @X86_LEGACY_I8042_EXPECTED_PRESENT: the controller is likely to be
  *	present, the i8042 driver should probe for controller existence.
  */
 enum x86_legacy_i8042_state {
@@ -244,6 +244,8 @@ enum x86_legacy_i8042_state {
  * @i8042: indicated if we expect the device to have i8042 controller
  *	present.
  * @rtc: this device has a CMOS real-time clock present
+ * @warm_reset: 1 if platform allows warm reset, else 0
+ * @no_vga: 1 if (FADT.boot_flags & ACPI_FADT_NO_VGA) is set, else 0
  * @reserve_bios_regions: boot code will search for the EBDA address and the
  * 	start of the 640k - 1M BIOS region.  If false, the platform must
  * 	ensure that its memory map correctly reserves sub-1MB regions as needed.
@@ -290,9 +292,10 @@ struct x86_hyper_runtime {
  * @calibrate_tsc:		calibrate TSC, if different from CPU
  * @get_wallclock:		get time from HW clock like RTC etc.
  * @set_wallclock:		set time back to HW clock
- * @is_untracked_pat_range	exclude from PAT logic
- * @nmi_init			enable NMI on cpus
- * @get_nmi_reason		get the reason an NMI was received
+ * @iommu_shutdown:		set by an IOMMU driver for shutdown if necessary
+ * @is_untracked_pat_range:	exclude from PAT logic
+ * @nmi_init:			enable NMI on cpus
+ * @get_nmi_reason:		get the reason an NMI was received
  * @save_sched_clock_state:	save state for sched_clock() on suspend
  * @restore_sched_clock_state:	restore state for sched_clock() on resume
  * @apic_post_init:		adjust apic if needed
@@ -307,6 +310,7 @@ struct x86_hyper_runtime {
  * @realmode_reserve:		reserve memory for realmode trampoline
  * @realmode_init:		initialize realmode trampoline
  * @hyper:			x86 hypervisor specific runtime callbacks
+ * @guest:			guest incarnations callbacks
  */
 struct x86_platform_ops {
 	unsigned long (*calibrate_cpu)(void);

