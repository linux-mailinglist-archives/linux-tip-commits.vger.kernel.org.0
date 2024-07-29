Return-Path: <linux-tip-commits+bounces-1811-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D39393F705
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 15:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA449280E96
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 13:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE672148FE1;
	Mon, 29 Jul 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zrxAqJg1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8AiAdaif"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12C146D54;
	Mon, 29 Jul 2024 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261074; cv=none; b=AnySv3H+N78zJ1uxS+xp9pMwiL3b/9RX+Go751HEylRMwJe0vzUYQUo3VixGlWlQMaSwjiobBv+S4NrwmFQQeS9vWAiN1O732Njx4Zw27eJbesz3ibDRohZuA2eg66st1QhUzN9EBj07hU3Kc6ka6Fbj/Qvz3wse9QVxKxOj2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261074; c=relaxed/simple;
	bh=CesZ3ok2b5rTOmfHhGz9axSgzjwB2knwDncUPGObFpQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SsGHdqWVZn0hAevEIUotGRsvfW0WBF7txDVcNs5r8CGVdBUKqP8vrAVs27vM7fZtBsquUtNqmhK7xSMBLgZ7BfHKmp8/XNlXir5KXryD3G3KbJ9VfT/RIFwBTHTXkxw/aSWoH675XpQcL77c6TS6hieIMKPYE/FjSTuXHlXG2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zrxAqJg1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8AiAdaif; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 13:51:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722261067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k40c5B+i3XXxDAkcVifWU6N3yvDHJSQqO9Bl+gdWbGA=;
	b=zrxAqJg1rT2BFu4dVBurArgtfyN8KG1jQ5XRS8ZnhZl+dtlxRVGUZ4hHW8aOV0wbRRhhCI
	np6KaDwryZFb4s1GOCZzekScFB1VGJrIBmSc3jWV06MdqmhTXFV+cf4o94ZJwVO0Q0KqIF
	M9awwNXeAhhO6jWLAgBw+kaX4jV9r38r89mNwlgncMpTJCODkmbXY6M13lMNk025kWVjTQ
	m0QBnrKC4X9SRmgrBs7RlPqTpZyMuHLOIXKxPyBRsT4Ep6IfS/B/aRdEIOWguf9HmeanER
	9gtUjIjLmizpmm2mQ6v/jacCic78R+y37DIm6jLhF7KwkcOCMhfgnY2wOhpyMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722261067;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k40c5B+i3XXxDAkcVifWU6N3yvDHJSQqO9Bl+gdWbGA=;
	b=8AiAdaifWPk4L8O9wejytiFfBzFgzoVc53dGA/wnzcRqFHu/TeHMrC/oVu/obAkmyYYZAq
	yFL1yxLx6cNRNOCg==
From: "tip-bot2 for Jonathan Cameron" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/aperfmperf: Fix deadlock on cpu_hotplug_lock
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>
References: <20240729105504.2170-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172226106647.2215.11540272455140168074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     0f7ced7d620ecc7a986843d6aeec41cce3116f41
Gitweb:        https://git.kernel.org/tip/0f7ced7d620ecc7a986843d6aeec41cce3116f41
Author:        Jonathan Cameron <Jonathan.Cameron@huawei.com>
AuthorDate:    Mon, 29 Jul 2024 11:55:04 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 29 Jul 2024 15:32:37 +02:00

x86/aperfmperf: Fix deadlock on cpu_hotplug_lock

The broken patch results in a call to init_freq_invariance_cppc() in a CPU
hotplug handler in both the path for initially present CPUs and those
hotplugged later.  That function includes a one time call to
amd_set_max_freq_ratio() which in turn calls freq_invariance_enable() that has
a static_branch_enable() which takes the cpu_hotlug_lock which is already
held.

Avoid the deadlock by using static_branch_enable_cpuslocked() as the lock will
always be already held.  The equivalent path on Intel does not already hold
this lock, so take it around the call to freq_invariance_enable(), which
results in it being held over the call to register_syscall_ops, which looks to
be safe to do.

Fixes: c1385c1f0ba3 ("ACPI: processor: Simplify initial onlining to use same path for cold and hotplug")
Closes: https://lore.kernel.org/all/CABXGCsPvqBfL5hQDOARwfqasLRJ_eNPBbCngZ257HOe=xbWDkA@mail.gmail.com/
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240729105504.2170-1-Jonathan.Cameron@huawei.com
---
 arch/x86/kernel/cpu/aperfmperf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index b3fa61d..0b69bfb 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -306,7 +306,7 @@ static void freq_invariance_enable(void)
 		WARN_ON_ONCE(1);
 		return;
 	}
-	static_branch_enable(&arch_scale_freq_key);
+	static_branch_enable_cpuslocked(&arch_scale_freq_key);
 	register_freq_invariance_syscore_ops();
 	pr_info("Estimated ratio of average max frequency by base frequency (times 1024): %llu\n", arch_max_freq_ratio);
 }
@@ -323,8 +323,10 @@ static void __init bp_init_freq_invariance(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return;
 
-	if (intel_set_max_freq_ratio())
+	if (intel_set_max_freq_ratio()) {
+		guard(cpus_read_lock)();
 		freq_invariance_enable();
+	}
 }
 
 static void disable_freq_invariance_workfn(struct work_struct *work)

