Return-Path: <linux-tip-commits+bounces-5091-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43578A95EA0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 08:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633C91782B5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 06:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B31E5018;
	Tue, 22 Apr 2025 06:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2q8Xmqa+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MTfUcCx+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A719AD70;
	Tue, 22 Apr 2025 06:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304456; cv=none; b=iF3vCj84jKWrimgStn5n2cR+qGdDRr4nRihqyH/f+7KKjoOLAF7Ie+xianYY5ArAsmbLTbqXf1KUC7irBQ55Fy7l/b4j4c0aLnXR37V2OTEOAxXMMsHI6tDI2wFJb+6R+CRjv/2dgYUXK6j+AhQeN+9v8Id3jANe3pk7ghjHRBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304456; c=relaxed/simple;
	bh=kKNfyiSnq/+RRxAtDqtALUaqXR7lZy9g3Uru2PzPhIc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=axjyxImt9K0VwwEYhZhqn0t4K1Ng/G/hBPGMUwTVseC40fgWSVQyjxis+ArnslEdSrFqmH6YB2wb8Kdbp2x/lGHlLodkPaAjUuQE2NHqZ5TjFQWKstoPnDyzya9Jhqx79P/co9K3YcSFdyJoihd99aXovxc7ctotshTZVvYMVYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2q8Xmqa+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MTfUcCx+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Apr 2025 06:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745304451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3RMqx+YbDFispUHmM7ODzE4FhAI+emW7v3b731XIvQA=;
	b=2q8Xmqa+ofUaWohAewIEYBV8hbSI9cHd8/bBR+LIyzJY8niRT6IO0R0LCC8gDBgvfs1j9D
	/IYAeTMhw62EFkxW2y1paKcubcxTGERzJG7LS/3iuULyiCXrZwAP8WRZD29M82YWQQTAgX
	OG+Q22i1ELDuSPDP7zc7xmdd5mD3UglTYsdBanfAAn21gVnUTNpU6zfDmUKc1OAr2lYc0L
	3LGldfZR8QFnloUvwM7z+R+IWmcgoO7oax98EoKlcXU4Z+B4Rw7cIzc95UPPEN+MQBldZe
	okLRg452xJpp+SIcxbCmLuwevIdpyhoCp0BlUTnfNrxn7BevCIO0/uoRqGKbRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745304451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=3RMqx+YbDFispUHmM7ODzE4FhAI+emW7v3b731XIvQA=;
	b=MTfUcCx+fvaYtPOJePIBVo8C3ksIgGTfZ2Gha6Zsp9xSKkcZRXzv4fk7kdSkJeBgEKm2y3
	QHjCf67PU2lVbICA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/cpu: Help users notice when running old
 Intel microcode
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Andy Lutomirski <luto@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, John Ogness <john.ogness@linutronix.de>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174530444932.31282.15748299566756052894.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     4e2c719782a84702db7fc2dc07ced796f308fec7
Gitweb:        https://git.kernel.org/tip/4e2c719782a84702db7fc2dc07ced796f308fec7
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Tue, 22 Apr 2025 08:32:47 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Apr 2025 08:33:52 +02:00

x86/cpu: Help users notice when running old Intel microcode

Old microcode is bad for users and for kernel developers.

For users, it exposes them to known fixed security and/or functional
issues. These obviously rarely result in instant dumpster fires in
every environment. But it is as important to keep your microcode up
to date as it is to keep your kernel up to date.

Old microcode also makes kernels harder to debug. A developer looking
at an oops need to consider kernel bugs, known CPU issues and unknown
CPU issues as possible causes. If they know the microcode is up to
date, they can mostly eliminate known CPU issues as the cause.

Make it easier to tell if CPU microcode is out of date. Add a list
of released microcode. If the loaded microcode is older than the
release, tell users in a place that folks can find it:

	/sys/devices/system/cpu/vulnerabilities/old_microcode

Tell kernel kernel developers about it with the existing taint
flag:

	TAINT_CPU_OUT_OF_SPEC

== Discussion ==

When a user reports a potential kernel issue, it is very common
to ask them to reproduce the issue on mainline. Running mainline,
they will (independently from the distro) acquire a more up-to-date
microcode version list. If their microcode is old, they will
get a warning about the taint and kernel developers can take that
into consideration when debugging.

Just like any other entry in "vulnerabilities/", users are free to
make their own assessment of their exposure.

== Microcode Revision Discussion ==

The microcode versions in the table were generated from the Intel
microcode git repo:

	8ac9378a8487 ("microcode-20241112 Release")

which as of this writing lags behind the latest microcode-20250211.

It can be argued that the versions that the kernel picks to call "old"
should be a revision or two old. Which specific version is picked is
less important to me than picking *a* version and enforcing it.

This repository contains only microcode versions that Intel has deemed
to be OS-loadable. It is quite possible that the BIOS has loaded a
newer microcode than the latest in this repo. If this happens, the
system is considered to have new microcode, not old.

Specifically, the sysfs file and taint flag answer the question:

	Is the CPU running on the latest OS-loadable microcode,
	or something even later that the BIOS loaded?

In other words, Intel never publishes an authoritative list of CPUs
and latest microcode revisions. Until it does, this is the best that
Linux can do.

Also note that the "intel-ucode-defs.h" file is simple, ugly and
has lots of magic numbers. That's on purpose and should allow a
single file to be shared across lots of stable kernel regardless of if
they have the new "VFM" infrastructure or not. It was generated with
a dumb script.

== FAQ ==

Q: Does this tell me if my system is secure or insecure?
A: No. It only tells you if your microcode was old when the
   system booted.

Q: Should the kernel warn if the microcode list itself is too old?
A: No. New kernels will get new microcode lists, both mainline
   and stable. The only way to have an old list is to be running
   an old kernel in which case you have bigger problems.

Q: Is this for security or functional issues?
A: Both.

Q: If a given microcode update only has functional problems but
   no security issues, will it be considered old?
A: Yes. All microcode image versions within a microcode release
   are treated identically. Intel appears to make security
   updates without disclosing them in the release notes.  Thus,
   all updates are considered to be security-relevant.

Q: Who runs old microcode?
A: Anybody with an old distro. This happens all the time inside
   of Intel where there are lots of weird systems in labs that
   might not be getting regular distro updates and might also
   be running rather exotic microcode images.

Q: If I update my microcode after booting will it stop saying
   "Vulnerable"?
A: No. Just like all the other vulnerabilies, you need to
   reboot before the kernel will reassess your vulnerability.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/all/20250421195659.CF426C07%40davehans-spike.ostc.intel.com
(cherry picked from commit 9127865b15eb0a1bd05ad7efe29489c44394bdc1)
---
 Documentation/ABI/testing/sysfs-devices-system-cpu  |   1 +-
 Documentation/admin-guide/hw-vuln/old_microcode.rst |  21 ++-
 arch/x86/include/asm/cpufeatures.h                  |   2 +-
 arch/x86/kernel/cpu/bugs.c                          |  16 +-
 arch/x86/kernel/cpu/common.c                        |  42 +++-
 arch/x86/kernel/cpu/microcode/intel-ucode-defs.h    | 150 +++++++++++-
 drivers/base/cpu.c                                  |   3 +-
 include/linux/cpu.h                                 |   2 +-
 8 files changed, 237 insertions(+)
 create mode 100644 Documentation/admin-guide/hw-vuln/old_microcode.rst
 create mode 100644 arch/x86/kernel/cpu/microcode/intel-ucode-defs.h

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 206079d..766a974 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -516,6 +516,7 @@ What:		/sys/devices/system/cpu/vulnerabilities
 		/sys/devices/system/cpu/vulnerabilities/mds
 		/sys/devices/system/cpu/vulnerabilities/meltdown
 		/sys/devices/system/cpu/vulnerabilities/mmio_stale_data
+		/sys/devices/system/cpu/vulnerabilities/old_microcode
 		/sys/devices/system/cpu/vulnerabilities/reg_file_data_sampling
 		/sys/devices/system/cpu/vulnerabilities/retbleed
 		/sys/devices/system/cpu/vulnerabilities/spec_store_bypass
diff --git a/Documentation/admin-guide/hw-vuln/old_microcode.rst b/Documentation/admin-guide/hw-vuln/old_microcode.rst
new file mode 100644
index 0000000..6ded8f8
--- /dev/null
+++ b/Documentation/admin-guide/hw-vuln/old_microcode.rst
@@ -0,0 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Old Microcode
+=============
+
+The kernel keeps a table of released microcode. Systems that had
+microcode older than this at boot will say "Vulnerable".  This means
+that the system was vulnerable to some known CPU issue. It could be
+security or functional, the kernel does not know or care.
+
+You should update the CPU microcode to mitigate any exposure. This is
+usually accomplished by updating the files in
+/lib/firmware/intel-ucode/ via normal distribution updates. Intel also
+distributes these files in a github repo:
+
+	https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files.git
+
+Just like all the other hardware vulnerabilities, exposure is
+determined at boot. Runtime microcode updates do not change the status
+of this vulnerability.
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index bc81b9d..426c7e8 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -533,4 +533,6 @@
 #define X86_BUG_BHI			X86_BUG( 1*32+ 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET		X86_BUG( 1*32+ 4) /* "ibpb_no_ret" IBPB omits return target predictions */
 #define X86_BUG_SPECTRE_V2_USER		X86_BUG( 1*32+ 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
+#define X86_BUG_OLD_MICROCODE		X86_BUG( 1*32+ 6) /* "old_microcode" CPU has old microcode, it is surely vulnerable to something */
+
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 606c0cb..aa9f86b 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2794,6 +2794,14 @@ static ssize_t rfds_show_state(char *buf)
 	return sysfs_emit(buf, "%s\n", rfds_strings[rfds_mitigation]);
 }
 
+static ssize_t old_microcode_show_state(char *buf)
+{
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return sysfs_emit(buf, "Unknown: running under hypervisor");
+
+	return sysfs_emit(buf, "Vulnerable\n");
+}
+
 static char *stibp_state(void)
 {
 	if (spectre_v2_in_eibrs_mode(spectre_v2_enabled) &&
@@ -2975,6 +2983,9 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 	case X86_BUG_RFDS:
 		return rfds_show_state(buf);
 
+	case X86_BUG_OLD_MICROCODE:
+		return old_microcode_show_state(buf);
+
 	default:
 		break;
 	}
@@ -3051,6 +3062,11 @@ ssize_t cpu_show_reg_file_data_sampling(struct device *dev, struct device_attrib
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_RFDS);
 }
+
+ssize_t cpu_show_old_microcode(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return cpu_show_common(dev, attr, buf, X86_BUG_OLD_MICROCODE);
+}
 #endif
 
 void __warn_thunk(void)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 4ada55f..19893eb 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1318,10 +1318,52 @@ static bool __init vulnerable_to_rfds(u64 x86_arch_cap_msr)
 	return cpu_matches(cpu_vuln_blacklist, RFDS);
 }
 
+static struct x86_cpu_id cpu_latest_microcode[] = {
+#include "microcode/intel-ucode-defs.h"
+	{}
+};
+
+static bool __init cpu_has_old_microcode(void)
+{
+	const struct x86_cpu_id *m = x86_match_cpu(cpu_latest_microcode);
+
+	/* Give unknown CPUs a pass: */
+	if (!m) {
+		/* Intel CPUs should be in the list. Warn if not: */
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+			pr_info("x86/CPU: Model not found in latest microcode list\n");
+		return false;
+	}
+
+	/*
+	 * Hosts usually lie to guests with a super high microcode
+	 * version. Just ignore what hosts tell guests:
+	 */
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return false;
+
+	/* Consider all debug microcode to be old: */
+	if (boot_cpu_data.microcode & BIT(31))
+		return true;
+
+	/* Give new microcode a pass: */
+	if (boot_cpu_data.microcode >= m->driver_data)
+		return false;
+
+	/* Uh oh, too old: */
+	return true;
+}
+
 static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 {
 	u64 x86_arch_cap_msr = x86_read_arch_cap_msr();
 
+	if (cpu_has_old_microcode()) {
+		pr_warn("x86/CPU: Running old microcode\n");
+		setup_force_cpu_bug(X86_BUG_OLD_MICROCODE);
+		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	}
+
 	/* Set ITLB_MULTIHIT bug if cpu is not in the whitelist and not mitigated */
 	if (!cpu_matches(cpu_vuln_whitelist, NO_ITLB_MULTIHIT) &&
 	    !(x86_arch_cap_msr & ARCH_CAP_PSCHANGE_MC_NO))
diff --git a/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
new file mode 100644
index 0000000..cb6e601
--- /dev/null
+++ b/arch/x86/kernel/cpu/microcode/intel-ucode-defs.h
@@ -0,0 +1,150 @@
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x03, .steppings = 0x0004, .driver_data = 0x2 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0001, .driver_data = 0x45 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0002, .driver_data = 0x40 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0004, .driver_data = 0x2c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x05, .steppings = 0x0008, .driver_data = 0x10 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0001, .driver_data = 0xa },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0020, .driver_data = 0x3 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x0400, .driver_data = 0xd },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x06, .steppings = 0x2000, .driver_data = 0x7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0002, .driver_data = 0x14 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0004, .driver_data = 0x38 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x07, .steppings = 0x0008, .driver_data = 0x2e },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0002, .driver_data = 0x11 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0008, .driver_data = 0x8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0040, .driver_data = 0xc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x08, .steppings = 0x0400, .driver_data = 0x5 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x09, .steppings = 0x0020, .driver_data = 0x47 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0a, .steppings = 0x0001, .driver_data = 0x3 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0a, .steppings = 0x0002, .driver_data = 0x1 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0b, .steppings = 0x0002, .driver_data = 0x1d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0b, .steppings = 0x0010, .driver_data = 0x2 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0d, .steppings = 0x0040, .driver_data = 0x18 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0e, .steppings = 0x0100, .driver_data = 0x39 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0e, .steppings = 0x1000, .driver_data = 0x59 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0004, .driver_data = 0x5d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0040, .driver_data = 0xd2 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0080, .driver_data = 0x6b },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0400, .driver_data = 0x95 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x0800, .driver_data = 0xbc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x0f, .steppings = 0x2000, .driver_data = 0xa4 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x16, .steppings = 0x0002, .driver_data = 0x44 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0040, .driver_data = 0x60f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0080, .driver_data = 0x70a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x17, .steppings = 0x0400, .driver_data = 0xa0b },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1a, .steppings = 0x0010, .driver_data = 0x12 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1a, .steppings = 0x0020, .driver_data = 0x1d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1c, .steppings = 0x0004, .driver_data = 0x219 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1c, .steppings = 0x0400, .driver_data = 0x107 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1d, .steppings = 0x0002, .driver_data = 0x29 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x1e, .steppings = 0x0020, .driver_data = 0xa },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x25, .steppings = 0x0004, .driver_data = 0x11 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x25, .steppings = 0x0020, .driver_data = 0x7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x26, .steppings = 0x0002, .driver_data = 0x105 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2a, .steppings = 0x0080, .driver_data = 0x2f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2c, .steppings = 0x0004, .driver_data = 0x1f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2d, .steppings = 0x0040, .driver_data = 0x621 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2d, .steppings = 0x0080, .driver_data = 0x71a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2e, .steppings = 0x0040, .driver_data = 0xd },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x2f, .steppings = 0x0004, .driver_data = 0x3b },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x37, .steppings = 0x0100, .driver_data = 0x838 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x37, .steppings = 0x0200, .driver_data = 0x90d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3a, .steppings = 0x0200, .driver_data = 0x21 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3c, .steppings = 0x0008, .driver_data = 0x28 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3d, .steppings = 0x0010, .driver_data = 0x2f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0010, .driver_data = 0x42e },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0040, .driver_data = 0x600 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3e, .steppings = 0x0080, .driver_data = 0x715 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3f, .steppings = 0x0004, .driver_data = 0x49 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x3f, .steppings = 0x0010, .driver_data = 0x1a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x45, .steppings = 0x0002, .driver_data = 0x26 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x46, .steppings = 0x0002, .driver_data = 0x1c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x47, .steppings = 0x0002, .driver_data = 0x22 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4c, .steppings = 0x0008, .driver_data = 0x368 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4c, .steppings = 0x0010, .driver_data = 0x411 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4d, .steppings = 0x0100, .driver_data = 0x12d },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x4e, .steppings = 0x0008, .driver_data = 0xf0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0008, .driver_data = 0x1000191 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0010, .driver_data = 0x2007006 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0020, .driver_data = 0x3000010 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0040, .driver_data = 0x4003605 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0080, .driver_data = 0x5003707 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x55, .steppings = 0x0800, .driver_data = 0x7002904 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0004, .driver_data = 0x1c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0008, .driver_data = 0x700001c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0010, .driver_data = 0xf00001a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x56, .steppings = 0x0020, .driver_data = 0xe000015 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0004, .driver_data = 0x14 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0200, .driver_data = 0x48 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5c, .steppings = 0x0400, .driver_data = 0x28 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5e, .steppings = 0x0008, .driver_data = 0xf0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x5f, .steppings = 0x0002, .driver_data = 0x3e },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x66, .steppings = 0x0008, .driver_data = 0x2a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0020, .driver_data = 0xc0002f0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6a, .steppings = 0x0040, .driver_data = 0xd0003e7 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x6c, .steppings = 0x0002, .driver_data = 0x10002b0 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0002, .driver_data = 0x42 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7a, .steppings = 0x0100, .driver_data = 0x24 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x7e, .steppings = 0x0020, .driver_data = 0xc6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8a, .steppings = 0x0002, .driver_data = 0x33 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0002, .driver_data = 0xb8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8c, .steppings = 0x0004, .driver_data = 0x38 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8d, .steppings = 0x0002, .driver_data = 0x52 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0200, .driver_data = 0xf6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0400, .driver_data = 0xf6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x0800, .driver_data = 0xf6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8e, .steppings = 0x1000, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0100, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0080, .driver_data = 0x2b000603 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0040, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0020, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x8f, .steppings = 0x0010, .driver_data = 0x2c000390 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x96, .steppings = 0x0002, .driver_data = 0x1a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0004, .driver_data = 0x37 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x97, .steppings = 0x0020, .driver_data = 0x37 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0004, .driver_data = 0x37 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbf, .steppings = 0x0020, .driver_data = 0x37 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0008, .driver_data = 0x435 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9a, .steppings = 0x0010, .driver_data = 0x435 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9c, .steppings = 0x0001, .driver_data = 0x24000026 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0200, .driver_data = 0xf8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0400, .driver_data = 0xf8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x0800, .driver_data = 0xf6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x1000, .driver_data = 0xf8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0x9e, .steppings = 0x2000, .driver_data = 0x100 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0004, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0008, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa5, .steppings = 0x0020, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0001, .driver_data = 0xfe },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa6, .steppings = 0x0002, .driver_data = 0xfc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xa7, .steppings = 0x0002, .driver_data = 0x62 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xaa, .steppings = 0x0010, .driver_data = 0x20 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xb7, .steppings = 0x0002, .driver_data = 0x12b },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0004, .driver_data = 0x4123 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0008, .driver_data = 0x4123 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xba, .steppings = 0x0100, .driver_data = 0x4123 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xbe, .steppings = 0x0001, .driver_data = 0x1a },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0004, .driver_data = 0x21000283 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0x6,  .model = 0xcf, .steppings = 0x0002, .driver_data = 0x21000283 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x00, .steppings = 0x0080, .driver_data = 0x12 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x00, .steppings = 0x0400, .driver_data = 0x15 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x01, .steppings = 0x0004, .driver_data = 0x2e },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0010, .driver_data = 0x21 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0020, .driver_data = 0x2c },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0040, .driver_data = 0x10 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0080, .driver_data = 0x39 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x02, .steppings = 0x0200, .driver_data = 0x2f },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0004, .driver_data = 0xa },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0008, .driver_data = 0xc },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x03, .steppings = 0x0010, .driver_data = 0x17 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0002, .driver_data = 0x17 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0008, .driver_data = 0x5 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0010, .driver_data = 0x6 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0080, .driver_data = 0x3 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0100, .driver_data = 0xe },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0200, .driver_data = 0x3 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x04, .steppings = 0x0400, .driver_data = 0x4 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0004, .driver_data = 0xf },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0010, .driver_data = 0x4 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0020, .driver_data = 0x8 },
+{ .flags = X86_CPU_ID_FLAG_ENTRY_VALID, .vendor = X86_VENDOR_INTEL, .family = 0xf,  .model = 0x06, .steppings = 0x0100, .driver_data = 0x9 },
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index a7e5118..1c43593 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -600,6 +600,7 @@ CPU_SHOW_VULN_FALLBACK(spec_rstack_overflow);
 CPU_SHOW_VULN_FALLBACK(gds);
 CPU_SHOW_VULN_FALLBACK(reg_file_data_sampling);
 CPU_SHOW_VULN_FALLBACK(ghostwrite);
+CPU_SHOW_VULN_FALLBACK(old_microcode);
 
 static DEVICE_ATTR(meltdown, 0444, cpu_show_meltdown, NULL);
 static DEVICE_ATTR(spectre_v1, 0444, cpu_show_spectre_v1, NULL);
@@ -616,6 +617,7 @@ static DEVICE_ATTR(spec_rstack_overflow, 0444, cpu_show_spec_rstack_overflow, NU
 static DEVICE_ATTR(gather_data_sampling, 0444, cpu_show_gds, NULL);
 static DEVICE_ATTR(reg_file_data_sampling, 0444, cpu_show_reg_file_data_sampling, NULL);
 static DEVICE_ATTR(ghostwrite, 0444, cpu_show_ghostwrite, NULL);
+static DEVICE_ATTR(old_microcode, 0444, cpu_show_old_microcode, NULL);
 
 static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_meltdown.attr,
@@ -633,6 +635,7 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	&dev_attr_gather_data_sampling.attr,
 	&dev_attr_reg_file_data_sampling.attr,
 	&dev_attr_ghostwrite.attr,
+	&dev_attr_old_microcode.attr,
 	NULL
 };
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index e304954..1f5cfc4 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -78,6 +78,8 @@ extern ssize_t cpu_show_gds(struct device *dev,
 extern ssize_t cpu_show_reg_file_data_sampling(struct device *dev,
 					       struct device_attribute *attr, char *buf);
 extern ssize_t cpu_show_ghostwrite(struct device *dev, struct device_attribute *attr, char *buf);
+extern ssize_t cpu_show_old_microcode(struct device *dev,
+				      struct device_attribute *attr, char *buf);
 
 extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,

