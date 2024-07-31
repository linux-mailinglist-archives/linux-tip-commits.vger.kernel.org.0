Return-Path: <linux-tip-commits+bounces-1896-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57416943650
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jul 2024 21:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA2E1F217D3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jul 2024 19:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6E61FDF;
	Wed, 31 Jul 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKszDlCm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2JKTNFnr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294531396;
	Wed, 31 Jul 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453443; cv=none; b=rMK0CpB0OjMi7vOC5wkIFvvqT3YtFkZhrEv4pY9RuGqnBQ4KmTkHXn0WcA9DIxnAKkK9yJktlvuf3j3u8nUrl3osPTabiq8SWasVK/f2BmccqgbtQO96zhQuadt3n9GVhNy/ct8dwXp8UmaD1ePjJIe3h9UPh7BZwAlt0R+77Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453443; c=relaxed/simple;
	bh=nqj64kAThfczR9bdWhrT4KStOx4CZ+UF7F5m/XfLIIk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mgRDC9foCucokoJT05fMj3D/uh+LU8nain2Hmftsa2nkszEkSkCq3s9nAmiaO2MYeEt3b6YNVwHI343XXO5N0VC0SkrapHiPmG/tt5lZxVWI1/eXkfOTxgtiewU2yITpxkOthofmmCD2nmjinsMaq0ggp4rsNJzoAgBc8OJ/YMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKszDlCm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2JKTNFnr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jul 2024 19:17:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722453439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6GS5RHz/pZ7rgdQqcinf2PakNtwOpSWpViqa7VEnqE=;
	b=hKszDlCmgQYg/hQLEwhLWLrjJb5bG8y4SYCdMXuB+vJhi4qDGRoATJTS7feQbTx5WelcHN
	UFkJ3kw6Ez5nivnQoGCrA1D+TGAuN0dZsaSF8l6iHb74K0DQizDcFRvL2RICTItNOSRYjW
	TrGsTcqSfsJaU0YHaeEvSOOn3SKk4JaX4x733itRpxMQeEo3RgvpQh/2N+j+0jhw+eIsZc
	e8SFPr3vW9in+GlD1mj3qrD0yNAv0IbBEX95LzJOIgSPlahh2tyH9fy7tavUP7nu6Qlzh6
	dtzhp6EhDXrGe7YxclPSR5fcqHnWC8jPCEqpymb8ZJx+rO9tTLHnuSu2fyExEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722453439;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6GS5RHz/pZ7rgdQqcinf2PakNtwOpSWpViqa7VEnqE=;
	b=2JKTNFnr8hqL9ykuxB8EPDZ1Gz4EcuCZeu6/zFnkgg2gMyGsWGiVef9QNq4nPhEndM4wO+
	iRSxyMK3cvB1XMAg==
From: "tip-bot2 for Feng Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/timers] x86/tsc: Use topology_max_packages() to get package number
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Feng Tang <feng.tang@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <longman@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240729021202.180955-1-feng.tang@intel.com>
References: <20240729021202.180955-1-feng.tang@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172245343893.2215.4640869699276515381.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/timers branch of tip:

Commit-ID:     b4bac279319d3082eb42f074799c7b18ba528c71
Gitweb:        https://git.kernel.org/tip/b4bac279319d3082eb42f074799c7b18ba528c71
Author:        Feng Tang <feng.tang@intel.com>
AuthorDate:    Mon, 29 Jul 2024 10:12:02 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 31 Jul 2024 21:12:09 +02:00

x86/tsc: Use topology_max_packages() to get package number

Commit b50db7095fe0 ("x86/tsc: Disable clocksource watchdog for TSC on
qualified platorms") was introduced to solve problem that sometimes TSC
clocksource is wrongly judged as unstable by watchdog like 'jiffies', HPET,
etc.

In it, the hardware package number is a key factor for judging whether to
disable the watchdog for TSC, and 'nr_online_nodes' was chosen due to, at
that time (kernel v5.1x), it is available in early boot phase before
registering 'tsc-early' clocksource, where all non-boot CPUs are not
brought up yet.

Dave and Rui pointed out there are many cases in which 'nr_online_nodes'
is cheated and not accurate, like:

 * SNC (sub-numa cluster) mode enabled
 * numa emulation (numa=fake=8 etc.)
 * numa=off
 * platforms with CPU-less HBM nodes, CPU-less Optane memory nodes.
 * 'maxcpus=' cmdline setup, where chopped CPUs could be onlined later
 * 'nr_cpus=', 'possible_cpus=' cmdline setup, where chopped CPUs can
   not be onlined after boot

The SNC case is the most user-visible case, as many CSP (Cloud Service
Provider) enable this feature in their server fleets. When SNC3 enabled, a
2 socket machine will appear to have 6 NUMA nodes, and get impacted by the
issue in reality.

Thomas' recent patchset of refactoring x86 topology code improves
topology_max_packages() greatly, by making it more accurate and available
in early boot phase, which works well in most of the above cases.

The only exceptions are 'nr_cpus=' and 'possible_cpus=' setup, which may
under-estimate the package number. As during topology setup, the boot CPU
iterates through all enumerated APIC IDs and either accepts or rejects the
APIC ID. For accepted IDs, it figures out which bits of the ID map to the
package number.  It tracks which package numbers have been seen in a
bitmap.  topology_max_packages() just returns the number of bits set in
that bitmap.

'nr_cpus=' and 'possible_cpus=' can cause more APIC IDs to be rejected and
can artificially lower the number of bits in the package bitmap and thus
topology_max_packages().  This means that, for example, a system with 8
physical packages might reject all the CPUs on 6 of those packages and be
left with only 2 packages and 2 bits set in the package bitmap. It needs
the TSC watchdog, but would disable it anyway.  This isn't ideal, but it
only happens for debug-oriented options. This is fixable by tracking the
package numbers for rejected CPUs.  But it's not worth the trouble for
debugging.

So use topology_max_packages() to replace nr_online_nodes().

Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/all/20240729021202.180955-1-feng.tang@intel.com
Closes: https://lore.kernel.org/lkml/a4860054-0f16-6513-f121-501048431086@intel.com/
---
 arch/x86/kernel/tsc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d4462fb..0ced187 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -28,6 +28,7 @@
 #include <asm/apic.h>
 #include <asm/cpu_device_id.h>
 #include <asm/i8259.h>
+#include <asm/topology.h>
 #include <asm/uv/uv.h>
 
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
@@ -1253,15 +1254,12 @@ static void __init check_system_tsc_reliable(void)
 	 *  - TSC which does not stop in C-States
 	 *  - the TSC_ADJUST register which allows to detect even minimal
 	 *    modifications
-	 *  - not more than two sockets. As the number of sockets cannot be
-	 *    evaluated at the early boot stage where this has to be
-	 *    invoked, check the number of online memory nodes as a
-	 *    fallback solution which is an reasonable estimate.
+	 *  - not more than four packages
 	 */
 	if (boot_cpu_has(X86_FEATURE_CONSTANT_TSC) &&
 	    boot_cpu_has(X86_FEATURE_NONSTOP_TSC) &&
 	    boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
-	    nr_online_nodes <= 4)
+	    topology_max_packages() <= 4)
 		tsc_disable_clocksource_watchdog();
 }
 

