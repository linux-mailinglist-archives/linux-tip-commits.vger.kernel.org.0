Return-Path: <linux-tip-commits+bounces-6107-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B29CB03A6C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A02B189C712
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B8242909;
	Mon, 14 Jul 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4RwfqKfJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ycBSOZs/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8A23F409;
	Mon, 14 Jul 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484243; cv=none; b=aJLrk+Oi+fN11KzQKrrUBvVOrPXVLtlD1iMps9Naj58pzuHK7MQP1G8IdFC6ZJxE7QB5+i6NUPt1bGtslMuMUQVjtNF1TW0YEtK5v3h5dKwjD0UdLqnk9OalV+jW53TsLBUIO2U2TwdA+K9tJaYowhOZSx0CaMxogRNAOPVWcyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484243; c=relaxed/simple;
	bh=AItfdDMTA1BYvsMlkU7h7WoFpDa3+0Akd6yaX2zKUgA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m2tkQIVJZuDDVwRagF0A590bL0ATxw/D7Xr89wGUpmBTdJ2Bkv+qN46WyWXNxGofsAiemsIGw8EqKKu+1b5uisAhiI1d22oj4OLFHydND2tj95MdIygN5hoCqjhODURiKprhqX/XWtHGSoK+4oT3tAPtGz9dAjqF7oHyAzicpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4RwfqKfJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ycBSOZs/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vqyf5xaSpKpxtHZo+efTuU7QQYP/DeI47UXdxTJczls=;
	b=4RwfqKfJQ3mAYUXS+UPb4lPvfeaOo6vCjuaaw3hg9RKXOv1R+8sh5WYK4alUjUaw0sEENm
	fF9mfBOvRbzeYTa1LXuJto8pYf9cJhFCmbHx15pKv8+0vSO62AHvFuGa0Xz7wVGlU7YEL6
	0LIK9IHVNIuW1UmHyc09dovAhU3rlca7MbjHnvoL81YvLiliG4W3FKu1bGjl0IrTa8IY/d
	z6QefjHFokvgukkPU3F472GmD8iMkXwJl3+Feg3qRY3+OSl8p+mYlmeTGBcXpeWsa+g4Nl
	QJbz9Wuhmwa8r+U1wAgy8mdmgkOkKal55F+O75pawziIU+7DWMyE1BdkMO7cTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484240;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vqyf5xaSpKpxtHZo+efTuU7QQYP/DeI47UXdxTJczls=;
	b=ycBSOZs/qJ97qGZjpNq1ZxSJuN/i+l/uBuFvr8ISbRxttO7457ZI/ggNt8L1j41K0X8RWX
	6HOmPw8zhk0ZWsCg==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] tools/sched: Add dl_bw_dump.py for printing
 bandwidth accounting info
Cc: Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250627115118.438797-6-juri.lelli@redhat.com>
References: <20250627115118.438797-6-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248423913.406.14126969726370943209.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     634c24068abf8f325e520e663250e4a32a95ea0e
Gitweb:        https://git.kernel.org/tip/634c24068abf8f325e520e663250e4a32a95ea0e
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Fri, 27 Jun 2025 13:51:18 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:33 +02:00

tools/sched: Add dl_bw_dump.py for printing bandwidth accounting info

dl_rq bandwidth accounting information is crucial for the correct
functioning of SCHED_DEADLINE.

Add a drgn script for accessing that information at runtime, so that
it's easier to check and debug issues related to it.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # nuc & rock5b
Link: https://lore.kernel.org/r/20250627115118.438797-6-juri.lelli@redhat.com
---
 tools/sched/dl_bw_dump.py | 57 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+)
 create mode 100644 tools/sched/dl_bw_dump.py

diff --git a/tools/sched/dl_bw_dump.py b/tools/sched/dl_bw_dump.py
new file mode 100644
index 0000000..aae4e42
--- /dev/null
+++ b/tools/sched/dl_bw_dump.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env drgn
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 Juri Lelli <juri.lelli@redhat.com>
+# Copyright (C) 2025 Red Hat, Inc.
+
+desc = """
+This is a drgn script to show dl_rq bandwidth accounting information. For more
+info on drgn, visit https://github.com/osandov/drgn.
+
+Only online CPUs are reported.
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
+def print_dl_bws_info():
+
+    print("Retrieving dl_rq bandwidth accounting information:")
+
+    runqueues = prog['runqueues']
+
+    for cpu_id in for_each_possible_cpu(prog):
+        try:
+            rq = per_cpu(runqueues, cpu_id)
+
+            if rq.online == 0:
+                continue
+
+            dl_rq = rq.dl
+
+            print(f"  From CPU: {cpu_id}")
+
+            # Access and print relevant fields from struct dl_rq
+            print(f"  running_bw : {dl_rq.running_bw}")
+            print(f"  this_bw    : {dl_rq.this_bw}")
+            print(f"  extra_bw   : {dl_rq.extra_bw}")
+            print(f"  max_bw     : {dl_rq.max_bw}")
+            print(f"  bw_ratio   : {dl_rq.bw_ratio}")
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
+    print_dl_bws_info()

