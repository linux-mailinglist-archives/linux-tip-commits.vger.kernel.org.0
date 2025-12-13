Return-Path: <linux-tip-commits+bounces-7646-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ADECBA806
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 11:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 693A230F579F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7CE2F5A02;
	Sat, 13 Dec 2025 10:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XX0zFpXw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mfy/D8Mh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821C12F60A4;
	Sat, 13 Dec 2025 10:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620445; cv=none; b=Mdc/eZ6PWNx0D4oWjWN/UdSAd33WBzbRavZQPQYtwAENtM9N1PxNB+PSguN2CYPk75oj07nnuu8nuyiEhCwReS77auR9kCEPalBSzHHsU+SNufU5+kZpPfUFm+PCArW1V5qqALzOpJ56E14W1EtLmXpJtd1jXKZ0KCFAvshuNRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620445; c=relaxed/simple;
	bh=dRDMeWoIX5hzWFQfU6TzkiopiemPZy4QP1JI3NN49Jo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=HdMWUZA6UxpCd4s9fYIOhHuHyjq0AgTgQjsF+Ms6vC0VCrOe+81BAwCUe2+T+2od4qWAgF85Fk9aOkyFl7hcrqua9a5GATqD2xjHqD6xUnDny58Y1PZNveT6BfUdSW1gbWFDX2t/3n/jUQDOfUz6CZgF1C13xH5l8LK1EsdBa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XX0zFpXw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mfy/D8Mh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Dec 2025 10:07:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765620442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=h/fmLOb6cfaDS+GNDCWX/PfGIac5HAPkst6Em0NP178=;
	b=XX0zFpXwzsEPGlnK8WHEU/Xqv6psI51K1cLa/dKgsegEhqPhS8EJqXcluGgP1V2yDN+5Gs
	XCK+7ru1ciBVe27Cd3091FmCIggP7OxwI7rxfraDVrjPNg22XNuxUS0AiPRbqNw+0Jk+TZ
	eZjSPggTnxSWRGnP9Od8+g5AQAiT5oERQ08bpt6zwWD3YvsOoHJhaMQ7glgvPdWWAu0OGd
	tXteaHR5CmMCrBWHDOD8sDXZhAmt2+4gOad2dfPcfvvO/c/f0sv+hXNI1QIRD/HxbF4Z4j
	rPvxq9Oe2zldt8HZAuMfyfRdFJUpnJKxrFfg0ekdab2tyA4k6Ffnvh6p4DBj2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765620442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=h/fmLOb6cfaDS+GNDCWX/PfGIac5HAPkst6Em0NP178=;
	b=Mfy/D8Mh+tLtA4U/+vAcPJ1II+eMdcqKofIOgKmCaIA+eBfpWUDJ3My6LawK3PkgTVCiiE
	GH2fRy5k1X0yTyAQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/boot] x86/acpi/boot: Correct acpi_is_processor_usable() check again
Cc: Michal Pecio <michal.pecio@gmail.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176562044083.498.10441108967564582257.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     825c5d67c389426b71710d89dd9cb428e6a7e81e
Gitweb:        https://git.kernel.org/tip/825c5d67c389426b71710d89dd9cb428e6a=
7e81e
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 11 Nov 2025 14:53:57=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 13 Dec 2025 11:00:28 +01:00

x86/acpi/boot: Correct acpi_is_processor_usable() check again

ACPI v6.3 defined a new "Online Capable" MADT LAPIC flag. This bit is
used in conjunction with the "Enabled" MADT LAPIC flag to determine if
a CPU can be enabled/hotplugged by the OS after boot.

Before the new bit was defined, the "Enabled" bit was explicitly
described like this (ACPI v6.0 wording provided):

  "If zero, this processor is unusable, and the operating system
  support will not attempt to use it"

This means that CPU hotplug (based on MADT) is not possible. Many BIOS
implementations follow this guidance. They may include LAPIC entries in
MADT for unavailable CPUs, but since these entries are marked with
"Enabled=3D0" it is expected that the OS will completely ignore these
entries.

However, QEMU will do the same (include entries with "Enabled=3D0") for
the purpose of allowing CPU hotplug within the guest.

Comment from QEMU function pc_madt_cpu_entry():

  /* ACPI spec says that LAPIC entry for non present
   * CPU may be omitted from MADT or it must be marked
   * as disabled. However omitting non present CPU from
   * MADT breaks hotplug on linux. So possible CPUs
   * should be put in MADT but kept disabled.
   */

Recent Linux topology changes broke the QEMU use case. A following fix
for the QEMU use case broke bare metal topology enumeration.

Rework the Linux MADT LAPIC flags check to allow the QEMU use case only
for guests and to maintain the ACPI spec behavior for bare metal.

Remove an unnecessary check added to fix a bare metal case introduced by
the QEMU "fix".

  [ bp: Change logic as Michal suggested. ]
  [ mingo: Removed misapplied -stable tag. ]

Fixes: fed8d8773b8e ("x86/acpi/boot: Correct acpi_is_processor_usable() check=
")
Fixes: f0551af02130 ("x86/topology: Ignore non-present APIC IDs in a present =
package")
Closes: https://lore.kernel.org/r/20251024204658.3da9bf3f.michal.pecio@gmail.=
com
Reported-by: Michal Pecio <michal.pecio@gmail.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Michal Pecio <michal.pecio@gmail.com>
Tested-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Link: https://lore.kernel.org/20251111145357.4031846-1-yazen.ghannam@amd.com
---
 arch/x86/kernel/acpi/boot.c    | 12 ++++++++----
 arch/x86/kernel/cpu/topology.c | 15 ---------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9fa321a..d6138b2 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -35,6 +35,7 @@
 #include <asm/smp.h>
 #include <asm/i8259.h>
 #include <asm/setup.h>
+#include <asm/hypervisor.h>
=20
 #include "sleep.h" /* To include x86_acpi_suspend_lowlevel */
 static int __initdata acpi_force =3D 0;
@@ -164,11 +165,14 @@ static bool __init acpi_is_processor_usable(u32 lapic_f=
lags)
 	if (lapic_flags & ACPI_MADT_ENABLED)
 		return true;
=20
-	if (!acpi_support_online_capable ||
-	    (lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
-		return true;
+	if (acpi_support_online_capable)
+		return lapic_flags & ACPI_MADT_ONLINE_CAPABLE;
=20
-	return false;
+	/*
+	 * QEMU expects legacy "Enabled=3D0" LAPIC entries to be counted as usable
+	 * in order to support CPU hotplug in guests.
+	 */
+	return !hypervisor_is_type(X86_HYPER_NATIVE);
 }
=20
 static int __init
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index f55ea3c..23190a7 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,7 +27,6 @@
 #include <xen/xen.h>
=20
 #include <asm/apic.h>
-#include <asm/hypervisor.h>
 #include <asm/io_apic.h>
 #include <asm/mpspec.h>
 #include <asm/msr.h>
@@ -236,20 +235,6 @@ static __init void topo_register_apic(u32 apic_id, u32 a=
cpi_id, bool present)
 		cpuid_to_apicid[cpu] =3D apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
-		u32 pkgid =3D topo_apicid(apic_id, TOPO_PKG_DOMAIN);
-
-		/*
-		 * Check for present APICs in the same package when running
-		 * on bare metal. Allow the bogosity in a guest.
-		 */
-		if (hypervisor_is_type(X86_HYPER_NATIVE) &&
-		    topo_unit_count(pkgid, TOPO_PKG_DOMAIN, phys_cpu_present_map)) {
-			pr_info_once("Ignoring hot-pluggable APIC ID %x in present package.\n",
-				     apic_id);
-			topo_info.nr_rejected_cpus++;
-			return;
-		}
-
 		topo_info.nr_disabled_cpus++;
 	}
=20

