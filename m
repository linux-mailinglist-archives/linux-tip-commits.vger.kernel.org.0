Return-Path: <linux-tip-commits+bounces-8093-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMimH2/6cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8093-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:22:39 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22804652E2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDDD26802D5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C59E34165B;
	Thu, 22 Jan 2026 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDneD73Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lpMIvqQR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E23191B0;
	Thu, 22 Jan 2026 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076941; cv=none; b=Bd/h1rQ4DG1N/H06xBmN7a6Ybk9rsPxeEf+eDM1zJuaOpua/bVu802pskDxxFy+N7Wl3AdjZgicUulvrH5h1ctZKHuH1c0YGpMxa+VV5j22CxHt0q8WRIPYsGhX0agwSCAGgUi0tvlDUOfWHnNA9VYxMKHf1M9itD4Zmc7Ng/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076941; c=relaxed/simple;
	bh=ijbNm/zwu6NtPcJ1r8sdjun0uLtvnvFxu7o4v4mxPzY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UIkCx4GEpog1puqwx7JL0HskzgpC5hVB1Zgz2rxmp9gRQoLJ5S0GpFkuD0xyQTtslT2OBhhWcgsNV5N8ZhuX7rPLojWDNSYQqBJJbVTPeVcF0V2ecFkzd0C4KFH/SteXPSyFNDRZGCbIhaS225qH3O2hklr/frA3cAhPdvGsbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDneD73Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lpMIvqQR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QHuKPauCbYCD1zfq8rGIZfhwQMAwMDPMZnHpXBMjqA=;
	b=QDneD73Z+4i4NqYvYsZ8ZVUungGzGbdYz0tH3LwFSsUUeqF3KAjNiEuPVALOL9s4oKjAwK
	lJxzLsHzVVi+Qy03o9CuOyA9ft92bqgqaxROzgaBb5DsJOqx41jF04GRLRvhuGEm9Fbz2B
	OX1xf6W1JZSB/JmujbCxZIBCaWkPWN889m6IOFcKepXuL15nCsWsuQSDEulyEDSWSLNOdW
	aSuXp6S5fEs0OXFJ5TG4XZ953Sib0zGGcIdbiBymoy04E4HVte1BTyihEndMfk3/m1ykCl
	aPiq878+ig3lvxNA1Akrk2pjRj3DJoJhROoD5djDo0rY+oGNPId6AV8ooicCOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076936;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QHuKPauCbYCD1zfq8rGIZfhwQMAwMDPMZnHpXBMjqA=;
	b=lpMIvqQRr8vXoLEGymaCKhhh3HVst0OyCIse1sKkXHwggtWc/fi4/dEUIhBd09JfaURdj7
	G9G2Fsu89iwoO4BQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] selftests/rseq: Add rseq slice histogram script
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260121143208.340549136@infradead.org>
References: <20260121143208.340549136@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907693497.510.4913112096610527137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8093-lists,linux-tip-commits=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,msgid.link:url,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 22804652E2
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bb332a9e5a057d2cb9b90e307b26cce9b1f6f660
Gitweb:        https://git.kernel.org/tip/bb332a9e5a057d2cb9b90e307b26cce9b1f=
6f660
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 21 Jan 2026 15:10:29 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:20 +01:00

selftests/rseq: Add rseq slice histogram script

A script that processes trace-cmd data and generates a histogram of
rseq slice_ext durations for the recorded workload.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260121143208.340549136@infradead.org
---
 Documentation/userspace-api/rseq.rst            |   3 +-
 tools/testing/selftests/rseq/rseq-slice-hist.py | 132 +++++++++++++++-
 2 files changed, 135 insertions(+)
 create mode 100644 tools/testing/selftests/rseq/rseq-slice-hist.py

diff --git a/Documentation/userspace-api/rseq.rst b/Documentation/userspace-a=
pi/rseq.rst
index 468f6bb..3cd27a3 100644
--- a/Documentation/userspace-api/rseq.rst
+++ b/Documentation/userspace-api/rseq.rst
@@ -83,6 +83,9 @@ determined by debugfs:rseq/slice_ext_nsec. The default valu=
e is 5 usec; which
 is the minimum value. It can be incremented to 50 usecs, however doing so
 can/will affect the minimum scheduling latency.
=20
+Any proposed changes to this default will have to come with a selftest and
+rseq-slice-hist.py output that shows the new value has merrit.
+
 The kernel indicates the grant by clearing rseq::slice_ctrl::request and
 setting rseq::slice_ctrl::granted to 1. If there is a reschedule of the
 thread after granting the extension, the kernel clears the granted bit to
diff --git a/tools/testing/selftests/rseq/rseq-slice-hist.py b/tools/testing/=
selftests/rseq/rseq-slice-hist.py
new file mode 100644
index 0000000..b7933ee
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-slice-hist.py
@@ -0,0 +1,132 @@
+#!/usr/bin/python3
+
+#
+# trace-cmd record -e hrtimer_start -e hrtimer_cancel -e hrtimer_expire_entr=
y -- $cmd
+#
+
+from tracecmd import *
+
+def load_kallsyms(file_path=3D'/proc/kallsyms'):
+    """
+    Parses /proc/kallsyms into a dictionary.
+    Returns: { address_int: symbol_name }
+    """
+    kallsyms_map =3D {}
+
+    try:
+        with open(file_path, 'r') as f:
+            for line in f:
+                # The format is: [address] [type] [name] [module]
+                parts =3D line.split()
+                if len(parts) < 3:
+                    continue
+
+                addr =3D int(parts[0], 16)
+                name =3D parts[2]
+
+                kallsyms_map[addr] =3D name
+
+    except PermissionError:
+        print(f"Error: Permission denied reading {file_path}. Try running wi=
th sudo.")
+    except FileNotFoundError:
+        print(f"Error: {file_path} not found.")
+
+    return kallsyms_map
+
+ksyms =3D load_kallsyms()
+
+# pending[timer_ptr] =3D {'ts': timestamp, 'comm': comm}
+pending =3D {}
+
+# histograms[comm][bucket] =3D count
+histograms =3D {}
+
+class OnlineHarmonicMean:
+    def __init__(self):
+        self.n =3D 0          # Count of elements
+        self.S =3D 0.0        # Cumulative sum of reciprocals
+
+    def update(self, x):
+        if x =3D=3D 0:
+            raise ValueError("Harmonic mean is undefined for zero.")
+
+        self.n +=3D 1
+        self.S +=3D 1.0 / x
+        return self.n / self.S
+
+    @property
+    def mean(self):
+        return self.n / self.S if self.n > 0 else 0
+
+ohms =3D {}
+
+def handle_start(record):
+    func_name =3D ksyms[record.num_field("function")]
+    if "rseq_slice_expired" in func_name:
+        timer_ptr =3D record.num_field("hrtimer")
+        pending[timer_ptr] =3D {
+            'ts': record.ts,
+            'comm': record.comm
+        }
+    return None
+
+def handle_cancel(record):
+    timer_ptr =3D record.num_field("hrtimer")
+
+    if timer_ptr in pending:
+        start_data =3D pending.pop(timer_ptr)
+        duration_ns =3D record.ts - start_data['ts']
+        duration_us =3D duration_ns // 1000
+
+        comm =3D start_data['comm']
+
+        if comm not in ohms:
+            ohms[comm] =3D OnlineHarmonicMean()
+
+        ohms[comm].update(duration_ns)
+
+        if comm not in histograms:
+            histograms[comm] =3D {}
+
+        histograms[comm][duration_us] =3D histograms[comm].get(duration_us, =
0) + 1
+    return None
+
+def handle_expire(record):
+    timer_ptr =3D record.num_field("hrtimer")
+
+    if timer_ptr in pending:
+        start_data =3D pending.pop(timer_ptr)
+        comm =3D start_data['comm']
+
+        if comm not in histograms:
+            histograms[comm] =3D {}
+
+        # Record -1 bucket for expired (failed to cancel)
+        histograms[comm][-1] =3D histograms[comm].get(-1, 0) + 1
+    return None
+
+if __name__ =3D=3D "__main__":
+    t =3D Trace("trace.dat")
+    for cpu in range(0, t.cpus):
+        ev =3D t.read_event(cpu)
+        while ev:
+            if "hrtimer_start" in ev.name:
+                handle_start(ev)
+            if "hrtimer_cancel" in ev.name:
+                handle_cancel(ev)
+            if "hrtimer_expire_entry" in ev.name:
+                handle_expire(ev)
+
+            ev =3D t.read_event(cpu)
+
+    print("\n" + "=3D"*40)
+    print("RSEQ SLICE HISTOGRAM (us)")
+    print("=3D"*40)
+    for comm, buckets in histograms.items():
+        print(f"\nTask: {comm}    Mean: {ohms[comm].mean:.3f} ns")
+        print(f"  {'Latency (us)':<15} | {'Count'}")
+        print(f"  {'-'*30}")
+        # Sort buckets numerically, putting -1 at the top
+        for bucket in sorted(buckets.keys()):
+            label =3D "EXPIRED" if bucket =3D=3D -1 else f"{bucket} us"
+            print(f"  {label:<15} | {buckets[bucket]}")

