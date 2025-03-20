Return-Path: <linux-tip-commits+bounces-4406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0602BA6A1FC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 10:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5289C7AAEE4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Mar 2025 08:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D322256A;
	Thu, 20 Mar 2025 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nwB0yxuD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2x8xh3i"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6221481E;
	Thu, 20 Mar 2025 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742461206; cv=none; b=OoD3LKMbuwvmRswgZgf6ff9U2h/4b0sKQwMgOsxq2zcWqnojLJPziFbcJAssaB573rG2vIuVUG7MZJw0K9ClhDobNFxpwP/3zoBro5ReY8Qt6cio6i/r2probU+B7GIf4aksTfxDIV56Juu3dVnj/XA+o+sZDyHRnF60bN9IMU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742461206; c=relaxed/simple;
	bh=gK/5yhC3m02Df7DK11Aq4/OzGCzn9zMj3t5SrFXKpk0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LWxIRYEl0uZzxpNoRgx2CE2lZXDwB021AcWpMIbi5rHDxhILaeeeWvAgv+/q1ZYvjCfgUxNOg78xqT70kNgbilOEY9vCzll/ERh09QjO/PLgDOvy0wgTF8nw6eG6os9UaSP5kvFRJdatlGYgu4FF35B3LuvDfK9x8BbPdcQoLsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nwB0yxuD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2x8xh3i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Mar 2025 09:00:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742461202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ofuC/UbfTB+z7M7nOFtIGyr/fY+CMNF/3pugnXIq+E=;
	b=nwB0yxuDvnnqztDijtlxHuMs4hQ/eKRa/tuMlBwCDPgd1hOR9oBej94TVhCIDrm64JqSTn
	WASed6FgSNvo2lf3Noq2tT4gpMycMarcbYgRYf8czKSvL87/2w+r4h0dfoZcBreEGAIrf4
	5hlzFzvpvN7HeElTCesb+j/VpXIhp5vOR9gB2/27Cqh9tcK7FkU9f9IAM3xAzt6tsSgDYd
	AfQfRr6kgyHlwBWNmOnZyWpcuzumdUT5Jlr0J5ZGdvdD9/e7kof5b4ifhJHaQd83x3WX24
	GXsILOomp6ZnuexppTSkyZx+nY/b9fC6FKxwtyJIxbrHXAseCIg2B13cz1y/QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742461202;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ofuC/UbfTB+z7M7nOFtIGyr/fY+CMNF/3pugnXIq+E=;
	b=H2x8xh3i4dDQ/4fzOUUhHjK6M/p/F/cK40we7T1W8mXjxIZVj98L+LirUap51jD2Jzt9gE
	bkQOfE6PURN2AAAw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug, Documentation: Remove (most)
 CONFIG_SCHED_DEBUG references from documentation
Cc: Ingo Molnar <mingo@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250317104257.3496611-5-mingo@kernel.org>
References: <20250317104257.3496611-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174246120134.14745.13772927227797745702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1b68a6aba00efbee9804c11d85019646b2e2646f
Gitweb:        https://git.kernel.org/tip/1b68a6aba00efbee9804c11d85019646b2e=
2646f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 11:42:55 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 22:20:54 +01:00

sched/debug, Documentation: Remove (most) CONFIG_SCHED_DEBUG references from =
documentation

Since it's enabled unconditionally now, remove all references to it.

(Left out languages I cannot read.)

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250317104257.3496611-5-mingo@kernel.org
---
 Documentation/scheduler/sched-debug.rst                         | 2 +-
 Documentation/scheduler/sched-design-CFS.rst                    | 2 +-
 Documentation/scheduler/sched-domains.rst                       | 5 ++---
 Documentation/scheduler/sched-ext.rst                           | 3 +--
 Documentation/scheduler/sched-stats.rst                         | 2 +-
 Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst | 2 +-
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/scheduler/sched-debug.rst b/Documentation/schedule=
r/sched-debug.rst
index 4d3d24f..b5a92a3 100644
--- a/Documentation/scheduler/sched-debug.rst
+++ b/Documentation/scheduler/sched-debug.rst
@@ -2,7 +2,7 @@
 Scheduler debugfs
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Booting a kernel with CONFIG_SCHED_DEBUG=3Dy will give access to
+Booting a kernel with debugfs enabled will give access to
 scheduler specific debug files under /sys/kernel/debug/sched. Some of
 those files are described below.
=20
diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/sch=
eduler/sched-design-CFS.rst
index 8786f21..b574a26 100644
--- a/Documentation/scheduler/sched-design-CFS.rst
+++ b/Documentation/scheduler/sched-design-CFS.rst
@@ -96,7 +96,7 @@ picked and the current task is preempted.
 CFS uses nanosecond granularity accounting and does not rely on any jiffies =
or
 other HZ detail.  Thus the CFS scheduler has no notion of "timeslices" in the
 way the previous scheduler had, and has no heuristics whatsoever.  There is
-only one central tunable (you have to switch on CONFIG_SCHED_DEBUG):
+only one central tunable:
=20
    /sys/kernel/debug/sched/base_slice_ns
=20
diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/schedu=
ler/sched-domains.rst
index 5e996fe..15e3a4c 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -73,9 +73,8 @@ Architectures may override the generic domain builder and t=
he default SD flags
 for a given topology level by creating a sched_domain_topology_level array a=
nd
 calling set_sched_topology() with this array as the parameter.
=20
-The sched-domains debugging infrastructure can be enabled by enabling
-CONFIG_SCHED_DEBUG and adding 'sched_verbose' to your cmdline. If you
-forgot to tweak your cmdline, you can also flip the
+The sched-domains debugging infrastructure can be enabled by 'sched_verbose'
+to your cmdline. If you forgot to tweak your cmdline, you can also flip the
 /sys/kernel/debug/sched/verbose knob. This enables an error checking parse of
 the sched domains which should catch most possible errors (described above).=
 It
 also prints out the domain structure in a visual format.
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/=
sched-ext.rst
index c4672d7..5788a33 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -107,8 +107,7 @@ detailed information:
     nr_rejected   : 0
     enable_seq    : 1
=20
-If ``CONFIG_SCHED_DEBUG`` is set, whether a given task is on sched_ext can
-be determined as follows:
+Whether a given task is on sched_ext can be determined as follows:
=20
 .. code-block:: none
=20
diff --git a/Documentation/scheduler/sched-stats.rst b/Documentation/schedule=
r/sched-stats.rst
index caea83d..08b6bc9 100644
--- a/Documentation/scheduler/sched-stats.rst
+++ b/Documentation/scheduler/sched-stats.rst
@@ -88,7 +88,7 @@ One of these is produced per domain for each cpu described.=
 (Note that if
 CONFIG_SMP is not defined, *no* domains are utilized and these lines
 will not appear in the output. <name> is an extension to the domain field
 that prints the name of the corresponding sched domain. It can appear in
-schedstat version 17 and above, and requires CONFIG_SCHED_DEBUG.)
+schedstat version 17 and above.
=20
 domain<N> <name> <cpumask> 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 2=
0 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
=20
diff --git a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst =
b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
index dc728c7..b35d244 100644
--- a/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
+++ b/Documentation/translations/sp_SP/scheduler/sched-design-CFS.rst
@@ -112,7 +112,7 @@ CFS usa una granularidad de nanosegundos y no depende de =
ning=C3=BAn
 jiffy o detalles como HZ. De este modo, el gestor de tareas CFS no tiene
 noci=C3=B3n de "ventanas de tiempo" de la forma en que ten=C3=ADa el gestor =
de
 tareas previo, y tampoco tiene heur=C3=ADsticos. =C3=9Anicamente hay un par=
=C3=A1metro
-central ajustable (se ha de cambiar en CONFIG_SCHED_DEBUG):
+central ajustable:
=20
    /sys/kernel/debug/sched/base_slice_ns
=20

