Return-Path: <linux-tip-commits+bounces-6108-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32716B03A6F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C057ADC6D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBD3242D6E;
	Mon, 14 Jul 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ox34Zq8Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbPqrapC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A4240604;
	Mon, 14 Jul 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484244; cv=none; b=qTucqZjjgEP2jLTgR3lRAPQZQk7rPnTDmqnU6SUn4RqvVt1YdjTftkmm+LVkWLeY5eHVCoqGn9BJbK+x87e4NtYoUcpLBeX7Qe8u34wb33flNvH4/1PD883yRtIM/EZFCPshZaFdbgenymat/Z1FNO7tM1GlzFzqYw1PwHQWuK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484244; c=relaxed/simple;
	bh=LQZFhC8IitkLj01E8uUetUTm+kFBgaI58tQevFa9kQw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V42r74j1u03HneRIN4Yrj/ZldP937dI08DE7iX9kK3EAwPgv0YVIqlSHBFTtBeTblS/McBJBdApHmqHzspZ5pHo3xu0q9tBWOLXHGBClOymLsqw6Cc37zAHq0ztF/HfU/MtGKUxfnpXOZ2Ezd36gYD6bWhcsEX9mABtlyE2BYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ox34Zq8Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DbPqrapC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jpFo7MrXV59xIVn/LhZSIz2lfXVG5dQWr//pdfSdJ4=;
	b=ox34Zq8YhSibv9pzxkn+Qz2M2kCU75zf7GN8d7ODQC+VUwHQrwgRhJycqyOvmUkPY5Yhdn
	HzdMa8k0twimIbZNLAZgWcIJm3oETCR9EH7rJD2kH21pVoJYnCBAn8Ch9lthoBg+MMuysa
	CRspTk07BFQwv0tqf+xQOanGrzfcCy1IVXCh4hN+ygesZc+Uh3l58qU3+zlm42FCz+X03e
	U1grAeJBy7r+VuZhZ8PKLW5f1TcuPm7HlJUn6+0sxAHRC9G+glfvNhQqdXB9cNaXs96WkI
	pVv/HT2PLV25iDMBZis8trcn7TyJwGfBFXh/UQ1ocdhsLWNdbJKFg4yul/WlCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jpFo7MrXV59xIVn/LhZSIz2lfXVG5dQWr//pdfSdJ4=;
	b=DbPqrapClM9W6y3fvg8V9MmYDhy0yRS5EQ/P3rGl3rkiNQyJAGRTxhQ8mwWlVmll1IFgP3
	TXpRuWHjlN86B/AA==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] tools/sched: Add root_domains_dump.py which dumps
 root domains info
Cc: Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627115118.438797-5-juri.lelli@redhat.com>
References: <20250627115118.438797-5-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248424010.406.599100229450146778.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9fdb12c88e9ba75e2d831fb397dd27f03a534968
Gitweb:        https://git.kernel.org/tip/9fdb12c88e9ba75e2d831fb397dd27f03a534968
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Fri, 27 Jun 2025 13:51:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:33 +02:00

tools/sched: Add root_domains_dump.py which dumps root domains info

Root domains information is somewhat hard to access at runtime. Even
with sched_debug and sched_verbose, such information is only printed
on kernel console when domains are modified.

Add a simple drgn script to more easily retrieve root domains
information at runtime.

Since tools/sched is a new directory, add it to MAINTAINERS as well.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # nuc & rock5b
Link: https://lore.kernel.org/r/20250627115118.438797-5-juri.lelli@redhat.com
---
 MAINTAINERS                      |  1 +-
 tools/sched/root_domains_dump.py | 68 +++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+)
 create mode 100644 tools/sched/root_domains_dump.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290f..b986a49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22165,6 +22165,7 @@ F:	include/linux/wait.h
 F:	include/uapi/linux/sched.h
 F:	kernel/fork.c
 F:	kernel/sched/
+F:	tools/sched/
 
 SCHEDULER - SCHED_EXT
 R:	Tejun Heo <tj@kernel.org>
diff --git a/tools/sched/root_domains_dump.py b/tools/sched/root_domains_dump.py
new file mode 100644
index 0000000..56dc91f
--- /dev/null
+++ b/tools/sched/root_domains_dump.py
@@ -0,0 +1,68 @@
+#!/usr/bin/env drgn
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 Juri Lelli <juri.lelli@redhat.com>
+# Copyright (C) 2025 Red Hat, Inc.
+
+desc = """
+This is a drgn script to show the current root domains configuration. For more
+info on drgn, visit https://github.com/osandov/drgn.
+
+Root domains are only printed once, as multiple CPUs might be attached to the
+same root domain.
+"""
+
+import os
+import argparse
+
+import drgn
+from drgn import FaultError
+from drgn.helpers.common import *
+from drgn.helpers.linux import *
+
+def print_root_domains_info():
+
+    # To store unique root domains found
+    seen_root_domains = set()
+
+    print("Retrieving (unique) Root Domain Information:")
+
+    runqueues = prog['runqueues']
+    def_root_domain = prog['def_root_domain']
+
+    for cpu_id in for_each_possible_cpu(prog):
+        try:
+            rq = per_cpu(runqueues, cpu_id)
+
+            root_domain = rq.rd
+
+            # Check if we've already processed this root domain to avoid duplicates
+            # Use the memory address of the root_domain as a unique identifier
+            root_domain_cast = int(root_domain)
+            if root_domain_cast in seen_root_domains:
+                continue
+            seen_root_domains.add(root_domain_cast)
+
+            if root_domain_cast == int(def_root_domain.address_):
+                print(f"\n--- Root Domain @ def_root_domain ---")
+            else:
+                print(f"\n--- Root Domain @ 0x{root_domain_cast:x} ---")
+
+            print(f"  From CPU: {cpu_id}") # This CPU belongs to this root domain
+
+            # Access and print relevant fields from struct root_domain
+            print(f"  Span       : {cpumask_to_cpulist(root_domain.span[0])}")
+            print(f"  Online     : {cpumask_to_cpulist(root_domain.span[0])}")
+
+        except drgn.FaultError as fe:
+            print(f"  (CPU {cpu_id}: Fault accessing kernel memory: {fe})")
+        except AttributeError as ae:
+            print(f"  (CPU {cpu_id}: Missing attribute for root_domain (kernel struct change?): {ae})")
+        except Exception as e:
+            print(f"  (CPU {cpu_id}: An unexpected error occurred: {e})")
+
+if __name__ == "__main__":
+    parser = argparse.ArgumentParser(description=desc,
+                                     formatter_class=argparse.RawTextHelpFormatter)
+    args = parser.parse_args()
+
+    print_root_domains_info()

