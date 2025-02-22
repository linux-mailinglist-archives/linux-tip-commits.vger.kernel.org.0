Return-Path: <linux-tip-commits+bounces-3598-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40865A40822
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 12:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F51F17E60A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 22 Feb 2025 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C9E20ADFA;
	Sat, 22 Feb 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bXDGtFq4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hbfaJwLI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CEF1FA16B;
	Sat, 22 Feb 2025 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225385; cv=none; b=I5YCH7QFpdW/PAWP+fuWxv/hsl4QecCifErsA+EnisVJnfIMbburAoBehEy5NNfYueFlPe9d7H4idAO+yAsuL1KYGTtoyTugtoBUkKRTcoP2UZ/vqRwgnAzpf8DWo9PDtYlc5YzUGqpiJB/Uusq6SF50C+g2cmEoQFaSTm5fEJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225385; c=relaxed/simple;
	bh=3RM89jLMulqKp32A2RW2AtEeXu3EKldqa0oMgl1f230=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e4CR4auXEBQIhkA2nxhfxzdA4LOsjFdK/mTRZ7ST+3guwfoz13930ezSoy82qGgrsWI2jkJfyTynAqn+K9CEEQdI827Zj3+TVT5K8grCDxS+g4ese0tqCUn+0etF7pQPFg8qn2BYO+ZY/gTQevo8G/6M5Tk4HRoV6nIdRwFVTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bXDGtFq4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hbfaJwLI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 22 Feb 2025 11:56:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740225380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDK7yeWwvOqaeDzDdPIPBEkV1kOeKIcvKG/lmJ0VH8E=;
	b=bXDGtFq4E2aOrqKKV/K4L6ZTlLqxXjMleQEyobLthLV+hOI1vYZx1EJyXILxT4VYP2r99g
	3cs+weWt5143zf2QAnVOqKoJf5/e+WOGbR1FbiY3pVhZVmfdI9v+UmOVgu0MBgiFzMjIUH
	EtULQJuARfkR8EXxFLcmLEKHQrttK/BioOmw92/gvCC3IHsNQFeo/+pO9Z2KGdlZHAfLEv
	jXBV0GQl5IJfBs/suJKDSZhmiKFAjaPmoWGT+nOOWNPeqMgGNKj5I5JSIEUv8X/mVHoVxw
	Vlf224GAAyYJhMO0P+2txwjhxSMIDr24PE6iWwTW81nD6UnMWNvQ3VTa0HORLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740225380;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDK7yeWwvOqaeDzDdPIPBEkV1kOeKIcvKG/lmJ0VH8E=;
	b=hbfaJwLILmMC8VrHGteKkv5StYMSwBqL05pmruKBAYm/u+dEKdvVv+lsw9d+zf70Qtx7iJ
	ARDAUPnVXrwVWrDg==
From: "tip-bot2 for Dave Young" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/kexec: Export e820_table_kexec[] to sysfs
Cc: Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Ashish Kalra <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Z5jcb1GKhLvH8kDc@darkstar.users.ipa.redhat.com>
References: <Z5jcb1GKhLvH8kDc@darkstar.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174022537912.10177.11644259763508387652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     a2498e5c453b3d8d054d77751487cd593332f8c2
Gitweb:        https://git.kernel.org/tip/a2498e5c453b3d8d054d77751487cd593332f8c2
Author:        Dave Young <dyoung@redhat.com>
AuthorDate:    Tue, 28 Jan 2025 21:32:31 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 22 Feb 2025 12:44:45 +01:00

x86/kexec: Export e820_table_kexec[] to sysfs

Previously the e820_table_kexec[] was exported to sysfs since kexec-tools uses
the memmap entries to prepare the e820 table for the new kernel.

The following commit, ~8 years ago, introduced e820_table_firmware[] and changed
the behavior to export the firmware table instead:

  12df216c61c8 ("x86/boot/e820: Introduce the bootloader provided e820_table_firmware[] table")

Originally the kexec_file_load and kexec_load syscalls both used e820_table_kexec[].
Since the sysfs exported entries are from e820_table_firmware[] people
now need to tune both tables for kexec.

Restore the old behavior so the kexec_load and kexec_file_load syscalls work with
only one table update.  The e820_table_firmware[] is used by hibernation kernel
code and it works without the sysfs exporting. Also remove the SEV
e820_table_firmware[] updating code.

Also update the code comments here and drop the comments about setup_data
reservation since it is not needed any more after this change was made
a year ago:

  fc7f27cda843 ("x86/kexec: Do not update E820 kexec table for setup_data")

[ mingo: Tidy up the changelog and comments. ]

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ashish Kalra <ashish.kalra@amd.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Link: https://lore.kernel.org/r/Z5jcb1GKhLvH8kDc@darkstar.users.ipa.redhat.com
---
 arch/x86/kernel/e820.c  | 20 ++++++++++----------
 arch/x86/virt/svm/sev.c |  1 -
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 9fb67ab..57120f0 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -28,18 +28,13 @@
  *   the first 128 E820 memory entries in boot_params.e820_table and the remaining
  *   (if any) entries of the SETUP_E820_EXT nodes. We use this to:
  *
- *       - inform the user about the firmware's notion of memory layout
- *         via /sys/firmware/memmap
- *
  *       - the hibernation code uses it to generate a kernel-independent CRC32
  *         checksum of the physical memory layout of a system.
  *
  * - 'e820_table_kexec': a slightly modified (by the kernel) firmware version
  *   passed to us by the bootloader - the major difference between
- *   e820_table_firmware[] and this one is that, the latter marks the setup_data
- *   list created by the EFI boot stub as reserved, so that kexec can reuse the
- *   setup_data information in the second kernel. Besides, e820_table_kexec[]
- *   might also be modified by the kexec itself to fake a mptable.
+ *   e820_table_firmware[] and this one is that e820_table_kexec[]
+ *   might be modified by the kexec itself to fake an mptable.
  *   We use this to:
  *
  *       - kexec, which is a bootloader in disguise, uses the original E820
@@ -47,6 +42,11 @@
  *         can have a restricted E820 map while the kexec()-ed kexec-kernel
  *         can have access to full memory - etc.
  *
+ *         Export the memory layout via /sys/firmware/memmap. kexec-tools uses
+ *         the entries to create an E820 table for the kexec kernel.
+ *
+ *         kexec_file_load in-kernel code uses the table for the kexec kernel.
+ *
  * - 'e820_table': this is the main E820 table that is massaged by the
  *   low level x86 platform code, or modified by boot parameters, before
  *   passed on to higher level MM layers.
@@ -1117,9 +1117,9 @@ void __init e820__reserve_resources(void)
 		res++;
 	}
 
-	/* Expose the bootloader-provided memory layout to the sysfs. */
-	for (i = 0; i < e820_table_firmware->nr_entries; i++) {
-		struct e820_entry *entry = e820_table_firmware->entries + i;
+	/* Expose the kexec e820 table to the sysfs. */
+	for (i = 0; i < e820_table_kexec->nr_entries; i++) {
+		struct e820_entry *entry = e820_table_kexec->entries + i;
 
 		firmware_map_add_early(entry->addr, entry->addr + entry->size, e820_type_to_string(entry));
 	}
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 42e74a5..fc473ca 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -198,7 +198,6 @@ static void __init __snp_fixup_e820_tables(u64 pa)
 		pr_info("Reserving start/end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
 		e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		e820__range_update_table(e820_table_kexec, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
-		e820__range_update_table(e820_table_firmware, pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
 		if (!memblock_is_region_reserved(pa, PMD_SIZE))
 			memblock_reserve(pa, PMD_SIZE);
 	}

