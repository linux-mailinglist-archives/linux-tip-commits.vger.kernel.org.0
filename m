Return-Path: <linux-tip-commits+bounces-1457-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0141090D4A9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD6B1F21E9C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1FF1A3BB2;
	Tue, 18 Jun 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t64YQuwE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IUIrYQ1t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE8C1A2FCE;
	Tue, 18 Jun 2024 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719315; cv=none; b=oMiStNDR+KRHilwVnmBYpDQs9pGRdR8s09n8wtdoF6mIYyr228k3kRsIl/2kJu6CtBgkps6ekEtAzS1ry9+WFs0eJp3qaQXq5+vlxnnFm+5dLc30qIVTYj/qdX3c4NmcBcJAl9i63t7stzBeNbDOTfNNuShxU8eO9ABuMRlh6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719315; c=relaxed/simple;
	bh=Nv2OMF5plJD1Hk35j60RcRSFPrIqpyAANp81hkOdN74=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rQxNeXmQGMtd496mMrBFGh4E1TArAC5aoi/0CMVo95opvngSI7/wSQMiloSSb43giCQjhvfrp2lTO3jQlspXXkKJamU2eflJPxhdWL4QnJuFwlfPatYjBF7byQoZOMxLFM8Ael2ALxujCDPFM+xUaBbCesDRZjp8CJ26j5x8C4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t64YQuwE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IUIrYQ1t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8TE9qd+RJ5SHd+kzZBwg+ioVVS+tM8nRRZq/nNDAxg=;
	b=t64YQuwETBuOIHoevOpfRkZvd+sjujawx7RK4+lRK73HL7gtZLhFLVS01NFd+Wwk26udtt
	i0djBk0jDMNVWvdWpG7W2PiGdNTcdhb9kkOD6DOq4UVGJ0u7UerFQLRBaYv9KjOaaNyMc2
	0EA+v5e7k1b3kWkl/Ta4TzvF5PzIqSX563/B8RWd7pPvrIiSKSFhgo13z7rd6zfeV8z/dl
	qL7CLBzSzYSUiaKX92VVvknvSg9LND19N8yWT59pM/hzRHBkLPNDH0tVoStmgHp53CH4b4
	33tYJBDLCTJz6sOOBR9WTLPAqPNmOJdsT6iEWj/sndmDkSmk4W3ZlPw3K2Py7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8TE9qd+RJ5SHd+kzZBwg+ioVVS+tM8nRRZq/nNDAxg=;
	b=IUIrYQ1t5sG718c83iS42djuWn3QtANizrkoT7TdG/HYTEPvFLJQ7CyYA6G5mj6Ix+MGDG
	TV1L81xUmxtq5YAg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] cpu/hotplug: Add support for declaring CPU offlining
 not supported
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Tao Liu <ltao@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-4-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-4-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930316.10875.13637336937454429495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     1037e4c53e851682ff8d1ab656567a4d5a333c93
Gitweb:        https://git.kernel.org/tip/1037e4c53e851682ff8d1ab656567a4d5a333c93
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:48 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:45:31 +02:00

cpu/hotplug: Add support for declaring CPU offlining not supported

The ACPI MADT mailbox wakeup method doesn't allow to offline a CPU after
it has been woken up.

Currently, offlining is prevented based on the confidential computing attribute
which is set for Intel TDX. But TDX is not the only possible user of the wake up
method. The MADT wakeup can be implemented outside of a confidential computing
environment. Offline support is a property of the wakeup method, not the CoCo
implementation.

Introduce cpu_hotplug_disable_offlining() that can be called to indicate that
CPU offlining should be disabled.

This function is going to replace CC_ATTR_HOTPLUG_DISABLED for ACPI MADT wakeup
method.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-4-kirill.shutemov@linux.intel.com
---
 include/linux/cpuhplock.h |  2 ++
 kernel/cpu.c              | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuhplock.h b/include/linux/cpuhplock.h
index 431560b..f7aa20f 100644
--- a/include/linux/cpuhplock.h
+++ b/include/linux/cpuhplock.h
@@ -21,6 +21,7 @@ void cpus_read_lock(void);
 void cpus_read_unlock(void);
 int  cpus_read_trylock(void);
 void lockdep_assert_cpus_held(void);
+void cpu_hotplug_disable_offlining(void);
 void cpu_hotplug_disable(void);
 void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
@@ -36,6 +37,7 @@ static inline void cpus_read_lock(void) { }
 static inline void cpus_read_unlock(void) { }
 static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
+static inline void cpu_hotplug_disable_offlining(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
 static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563877d..4c15b47 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -483,6 +483,8 @@ static int cpu_hotplug_disabled;
 
 DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
 
+static bool cpu_hotplug_offline_disabled __ro_after_init;
+
 void cpus_read_lock(void)
 {
 	percpu_down_read(&cpu_hotplug_lock);
@@ -542,6 +544,14 @@ static void lockdep_release_cpus_lock(void)
 	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
 }
 
+/* Declare CPU offlining not supported */
+void cpu_hotplug_disable_offlining(void)
+{
+	cpu_maps_update_begin();
+	cpu_hotplug_offline_disabled = true;
+	cpu_maps_update_done();
+}
+
 /*
  * Wait for currently running CPU hotplug operations to complete (if any) and
  * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
@@ -1471,7 +1481,8 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
 	 */
-	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
+	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
+	    cpu_hotplug_offline_disabled)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;

