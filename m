Return-Path: <linux-tip-commits+bounces-4585-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A42A75235
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 22:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E627A635A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Mar 2025 21:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80081EF362;
	Fri, 28 Mar 2025 21:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W0oZFSYO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M3/f8RVv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E3C1E1E11;
	Fri, 28 Mar 2025 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743198789; cv=none; b=t3p2GjTbLXngzply/CDP/TI21DbX9qOAJ7qtrdbiKd1CsIX4A9rvR6V0g0gEiJmEd1W4zvlYRDcK6JWu2NtvmOvgwX285EgUObz3IxwnlNSwosOcc/Ss2C/EbRthV4OUfbxE6VSh3O9os3B+JC3Y9atRlAnAtQI+5KgPIRVIgDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743198789; c=relaxed/simple;
	bh=9qYOIp3WdhidlviUBexFtVBRLdSagZc4upcipxzf/Co=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Aa/AgH/UV+E0Lo4FA4mCYSMp2XAxUXhFxCHI7Y2hscFQUadrb3tYNFRjPyGT11mtaE5Z1SesBq810KqxXfHdhY+FBjsMo1I1h4XAOT/Ry704rDd7erLHdEQutYy/A5qOQl5KL14/bUNXhQ6Dq+YwoUdVgsE+VN4Fm/pz3xGGFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W0oZFSYO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M3/f8RVv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Mar 2025 21:53:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743198785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2fW1+N+bQbWl4PwdRh4quOjK6im68NjxkVYURT6NfI=;
	b=W0oZFSYOEk49m8HstESJM/utC0U1+ksV48viY65ZaQyQBr9pJaoPQzGiaf/fuFD/mqNIu+
	ubQPvb+xdsfHvABA7IbZGDbGOsPFNBXfXhWM4gQ7Ti/fA1GMaVeOnxtHMWLJkygZkWMvB/
	QskYNSnGKT5JjL5aY/JXTWSEyRHLroFBSfHMkge6ePt8FKLhNEM95Lo4ChZBXFSpiX1e4V
	jmiePgoMGasUftEaxEXv1GF38yHJ9PtiVEsvnSb5EZL4hV+TWjpAx3i8J7j3tdhwcX8f1e
	EopUuqrahYvdUtu9ijaEQIKD5yQUd/NLdR5Zt4962HqHCIoVUJtIT9LtH0YOnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743198785;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2fW1+N+bQbWl4PwdRh4quOjK6im68NjxkVYURT6NfI=;
	b=M3/f8RVv8/Y/Zp/DU+BhYLKvPjpxVhwkMxRqJU/UXc0jURIogkodTQPXfxBesxi6le99bz
	K2f3mgPTFi/utECA==
From: "tip-bot2 for Herton R. Krzesinski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/uaccess: Improve performance by aligning writes
 to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs
Cc: Ondrej Lichtner <olichtne@redhat.com>,
 "Herton R. Krzesinski" <herton@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250320142213.2623518-1-herton@redhat.com>
References: <20250320142213.2623518-1-herton@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174319878123.14745.17191818776125218819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     3f7176e19a0f723c5b2abcc633ad0616c67d1f6d
Gitweb:        https://git.kernel.org/tip/3f7176e19a0f723c5b2abcc633ad0616c67d1f6d
Author:        Herton R. Krzesinski <herton@redhat.com>
AuthorDate:    Thu, 20 Mar 2025 11:22:13 -03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 28 Mar 2025 22:45:25 +01:00

x86/uaccess: Improve performance by aligning writes to 8 bytes in copy_user_generic(), on non-FSRM/ERMS CPUs

History of the performance regression:
======================================

Since the following series of user copy updates were merged upstream
~2 years ago via:

  a5624566431d ("Merge branch 'x86-rep-insns': x86 user copy clarifications")

.. copy_user_generic() on x86_64 stopped doing alignment of the
writes to the destination to a 8 byte boundary for the non FSRM case.

Previously, this was done through the ALIGN_DESTINATION macro that
was used in the now removed copy_user_generic_unrolled function.

Turns out this change causes some loss of performance/throughput on
some use cases and specific CPU/platforms without FSRM and ERMS.

Lately I got two reports of performance/throughput issues after a
RHEL 9 kernel pulled the same upstream series with updates to user
copy functions. Both reports consisted of running specific
networking/TCP related testing using iperf3.

Partial upstream fix
====================

The first report was related to a Linux Bridge testing using VMs on a
specific machine with an AMD CPU (EPYC 7402), and after a brief
investigation it turned out that the later change via:

  ca96b162bfd2 ("x86: bring back rep movsq for user access on CPUs without ERMS")

... helped/fixed the performance issue.

However, after the later commit/fix was applied, then I got another
regression reported in a multistream TCP test on a 100Gbit mlx5 nic, also
running on an AMD based platform (AMD EPYC 7302 CPU), again that was using
iperf3 to run the test. That regression was after applying the later
fix/commit, but only this didn't help in telling the whole history.

Testing performed to pinpoint residual regression
=================================================

So I narrowed down the second regression use case, but running it
without traffic through a NIC, on localhost, in trying to narrow down
CPU usage and not being limited by other factor like network bandwidth.
I used another system also with an AMD CPU (AMD EPYC 7742). Basically,
I run iperf3 in server and client mode in the same system, for example:

 - Start the server binding it to CPU core/thread 19:
   $ taskset -c 19 iperf3 -D -s -B 127.0.0.1 -p 12000

 - Start the client always binding/running on CPU core/thread 17, using
   perf to get statistics:
   $ perf stat -o stat.txt taskset -c 17 iperf3 -c 127.0.0.1 -b 0/1000 -V \
       -n 50G --repeating-payload -l 16384 -p 12000 --cport 12001 2>&1 \
       > stat-19.txt

For the client, always running/pinned to CPU 17. But for the iperf3 in
server mode, I did test runs using CPUs 19, 21, 23 or not pinned to any
specific CPU. So it basically consisted with four runs of the same
commands, just changing the CPU which the server is pinned, or without
pinning by removing the taskset call before the server command. The CPUs
were chosen based on NUMA node they were on, this is the relevant output
of lscpu on the system:

  $ lscpu
  ...
    Model name:             AMD EPYC 7742 64-Core Processor
  ...
  Caches (sum of all):
    L1d:                    2 MiB (64 instances)
    L1i:                    2 MiB (64 instances)
    L2:                     32 MiB (64 instances)
    L3:                     256 MiB (16 instances)
  NUMA:
    NUMA node(s):           4
    NUMA node0 CPU(s):      0,1,8,9,16,17,24,25,32,33,40,41,48,49,56,57,64,65,72,73,80,81,88,89,96,97,104,105,112,113,120,121
    NUMA node1 CPU(s):      2,3,10,11,18,19,26,27,34,35,42,43,50,51,58,59,66,67,74,75,82,83,90,91,98,99,106,107,114,115,122,123
    NUMA node2 CPU(s):      4,5,12,13,20,21,28,29,36,37,44,45,52,53,60,61,68,69,76,77,84,85,92,93,100,101,108,109,116,117,124,125
    NUMA node3 CPU(s):      6,7,14,15,22,23,30,31,38,39,46,47,54,55,62,63,70,71,78,79,86,87,94,95,102,103,110,111,118,119,126,127
  ...

So for the server run, when picking a CPU, I chose CPUs to be not on the same
node. The reason is with that I was able to get/measure relevant
performance differences when changing the alignment of the writes to the
destination in copy_user_generic.

Testing shows up to +81% performance improvement under iperf3
=============================================================

Here's a summary of the iperf3 runs:

  # Vanilla upstream alignment:

		     CPU      RATE          SYS          TIME     sender-receiver
	Server bind   19: 13.0Gbits/sec 28.371851000 33.233499566 86.9%-70.8%
	Server bind   21: 12.9Gbits/sec 28.283381000 33.586486621 85.8%-69.9%
	Server bind   23: 11.1Gbits/sec 33.660190000 39.012243176 87.7%-64.5%
	Server bind none: 18.9Gbits/sec 19.215339000 22.875117865 86.0%-80.5%

  # With the attached patch (aligning writes in non ERMS/FSRM case):

		     CPU      RATE          SYS          TIME     sender-receiver
	Server bind   19: 20.8Gbits/sec 14.897284000 20.811101382 75.7%-89.0%
	Server bind   21: 20.4Gbits/sec 15.205055000 21.263165909 75.4%-89.7%
	Server bind   23: 20.2Gbits/sec 15.433801000 21.456175000 75.5%-89.8%
	Server bind none: 26.1Gbits/sec 12.534022000 16.632447315 79.8%-89.6%

So I consistently got better results when aligning the write. The
results above were run on 6.14.0-rc6/rc7 based kernels. The sys is sys
time and then the total time to run/transfer 50G of data. The last
field is the CPU usage of sender/receiver iperf3 process. It's also
worth to note that each pair of iperf3 runs may get slightly different
results on each run, but I always got consistent higher results with
the write alignment for this specific test of running the processes
on CPUs in different NUMA nodes.

Linus Torvalds helped/provided this version of the patch. Initially I
proposed a version which aligned writes for all cases in
rep_movs_alternative, however it used two extra registers and thus
Linus provided an enhanced version that only aligns the write on the
large_movsq case, which is sufficient since the problem happens only
on those AMD CPUs like ones mentioned above without ERMS/FSRM, and
also doesn't require using extra registers. Also, I validated that
aligning only on large_movsq case is really enough for getting the
performance back.

I also tested this patch on an old Intel based non-ERMS/FRMS system
(with Xeon E5-2667 - Sandy Bridge based) and didn't get any problems:
no performance enhancement but also no regression either, using the
same iperf3 based benchmark. Also newer Intel processors after
Sandy Bridge usually have ERMS and should not be affected by this change.

[ mingo: Updated the changelog. ]

Fixes: ca96b162bfd2 ("x86: bring back rep movsq for user access on CPUs without ERMS")
Fixes: 034ff37d3407 ("x86: rewrite '__copy_user_nocache' function")
Reported-by: Ondrej Lichtner <olichtne@redhat.com>
Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Herton R. Krzesinski <herton@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250320142213.2623518-1-herton@redhat.com
---
 arch/x86/lib/copy_user_64.S | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index aa8c341..06296eb 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -77,6 +77,24 @@ SYM_FUNC_START(rep_movs_alternative)
 	_ASM_EXTABLE_UA( 0b, 1b)
 
 .Llarge_movsq:
+	/* Do the first possibly unaligned word */
+0:	movq (%rsi),%rax
+1:	movq %rax,(%rdi)
+
+	_ASM_EXTABLE_UA( 0b, .Lcopy_user_tail)
+	_ASM_EXTABLE_UA( 1b, .Lcopy_user_tail)
+
+	/* What would be the offset to the aligned destination? */
+	leaq 8(%rdi),%rax
+	andq $-8,%rax
+	subq %rdi,%rax
+
+	/* .. and update pointers and count to match */
+	addq %rax,%rdi
+	addq %rax,%rsi
+	subq %rax,%rcx
+
+	/* make %rcx contain the number of words, %rax the remainder */
 	movq %rcx,%rax
 	shrq $3,%rcx
 	andl $7,%eax

