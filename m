Return-Path: <linux-tip-commits+bounces-1452-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFB690D66B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 17:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A761B33E94
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F11A2FC7;
	Tue, 18 Jun 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jEXGVdKW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d+dE0aCz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315716CD01;
	Tue, 18 Jun 2024 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719313; cv=none; b=c66I4Ojh2ca9K0gT2d0awkYXI/XrliQHCd4mR/JWoRjIVOZFrz4wnVeCHivGYF4BfjYgl0uK9fi4VkEAhaJwVr1ozaXKGVS9qoyKom1Fcx9PHZhMp1KXOQSE08oPw5sSWyI52PiWB8Prk+ey6iIq83nCXSA6c5Vmt/PJeKeIUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719313; c=relaxed/simple;
	bh=SU6XXA7AYsjI4uZrCr6kSWYkhKTn8mhUBzzN08UeVkk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I++HtBjeexmP8l4wvY0kK3lciFN/H5GokiqMIsuywi5PZKWq1Ujn+A6KUf1b86/WjO0mz5foJ6ZQPDmBg3sppqY6I9xZbMPGO6ouFHQeVPTbt8+2FiA4HMQzexa/wjO+uSktdwBI5Yntuj4GHa8hZRj+uj177uf5phiPInbvaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jEXGVdKW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d+dE0aCz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZYkwt8W3ao9jnay3BePieKPgsIKpIsomKWx3Os4QiQ=;
	b=jEXGVdKWyrjjrEW85TkMrvxg8ezMZ1R26E4CoVXFK7hDfC9YE9/QQAK5dMMjUq9Gw16Iv/
	odoMoRb7XKiAI+wia0EiF7RULleFpMqw3E8SriCgVmTIf8hA7ydmNsb01v2M2LUKsxF1uM
	Yk5pYZKEzpemYH9LWHtQi1uG5Ye1MDTpc0kJ/mJ208TmG4lWWBHBdw/Vf+5cmN66jzJUMH
	W5h4uB3Jti7nvO5SXHzGP9PxxNbXCzRDIRstzD0IspYtN4EVi3ks+rQlM8m/Fpm34wcGVa
	Ii+TJ0Dbe2uSFWwQPqPHNXArBDA2/Dd57b7cTRiExbp/9a4OYRNtEwod2SX0Eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZYkwt8W3ao9jnay3BePieKPgsIKpIsomKWx3Os4QiQ=;
	b=d+dE0aCzbuncYF2vyzRslPWFdpuNBx5Es08622aHH0wp7cr81P0eiCPFz/GIHUcFEWhH/N
	G2D3l5WyJKcObgDw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cc] x86/mm: Add callbacks to prepare encrypted memory for kexec
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, Kai Huang <kai.huang@intel.com>,
 Tao Liu <ltao@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-11-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-11-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930098.10875.5070684762655415660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     22daa42294b419a0d8060a3870285e7a72aa63e4
Gitweb:        https://git.kernel.org/tip/22daa42294b419a0d8060a3870285e7a72aa63e4
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:55 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:46:02 +02:00

x86/mm: Add callbacks to prepare encrypted memory for kexec

AMD SEV and Intel TDX guests allocate shared buffers for performing I/O.
This is done by allocating pages normally from the buddy allocator and
then converting them to shared using set_memory_decrypted().

On kexec, the second kernel is unaware of which memory has been
converted in this manner. It only sees E820_TYPE_RAM. Accessing shared
memory as private is fatal.

Therefore, the memory state must be reset to its original state before
starting the new kernel with kexec.

The process of converting shared memory back to private occurs in two
steps:

- enc_kexec_begin() stops new conversions.

- enc_kexec_finish() unshares all existing shared memory, reverting it
  back to private.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-11-kirill.shutemov@linux.intel.com
---
 arch/x86/include/asm/x86_init.h | 10 ++++++++++
 arch/x86/kernel/crash.c         | 12 ++++++++++++
 arch/x86/kernel/reboot.c        | 12 ++++++++++++
 arch/x86/kernel/x86_init.c      |  4 ++++
 4 files changed, 38 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 28ac3cb..213cf53 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -149,12 +149,22 @@ struct x86_init_acpi {
  * @enc_status_change_finish	Notify HV after the encryption status of a range is changed
  * @enc_tlb_flush_required	Returns true if a TLB flush is needed before changing page encryption status
  * @enc_cache_flush_required	Returns true if a cache flush is needed before changing page encryption status
+ * @enc_kexec_begin		Begin the two-step process of converting shared memory back
+ *				to private. It stops the new conversions from being started
+ *				and waits in-flight conversions to finish, if possible.
+ * @enc_kexec_finish		Finish the two-step process of converting shared memory to
+ *				private. All memory is private after the call when
+ *				the function returns.
+ *				It is called on only one CPU while the others are shut down
+ *				and with interrupts disabled.
  */
 struct x86_guest {
 	int (*enc_status_change_prepare)(unsigned long vaddr, int npages, bool enc);
 	int (*enc_status_change_finish)(unsigned long vaddr, int npages, bool enc);
 	bool (*enc_tlb_flush_required)(bool enc);
 	bool (*enc_cache_flush_required)(void);
+	void (*enc_kexec_begin)(void);
+	void (*enc_kexec_finish)(void);
 };
 
 /**
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index f065014..340af81 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -128,6 +128,18 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 #ifdef CONFIG_HPET_TIMER
 	hpet_disable();
 #endif
+
+	/*
+	 * Non-crash kexec calls enc_kexec_begin() while scheduling is still
+	 * active. This allows the callback to wait until all in-flight
+	 * shared<->private conversions are complete. In a crash scenario,
+	 * enc_kexec_begin() gets called after all but one CPU have been shut
+	 * down and interrupts have been disabled. This allows the callback to
+	 * detect a race with the conversion and report it.
+	 */
+	x86_platform.guest.enc_kexec_begin();
+	x86_platform.guest.enc_kexec_finish();
+
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index f3130f7..bb7a44a 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/objtool.h>
 #include <linux/pgtable.h>
+#include <linux/kexec.h>
 #include <acpi/reboot.h>
 #include <asm/io.h>
 #include <asm/apic.h>
@@ -716,6 +717,14 @@ static void native_machine_emergency_restart(void)
 
 void native_machine_shutdown(void)
 {
+	/*
+	 * Call enc_kexec_begin() while all CPUs are still active and
+	 * interrupts are enabled. This will allow all in-flight memory
+	 * conversions to finish cleanly.
+	 */
+	if (kexec_in_progress)
+		x86_platform.guest.enc_kexec_begin();
+
 	/* Stop the cpus and apics */
 #ifdef CONFIG_X86_IO_APIC
 	/*
@@ -752,6 +761,9 @@ void native_machine_shutdown(void)
 #ifdef CONFIG_X86_64
 	x86_platform.iommu_shutdown();
 #endif
+
+	if (kexec_in_progress)
+		x86_platform.guest.enc_kexec_finish();
 }
 
 static void __machine_emergency_restart(int emergency)
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index a7143bb..82b128d 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -138,6 +138,8 @@ static int enc_status_change_prepare_noop(unsigned long vaddr, int npages, bool 
 static int enc_status_change_finish_noop(unsigned long vaddr, int npages, bool enc) { return 0; }
 static bool enc_tlb_flush_required_noop(bool enc) { return false; }
 static bool enc_cache_flush_required_noop(void) { return false; }
+static void enc_kexec_begin_noop(void) {}
+static void enc_kexec_finish_noop(void) {}
 static bool is_private_mmio_noop(u64 addr) {return false; }
 
 struct x86_platform_ops x86_platform __ro_after_init = {
@@ -161,6 +163,8 @@ struct x86_platform_ops x86_platform __ro_after_init = {
 		.enc_status_change_finish  = enc_status_change_finish_noop,
 		.enc_tlb_flush_required	   = enc_tlb_flush_required_noop,
 		.enc_cache_flush_required  = enc_cache_flush_required_noop,
+		.enc_kexec_begin	   = enc_kexec_begin_noop,
+		.enc_kexec_finish	   = enc_kexec_finish_noop,
 	},
 };
 

